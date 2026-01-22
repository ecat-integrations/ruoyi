<template>
  <div class="container" ref="container" id="container">
    <!-- 大屏首页内容 -->
    <div v-if="!isDeviceListMode" class="dashboard-content">
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
            <div class="s_time">{{ nowTime }}</div>
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
            <div class="s_time">{{ nowTime }}</div>
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
            <div class="s_time">{{ nowTime }}</div>
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
            <div class="s_time">{{ nowTime }}</div>
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
            <div class="s_time">{{ nowTime }}</div>
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
              <div class="s_time">{{ nowTime }}</div>
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
              <div class="s_time">{{ nowTime }}</div>
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
                ><span class="cy_unit">号位</span>
                </div>
              </div>
            </div>
            <div style="display: flex">
              <div class="s_title">【标准物质剩余量】</div>
              <div class="s_time">{{ nowTime }}</div>
            </div>
            <div class="s_content">
              <div>
                <div class="cy_text successstatus" v-for="(item, index) of middleRightTwoMaterial" :key="index">
                  <span class="cy_name">{{ item.materialName }}</span>
                    <div class="progress-container">

                      <el-progress
                        :percentage="getPercentage(item)"
                        :status="getStatus(item)"
                        stroke-width="18"
                        :show-text="false"
                      />
                    </div>
                  <span class="cy_unit">{{ calculatePercentage(item) }}%/{{ item.materialRemainCapacity }}{{item.materialCapacityUnit}}</span>
<!--                  <span class="cy_name">{{ item.name }}:</span-->
<!--                  ><span class="cy_val"><span-->
<!--                  :class="{-->
<!--                     'cy_val_no_inner': item.datastatus === -1,-->
<!--                     'cy_val_success_inner': item.datastatus === 1,-->
<!--                     'cy_val_error_inner': item.datastatus === 2-->
<!--                   }">{{ item.value }}</span></span-->
<!--                ><span class="cy_unit">{{ item.unit }}</span>-->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="right h_space">
        <div class="s_box hm">
          <div style="display: flex">
            <div class="s_title">【气象监测】</div>
            <div class="s_time">{{ nowTime }}</div>
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
            <div class="s_time">{{ nowTime }}</div>
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
            <div class="s_time">{{ nowTime }}</div>
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
    <div v-else class="device-list-content">
      <DeviceListComponent 
        @return-to-dashboard="handleReturnToDashboard"
        @update-device-data="handleDeviceDataUpdate"
        :device-data="deviceData"
        :is-device-list-mode="isDeviceListMode"
      />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import * as echarts from "echarts";
import {getNowData, listindexAlarms, listMaterialManager} from "@/api/login";
// import App from '@/App.vue'
import date from "@/utils/date";
import { ElMessage } from 'element-plus';
import { recordPageVisit, getHomepageDisplayMode, saveHomepageDisplayMode } from '@/utils/pageState';
import DeviceListComponent from './index_list.vue';
// app.mount("#app");
export default {
  name: "viewSet",
  components: {
    DeviceListComponent
  },
  data() {
    return {
      // 首页显示模式：false=大屏模式，true=设备管理模式
      isDeviceListMode: true,
      // 设备数据 - 用于设备管理模式
      deviceData: [],
      nowTime: "",
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
          "id": "sms-qc-infrared_status",
          "type": "alarm",
          "valuestatus": -1
        }, {
          "name": "烟感1状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-smoke_detector1",
          "type": "alarm",
          "valuestatus": -1
        }, {
          "name": "烟感2状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-smoke_detector2",
          "type": "alarm",
          "valuestatus": -1
        }, {
          "name": "温感1状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-temp_detector1",
          "type": "alarm",
          "valuestatus": -1
        }, {
          "name": "温感2状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-temp_detector2",
          "type": "alarm",
          "valuestatus": -1
        }, {
          "name": "水浸状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-water_leak_detector",
          "type": "alarm",
          "valuestatus": -1
      }],//左侧第一列
      leftTwo: [
        {
          "name": "PM10工况流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-pm10_working_flow",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "PM2.5工况流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-pm2_5_working_flow",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "PM10标况流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-pm10_std_flow",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "PM2.5标况流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-pm2_5_std_flow",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "SO2监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-so2-flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-o3-flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NO2监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-no2-flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO监测仪流量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-co-flow",
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
          "id": "sms-qc-bench_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房湿度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-bench_humidity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "PM2.5浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-pm2_5_concentration",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "PM10浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-pm10_concentration",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-o3_concentration_qc",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-co_concentration_qc",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NO2浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-no2_concentration_qc",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "SO2浓度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-so2_concentration_qc",
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
          "id": "sms-qc-sample_tube_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "采样管湿度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-sample_tube_humidity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "采样管流速",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-sample_tube_flow",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "SO2支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-so2_gas_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-co_gas_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-o3_gas_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NO支管温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-nox_gas_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "采样管滞留时间",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-sampling_tube_residence_time",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "露点温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-dew_point_temp",
          "type": "value",
          "valuestatus": -1
        }
      ],//左侧第四列
      rightOne:[
        {
          "name": "风速",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-wind_speed",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "风向",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-wind_direction",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "湿度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-humidity",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "大气压力",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-pressure",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "24小时雨量",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-rainfall_24h",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "太阳光总辐射",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "flying-wis-01-solar_radiation",
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
          "id": "sms-qc-light_control",
          "type": "switch",
          "valuestatus": -1
        }, {
          "name": "风机控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-fan_control",
          "type": "switch",
          "valuestatus": -1
        }, {
          "name": "空调1控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ac1_power",
          "type": "reverseSwitch",
          "valuestatus": -1
        }, {
          "name": "空调2控制",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ac2_power",
          "type": "reverseSwitch",
          "valuestatus": -1
        }, {
          "name": "零气继电器",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-zero_gas_relay",
          "type": "switch",
          "valuestatus": -1
        },
        {
          "name": "第一路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-relay_l1",
          "type": "switch2",
          "valuestatus": -1
        },{
          "name": "第二路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-relay_l2",
          "type": "switch2",
          "valuestatus": -1
        },{
          "name": "第三路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-relay_l3",
          "type": "switch2",
          "valuestatus": -1
        },{
          "name": "第四路开关状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-relay_l4",
          "type": "switch2",
          "valuestatus": -1
        }
      ],//右侧第二列
      rightThree:[
        {
          "name": "站房A相电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_ua",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房B相电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_ub",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房C相电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_uc",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房A相电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_ia",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房B相电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_ib",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "站房C相电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_ic",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "A相有功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_pa",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "B相有功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_pb",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "C相有功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_pc",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "A相无功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_qa",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "B相无功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_qb",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "C相无功功率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_qc",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "A相功率因数",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_pf_a",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "B相功率因数",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_pf_b",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "C相功率因数",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-station_pf_c",
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
          "id": "xianhe-pm10-PM",
          "type": "value",
          "affix":"10",
          "valuestatus": -1
        },
        {
          "name": "PM",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "xianhe-pm2.5-PM",
          "type": "value",
          "affix":"2.5",
          "valuestatus": -1
        },
        {
          "name": "CO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-co-co",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "SO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-so2-so2",
          "type": "value",
          "affix":"2",
          "valuestatus": -1
        },
        {
          "name": "O",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-o3-o3",
          "type": "value",
          "affix":"3",
          "valuestatus": -1
        },
        {
          "name": "NO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-no2-no",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "NO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-no2-no2",
          "type": "value",
          "affix":"2",
          "valuestatus": -1
        },
        {
          "name": "NO",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-no2-nox",
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
          "id": "esa-co-co",
          "type": "value",
          "valuestatus": -1
        },
        "O3":{
          "name": "O3设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-o3-o3",
          "type": "value",
          "valuestatus": -1
        },
        "NO2":{
          "name": "NO2设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-no2-no2",
          "type": "value",
          "valuestatus": -1
        },
        "SO2":{
          "name": "SO2设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "esa-so2-so2",
          "type": "value",
          "valuestatus": -1
        },
        "PM10":{
          "name": "PM10设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "xianhe-pm10-PM",
          "type": "value",
          "valuestatus": -1
        },
        "PM2_5":{
          "name": "PM2.5设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "xianhe-pm2.5-PM",
          "type": "value",
          "valuestatus": -1
        },
        "calib":{
          "name": "校准仪",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-calib-so2_std_gas_concentration",
          "type": "value",
          "valuestatus": -1
        },
        "air":{
          "name": "空调",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ac1_power",
          "type": "value",
          "valuestatus": -1
        },
        "sample_tube":{
          "name": "采样管",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-sample_tube_temp",
          "type": "value",
          "valuestatus": -1
        },
        "power":{
          "name": "电源设备",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-temperature",
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
          "id": "sms-qc-ups_input_voltage",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS输出电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ups_output_voltage",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS输出负载百分比",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ups_load_percent",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS输入频率",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ups_input_freq",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS电池单元电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ups_battery_voltage",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS电池温度",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ups_battery_temp",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "UPS状态",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-ups_status",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第一路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-voltage_l1",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第二路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-voltage_l2",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第三路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-voltage_l3",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第四路电压",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-voltage_l4",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第一路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-current_l1",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第二路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-current_l2",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第三路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-current_l3",
          "type": "value",
          "valuestatus": -1
        },
        {
          "name": "第四路电流",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-power-current_l4",
          "type": "value",
          "valuestatus": -1
        }
      ],//中间底部左侧
      middleRightOne:[
        {
          "name": "SO2换膜仪器位置",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-so2_film_changer_status",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NOx换膜仪器位置",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-nox_film_changer_status",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO换膜仪器位置",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-co_film_changer_status",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "O3换膜仪器位置",
          "value": null,
          "unit": null,
          "status": -1,
          "id": "sms-qc-o3_film_changer_status",
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
          "id": "sms-qc-gas_cylinder1_pressure",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "NOX钢瓶气剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "sms-qc-gas_cylinder2_pressure",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "CO钢瓶气剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "sms-qc-gas_cylinder3_pressure",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "PM10纸袋剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "sms-qc-gas_cylinder3_pressure",
          "type": "value",
          "valuestatus": -1
        },{
          "name": "PM2.5纸袋剩余量",
          "value": null,
          "unit": "%",
          "status": -1,
          "id": "sms-qc-gas_cylinder3_pressure",
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
      middleRightTwoMaterial: null
    };
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
    if (savedMode === 'device-list') {
      this.isDeviceListMode = true;
      console.log('恢复设备列表模式');
    } else {
      this.isDeviceListMode = false;
      console.log('恢复大屏模式');
    }
    
    // 监听主题变化
    this.updateThemeClass();
    this.themeObserver = new MutationObserver(() => {
      this.updateThemeClass();
    });
    this.themeObserver.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['class']
    });
    
    //获取当前时间
    this.timeIntervalId1 = setInterval(() => {
      this.nowTime = date.currDate();
    }, 1000);
    // 获取实时数据
    this.timeIntervalId2 = setInterval(() => {
      getNowData().then(res => {
        console.log(res);
        this.dataList = res.data;
        this.handleData3(res.data)
      });
      let  materialQuery = {
        pageNum: 1,
        pageSize: 100,
        materialStatus: 1
      };
      listMaterialManager(materialQuery).then(response => {
        this.middleRightTwoMaterial = response.rows;
      });

    }, 5000);

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
  beforeUnmount() {
  // 清除所有定时器
  if (this.timeIntervalId1) {
    clearInterval(this.timeIntervalId1);
  }
  if (this.timeIntervalId2) {
    clearInterval(this.timeIntervalId2);
  }
  if (this.timeIntervalId3) {
    clearInterval(this.timeIntervalId3);
  }
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
    handleData3(datas){
      let data_dict = {};
      // 组织数据
      datas.forEach(data => {
        data_dict[data.deviceId] = {
          "name": data.deviceName,
          "value": null,
          "unit":data.deviceModel,
          "status": data.deviceStatus,
          "id":data.deviceId,
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
          data_dict[data.deviceId + "-" + attr.attributeID] = {
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
      //   "id": "sms-qc-INFRARED_STATUS",
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
    // 处理logo三次点击切换到设备管理模式
    handleLogoTripleClick() {
      // 记录页面访问状态
      recordPageVisit('/index', {
        timestamp: Date.now(),
        action: 'switch_to_device_list_mode',
        userAgent: navigator.userAgent
      });
      
      // 添加页面切换动画效果
      this.$el.style.transition = 'all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1)';
      this.$el.style.transform = 'translateX(-100%)';
      this.$el.style.opacity = '0.8';
      
      ElMessage({
        message: '正在切换到设备管理模式...',
        type: 'info',
        duration: 1000
      });
      
      // 延迟切换模式，让动画效果更自然
      setTimeout(() => {
        this.isDeviceListMode = true;
        // 保存当前显示模式
        saveHomepageDisplayMode('device-list');
        // 重置动画效果
        this.$el.style.transition = 'all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1)';
        this.$el.style.transform = 'translateX(0)';
        this.$el.style.opacity = '1';
      }, 400);
    },
    
    // 处理从设备管理模式返回大屏模式
    handleReturnToDashboard() {
      // 记录页面访问状态
      recordPageVisit('/index', {
        timestamp: Date.now(),
        action: 'return_to_dashboard_mode',
        userAgent: navigator.userAgent
      });
      
      // 添加页面切换动画效果
      this.$el.style.transition = 'all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1)';
      this.$el.style.transform = 'translateX(100%)';
      this.$el.style.opacity = '0.8';
      
      ElMessage({
        message: '正在返回大屏模式...',
        type: 'info',
        duration: 1000
      });
      
      // 延迟切换模式，让动画效果更自然
      setTimeout(() => {
        this.isDeviceListMode = false;
        // 保存当前显示模式
        saveHomepageDisplayMode('dashboard');
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
    
    calculatePercentage(row){
      return (row.materialRemainCapacity / row.materialCapacity * 100).toFixed(1);
    },
    getPercentage(row){
      return row.materialRemainCapacity / row.materialCapacity * 100;
    },
    getStatus(row){
      const ratio = row.materialRemainCapacity / row.materialCapacity;
      if (ratio < 0.2) return 'exception';
      if (ratio < 0.5) return 'warning';
      return 'success';
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
.progress-container {
  display: flex;
  align-items: center; /* 垂直居中对齐 */
  gap: 10px; /* 进度条和文本之间的间距 */
  width: 20%; /* 确保容器有宽度 */
  background-color: rgba(128, 128, 128, 0.3);
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
  text-shadow: 0 0 3px rgba(0, 255, 12, 0.7);
  animation: value-breathing 2s infinite ease-in-out;
}

.cy_val_success_inner::after {
  content: "";
  position: absolute;
  inset: -0.5px;
  border-radius: 3px;
  background: rgba(0, 255, 12, 0.2);
  opacity: 0.5;
  z-index: -1;
  animation: glow-breathing 2s infinite ease-in-out;
}

/* 无状态 - 灰色数值 */
.cy_val_no_inner {
  display: inline-block;
  position: relative;
  color: rgba(189, 189, 192, 0.99);
  text-shadow: 0 0 2px rgba(100, 100, 101, 0.99);
  animation: value-breathing-no 2s infinite ease-in-out;
}

.cy_val_no_inner::after {
  content: "";
  position: absolute;
  inset: -0.5px;
  border-radius: 3px;
  background: rgba(153, 153, 153, 0.1);
  opacity: 0.3;
  z-index: -1;
  animation: glow-breathing-no 2s infinite ease-in-out;
}

/* 错误状态 - 红色数值 */
.cy_val_error_inner {
  display: inline-block;
  position: relative;
  color: #ff3333;
  text-shadow: 0 0 3px rgba(255, 51, 51, 0.7);
  animation: value-breathing-error 2s infinite ease-in-out;
}

.cy_val_error_inner::after {
  content: "";
  position: absolute;
  inset: -0.5px;
  border-radius: 3px;
  background: rgba(255, 51, 51, 0.2);
  opacity: 0.5;
  z-index: -1;
  animation: glow-breathing-error 2s infinite ease-in-out;
}

/* 共用呼吸动画 - 绿色 */
@keyframes value-breathing {
  0%, 100% {
    transform: scale(1);
    text-shadow: 0 0 3px rgba(0, 255, 12, 0.7);
  }
  50% {
    transform: scale(1);
    text-shadow: 0 0 8px rgba(0, 255, 12, 0.9);
  }
}

@keyframes glow-breathing {
  0%, 100% {
    opacity: 0.2;
    transform: scale(1);
  }
  50% {
    opacity: 0.3;
    transform: scale(1);
  }
}

/* 灰色呼吸动画 */
@keyframes value-breathing-no {
  0%, 100% {
    transform: scale(1);
    text-shadow: 0 0 2px rgba(153, 153, 153, 0.5);
  }
  50% {
    transform: scale(1);
    text-shadow: 0 0 5px rgba(153, 153, 153, 0.7);
  }
}

@keyframes glow-breathing-no {
  0%, 100% {
    opacity: 0.2;
    transform: scale(1);
  }
  50% {
    opacity: 0.3;
    transform: scale(1);
  }
}

/* 红色呼吸动画 */
@keyframes value-breathing-error {
  0%, 100% {
    transform: scale(1);
    text-shadow: 0 0 3px rgba(255, 51, 51, 0.7);
  }
  50% {
    transform: scale(1);
    text-shadow: 0 0 8px rgba(255, 51, 51, 0.9);
  }
}

@keyframes glow-breathing-error {
  0%, 100% {
    opacity: 0.2;
    transform: scale(1);
  }
  50% {
    opacity: 0.3;
    transform: scale(1);
  }
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
  animation:
    gradientShift 12s ease infinite, /* 加速动画周期，提升活跃度 */
    glowEffect 3s ease-in-out infinite; /* 延长发光动画周期，减少闪烁感 */
  text-shadow: 0 0 18px rgba(255, 255, 255, 0.4); /* 增强文字光晕，提升边缘清晰度 */
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

@keyframes glowEffect {
  0%, 100% { text-shadow: 0 0 12px rgba(255, 255, 255, 0.3); }
  50% { text-shadow: 0 0 25px rgba(255, 255, 255, 0.7),
  0 0 35px rgba(0, 229, 255, 0.5),
  0 0 45px rgba(153, 102, 255, 0.4); }
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
}
.s_title::before {
  content: "";
  //display: inline-block;
  //width: 0.7rem;
  //height: 0.7rem;
  //line-height: 2.4rem;
  //margin-right: 0.6rem;
  //background: rgb(208, 208, 208);
  //border-radius: 50%;
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
  background: url("@/assets/image/logo-sms.99073225.png");
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

/* 居中对齐的外层光晕 */
.successstatus::after,
.errorstatus::after,
.nostatus::after {
  content: "";
  position: absolute;
  left: 0; /* 从0开始计算确保居中 */
  top: 50%;
  transform: translateY(-50%);
  width: 0.8rem; /* 略微减小尺寸以确保完美居中 */
  height: 0.8rem;
  border-radius: 50%;
  opacity: 0.4;
  z-index: 0;
  animation: glow-pulse 2s infinite ease-in-out;
  filter: blur(1.5px);
  -webkit-filter: blur(1.5px);
}

.successstatus::before { background: #00ff0c; }
.successstatus::after { background: #00ff0c; }

.errorstatus::before { background: #f30000; }
.errorstatus::after { background: #f30000; }

.nostatus::before { background: #646465; }
.nostatus::after { background: #646465; }

/* 光晕呼吸动画 */
@keyframes glow-pulse {
  0%, 100% {
    transform: translateY(-50%) scale(0.8);
    opacity: 0.3;
  }
  50% {
    transform: translateY(-50%) scale(1);
    opacity: 0.7;
  }
}
</style>
