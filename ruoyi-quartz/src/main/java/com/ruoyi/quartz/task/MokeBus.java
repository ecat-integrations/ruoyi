package com.ruoyi.quartz.task;

import com.ecat.core.Bus.BusTopic;
import com.ecat.core.Bus.event.BusEvent;
import com.ecat.core.Bus.event.DeviceDataChangedEvent;
import com.ecat.core.Bus.event.EventContext;
import com.ecat.core.Device.DeviceRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ecat.core.EcatCore;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Component("mokeBus")
public class MokeBus {
    @Autowired
    private EcatCore core;


    // triggerType 0自动 1手动
    public void send(String triggerType, String deviceid, String paramid, String value, String datatime){
        Map<String, Object> data = new HashMap<>();

        DeviceRegistry device = core.getDeviceRegistry();
        device.getDeviceByID(deviceid).getAttrs().get(paramid).setDisplayValue(value);
//        device.getDeviceByID(deviceid).getAttrs().get(paramid).setDisplayValue();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 进行字符串解析
        LocalDateTime dateTime = LocalDateTime.parse(datatime, formatter);
//        device.getDeviceByID(deviceid).getAttrs().get(paramid).setUpdateTime(dateTime);
        // 新 Bus API：device.data.update 载荷为 DeviceDataChangedEvent（内嵌不可变 AttrState），
        // 不再直接发 AttributeBase（其已非 BusPayload）。MokeBus 是后台定时任务驱动发布，
        // 来源标记为 SYSTEM、无关联用户；newState 取属性当前 AttrState。
        // EventContext.root 创建根事件上下文便于下游溯源。
        core.getBusRegistry().publish(BusEvent.of(
                BusTopic.DEVICE_DATA_UPDATE.getTopicName(),
                new DeviceDataChangedEvent(deviceid, paramid, null,
                        device.getDeviceByID(deviceid).getAttrs().get(paramid).getState()),
                EventContext.root(EventContext.Source.SYSTEM, null)));
    }


}
