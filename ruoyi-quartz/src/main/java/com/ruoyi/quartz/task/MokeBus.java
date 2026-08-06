package com.ruoyi.quartz.task;

import com.ecat.core.Bus.event.EventContext;
import com.ecat.core.EcatCore;
import com.ecat.core.State.AttributeBase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("mokeBus")
public class MokeBus {
    @Autowired
    private EcatCore core;


    // triggerType 0自动 1手动
    public void send(String triggerType, String deviceid, String paramid, String value, String datatime){
        AttributeBase<?> attr = core.getDeviceRegistry()
                .getDeviceByID(deviceid).getAttrs().get(paramid);
        // 保留 SYSTEM 来源标记：publicState 优先用此 eventContext，否则默认 DEVICE_POLL。
        // 必须在 setDisplayValue 之前设置——setDisplayValue 内部会触发 publicState。
        attr.setEventContext(EventContext.root(EventContext.Source.SYSTEM, null));
        // setDisplayValue 内部链路：convertStringToType → updateValue → publicState，
        // 即已经 AttributeBase.publicState 的 READY 门禁（设备就绪 + 稳定 id 后单次发布）。
        // 不再手动 new DeviceDataChangedEvent + bus.publish——那是绕过门禁的直发，
        // 且与 setDisplayValue 内置发布重复双发（复活启动竞态 type=null / 虚假样本同源风险）。
        attr.setDisplayValue(value);
    }


}
