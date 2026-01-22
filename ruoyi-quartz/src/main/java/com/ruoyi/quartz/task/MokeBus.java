package com.ruoyi.quartz.task;

import com.ecat.core.Bus.BusTopic;
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
        core.getBusRegistry().publish(BusTopic.DEVICE_DATA_UPDATE.getTopicName(),device.getDeviceByID(deviceid).getAttrs().get(paramid));
    }


}
