<template>
  <div :class="['container', { 'station-preview-mode': displayMode === 'station-preview' }]" ref="container" id="container">
    <!-- 大屏首页内容 -->
    <div
      v-if="displayMode === 'dashboard'"
      class="dashboard-content"
      :style="{ '--sec-deg': secHandDeg + 'deg' }"
    >
      <!-- 返回列表页按钮 - 始终存在于DOM，通过透明度控制显示 -->
      <div 
        class="back-to-list-btn" 
        :class="{ 'btn-visible': isBackButtonVisible }"
        @click="handleReturnToList"
      >
        <span class="back-icon">←</span>
        <span class="back-text">返回列表页</span>
      </div>
      
      <div class="head">
        <div style="position: relative">
          <div class="logo" v-triple-click="handleLogoTripleClick"></div>
          <div class="title">数智化无人运维监控平台</div>
          <div class="nav">
            <div class="nav_item_alarm" id="alarmopen"  @click="handleTripleClick">
              <span class="version-number">软件版本号:V1.0.3</span>
            </div>
  <!--          <div class="nav_item" @click="addNewElement()">设置界面</div>-->
  <!--          <div class="nav_item" @click="handleRoute('/')">首页</div>-->
  <!--          <div-->
  <!--            class="nav_item"-->
  <!--            style="margin-left: 2rem"-->
  <!--            @click="handleRoute('/controlResult')"-->
  <!--          >-->
  <!--            质控结果-->
  <!--          </div>-->
  <!--          <div-->
  <!--            class="nav_item"-->
  <!--            style="margin-left: 2rem"-->
  <!--            @click="handleRoute('/controlPage')"-->
  <!--          >-->
  <!--            手动校准-->
  <!--          </div>-->
  <!--          <div class="nav_item" style="margin-left: 2rem" @click="handleBD">-->
  <!--            比对系统-->
  <!--          </div>-->
          </div>
        </div>
      </div>
    <div class="main">
      <div class="left">
        <div class="s_box cyg">
          <div style="display: flex">
            <div class="s_title">【报警状态监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>

          <div class="s_content">
            <div>
              <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of leftOne" :key="index">
                <span class="cy_name">{{ item.name }}:</span
                ><span class="cy_val"><span
               :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
              ><span class="cy_unit">{{ item.unit }}</span>
                <span class="cy_status"></span>
              </div>
            </div>
          </div>
        </div>
        <div class="s_box abc_elec">
          <div style="display: flex">
            <div class="s_title">【流量监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>
          <div class="s_content">
            <div>
              <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of leftTwo" :key="index">
                <span class="cy_name">{{ item.name }}:</span
                ><span class="cy_val"><span
                :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
              ><span class="cy_unit">{{ item.unit }}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="s_box hw">
          <div style="display: flex">
            <div class="s_title">【站房环境监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>
          <div class="s_content">
            <div>
              <!-- <div class="cy_text">
                <span class="cy_name">站房温度:</span
                ><span class="cy_val">33</span><span class="cy_unit">℃</span>
              </div> -->
              <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of leftThree" :key="index">
                <span class="cy_name">{{ item.name }}:</span
                ><span class="cy_val"><span
                :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
              ><span class="cy_unit">{{ item.unit }}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="s_box ups">
          <div style="display: flex">
            <div class="s_title">【采样管设备监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>
          <div class="s_content">
            <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of leftFour" :key="index">
              <span class="cy_name">{{ item.name }}:</span
              ><span class="cy_val"><span
              :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
            ><span class="cy_unit">{{ item.unit }}</span>
            </div>
          </div>
        </div>
      </div>
      <div class="middle h_space">
        <div class="s_box dq_para">
          <div style="display: flex">
            <div class="s_title" style="height: 1.8rem; line-height: 1.8rem">
              【大气环境监测】
            </div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>

          <div style="display: flex; margin-top: 0.8rem">
            <!-- <div id="bar-chart" style="width: 100%; height: 80%"></div> -->
            <div v-for="item of middleOne" :key="item.index" class="dh_data_panel">
              <!-- <div class="text-align:left;">
                <span style="font-weight: bold; font-size: 14px"
                  >{{ item.name }}:</span
                >
              </div> -->
              <div
                style="
                  font-weight: bold;
                  font-size: 14px;
                  text-align: center;
                  color: #fff;
                  margin-top: 1rem;
                "

              >
                <span
                  :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span>
              </div>
              <div
                style="
                  margin-top: 1rem;
                  height: 2rem;
                  line-height: 2rem;
                  text-align: center;
                  background: #ccc;
                  color: #000;
                "
              >
                <span
                  :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" >{{ item.name }}<sub>{{ item.affix }}</sub></span
                >
              </div>
            </div>
          </div>
        </div>
        <div class="m_view">
          <div style="position: relative">
            <img
              src="@/assets/image/air.22a18526.png"
              style="max-width: 100%; height: 98%"
            />
            <div
              style="
                position: absolute;
                left: 41%;
                top: 33%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.CO.status !== 1,
                     'successstatus': middleTwoDict.CO.status === 1
                   }"
              id="costatus"
            >
              CO设备
            </div>
            <div
              style="
                position: absolute;
                left: 52.5%;
                top: 34%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              " :class="{
                     'nostatus': middleTwoDict.PM10.status !== 1,
                     'successstatus': middleTwoDict.PM10.status === 1
                   }"
              id="pm10status"
            >
              PM<sub>10</sub>设备
            </div>
            <div
              style="
                position: absolute;
                left: 41%;
                top: 44%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.O3.status !== 1,
                     'successstatus': middleTwoDict.O3.status === 1
                   }"
            >
              O<sub>3</sub>设备
            </div>
            <div
              style="
                position: absolute;
                left: 41%;
                top: 55%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.NO2.status !== 1,
                     'successstatus': middleTwoDict.NO2.status === 1
                   }"
            >
              NO<sub>2</sub>设备
            </div>
            <div
              style="
                position: absolute;
                left: 41%;
                top: 68%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.SO2.status !== 1,
                     'successstatus': middleTwoDict.SO2.status === 1
                   }"
            >
              SO<sub>2</sub>设备

            </div>
            <div
              style="
                position: absolute;
                left: 43.5%;
                top: 15%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.sample_tube.status !== 1,
                     'successstatus': middleTwoDict.sample_tube.status === 1
                   }"
            >
            </div>
            <div
              style="
                position: absolute;
                left: 30%;
                top: 14%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.air.status !== 1,
                     'successstatus': middleTwoDict.air.status === 1
                   }"
            >
            </div>
            <div
              style="
                position: absolute;
                left: 52.5%;
                top: 51%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.PM2_5.status !== 1,
                     'successstatus': middleTwoDict.PM2_5.status === 1
                   }"
            >
              PM<sub>2.5</sub>设备
            </div>
            <div
              style="
                position: absolute;
                left: 52.5%;
                top: 66%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.calib.status !== 1,
                     'successstatus': middleTwoDict.calib.status === 1
                   }"
            >
              校准仪
            </div>
            <div
              style="
                position: absolute;
                left: 77%;
                top: 60%;
                color: green;
                font-size: 10px;
                font-weight: bold;
              "
              :class="{
                     'nostatus': middleTwoDict.power.status !== 1,
                     'successstatus': middleTwoDict.power.status === 1
                   }"
            >
              电源
            </div>
          </div>
        </div>
        <div style="display: flex">
          <div class="s_box pm25">
            <div style="display: flex">
              <div class="s_title">【UPS设备】</div>
              <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
            </div>

            <div class="s_content">
              <div>
                <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of middleLeftOne" :key="index">
                  <span class="cy_name">{{ item.name }}:</span
                  ><span class="cy_val"><span
                  :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
                ><span class="cy_unit">{{ item.unit }}</span>
                </div>
              </div>
            </div>
          </div>
          <div class="s_box pm10 h_space">
            <div style="display: flex">
              <div class="s_title">【换膜器状态】</div>
              <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
            </div>
            <div class="s_content">
              <div>
                <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of middleRightOne" :key="index">
                  <span class="cy_name">{{ item.name }}:</span
                  ><span class="cy_val"><span
                  class="cy_val_success_inner">{{ item.value }}</span></span
                ><span class="cy_unit">个</span>
                </div>
              </div>
            </div>
            <div style="display: flex">
              <div class="s_title">【标准物质剩余量】</div>
              <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
            </div>
            <div class="s_content">
              <div>
                <template v-if="materialAvailable === false">
                  <div
                    class="cy_text nostatus material-placeholder-row"
                    v-for="(item, index) of materialPlaceholders"
                    :key="'material-ph-' + index"
                  >
                    <span class="cy_name">{{ item.materialName }}</span>
                    <div class="progress-container material-placeholder-bar">
                      <el-progress
                        :percentage="0"
                        stroke-width="18"
                        :show-text="false"
                        color="#555555"
                      />
                    </div>
                    <span class="cy_unit material-placeholder-unit">--/--</span>
                  </div>
                  <div class="material-placeholder-tip">{{ materialDisabledTip }}</div>
                </template>
                <template v-else>
                  <div
                    class="cy_text successstatus"
                    v-for="(item, index) of middleRightTwoMaterial"
                    :key="index"
                  >
                    <span class="cy_name">{{ item.materialName }}</span>
                      <div class="progress-container">

                        <el-progress
                          :percentage="getPercentage(item)"
                          :status="getStatus(item)"
                          stroke-width="18"
                          :show-text="false"
                        />
                      </div>
                    <span class="cy_unit">{{ calculatePercentage(item) }}%/{{ formatMaterialRemain(item) }}</span>
                  </div>
                </template>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="right h_space">
        <div class="s_box hm">
          <div style="display: flex">
            <div class="s_title">【气象监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>
          <div class="s_content">
            <div>
              <div class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of rightOne" :key="index">
                <span class="cy_name">{{ item.name }}:</span
                ><span class="cy_val"><span
                :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
              ><span class="cy_unit">{{ item.unit }}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="s_box fjzm">
          <div style="display: flex">
            <div class="s_title">【控制监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>
          <div class="s_content">
            <div>
              <div class="cy_text"  :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }" v-for="(item, index) of rightTwo" :key="index">
                <span class="cy_name">{{ item.name }}:</span
                ><span class="cy_val"><span
                :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
              ><span class="cy_unit">{{ item.unit }}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="s_box qx" style="height: 25rem">
          <div style="display: flex">
            <div class="s_title">【电力监测】</div>
            <div class="s_time"><span class="mini-sec-clock" aria-hidden="true"><span class="mini-sec-clock__hand"></span></span>{{ nowTime }}</div>
          </div>
          <div class="s_content">
            <div>
              <div
                class="cy_text" :class="{
                     'nostatus': item.status !== 1,
                     'successstatus': item.status === 1
                   }"
                v-for="(item, index) of rightThree"
                :key="index"
              >
                <span class="cy_name">{{ item.name }}:</span
                ><span class="cy_val"><span
                :class="{
                     'cy_val_no_inner': item.datastatus === -1,
                     'cy_val_success_inner': item.datastatus === 1,
                     'cy_val_error_inner': item.datastatus === 2
                   }">{{ item.value }}</span></span
              ><span class="cy_unit">{{ item.unit }}</span>
              </div>
            </div>
          </div>
        </div>
        <!-- <div class="s_box zd"></div> -->
      </div>
    </div>
    </div>
    
    <!-- 设备管理模式内容 -->
    <div v-else-if="displayMode === 'device-list'" class="device-list-content">
      <DeviceListComponent 
        @return-to-dashboard="handleReturnToDashboard"
        @switch-to-station-preview="handleSwitchToStationPreview"
        @update-device-data="handleDeviceDataUpdate"
        :device-data="deviceData"
        :display-mode="displayMode"
      />
    </div>
    
    <!-- 全域控制视图页面内容 -->
    <div v-else-if="displayMode === 'station-preview'" class="station-preview-content">
      <StationPreviewComponent 
        @return-to-list="handleReturnToList"
      />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import {getNowData, listindexAlarms} from "@/api/login";
// import App from '@/App.vue'
import date from "@/utils/date";
import { ElMessage } from 'element-plus';
import { recordPageVisit, getHomepageDisplayMode, saveHomepageDisplayMode } from '@/utils/pageState';
import DeviceListComponent from './index_list.vue';
import StationPreviewComponent from './station_preview.vue';
import { initStatusMapper } from '@/views/index/list/utils/statusMapper'
import {
  MATERIAL_DISABLED_TIP,
  ensureMaterialAvailable,
  fetchMaterialList,
  markMaterialUnavailable,
  notifyMaterialDisabledOnce
} from '@/views/index/utils/materialAvailability'
// 预加载状态字典
initStatusMapper().catch(err => {
  console.warn('状态字典加载失败:', err)
})
// app.mount("#app");
export default {
  name: "viewSet",
  components: {
    DeviceListComponent,
    StationPreviewComponent
  },
  data() {
    return {
      // 首页显示模式：'device-list'=设备列表模式，'dashboard'=大屏模式，'station-preview'=全域控制视图模式
      displayMode: 'device-list',
      // 设备数据 - 用于设备管理模式
      deviceData: [],
      nowTime: "",
      /** 秒针角度 */
      secHandDeg: 0,
      queryAlarmParams:{
        pageNum: 1,
        pageSize: 3
      },
      dataArr: [],
      odataArr: [],
      warnStyle: "font-weight: bold; font-size: 14px; text-align: center",
      dataList: [],
      statusDict: {
        "1.0": "正常",
        "0.0": "异常"
      },
      reverseStatusDict:{
        "1.0":"异常",
        "0.0":"正常"
      },
      alarmDict: {
        "0.0":"报警",
        "1.0":"正常"
      },
      reverseAlarmDict: {
        "0.0":"正常",
        "1.0":"报警"
      },
      switchDict:{
        "0.0":"关",
        "1.0":"开"
      },
      switch2Dict:{
        "0":"关",
        "1":"开"
      },
      reverseSwitchDict:{
        "1.0":"关",
        "0.0":"开"
      },
      leftOne: [
        {
          "name": "红外状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.security_alarm-ir_alarm",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "烟感1状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.security_alarm-smoke_1",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "烟感2状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.security_alarm-smoke_2",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "温感1状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.security_alarm-temp_alarm_1",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "温感2状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.security_alarm-temp_alarm_2",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "水浸状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.security_alarm-water_leak",
          "type": "value",
          "valuestatus": -1
      }],//左侧第一列
      leftTwo: [
        {
          "name": "PM10流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.pm10-current_flow",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "PM2.5流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.pm25-current_flow",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "SO2监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.so2-sample_flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.o3-sample_flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NO2监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.nox-sample_flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.co-sample_flow",
          "type": "value",
          "valuestatus": -1
        }
      ],//左侧第二列
      leftThree:[
        {
          "name": "站房温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.th-temperature",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房湿度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.th-humidity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "室内PM2.5浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.indoor_pollutant-pm25_indoor",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "室内PM10浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.indoor_pollutant-pm10_indoor",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "室内O3浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.indoor_pollutant-o3_indoor",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "室内CO浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.indoor_pollutant-co_indoor",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "室内NO2浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.indoor_pollutant-no2_indoor",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "室内SO2浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.indoor_pollutant-so2_indoor",
          "type": "value",
          "valuestatus": -1
        }
      ],//左侧第三列
      leftFour:[
        {
          "name": "采样管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.sampling_tube-temperature",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "采样管湿度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.sampling_tube-humidity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "采样管流速",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.sampling_tube-flow_velocity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "SO2支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.so2-branch_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.co-branch_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.o3-branch_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NO支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.nox-branch_temp",
          "type": "value",
          "valuestatus": -1
        }
        // ,{
        //   "name": "采样管滞留时间",
        //   "value": null,
        //   "unit": null,
        //   "status": -1,
        //   "id": "logicdevice_station.sampling_tube-residence_time",
        //   "type": "value",
        //   "valuestatus": -1
        // }
      ],//左侧第四列
      rightOne:[
        {
          "name": "风速",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.meteo-wind_speed",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "风向",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.meteo-wind_direction",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.meteo-temperature",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "湿度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.meteo-humidity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "大气压力",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.meteo-atmospheric_pressure",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "露点温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.meteo-dew_point",
          "type": "value",
          "valuestatus": -1
        }
      ],//右侧第一列
      rightTwo:[
        {
          "name": "照明控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.lighting-switch_status",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "风机控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.exhaust_fan-speed",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "空调1控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.air_conditioner.ac1-running_mode",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "空调2控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.air_conditioner.ac2-running_mode",
          "type": "value",
          "valuestatus": -1
        }, {
          "name": "零气继电器",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.zero_gas_relay-relay_status",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第一路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-relay_ch1",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "第二路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-relay_ch2",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "第三路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-relay_ch3",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "第四路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-relay_ch1",
          "type": "value",
          "valuestatus": -1
        }
      ],//右侧第二列
      rightThree:[
        {
          "name": "站房A相电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-voltage_a",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房B相电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-voltage_b",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房C相电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-voltage_c",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房A相电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-current_a",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房B相电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-current_b",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房C相电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-current_c",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "A相有功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-power_active_a",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "B相有功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-power_active_b",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "C相有功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-power_active_c",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "A相功率因数",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-power_factor_a",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "B相功率因数",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-power_factor_b",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "C相功率因数",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.power_meter-power_factor_c",
          "type": "value",
          "valuestatus": -1
        }
      ],//右侧第三列
      middleOne:[
        {
          "name": "PM",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.pm10-pm_concentration",
          "type": "value",
          "affix":"10",
          "valuestatus": -1
        },
        {
          "name": "PM",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.pm25-pm_concentration",
          "type": "value",
          "affix":"2.5",
          "valuestatus": -1
        },
        {
          "name": "CO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.co-co",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "SO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.so2-so2",
          "type": "value",
          "affix":"2",
          "valuestatus": -1
        },
        {
          "name": "O",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.o3-o3",
          "type": "value",
          "affix":"3",
          "valuestatus": -1
        },
        {
          "name": "NO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.nox-no",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "NO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.nox-no2",
          "type": "value",
          "affix":"2",
          "valuestatus": -1
        },
        {
          "name": "NO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.nox-nox",
          "type": "value",
          "affix":"x",
          "valuestatus": -1
        }
      ],//中间第一列
      middleTwoDict:{
        "CO":{
          "name": "CO设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.co-co",
          "type": "value",
          "valuestatus": -1
        },
        "O3":{
          "name": "O3设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.o3-o3",
          "type": "value",
          "valuestatus": -1
        },
        "NO2":{
          "name": "NO2设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.nox-no2",
          "type": "value",
          "valuestatus": -1
        },
        "SO2":{
          "name": "SO2设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.so2-so2",
          "type": "value",
          "valuestatus": -1
        },
        "PM10":{
          "name": "PM10设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.pm10-pm_concentration",
          "type": "value",
          "valuestatus": -1
        },
        "PM2_5":{
          "name": "PM2.5设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice.pm25-pm_concentration",
          "type": "value",
          "valuestatus": -1
        },
        "calib":{
          "name": "校准仪",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.calibrator-co_cylinder_concentration",
          "type": "value",
          "valuestatus": -1
        },
        "air":{
          "name": "空调",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.air_conditioner.ac1-running_mode",
          "type": "value",
          "valuestatus": -1
        },
        "sample_tube":{
          "name": "采样管",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.sampling_tube-flow_velocity",
          "type": "value",
          "valuestatus": -1
        },
        "power":{
          "name": "电源设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-current_ch1",
          "type": "value",
          "valuestatus": -1
        }
      },//大图中间
      middleLeftOne:[
        {
          "name": "UPS输入电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-input_voltage",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS输出电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-output_voltage",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS输出负载",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-load_percent",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS输入频率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-input_freq",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS电池电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-battery_voltage",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS电池温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-battery_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.ups-ups_status",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第一路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-voltage_ch1",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第二路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-voltage_ch2",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第三路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-voltage_ch3",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第四路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-voltage_ch4",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第一路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-current_ch1",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第二路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-current_ch2",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第三路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-current_ch3",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第四路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.voltage_regulator-current_ch4",
          "type": "value",
          "valuestatus": -1
        }
      ],//中间底部左侧
      middleRightOne:[
        {
          "name": "SO2滤膜剩余量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.so2-filter_remaining",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NOx滤膜剩余量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.nox-filter_remaining",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO滤膜剩余量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.co-filter_remaining",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3滤膜剩余量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "logicdevice_station.filter_changer.o3-filter_remaining",
          "type": "value",
          "valuestatus": -1
        }
      ],//中间底部右侧第一列
      middleRightTwo:[
        {
          "name": "SO2钢瓶气剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "logicdevice_station.standard_gas.so2-gas_pressure_remaining",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NOX钢瓶气剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "logicdevice_station.standard_gas.nox-gas_pressure_remaining",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO钢瓶气剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "logicdevice_station.standard_gas.co-gas_pressure_remaining",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "PM10纸带剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "logicdevice_station.paper_tape.pm10-remaining_spots",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "PM2.5纸带剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "logicdevice_station.paper_tape.pm25-remaining_spots",
          "type": "value",
          "valuestatus": -1
        }
      ],//中间底部右侧第二列
      alertKeywords:["报警","异常","关"],
      alarmNotityList:[], // 报警队列
      alarmNotityCount:3,
      alarmNewData:null,
      alarmOpen:false,
      // 新增定时器 ID 变量
      timeIntervalId1: null,
      timeIntervalId2: null,
      timeIntervalId3: null,
      // 大屏页面返回按钮相关
      isBackButtonVisible: true,
      activityTimerId: null,
      materialPollTimer: null,
      /** 未启用时的低频静默重探（不弹 404） */
      materialProbeTimer: null,
      /** keep-alive 下页面是否处于激活态 */
      pageActive: true,
      /** null=未探测，true/false=耗材集成是否可用 */
      materialAvailable: null,
      materialDisabledTip: MATERIAL_DISABLED_TIP,
      middleRightTwoMaterial: [],
      /** 耗材集成未启用时的示意条 */
      materialPlaceholders: [
        { materialName: 'SO2钢瓶气' },
        { materialName: 'NOX钢瓶气' },
        { materialName: 'CO钢瓶气' },
        { materialName: 'PM10纸带' },
        { materialName: 'PM2.5纸带' }
      ]
    };
  },
  watch: {
    displayMode() {
      this.syncDashboardPolling();
      this.syncDashboardClock();
      this.syncActivityDetection();
    }
  },
  mounted() {
    // 记录页面访问
    recordPageVisit('/index', {
      timestamp: Date.now(),
      action: 'page_load',
      userAgent: navigator.userAgent
    });
    
    // 恢复上次的首页显示模式
    const savedMode = getHomepageDisplayMode();
    if (savedMode === 'dashboard' || savedMode === 'station-preview') {
      this.displayMode = savedMode;
      console.log('恢复' + (savedMode === 'dashboard' ? '大屏' : '全域控制视图') + '模式');
    } else {
      this.displayMode = 'device-list';
      console.log('恢复设备列表模式');
    }

    // 大屏活动检测 / 时钟：仅大屏模式启用
    this.syncActivityDetection();
    this.syncDashboardClock();
    
    // 监听主题变化
    this.updateThemeClass();
    this.themeObserver = new MutationObserver(() => {
      this.updateThemeClass();
    });
    this.themeObserver.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['class']
    });

    // 大屏实时数据 / 耗材：仅大屏模式且页面激活时轮询
    this.syncDashboardPolling();

    this.timeIntervalId3 = setInterval(() => {
      if(this.alarmOpen){
        listindexAlarms(this.queryAlarmParams).then(response => {
          let newAlarms = response.rows.slice(0, 3);
          const handleDeletedItem = (alarm) =>{
            console.log("关闭通知"+alarm.row.alarmId)
            alarm.close();
          }
          const addToAlarmQueue = (alarm) =>{

            // 1. 检查元素是否已存在（基于 id 属性）
            const exists = this.alarmNotityList.some(item => item.row && item.row.alarmId === alarm.alarmId);
            if (exists) {
              console.log("不存在返回！"+alarm.alarmId)
              return; // 存在则直接返回，不执行后续操作
            }
            const notifydata = this.$notify({
              title: '报警-'+ alarm.startTime,
              message: `${alarm.description}`,
              duration: 0,
              type: 'error',
              position: 'bottom-right',
              dangerouslyUseHTMLString: true,
              onClose: () => {
                this.alarmNewData = new Date();
              }
            });
            notifydata.row = alarm;
            // 1. 先将新元素加入队列
            this.alarmNotityList.push(notifydata);
            console.log("塞入队列")
            this.alarmNotityList.sort((a, b) => {
              // 处理 startTime 为字符串的情况（如 "2024-07-10 12:00:00"）
              const timeA = new Date(a.row.startTime).getTime();
              const timeB = new Date(b.row.startTime).getTime();
              return timeA - timeB; // 从小到大排序（旧 -> 新）
            });
            // 3. 如果队列长度超过3，删除最旧的一条（数组第一个元素）
            if (this.alarmNotityList.length > 3) {
              // 删除最旧的元素（此时数组第一个元素是最旧的）
              const deletedItem = this.alarmNotityList.shift();
              // 空函数：用于后续处理被删除的元素（如需扩展）
              handleDeletedItem(deletedItem);
            }
          }
          newAlarms.forEach(newAlarm => {
            console.log("开始新增了！"+newAlarm.startTime)
            if(new Date(newAlarm.startTime.replace(' ', 'T')) > this.alarmNewData || !this.alarmNewData){
              setTimeout(() => addToAlarmQueue(newAlarm), 500);
            }
          });

        });
      }else{

      }

    }, 5000);
  },
  activated() {
    this.pageActive = true;
    this.syncDashboardPolling();
    this.syncDashboardClock();
    this.syncActivityDetection();
  },
  deactivated() {
    this.pageActive = false;
    this.stopDashboardDataPoll();
    this.stopMaterialPoll();
    this.stopDashboardClock();
    this.cleanupActivityDetection();
  },
  beforeUnmount() {
  this.stopDashboardClock();
  this.stopDashboardDataPoll();
  this.stopMaterialPoll();
  if (this.timeIntervalId3) {
    clearInterval(this.timeIntervalId3);
  }
  // 清理活动检测
  this.cleanupActivityDetection();
  // 清理主题观察器
  if (this.themeObserver) {
    this.themeObserver.disconnect();
  }
  },
  created() {
    //let that = this;
    //this.requestData();
    // this.handleData2();
    // this.handleData3()
  },
  directives: {
    'triple-click': {
      mounted(el, binding) {
        let clickCount = 0;
        let lastClickTime = 0;
        let clickTimer = null;
        const interval = 300;

        const handleClick = () => {
          const now = Date.now();
          clickCount++;

          if (clickTimer) clearTimeout(clickTimer);
          if (now - lastClickTime > interval) clickCount = 1;

          lastClickTime = now;
          clickTimer = setTimeout(() => {
            if (clickCount === 3) binding.value();
            clickCount = 0;
          }, interval);
        };

        el.addEventListener('click', handleClick);
        el.__tripleClickHandler = handleClick;
      },
      unmounted(el) {
        el.removeEventListener('click', el.__tripleClickHandler);
      }
    }
  },
  methods: {
    // 大屏页面活动检测相关方法
    syncActivityDetection() {
      if (this.pageActive && this.displayMode === 'dashboard') {
        this.setupActivityDetection();
      } else {
        this.cleanupActivityDetection();
      }
    },
    setupActivityDetection() {
      if (this._activityHandler) {
        this.resetActivityTimer();
        return;
      }
      // 绑定事件处理器
      this._activityHandler = this.resetActivityTimer.bind(this);
      
      // 监听鼠标移动、点击、滚动、触摸等事件
      const events = ['mousemove', 'mousedown', 'click', 'scroll', 'touchstart', 'touchmove', 'keydown'];
      events.forEach(event => {
        document.addEventListener(event, this._activityHandler, { passive: true });
      });
      
      // 启动定时器
      this.resetActivityTimer();
    },
    
    resetActivityTimer() {
      // 避免 mousemove 高频写入同一响应式值
      if (!this.isBackButtonVisible) {
        this.isBackButtonVisible = true;
      }
      
      // 清除之前的定时器
      if (this.activityTimerId) {
        clearTimeout(this.activityTimerId);
      }
      
      // 设置新的定时器，10秒后隐藏按钮
      this.activityTimerId = setTimeout(() => {
        this.isBackButtonVisible = false;
      }, 10000);
    },
    
    cleanupActivityDetection() {
      // 清除定时器
      if (this.activityTimerId) {
        clearTimeout(this.activityTimerId);
        this.activityTimerId = null;
      }
      
      // 移除事件监听
      if (this._activityHandler) {
        const events = ['mousemove', 'mousedown', 'click', 'scroll', 'touchstart', 'touchmove', 'keydown'];
        events.forEach(event => {
          document.removeEventListener(event, this._activityHandler);
        });
        this._activityHandler = null;
      }
    },

    /** 仅大屏可见时执行时钟 */
    syncDashboardClock() {
      if (this.pageActive && this.displayMode === 'dashboard') {
        this.startDashboardClock();
      } else {
        this.stopDashboardClock();
      }
    },
    startDashboardClock() {
      if (this.timeIntervalId1) {
        return;
      }
      this.tickClock();
      this.timeIntervalId1 = setInterval(() => {
        this.tickClock();
      }, 1000);
    },
    tickClock() {
      const now = new Date();
      this.nowTime = date.currDate();
      const sec = now.getSeconds();
      if (this._lastClockSecond == null) {
        this.secHandDeg = sec * 6;
      } else {
        let delta = sec - this._lastClockSecond;
        if (delta < 0) delta += 60;
        if (delta > 0) {
          this.secHandDeg += delta * 6;
        }
      }
      this._lastClockSecond = sec;
    },
    stopDashboardClock() {
      if (this.timeIntervalId1) {
        clearInterval(this.timeIntervalId1);
        this.timeIntervalId1 = null;
      }
      this._lastClockSecond = null;
    },
    
    /** 经典大屏且页面激活时才轮询 */
    shouldPollDashboard() {
      return this.pageActive && this.displayMode === 'dashboard';
    },
    syncDashboardPolling() {
      if (this.shouldPollDashboard()) {
        this.startDashboardDataPoll();
        this.startMaterialPoll();
      } else {
        this.stopDashboardDataPoll();
        this.stopMaterialPoll();
      }
    },
    startDashboardDataPoll() {
      if (this.timeIntervalId2) {
        return;
      }
      this.refreshDashboardData();
      this.timeIntervalId2 = setInterval(() => {
        this.refreshDashboardData();
      }, 5000);
    },
    stopDashboardDataPoll() {
      if (this.timeIntervalId2) {
        clearInterval(this.timeIntervalId2);
        this.timeIntervalId2 = null;
      }
    },
    refreshDashboardData() {
      getNowData().then(res => {
        this.dataList = res.data;
        this.handleData3(res.data);
      }).catch(err => {
        console.warn('大屏实时数据刷新失败:', err);
      });
    },
    async startMaterialPoll() {
      if (this.materialPollTimer || this.materialProbeTimer || this._materialPollStarting) {
        return;
      }
      this._materialPollStarting = true;
      try {
        const available = await ensureMaterialAvailable({ force: true });
        this.materialAvailable = available;
        if (!this.shouldPollDashboard()) {
          return;
        }
        if (available) {
          this.startMaterialDataPoll();
        } else {
          this.startMaterialProbe();
        }
      } finally {
        this._materialPollStarting = false;
      }
    },
    startMaterialDataPoll() {
      this.stopMaterialProbe();
      if (this.materialPollTimer) {
        return;
      }
      this.refreshMaterialData();
      this.materialPollTimer = setInterval(() => {
        this.refreshMaterialData();
      }, 5000);
    },
    /** 未启用：每 60s 静默重探，不走 fetchMaterialList，避免 404 toast */
    startMaterialProbe() {
      this.stopMaterialDataPoll();
      this.middleRightTwoMaterial = [];
      notifyMaterialDisabledOnce(ElMessage);
      if (this.materialProbeTimer) {
        return;
      }
      this.materialProbeTimer = setInterval(() => {
        this.reprobeMaterialAvailability();
      }, 60000);
    },
    async reprobeMaterialAvailability() {
      if (!this.shouldPollDashboard() || this._materialReprobing) {
        return;
      }
      this._materialReprobing = true;
      try {
        const available = await ensureMaterialAvailable({ force: true });
        if (!this.shouldPollDashboard()) {
          return;
        }
        if (available) {
          this.materialAvailable = true;
          this.startMaterialDataPoll();
        }
      } finally {
        this._materialReprobing = false;
      }
    },
    stopMaterialDataPoll() {
      if (this.materialPollTimer) {
        clearInterval(this.materialPollTimer);
        this.materialPollTimer = null;
      }
    },
    stopMaterialProbe() {
      if (this.materialProbeTimer) {
        clearInterval(this.materialProbeTimer);
        this.materialProbeTimer = null;
      }
    },
    stopMaterialPoll() {
      this.stopMaterialDataPoll();
      this.stopMaterialProbe();
    },
    refreshMaterialData() {
      fetchMaterialList().then(response => {
        const rows = response.rows || [];
        this.middleRightTwoMaterial = rows.map(row => this.normalizeMaterialRow(row));
      }).catch(err => {
        console.warn('耗材数据刷新失败:', err);
        markMaterialUnavailable();
        this.materialAvailable = false;
        this.startMaterialProbe();
      });
    },
    handleData3(datas){
      let data_dict = {};
      // 允许的 coordinate 列表
      const allowedCoordinates = [
        'com.ecat:integration-logicdevice-airstation',
        'com.ecat:integration-logicdevice-airdevice'
      ];
      // 组织数据 - 只筛选符合 coordinate 条件的设备
      datas.filter(data => allowedCoordinates.includes(data.coordinate)).forEach(data => {
        data_dict[data.uniqueId] = {
          "name": data.deviceName,
          "value": null,
          "unit":data.deviceModel,
          "status": data.deviceStatus,
          "id":data.uniqueId,
          "type": "value"
        };
        data.deviceAttrs.forEach(attr => {
          let status;
          // 判断attr.updateTime  是否存在 且和当前时间五分钟内
          if (attr.updateTime && new Date(attr.updateTime).getTime() > new Date().getTime() - 1000 * 60 * 5) {
            status = 1;
          }else{
            status = 0;
          }
          data_dict[data.uniqueId + "-" + attr.attributeID] = {
            "name": attr.displayName,
            "value": attr.displayValue,
            "unit":attr.displayUnit,
            "status": status,
            "id":attr.attributeID,
            "type": "value"
          };
        });
      });
      this.leftOne.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.leftTwo.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.leftThree.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.leftFour.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.rightOne.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.rightTwo.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.rightThree.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.middleOne.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.middleLeftOne.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.middleRightOne.forEach(item => {
        this.analysisData(item, data_dict);
      })
      this.middleRightTwo.forEach(item => {
        this.analysisData(item, data_dict);
      })

    // 遍历 [key, value] 对
      for (const [key, value] of Object.entries(this.middleTwoDict)) {
        this.analysisData(value, data_dict);
      }
      // {
      //   "name": "红外状态",
      //   "value": null,
      //   "unit": null,
      //   "status": -1,
      //   "id": "ce770a61-a794-42b0-bd74-7eec49f5bf3f-INFRARED_STATUS",
      //   "type": "alarm"
      // }


    },
    analysisData(item, data_dict){
      let id = item.id;
      let value = data_dict[id]?.value;
      let type = item.type;
      if(type == "value"){
        item.value =value;
      }else if(type == "alarm"){
        item.value = this.alarmDict[value] || value;
      }else if(type == "switch"){
        item.value = this.switchDict[value]  || value;
      }else if(type == "reverseSwitch"){
        item.value = this.reverseSwitchDict[value]  || value;
      }else if(type == "status"){
        item.value = this.statusDict[value]  || value;
      }else if(type == "reverseStatus"){
        item.value = this.reverseStatusDict[value]  || value;
      }else if(type == "switch2"){
        item.value = this.switch2Dict[value]  || value;
      }else if(type == "reverseAlarm"){
        item.value = this.reverseAlarmDict[value]  || value;
      }
      else{
        item.value = value;
      }

      // item.value = data_dict[id]?.value;
      item.unit = data_dict[id]? data_dict[id].unit : null;
      item.status = data_dict[id] ? data_dict[id].status : 0;
      if(item.status == 1){
        if(this.alertKeywords.includes(item.value)){
          item.datastatus = 2
        }else{
          item.datastatus = 1
        }
      }else{
        item.datastatus = -1
      }
      // 后续需要删除
      // item.value = Math.floor(Math.random() * 100) + 1;
    },
    analysisMapData(item, data_dict){
      let id = item.id;
      let value = data_dict[id]?.value;
      let type = data_dict[id]?.type;
      if(type == "value"){
        item.value =value;
      }else if(type == "alarm"){
        item.value = this.alarmDict.get(value);
      }else if(type == "switch"){
        item.value = this.switchDict.get(value);
      }else if(type == "reverseSwitch"){
        item.value = this.reverseSwitchDict.get(value);
      }else if(type == "status"){
        item.value = this.statusDict.get(value);
      }else if(type == "reverseStatus"){
        item.value = this.reverseStatusDict.get(value);
      }else{
        item.value = value;
      }

      // item.value = data_dict[id]?.value;
      item.unit = data_dict[id]? data_dict[id].unit : null;
      item.status = data_dict[id] ? data_dict[id].status : 0;
      if(item.status == 1){
        if(this.alertKeywords.includes(item.value)){
          item.datastatus = 2
        }else{
          item.datastatus = 1
        }
      }else{
        item.datastatus = 0
      }
    },
    //比对系统
    handleBD() {
      window.open("http://localhost:80", "_blank");
    },
    //页面跳转
    handleRoute(path) {
      this.$router.push({ path: path });
    },
    //跳转校准
    handleXZ() {
      this.$router.push({ path: "controlPage" });
    },
    handleStatus(status) {
      if (status == "1") {
        return "正常";
      } else {
        return "异常";
      }
    },

    //转换时间
    convertISOToLocal(isoString) {
      const date = new Date(isoString);
      return date.toLocaleString();
    },
    handleTripleClick() {
      const message = `已${this.alarmOpen ? '关闭' : '开启'}报警通知`;
      ElMessage({
        message: message,
        type: this.alarmOpen? 'warning' :'success' ,
        duration: 3000
      });
      this.alarmOpen = !this.alarmOpen;
    },
    // 处理logo三次点击切换到设备管理模式（保留兼容性）
    handleLogoTripleClick() {
      this.switchToMode('device-list', '设备管理模式');
    },
    
    // 处理从设备管理模式返回大屏模式
    handleReturnToDashboard() {
      this.switchToMode('dashboard', '大屏模式');
    },
    
    // 处理从全域控制视图返回列表页
    handleReturnToList() {
      this.switchToMode('device-list', '设备列表模式');
    },
    
    // 处理切换到全域控制视图模式
    handleSwitchToStationPreview() {
      this.switchToMode('station-preview', '全域控制视图模式');
    },
    
    // 通用模式切换方法
    switchToMode(mode, modeName) {
      // 记录页面访问状态
      recordPageVisit('/index', {
        timestamp: Date.now(),
        action: 'switch_to_' + mode,
        userAgent: navigator.userAgent
      });
      
      // 添加页面切换动画效果
      this.$el.style.transition = 'all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1)';
      this.$el.style.transform = 'translateX(-100%)';
      this.$el.style.opacity = '0.8';
      
      ElMessage({
        message: '正在切换到' + modeName + '...',
        type: 'info',
        duration: 1000
      });
      
      // 延迟切换模式，动效自然
      setTimeout(() => {
        this.displayMode = mode;
        // 保存当前显示模式
        saveHomepageDisplayMode(mode);
        // 重置动画效果
        this.$el.style.transition = 'all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1)';
        this.$el.style.transform = 'translateX(0)';
        this.$el.style.opacity = '1';
      }, 400);
    },
    
    // 更新主题类名
    updateThemeClass() {
      const container = this.$refs.container;
      if (container) {
        if (document.documentElement.classList.contains('dark')) {
          container.classList.remove('light-theme');
        } else {
          container.classList.add('light-theme');
        }
      }
    },
    
    // 处理设备数据更新
    handleDeviceDataUpdate(newDeviceData) {
      this.deviceData = newDeviceData;
    },
    
    /** 钢瓶气物资类型：1=CO 2=SO2 3=NOx */
    isGasCylinder(row) {
      return ['1', '2', '3'].includes(String(row && row.materialType));
    },
    /**
     * 解析 materialContent。
     * HTTP JSON 解码后该字段已是普通字符串（引号已去转义），再 JSON.parse 一次得到对象。
     * 兼容：已是对象、双重 stringify、解析失败。
     */
    parseMaterialContentRaw(raw) {
      if (raw == null || raw === '') {
        return {};
      }
      if (typeof raw === 'object' && !Array.isArray(raw)) {
        return raw;
      }
      if (typeof raw !== 'string') {
        return {};
      }
      let text = raw.trim();
      if (!text) {
        return {};
      }
      try {
        let parsed = JSON.parse(text);
        if (typeof parsed === 'string') {
          parsed = JSON.parse(parsed);
        }
        return parsed && typeof parsed === 'object' ? parsed : {};
      } catch (e) {
        return {};
      }
    },
    normalizeMaterialRow(row) {
      return {
        ...row,
        parsedContent: this.parseMaterialContentRaw(row && row.materialContent)
      };
    },
    getMaterialRatio(row) {
      if (this.isGasCylinder(row)) {
        const content = (row && row.parsedContent) || this.parseMaterialContentRaw(row && row.materialContent);
        const remain = Number(content.pressureRemain);
        const total = Number(content.total_pressure);
        if (!Number.isFinite(remain) || !Number.isFinite(total) || total <= 0) {
          return 0;
        }
        return remain / total;
      }
      const remain = Number(row && row.materialRemainCapacity);
      const total = Number(row && row.materialCapacity);
      if (!Number.isFinite(remain) || !Number.isFinite(total) || total <= 0) {
        return 0;
      }
      return remain / total;
    },
    calculatePercentage(row) {
      return (this.getMaterialRatio(row) * 100).toFixed(1);
    },
    getPercentage(row) {
      const pct = this.getMaterialRatio(row) * 100;
      if (pct < 0) return 0;
      if (pct > 100) return 100;
      return pct;
    },
    getStatus(row) {
      const ratio = this.getMaterialRatio(row);
      if (ratio < 0.2) return 'exception';
      if (ratio < 0.5) return 'warning';
      return 'success';
    },
    /** 钢瓶气：kPa → MPa 保留两位；纸带：剩余个数+单位 */
    formatMaterialRemain(row) {
      if (this.isGasCylinder(row)) {
        const content = (row && row.parsedContent) || this.parseMaterialContentRaw(row && row.materialContent);
        const kpa = Number(content.pressureRemain);
        if (!Number.isFinite(kpa)) {
          return '--MPa';
        }
        return (kpa / 1000).toFixed(2) + 'MPa';
      }
      const remain = row && row.materialRemainCapacity;
      const unit = (row && row.materialCapacityUnit) || '';
      return (remain != null ? remain : '--') + unit;
    }
  },
};
</script>

<style scoped>
@import "@/assets/css/init.css";
.container {
  background: url("@/assets/image/bg.jpg") repeat;
  background-size: 100%;
  width: 99%;
  min-height: 960px;
  background: #000; /* 将背景设为黑色 */
}

/* —— 低开销动效：只动 opacity/transform，且无限动画控制在少量节点 —— */
.dashboard-content {
  position: relative;
  --sec-deg: 0deg;
}

.dashboard-content .head {
  position: relative;
}

/* 顶栏底部氛围线（单元素） */
.dashboard-content .head::after {
  content: "";
  position: absolute;
  left: 8%;
  right: 8%;
  bottom: 0;
  height: 1px;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(0, 229, 255, 0.15),
    rgba(0, 229, 255, 0.75),
    rgba(0, 224, 102, 0.55),
    rgba(0, 229, 255, 0.15),
    transparent
  );
  transform-origin: center;
  animation: head-line-breathe 4.5s ease-in-out infinite;
  pointer-events: none;
}

@keyframes head-line-breathe {
  0%, 100% { opacity: 0.35; transform: scaleX(0.92); }
  50% { opacity: 0.95; transform: scaleX(1); }
}

/* 面板入场：一次性，不持续占 CPU */
.dashboard-content .s_box,
.dashboard-content .dh_data_panel {
  animation: panel-enter 0.5s ease-out backwards;
}

.dashboard-content .left .s_box:nth-child(1) { animation-delay: 0.04s; }
.dashboard-content .left .s_box:nth-child(2) { animation-delay: 0.1s; }
.dashboard-content .left .s_box:nth-child(3) { animation-delay: 0.16s; }
.dashboard-content .left .s_box:nth-child(4) { animation-delay: 0.22s; }
.dashboard-content .middle > .s_box:nth-child(1) { animation-delay: 0.08s; }
.dashboard-content .right .s_box:nth-child(1) { animation-delay: 0.12s; }
.dashboard-content .right .s_box:nth-child(2) { animation-delay: 0.18s; }
.dashboard-content .right .s_box:nth-child(3) { animation-delay: 0.24s; }
.dashboard-content .dh_data_panel:nth-child(1) { animation-delay: 0.14s; }
.dashboard-content .dh_data_panel:nth-child(2) { animation-delay: 0.18s; }
.dashboard-content .dh_data_panel:nth-child(3) { animation-delay: 0.22s; }
.dashboard-content .dh_data_panel:nth-child(4) { animation-delay: 0.26s; }
.dashboard-content .dh_data_panel:nth-child(5) { animation-delay: 0.3s; }
.dashboard-content .dh_data_panel:nth-child(6) { animation-delay: 0.34s; }

@keyframes panel-enter {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 区块标题扫光 */
.s_title {
  position: relative;
  overflow: hidden;
}

.s_title::after {
  content: "";
  position: absolute;
  top: 0;
  left: -40%;
  width: 35%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.18),
    transparent
  );
  transform: translateX(0);
  animation: title-scan 5.5s ease-in-out infinite;
  pointer-events: none;
}

.left .s_box:nth-child(1) .s_title::after { animation-delay: 0s; }
.left .s_box:nth-child(2) .s_title::after { animation-delay: 0.7s; }
.left .s_box:nth-child(3) .s_title::after { animation-delay: 1.4s; }
.left .s_box:nth-child(4) .s_title::after { animation-delay: 2.1s; }
.middle .s_title::after { animation-delay: 0.35s; }
.right .s_box:nth-child(1) .s_title::after { animation-delay: 1s; }
.right .s_box:nth-child(2) .s_title::after { animation-delay: 1.7s; }
.right .s_box:nth-child(3) .s_title::after { animation-delay: 2.4s; }

@keyframes title-scan {
  0%, 12% { transform: translateX(0); opacity: 0; }
  18% { opacity: 1; }
  45% { transform: translateX(320%); opacity: 1; }
  52%, 100% { transform: translateX(320%); opacity: 0; }
}

/* 大气环境监测卡片：悬停轻抬起（仅交互时合成） */
.dh_data_panel {
  transition: transform 0.2s ease, border-color 0.2s ease;
}

.dh_data_panel:hover {
  transform: translateY(-2px);
  border-color: rgba(0, 229, 255, 0.65);
}

.version-number {
  animation: version-soft-pulse 3.2s ease-in-out infinite;
}

@keyframes version-soft-pulse {
  0%, 100% { opacity: 0.78; }
  50% { opacity: 1; }
}

@media (prefers-reduced-motion: reduce) {
  .dashboard-content .head::after,
  .s_title::after,
  .version-number,
  .dashboard-content .s_box,
  .dashboard-content .dh_data_panel,
  .cy_val_error_inner,
  .successstatus::after,
  .errorstatus::after,
  .nostatus::after,
  .title {
    animation: none !important;
  }

  .mini-sec-clock__hand {
    transition: none !important;
  }

  .dh_data_panel:hover {
    transform: none;
  }
}

.container.station-preview-mode {
  width: 100%;
  /* 填满 app-main 内容区，避免父级页面出现滚动条 */
  height: calc(100vh - 84px);
  min-height: 0;
  background: var(--el-bg-color-page, #f5f7fa);
  overflow: hidden;
}

/* 全域控制视图模式 - 占满全屏 */
.station-preview-content {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  background-color: var(--el-bg-color-page, #f5f7fa);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

/* 返回列表页按钮样式 */
.back-to-list-btn {
  position: fixed;
  top: 10px;
  left: 10px;
  z-index: 9999;
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 16px;
  background: rgba(0, 0, 0, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 6px;
  color: #fff;
  cursor: pointer;
  opacity: 0; /* 默认透明 */
  transition: opacity 0.3s ease;
  user-select: none;
  pointer-events: auto; /* 始终可点击 */
}

.back-to-list-btn:hover {
  background: rgba(0, 0, 0, 0.8);
  border-color: rgba(255, 255, 255, 0.5);
}

.back-to-list-btn.btn-visible {
  opacity: 1; /* 显示状态 */
}

.back-icon {
  font-size: 18px;
  font-weight: bold;
}

.back-text {
  font-size: 14px;
  font-weight: 500;
}
.progress-container {
  display: flex;
  align-items: center; /* 垂直居中对齐 */
  gap: 10px; /* 进度条和文本之间的间距 */
  width: 20%; /* 确保容器有宽度 */
  background-color: rgba(128, 128, 128, 0.3);
}

/* 耗材未启用 */
.material-placeholder-row {
  opacity: 0.5;
}

.material-placeholder-bar {
  border: 1px dashed rgba(160, 160, 160, 0.55);
  background-color: rgba(70, 70, 70, 0.28) !important;
  border-radius: 2px;
}

.material-placeholder-bar :deep(.el-progress-bar__outer) {
  background-color: rgba(90, 90, 90, 0.45) !important;
}

.material-placeholder-unit {
  color: #8a8a8a !important;
  letter-spacing: 0.02em;
}

.material-placeholder-tip {
  margin-top: 0.35rem;
  padding-left: 1.2rem;
  font-size: 12px;
  color: rgba(150, 150, 150, 0.9);
  text-align: left;
  line-height: 1.4;
}


.progress-text {
  font-size: 14px;
  text-align: center;
}
.el-progress {
  flex: 1; /* 让进度条占满剩余空间 */
}
.nav {
  position: absolute;
  top: 0;
  right: 20px;
  display: flex;
  color: #fff;
  font-size: 1rem;
}
.nav_item {
  line-height: 55px;
  padding-top: 2px;
  cursor: pointer;
  width: 80px;
}
.nav_item_alarm {
  line-height: 55px;
  padding-top: 2px;
  cursor: pointer;
  width: 160px;
  height: 80px;
  user-select: none; /* 禁止文本被选中 */
  -webkit-user-select: none; /* 兼容 Safari 浏览器 */
  -moz-user-select: none; /* 兼容 Firefox 浏览器 */
  -ms-user-select: none; /* 兼容 IE/Edge 浏览器 */
  cursor: pointer; /* 鼠标悬停显示手型光标，提示可点击 */
  //background-color: #00e5ff;
}
.s_content {
  padding: 0.8rem;
}
.cy_text {
  width: 100%;
  color: #ccc;
  font-size: 0.9rem;
  text-align: left;
  display: flex; /* 使用 flex 布局 */
  align-items: center; /* 垂直居中对齐 */
}
.cy_text span {
  display: inline-block;
  text-align: center;
}
.cy_name {
  width: 40%;
  text-align: left;
}
.air_val {
  font-weight: bold;
  font-size: 14px;
  text-align: center;
  color: #fff;
  margin-top: 1rem;
}
.cy_val {
  width: 30%;
  text-align: center;
  //transition: all 0.5s ease;
}
/* 正常状态 - 绿色数值 */
.cy_val_success_inner {
  display: inline-block;
  position: relative;
  color: #00ff0c;
  text-shadow: 0 0 4px rgba(0, 255, 12, 0.75);
}

/* 无状态 - 灰色数值 */
.cy_val_no_inner {
  display: inline-block;
  position: relative;
  color: rgba(189, 189, 192, 0.99);
  text-shadow: 0 0 2px rgba(100, 100, 101, 0.6);
}

/* 错误状态 - 红色数值（仅告警保留轻量 opacity 动画） */
.cy_val_error_inner {
  display: inline-block;
  position: relative;
  color: #ff3333;
  text-shadow: 0 0 4px rgba(255, 51, 51, 0.75);
  animation: value-alert-pulse 2s infinite ease-in-out;
}

@keyframes value-alert-pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.72; }
}
.cy_unit {
  width: 30%;
  text-align: right;
}
.title {
  width: 70%;
  font-size: 36px;
  height: 60px;
  line-height: 60px;
  font-weight: 800;
  margin: 0 auto;
  text-align: center;
  background: linear-gradient(90deg,
  #000000,              /* 纯黑起点 */
  #252525,              /* 深灰过渡（提升亮度） */
  #404040,              /* 中灰过渡（增强辨识度） */
  #00e5ff,              /* 亮青色（高饱和） */
  #00c4ff,              /* 天蓝色（提亮） */
  #40d8ff,              /* 水蓝色（增强亮度） */
  #00e066,              /* 亮绿色（高饱和） */
  #fff200,              /* 亮黄色（高亮度） */
  #ff9966,              /* 珊瑚色（暖色调强化） */
  #ff9933,              /* 橙色（高饱和） */
  #ff6699,              /* 粉色（高亮度） */
  #9966ff,              /* 紫色（增强饱和度） */
  #bb88ff               /* 亮紫色（提亮） */
  );
  background-size: 500% 100%; /* 扩展渐变范围，使流动更平滑 */
  color: transparent;
  -webkit-background-clip: text;
  background-clip: text;
  /* 仅保留渐变位移；去掉多层 text-shadow 动画（每帧重绘代价高） */
  animation: gradientShift 18s linear infinite;
}
.version-number {
  color: #ffd700; /* 金色文字 */
  font-size: 14px; /* 字体大小 */
  font-weight: bold; /* 字体加粗 */
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5); /* 文字阴影 */
}
@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  100% { background-position: 100% 50%; } /* 改为单向循环，避免颜色折返模糊 */
}

/* 增强在黑色背景下的可读性 */
body {
  background-color: #000;
  //margin: 0;
  //padding: 50px 0;
  margin: 0;
  padding: 0;
}
.main {
  display: flex;
}
.left {
  width: 25%;
}
.middle {
  width: 50%;
}
.s_box {
  width: 100%;
  border: 1px solid rgb(110, 109, 109);
  margin-top: 1rem;
}
.s_box_dq {
  width: 1rem;
  height: 5rem;
  background: rgb(42, 161, 172);
}
.s_box_space {
  margin-left: 7rem;
}
.right {
  width: 25%;
}
.cyg {
  height: 12rem;
}
.s_title {
  width: 9.6rem;
  height: 2.4rem;
  background: rgb(6, 141, 145);
  line-height: 2.4rem;
  color: #fff;
  font-size: 0.96rem;
  font-weight: bold;
  text-align: left;
  padding-left: 0.6rem;
  /* 浮雕效果 */
  text-shadow:
    -1px -1px 1px rgba(0,0,0,0.2),
    1px 1px 1px rgba(255,255,255,0.3);
}
.s_time {
  margin-left: 2rem;
  line-height: 2.4rem;
  color: #fff;
  position: relative;
  white-space: nowrap;
}

/* 迷你秒针表 */
.mini-sec-clock {
  position: absolute;
  left: -1.05rem;
  top: 50%;
  width: 11px;
  height: 11px;
  margin-top: -5.5px;
  border: 1px solid rgba(170, 190, 200, 0.38);
  border-radius: 50%;
  box-sizing: border-box;
  pointer-events: none;
  opacity: 0.85;
}

.mini-sec-clock::after {
  content: "";
  position: absolute;
  left: 50%;
  top: 50%;
  width: 2px;
  height: 2px;
  margin: -1px 0 0 -1px;
  border-radius: 50%;
  background: rgba(190, 210, 220, 0.75);
}

.mini-sec-clock__hand {
  position: absolute;
  left: 50%;
  bottom: 50%;
  width: 1px;
  height: 4px;
  margin-left: -0.5px;
  border-radius: 1px;
  background: rgba(0, 229, 255, 0.72);
  transform-origin: bottom center;
  transform: rotate(var(--sec-deg, 0deg));
  transition: transform 0.18s linear;
}
.s_title::before {
  content: none;
}
.abc_elec {
  height: 13rem;
}
.hw {
  height: 14rem;
}
.ups {
  height: 13.7rem;
}
.pm25 {
  height: 3rem;
}
.pm10 {
  height: 3rem;
}
.hm {
  height: 12rem;
}
.fjzm {
  height: 16rem;
}
.qx {
  height: 12rem;
}
.zd {
  height: 13.6rem;
}
.h_space {
  margin-left: 0.8rem;
}
.v_space {
  margin-top: 0.9rem;
}
.dq_para {
  height: 10rem;
}
.m_view {
  height: 22rem;
  padding: 0.2rem;
  box-sizing: border-box;
}
.pm25 {
  height: 18rem;
  height: 22rem;
}
.pm10 {
  height: 22rem;
}
.logo {
  //background: url("@/assets/image/logo-sms.99073225.png");
  width: 265px;
  height: 55px;
  position: absolute;
  left: 0;
  top: 0;
}
.dh_data_panel {
  width: 7rem;
  height: 5rem;
  background: transparent;
  margin: 6px;
  text-align: left;
  color: #fff;
  border: 1px solid rgb(127, 127, 127);
}
/* 分层光晕呼吸灯效果 */
.successstatus,
.errorstatus,
.nostatus {
  position: relative;
  padding-left: 1.2rem;
}

.successstatus::before,
.errorstatus::before,
.nostatus::before {
  content: "";
  position: absolute;
  left: 0.15rem; /* 调整内层圆点位置使其居中 */
  top: 50%;
  transform: translateY(-50%);
  width: 0.5rem;
  height: 0.5rem;
  border-radius: 50%;
  z-index: 1;
}

/*
 * 状态点外圈
 * 仅告警态保留 opacity/transform 呼吸。
 */
.successstatus::after,
.errorstatus::after,
.nostatus::after {
  content: "";
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 0.8rem;
  height: 0.8rem;
  border-radius: 50%;
  opacity: 0.55;
  z-index: 0;
}

.successstatus::before { background: #00ff0c; }
.successstatus::after {
  background: rgba(0, 255, 12, 0.35);
  box-shadow: 0 0 6px 2px rgba(0, 255, 12, 0.45);
}

.errorstatus::before { background: #f30000; }
.errorstatus::after {
  background: rgba(243, 0, 0, 0.35);
  box-shadow: 0 0 6px 2px rgba(243, 0, 0, 0.45);
  animation: glow-pulse 1.2s infinite ease-in-out;
}

.nostatus::before { background: #646465; }
.nostatus::after {
  background: rgba(100, 100, 101, 0.35);
  box-shadow: 0 0 4px 1px rgba(100, 100, 101, 0.35);
}

/* 光晕呼吸动画（仅 opacity/transform，可合成层加速） */
@keyframes glow-pulse {
  0%, 100% {
    transform: translateY(-50%) scale(0.85);
    opacity: 0.35;
  }
  50% {
    transform: translateY(-50%) scale(1);
    opacity: 0.7;
  }
}
</style>
