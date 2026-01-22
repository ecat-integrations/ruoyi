<template>
   <div class="app-container">
      <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
         <el-form-item label="任务名称" prop="jobName">
            <el-input
               v-model="queryParams.jobName"
               placeholder="请输入任务名称"
               clearable
               style="width: 200px"
               @keyup.enter="handleQuery"
            />
         </el-form-item>
         <el-form-item label="任务组名" prop="jobGroup">
            <el-select v-model="queryParams.jobGroup" placeholder="请选择任务组名" clearable style="width: 200px">
               <el-option
                  v-for="dict in sys_job_group"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
               />
            </el-select>
         </el-form-item>
         <el-form-item label="任务状态" prop="status">
            <el-select v-model="queryParams.status" placeholder="请选择任务状态" clearable style="width: 200px">
               <el-option
                  v-for="dict in sys_job_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
               />
            </el-select>
         </el-form-item>
         <el-form-item>
            <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
         </el-form-item>
      </el-form>

      <el-row :gutter="10" class="mb8">
         <el-col :span="1.5">
            <el-button
               type="primary"
               plain
               icon="Plus"
               @click="handleAdd"
               v-hasPermi="['monitor:job:add']"
            >新增</el-button>
         </el-col>
         <el-col :span="1.5">
            <el-button
               type="success"
               plain
               icon="Edit"
               :disabled="single"
               @click="handleUpdate"
               v-hasPermi="['monitor:job:edit']"
            >修改</el-button>
         </el-col>
         <el-col :span="1.5">
            <el-button
               type="danger"
               plain
               icon="Delete"
               :disabled="multiple"
               @click="handleDelete"
               v-hasPermi="['monitor:job:remove']"
            >删除</el-button>
         </el-col>
         <el-col :span="1.5">
            <el-button
               type="warning"
               plain
               icon="Download"
               @click="handleExport"
               v-hasPermi="['monitor:job:export']"
            >导出</el-button>
         </el-col>
         <el-col :span="1.5">
            <el-button
               type="info"
               plain
               icon="Operation"
               @click="handleJobLog"
               v-hasPermi="['monitor:job:query']"
            >日志</el-button>
         </el-col>
         <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
      </el-row>

      <el-table v-loading="loading" :data="jobList"
                @selection-change="handleSelectionChange"
                @sort-change="handleSortChange"
      >
         <el-table-column type="selection" width="55" align="center" />
         <el-table-column label="任务编号" width="100" align="center" prop="jobId"  sortable="custom"/>
         <el-table-column label="任务名称" align="center" prop="jobName" :show-overflow-tooltip="true"  sortable="custom"/>
         <el-table-column label="任务组名" align="center" prop="jobGroup"  sortable="custom">
            <template #default="scope">
               <dict-tag :options="sys_job_group" :value="scope.row.jobGroup" />
            </template>
         </el-table-column>
         <!--<el-table-column label="调用目标字符串" align="center" prop="invokeTarget" :show-overflow-tooltip="true" />-->
         <!-- 替换为语义化的执行任务详情 -->
         <el-table-column label="执行任务详情" align="center" >
           <template #default="scope">
             <el-tooltip effect="dark" placement="top">
               <template #content>
                 <div class="task-detail-tooltip">
                   {{ parseInvokeTarget(scope.row.invokeTarget) }}
                 </div>
               </template>
               <div class="ellipsis-text">
                 {{ parseInvokeTarget(scope.row.invokeTarget) }}
               </div>
             </el-tooltip>
           </template>
         </el-table-column>
         <!--<el-table-column label="cron执行表达式" align="center" prop="cronExpression" :show-overflow-tooltip="true" />-->
         <!-- 替换为语义化的执行时间周期 -->
         <el-table-column label="执行时间周期" align="center" :show-overflow-tooltip="true">
           <template #default="scope">
<!--            {{ parseCronExpression(scope.row.cronExpression) }}-->
            {{ analysisCrontab(scope.row.cronExpression) }}
           </template>
         </el-table-column>
        <el-table-column label="下次执行时间" align="center" prop="nextValidTime" sortable="custom"
                         :show-overflow-tooltip="true"
                         @sort-change="handleSortChange">
          <template #default="scope">
            {{ parseTime(scope.row.nextValidTime) }}
          </template>
          <template #header="scope">
            <el-tooltip content="点击排序仅对当前页有效" placement="top" :disabled="scope.column.property !== 'nextValidTime'">
              <span @click="handleSortChange({ column: scope.column, prop: 'nextValidTime', order: scope.column.order === 'ascending' ? 'descending' : 'ascending'  })">
                下次执行时间
              </span>
            </el-tooltip>
          </template>
        </el-table-column>
         <el-table-column label="自动运行" align="center">
            <template #default="scope">
               <el-switch
                  v-model="scope.row.status"
                  active-value="0"
                  inactive-value="1"
                  @change="handleStatusChange(scope.row)"
               ></el-switch>
            </template>
         </el-table-column>
         <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
            <template #default="scope">
               <el-tooltip content="修改" placement="top">
                  <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['monitor:job:edit']"></el-button>
               </el-tooltip>
               <el-tooltip content="删除" placement="top">
                  <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['monitor:job:remove']"></el-button>
               </el-tooltip>
               <el-tooltip content="执行一次" placement="top">
                  <el-button link type="primary" icon="CaretRight" @click="handleRun(scope.row)" v-hasPermi="['monitor:job:changeStatus']"></el-button>
               </el-tooltip>
               <el-tooltip content="任务详细" placement="top">
                  <el-button link type="primary" icon="View" @click="handleView(scope.row)" v-hasPermi="['monitor:job:query']"></el-button>
               </el-tooltip>
               <el-tooltip content="调度日志" placement="top">
                  <el-button link type="primary" icon="Operation" @click="handleJobLog(scope.row)" v-hasPermi="['monitor:job:query']"></el-button>
               </el-tooltip>
            </template>
         </el-table-column>
      </el-table>

      <pagination
         v-show="total > 0"
         :total="total"
         v-model:page="queryParams.pageNum"
         v-model:limit="queryParams.pageSize"
         @pagination="getList"
      />

      <!-- 添加或修改定时任务对话框 -->
      <el-dialog :title="title" v-model="open" width="820px" append-to-body>
         <el-form ref="jobRef" :model="form" :rules="rules" label-width="120px">
            <el-row>
               <el-col :span="12">
                  <el-form-item label="任务名称" prop="jobName">
                    <el-input v-model="form.jobName" placeholder="非必填，可自动生成" />
                  </el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="任务分组" prop="jobGroup">
                     <el-select v-model="form.jobGroup" placeholder="请选择">
                        <el-option
                           v-for="dict in sys_job_group"
                           :key="dict.value"
                           :label="dict.label"
                           :value="dict.value"
                        ></el-option>
                     </el-select>
                  </el-form-item>
               </el-col>
               <el-col :span="24">
                  <el-form-item prop="invokeTarget">
                     <template #label>
                        <span>
                           调用方法
                           <el-tooltip placement="top">
                              <template #content>
                                 <div>
                                    质控调用方式：点击右侧设置按钮进行选择设置。
                                    <br />巡检调用方式：点击右侧设置按钮进行选择设置。
                                    <br />维护调用方式：点击右侧设置按钮进行选择设置。
                                    <br />人工核查调用方式：点击右侧编辑按钮进行设置。
                                    <br />自定义方式：填写调用方法。
                                 </div>
                              </template>
                              <el-icon><question-filled /></el-icon>
                           </el-tooltip>
                        </span>
                     </template>
<!--                     <el-input v-model="form.invokeTarget" placeholder="请输入调用目标字符串" />-->
                    <!-- 新增条件渲染-质控类型 -->
                    <template v-if="form.jobGroup === 'ManualCheck'">
                      <el-input v-model="form.invokeTarget" placeholder="人工核查任务参数设置" readonly disabled>
                        <template #append>
                          <el-button type="primary" icon="Edit" @click="handleManualCheckOpen"></el-button>
                        </template>
                      </el-input>
                    </template>

                    <template v-if="form.jobGroup === 'QualityControl'">
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="请设置质控任务"
                        readonly
                        disabled
                      >
                        <template #append>
                          <el-button
                            type="primary"
                            icon="Setting"
                            @click="handleQualityControlOpen"
                          ></el-button>
                        </template>
                      </el-input>
                    </template>

                    <template v-else-if="form.jobGroup === 'Patrol'">
                      <!-- 巡检分组新增逻辑 -->
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="巡检任务参数设置"
                        readonly
                        disabled
                      >
                        <template #append>
                          <el-button
                            type="primary"
                            icon="Setting"
                            @click="handlePatrolOpen"
                          ></el-button>
                        </template>
                      </el-input>
                    </template>
                    <template v-else-if="form.jobGroup === 'Maintenance'">
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="维护任务参数设置"
                        readonly
                        disabled
                      >
                        <template #append>
                          <el-button
                            type="primary"
                            icon="Tools"
                            @click="handleMaintenanceOpen"
                          ></el-button>
                        </template>
                      </el-input>
                    </template>
                    <template v-else-if="form.jobGroup === 'aggregationDataTask'">
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="聚合数据设置"
                        readonly
                        disabled
                      >
                        <template #append>
                          <el-button
                            type="primary"
                            icon="Tools"
                            @click="handleAggregationDataTaskOpen"
                          ></el-button>
                        </template>
                      </el-input>
                    </template>
                    <template v-else-if="form.jobGroup === 'ExecuteSiChuanHj212RuleTask'">
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="数据推送设置"
                        readonly
                        disabled
                      >
                        <template #append>
                          <el-button
                            type="primary"
                            icon="Tools"
                            @click="handleExecuteHj212RuleTaskOpen"
                          ></el-button>
                        </template>
                      </el-input>
                    </template>
                    <template v-else-if="form.jobGroup === 'CreatePartitionTablesTask'">
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="创建分表参数设置"
                        readonly
                        disabled
                      >
                        <template #append>
                          <el-button
                            type="primary"
                            icon="Tools"
                            @click="handlePartitionOpen"
                          ></el-button>
                        </template>
                      </el-input>
                    </template>
                    <template v-else>
                      <el-input
                        v-model="form.invokeTarget"
                        placeholder="请输入调用目标字符串"
                      />
                    </template>

                    <div
                        :class="['invoke-target-help-text', form.invokeTarget ? 'valid-invoke' : 'invalid-invoke']"
                    >
                      调用方法解释：{{parseInvokeTarget(form.invokeTarget)}}
                    </div>
                  </el-form-item>
               </el-col>
               <el-col :span="24">
                  <el-form-item label="cron表达式" prop="cronExpression">
                     <el-input v-model="form.cronExpression" placeholder="请输入cron执行表达式">
                        <template #append>
                           <el-button type="primary" @click="handleShowCron">
                              生成表达式
                              <i class="el-icon-time el-icon--right"></i>
                           </el-button>
                        </template>
                     </el-input>
                     <div
                         :class="['cron-help-text', form.cronExpression ? 'valid-cron' : 'invalid-cron']"
                     >
                        执行周期解释：<span>{{ analysisCrontab(form.cronExpression) }}</span>
                     </div>
                  </el-form-item>
               </el-col>
               <el-col :span="24" v-if="form.jobId !== undefined">
                  <el-form-item label="状态">
                     <el-radio-group v-model="form.status">
                        <el-radio
                           v-for="dict in sys_job_status"
                           :key="dict.value"
                           :value="dict.value"
                        >{{ dict.label }}</el-radio>
                     </el-radio-group>
                  </el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="执行策略" prop="misfirePolicy">
                     <template #label>
                        <span>
                           执行策略
                           <el-tooltip placement="top">
                              <template #content>
                                 <div>
                                    <br />“立即执行”“执行一次”“放弃执行” 属于任务错过触发时间后的执行策略，主要用于处理任务因各种原因（如服务重启、任务阻塞、手动暂停后恢复等）未能按原定计划触发时的行为。
                                    <br /> - 立即执行（立即触发） 立即触发当任务错过原定触发时间（例如任务设定每天 10 点执行，但因服务凌晨 9 点重启，10 点时未启动完成），恢复正常后会立即补执行一次，之后仍按原调度规则（如每天 10 点）继续运行
                                    <br /> - 执行一次（仅补执行一次） 任务错过触发时间后，恢复正常时仅补执行一次错过的那次任务，但不会影响后续的正常调度（即后续仍按原计划执行）
                                    <br /> - 放弃执行（不补执行） 任务错过触发时间后，恢复正常时不补执行错过的任务，直接等待下一次原定计划的触发时间。
                                 </div>
                              </template>
                              <el-icon><question-filled /></el-icon>
                           </el-tooltip>
                        </span>
                     </template>
                     <el-radio-group v-model="form.misfirePolicy">
                        <el-radio-button value="1">立即执行</el-radio-button>
                        <el-radio-button value="2">执行一次</el-radio-button>
                        <el-radio-button value="3">放弃执行</el-radio-button>
                     </el-radio-group>
                  </el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="是否并发" prop="concurrent">
                     <el-radio-group v-model="form.concurrent">
                        <el-radio-button value="0">允许</el-radio-button>
                        <el-radio-button value="1">禁止</el-radio-button>
                     </el-radio-group>
                  </el-form-item>
               </el-col>
            </el-row>
         </el-form>
         <template #footer>
            <div class="dialog-footer">
               <el-button type="primary" @click="submitForm">确 定</el-button>
               <el-button @click="cancel">取 消</el-button>
            </div>
         </template>
      </el-dialog>

     <el-dialog title="Cron表达式生成器" v-model="openCron" append-to-body destroy-on-close>
       <crontab ref="crontabRef" @hide="openCron=false" @fill="crontabFill" :expression="expression"></crontab>
     </el-dialog>

      <!-- 任务日志详细 -->
      <el-dialog title="任务详细" v-model="openView" width="700px" append-to-body>
         <el-form :model="form" label-width="120px">
            <el-row>
               <el-col :span="12">
                  <el-form-item label="任务编号：">{{ form.jobId }}</el-form-item>
                  <el-form-item label="任务名称：">{{ form.jobName }}</el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="任务分组：">{{ jobGroupFormat(form) }}</el-form-item>
                  <el-form-item label="创建时间：">{{ form.createTime }}</el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="cron表达式：">{{ form.cronExpression }}</el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="下次执行时间：">{{ parseTime(form.nextValidTime) }}</el-form-item>
               </el-col>
               <el-col :span="24">
                  <el-form-item label="调用目标方法：">{{ form.invokeTarget }}</el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="任务状态：">
                     <div v-if="form.status == 0">正常</div>
                     <div v-else-if="form.status == 1">暂停</div>
                  </el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="是否并发：">
                     <div v-if="form.concurrent == 0">允许</div>
                     <div v-else-if="form.concurrent == 1">禁止</div>
                  </el-form-item>
               </el-col>
               <el-col :span="12">
                  <el-form-item label="执行策略：">
                     <div v-if="form.misfirePolicy == 0">默认策略</div>
                     <div v-else-if="form.misfirePolicy == 1">立即执行</div>
                     <div v-else-if="form.misfirePolicy == 2">执行一次</div>
                     <div v-else-if="form.misfirePolicy == 3">放弃执行</div>
                  </el-form-item>
               </el-col>
            </el-row>
         </el-form>
         <template #footer>
            <div class="dialog-footer">
               <el-button @click="openView = false">关 闭</el-button>
            </div>
         </template>
      </el-dialog>

     <!-- 新增人工核查任务设置对话框 -->
     <el-dialog
         title="人工核查任务参数设置"
         v-model="manualCheckOpen"
         width="400px"
         append-to-body
         @close="handleManualCheckClose"
     >
       <el-form
           ref="manualCheckFormRef"
           :model="manualCheckForm"
           :rules="manualCheckRules"
           label-width="140px"
       >
         <!-- 气体类型 -->
         <el-form-item label="气体类型" prop="gas">
           <el-select v-model="manualCheckForm.gas" placeholder="请选择气体类型" clearable style="width: 200px">
             <el-option
                 v-for="item in gasOptions"
                 :key="item.value"
                 :label="item.label"
                 :value="item.value"
             />
           </el-select>
         </el-form-item>

         <!-- 通气时间 -->
         <el-form-item label="稳定时间(秒)" prop="genGasTime">
           <el-input-number v-model.number="manualCheckForm.genGasTime" :min="0" :max="9600" />
         </el-form-item>

         <!-- 读取次数 -->
         <el-form-item label="读取次数(次)" prop="readDataCount">
           <el-input-number v-model.number="manualCheckForm.readDataCount" :min="0" :max="1000" />
         </el-form-item>

         <!-- 读取间隔 -->
         <el-form-item label="读取间隔(秒)" prop="readDataSpan">
           <el-input-number v-model.number="manualCheckForm.readDataSpan" :min="0" :max="3600" />
         </el-form-item>

         <!-- 气体浓度 -->
         <el-form-item :label="`气体浓度(${manualCheckForm.gas === 'CO' ? 'ppm' : 'ppb'})`" prop="genGasConc">
           <el-input-number v-model.number="manualCheckForm.genGasConc" :min="0" :step="0.01" />
         </el-form-item>

         <!--标准气入口-->
         <el-form-item label="标准气入口" prop="stdGasInPortName">
           <el-radio-group v-model="manualCheckForm.stdGasInPortName">
             <el-tooltip content="采用校准口" placement="top">
               <el-radio label="跨度检查" >跨度检查</el-radio>
             </el-tooltip>
             <el-tooltip content="采用采样口" placement="top">
               <el-radio label="测量">测量</el-radio>
             </el-tooltip>
           </el-radio-group>
         </el-form-item>
       </el-form>

       <!-- 说明信息 -->
       <el-form-item label="" prop="textInfo" class="task-detail-tooltip">
         <el-icon><InfoFilled /></el-icon> &nbsp;&nbsp;通入{{ formatConcentrationDisplay(manualCheckForm.genGasConc || 0, manualCheckForm.gas || 'CO') }} {{ manualCheckForm.gas || 'CO' }}气, 稳定{{ formatSecondsToMinutes(manualCheckForm.genGasTime || 0) }}后, 读取{{ formatReadTime((manualCheckForm.readDataSpan || 0) * (manualCheckForm.readDataCount || 0)) }}的稳定值
         <span /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(每{{ manualCheckForm.readDataSpan || 0 }}秒一个数, 读取{{ manualCheckForm.readDataCount || 0 }}次)
       </el-form-item>

       <template #footer>
         <div class="dialog-footer">
           <el-button @click="manualCheckOpen = false">取消</el-button>
           <el-button type="primary" @click="handleManualCheckConfirm">确认</el-button>
         </div>
       </template>
     </el-dialog>
     <!-- 新增质控任务设置页面 -->
     <el-dialog
       title="质控任务参数设置"
       v-model="qualityControlOpen"
       width="400px"
       append-to-body
       @close="handleQualityControlClose"
     >
       <el-form
         ref="qcFormRef"
         :model="qcForm"
         :rules="qcRules"
         label-width="100px"
       >
         <el-form-item label="选择参数" prop="parameter">
           <el-select
             v-model="qcForm.parameter"
             placeholder="请选择参数"
             clearable
           >
             <el-option
               v-for="item in qualityParameters"
               :key="item.value"
               :label="item.label"
               :value="item.value"
             />
           </el-select>
         </el-form-item>

         <el-form-item label="质控类型" prop="qcType">
           <el-select
             v-model="qcForm.qcType"
             placeholder="请选择质控类型"
             clearable
           >
             <el-option
               v-for="item in qualityControlTypes"
               :key="item.value"
               :label="item.label"
               :value="item.value"
             />
           </el-select>
         </el-form-item>

         <el-form-item label="质控浓度" prop="qcConcentration">
           <el-input-number
             v-model.number="qcForm.qcConcentration"
             placeholder="请输入质控浓度"
             :min="0"
             precision="2"
           />
         </el-form-item>
       </el-form>

       <template #footer>
         <el-button @click="qualityControlOpen = false">取消</el-button>
         <el-button type="primary" @click="handleQualityControlConfirm">确认</el-button>
       </template>
     </el-dialog>
     <!-- 新增巡检类型设置对话框 -->
     <el-dialog
       title="巡检任务参数设置"
       v-model="patrolOpen"
       width="300px"
       append-to-body
       @close="handlePatrolClose"
     >
       <el-form
         ref="patrolFormRef"
         :model="patrolForm"
         :rules="patrolRules"
         label-width="100px"
       >
         <el-form-item label="巡检类型" prop="patrolType">
           <el-select
             v-model="patrolForm.patrolType"
             placeholder="请选择巡检类型"
             clearable
           >
             <el-option
               v-for="item in patrolTypes"
               :key="item.value"
               :label="item.label"
               :value="item.value"
             />
           </el-select>
         </el-form-item>
       </el-form>

       <template #footer>
         <el-button @click="patrolOpen = false">取消</el-button>
         <el-button type="primary" @click="handlePatrolConfirm">确认</el-button>
       </template>
     </el-dialog>
     <!-- 新增维护类型设置对话框 -->
     <el-dialog
       title="维护任务参数设置"
       v-model="maintenanceOpen"
       width="350px"
       append-to-body
       @close="handleMaintenanceClose"
     >
       <el-form
         ref="maintenanceFormRef"
         :model="maintenanceForm"
         :rules="maintenanceRules"
         label-width="120px"
       >
         <el-form-item label="维护类型" prop="maintenanceType">
           <el-select
             v-model="maintenanceForm.maintenanceType"
             placeholder="请选择维护类型"
             clearable
           >
             <el-option
               v-for="item in maintenanceTypes"
               :key="item.value"
               :label="item.label"
               :value="item.value"
             />
           </el-select>
         </el-form-item>
       </el-form>

       <template #footer>
         <el-button @click="maintenanceOpen = false">取消</el-button>
         <el-button type="primary" @click="handleMaintenanceConfirm">确认</el-button>
       </template>
     </el-dialog>
     <!-- 新增聚合五分钟数据设置对话框 -->
     <el-dialog
       title="聚合数据任务设置"
       v-model="aggregateOpen"
       width="350px"
       append-to-body
       @close="handleAggregateClose"
     >
       <el-form
         ref="aggregateFormRef"
         :model="aggregateForm"
         :rules="aggregateRules"
         label-width="120px"
       >
         <el-row>
           <el-col :span="24">
             <el-form-item label="聚合类型" prop="aggregateType">
               <el-select
                 v-model="aggregateForm.aggregateType"
                 placeholder="请选择聚合类型"
                 clearable
               >
                 <el-option
                   v-for="item in aggregateTypes"
                   :key="item.value"
                   :label="item.label"
                   :value="item.value"
                 />
               </el-select>
             </el-form-item>
           </el-col>
         </el-row>
         <el-row>
           <el-col :span="24">
             <el-form-item label="指定起止时间" prop="aggregateIsTime">
               <el-switch
                 v-model="aggregateForm.aggregateIsTime"
                 active-value="true"
                 inactive-value="false"
                 active-text="是"
                 inactive-text="否"
               />
             </el-form-item>
           </el-col>
         </el-row>
         <el-row>
           <el-col :span="24">
             <el-form-item label="筛选设备参数" prop="aggregateIsFilter">
               <el-switch
                 v-model="aggregateForm.aggregateIsFilter"
                 active-value="true"
                 inactive-value="false"
                 active-text="是"
                 inactive-text="否"
               />
             </el-form-item>
           </el-col>
         </el-row>
         <el-row v-if="aggregateForm.aggregateIsTime === 'true'">
           <el-col :span="24">
             <el-form-item label="聚合开始时间" prop="aggregateStartTime" required>
               <el-date-picker
                 v-model="aggregateForm.aggregateStartTime"
                 type="datetime"
                 placeholder="请选择聚合开始时间"
                 value-format="YYYY-MM-DD HH:00:00"
                 format="YYYY-MM-DD HH:00:00"
                 clearable
               />
             </el-form-item>
           </el-col>
         </el-row>
         <el-row v-if="aggregateForm.aggregateIsTime === 'true'">
           <el-col :span="24">
             <el-form-item label="聚合结束时间" prop="aggregateEndTime" required>
               <el-date-picker
                 v-model="aggregateForm.aggregateEndTime"
                 type="datetime"
                 placeholder="请选择聚合结束时间"
                 value-format="YYYY-MM-DD HH:00:00"
                 format="YYYY-MM-DD HH:00:00"
                 clearable
               />
             </el-form-item>
           </el-col>
         </el-row>
         <el-row v-if="aggregateForm.aggregateIsFilter === 'true'">
           <el-col :span="24">
             <el-form-item label="选择设备" prop="aggregateDeviceId" required>
               <el-select
                 v-model="aggregateForm.aggregateDeviceId"
                 placeholder="请选择设备"
                 clearable
                 @change="handleDeviceChange"
               >
                 <el-option
                   v-for="device in deviceList"
                   :key="device.deviceId"
                   :label="device.deviceName"
                   :value="device.deviceId"
                 />
               </el-select>
             </el-form-item>
           </el-col>
         </el-row>
         <el-row v-if="aggregateForm.aggregateIsFilter === 'true'">
           <el-col :span="24">
             <el-form-item label="选择参数" prop="aggregateAttributeId">
               <el-select
                 v-model="aggregateForm.aggregateAttributeId"
                 placeholder="请选择参数"
                 clearable
                 :disabled="!aggregateForm.aggregateDeviceId"
               >
                 <el-option
                   v-for="attr in availableAttributes"
                   :key="attr.attributeID"
                   :label="attr.displayName"
                   :value="attr.attributeID"
                 />
               </el-select>
             </el-form-item>
           </el-col>
         </el-row>
       </el-form>
       <template #footer>
         <el-button @click="aggregateOpen = false">取消</el-button>
         <el-button type="primary" @click="handleAggregateConfirm">确认</el-button>
       </template>
     </el-dialog>
     <!-- 新增创建分表对话框 -->
     <el-dialog
       title="创建分表"
       v-model="partitionOpen"
       width="350px"
       append-to-body
       @close="handlePartitionClose"
     >
       <el-form
         ref="partitionFormRef"
         :model="partitionForm"
         :rules="partitionRules"
         label-width="120px"
       >
         <el-form-item label="表名" prop="table">
           <el-select
             v-model="partitionForm.table"
             placeholder="请选择表名"
             clearable
           >
             <el-option
               v-for="item in partitionTableList"
               :key="item"
               :label="item"
               :value="item"
             />

           </el-select>

         </el-form-item>
         <el-form-item label="开始周" prop="startWeek">
           <el-input-number
             v-model.number="partitionForm.startWeek"
             placeholder="请输入开始周"
             :min="-10"
             :max="10"
             precision="0"
           />
         </el-form-item>
         <el-form-item label="结束周" prop="endWeek">
           <el-input-number
             v-model.number="partitionForm.endWeek"
             placeholder="请输入结束周"
             :min="-10"
             :max="10"
             precision="0"
           />
         </el-form-item>
       </el-form>
       <template #footer>
         <el-button @click="partitionOpen = false">取消</el-button>
         <el-button type="primary" @click="handlePartitionConfirm">确认</el-button>
       </template>
     </el-dialog>
     <!-- HJ212推送 -->
     <el-dialog
       title="HJ212推送协议"
       v-model="executeComHj212Open"
       width="600px"
       append-to-body
       @close="handleExecuteComHj212Close"
     >
       <el-form
         ref="executeComHj212FormRef"
         :model="executeComHj212Form"
         :rules="executeComHj212Rules"
         label-width="140px"
       >
         <!-- 推送协议选择 -->
         <el-form-item label="推送协议" prop="executeComHj212Protocol">
           <el-select
             v-model="executeComHj212Form.executeComHj212Protocol"
             placeholder="请选择推送协议"
             clearable
             style="width: 100%"
             @change="handleProtocolChange"
           >
             <el-option
               label="四川HJ212推送协议"
               value="sichuan"
             />
             <el-option
               label="通用HJ212推送协议"
               value="common"
             />
           </el-select>
         </el-form-item>
         <!-- 设置host 及port 文本框 -->
         <el-row :gutter="2">
           <el-col :span="13">
             <el-form-item label="主机地址" prop="executeComHj212Host">
               <el-input
                 v-model="executeComHj212Form.executeComHj212Host"
                 placeholder="请输入主机地址"
                 clearable
               />
             </el-form-item>
           </el-col>
           <el-col :span="11">
             <el-form-item label="端口" prop="executeComHj212Port">
               <el-input-number
                 v-model.number="executeComHj212Form.executeComHj212Port"
                 placeholder="请输入端口"
                 :min="0"
                 :max="65535"
                 precision="0"
                 controls-position="left"
                 style="width: 100%"
                 clearable
               />
             </el-form-item>
           </el-col>
         </el-row>
         <el-form-item label="推送规则" prop="executeComHj212RuleId">
           <el-select
             v-model="executeComHj212Form.executeComHj212RuleId"
             placeholder="请选择推送规则"
             clearable
             style="width: 100%"
           >
             <el-option
               v-for="item in filteredRuleList"
               :key="item.value"
               :label="item.label"
               :value="item.value"
             />
           </el-select>
         </el-form-item>
         <el-form-item label="启用自定义时间" prop="executeComHj212IsTime">
           <el-switch
             v-model="executeComHj212Form.executeComHj212IsTime"
             active-value="true"
             inactive-value="false"
             active-text="是"
             inactive-text="否"
           />
         </el-form-item>
         <el-form-item v-if="executeComHj212Form.executeComHj212IsTime === 'true'" label="开始时间" prop="executeComHj212StartTime" required>
           <el-date-picker
             v-model="executeComHj212Form.executeComHj212StartTime"
             type="datetime"
             placeholder="请选择开始时间"
             value-format="YYYY-MM-DD HH:00:00"
             format="YYYY-MM-DD HH:00:00"
             style="width: 100%"
             clearable
           />
         </el-form-item>
         <el-form-item v-if="executeComHj212Form.executeComHj212IsTime === 'true'" label="结束时间" prop="executeComHj212EndTime" required>
           <el-date-picker
             v-model="executeComHj212Form.executeComHj212EndTime"
             type="datetime"
             placeholder="请选择结束时间"
             value-format="YYYY-MM-DD HH:00:00"
             format="YYYY-MM-DD HH:00:00"
             style="width: 100%"
             clearable
           />
         </el-form-item>
       </el-form>
       <template #footer>
         <el-button @click="executeComHj212Open = false">取消</el-button>
         <el-button type="primary" @click="handleExecuteComHj212Confirm">确认</el-button>
       </template>
     </el-dialog>

</div>
</template>
<script setup name="Job">
// import { cronstrue } from 'cronstrue'; // 默认支持cron的7字段表达式
import cronstrue from 'cronstrue/i18n';
import { listJob, getJob, delJob, addJob, updateJob, runJob, changeJobStatus } from "@/api/monitor/job";
import { getNowData } from "@/api/login";
import Crontab from '@/components/Crontab'
const { proxy } = getCurrentInstance();
const { sys_job_group, sys_job_status } = proxy.useDict("sys_job_group", "sys_job_status");
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const id = ref(null);
const jobGroup = ref(null);
const maintenanceMode = ref(null);

onMounted(() => {
  // 默认按“创建时间”降序
  queryParams.value.sortBy = 'createTime';
  queryParams.value.sortAsc = false;
  // 从路由参数中获取id
  jobGroup.value = route.query.jobGroup;
  maintenanceMode.value = route.query.maintenanceMode;
  // 根据路由传递参数获取数据的逻辑
  console.log('jobGroup:', jobGroup.value);
  console.log('MaintenanceMode:', maintenanceMode.value);
  if(jobGroup.value && maintenanceMode.value){
    queryParams.value.jobGroup = jobGroup.value;
    getList() ;
  }
  getList() ;

});

const jobList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const openView = ref(false);
const openCron = ref(false);
const expression = ref("");
// gas 可选值定义
const gasOptions = ref([
  { label: 'SO2', value: 'SO2' },
  { label: 'NO2', value: 'NO2' },
  { label: 'O3', value: 'O3' },
  { label: 'CO', value: 'CO' }
]);
// 表单校验规则
const manualCheckRules = ref({
  gas: [{ required: true, message: '气体类型不能为空', trigger: 'change' }],
  genGasTime: [
    { required: true, message: '通气时间不能为空', trigger: 'blur' },
    { type: 'number', min: 0, max: 9600, message: '取值范围0~9600秒', trigger: 'blur' }
  ],
  readDataCount: [
    { required: true, message: '读取次数不能为空', trigger: 'blur' },
    { type: 'number', min: 0, max: 1000, message: '取值范围0~1000次', trigger: 'blur' }
  ],
  readDataSpan: [
    { required: true, message: '读取间隔不能为空', trigger: 'blur' },
    { type: 'number', min: 0, max: 3600, message: '取值范围0~3600秒', trigger: 'blur' }
  ],
  genGasConc: [
    { required: true, message: '气体浓度不能为空', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        const gasValue = manualCheckForm.value.gas;
        if ((gasValue === 'CO' && (value < 0 || value > 50)) ||
            (gasValue !== 'CO' && (value < 0 || value > 500))) {
          callback(new Error(gasValue === 'CO' ? '范围0~50ppm' : '范围0~500ppb'));
        } else {
          callback();
        }
      },
      trigger: 'blur'
    }
  ],
  stdGasInPortName: [
    { required: true, message: '请选择标准气入口方式', trigger: 'change' }
  ],
});

// 控制人工核查对话框显示
const manualCheckOpen = ref(false);

// 表单数据对象
const manualCheckForm = ref({
  gas: '',
  genGasTime: null,
  readDataCount: null,
  readDataSpan: null,
  genGasConc: null,
  stdGasInPortName: '跨度检查'
});

function analysisCrontab(data){
  if(data){
    try {
      return cronstrue.toString(data, { locale: "zh_CN", use24HourTimeFormat: true})
    }catch (error) {
      console.error('解析Cron表达式时出错:', error);
      return '周期设置错误无法解析，请重新设置！';
    }
  }else{
    return "暂未设置执行时间周期"
  }
}

// 解析invokeTarget参数的方法
function parseInvokeTargetParams(invokeTarget) {
  if (!invokeTarget) return null;
  
  // 匹配方法名和参数（如 "qualityControlCustomTask.run(...)")
  const methodMatch = invokeTarget.match(/^(\w+\.\w+)\((.*)\)$/);
  if (!methodMatch || methodMatch.length < 3) {
    return null;
  }

  const methodName = methodMatch[1]; // 方法名（如 "qualityControlCustomTask.run"）
  const paramsStr = methodMatch[2]; // 参数部分（如 "'SO2', 600, 10, 5, 0.2"）
  const paramValues = paramsStr.split(',').map(p => p.trim().replace(/^['"]|['"]$/g, '')); // 移除引号并拆分参数值

  return {
    methodName,
    paramValues
  };
}

// 解析人工核查任务参数
function parseManualCheckParams(invokeTarget) {
  const parsed = parseInvokeTargetParams(invokeTarget);
  if (!parsed || parsed.methodName !== 'qualityControlCustomTask.run') {
    return null;
  }

  const [gas, genGasTime, readDataCount, readDataSpan, genGasConc, stdGasInPortName] = parsed.paramValues;
  
  // 处理气体浓度单位转换：后台存储的是ppm，需要转换为前端显示的ppb
  let displayConcentration = null;
  if (genGasConc) {
    const ppmValue = parseFloat(genGasConc);
    if (gas === 'CO') {
      // CO气体：直接显示ppm值
      displayConcentration = ppmValue;
    } else {
      // SO2/NO2/O3气体：将ppm转换为ppb显示 (1ppm = 1000ppb)
      displayConcentration = ppmValue * 1000;
    }
  }
  
  return {
    gas: gas || '',
    genGasTime: genGasTime ? parseInt(genGasTime) : null,
    readDataCount: readDataCount ? parseInt(readDataCount) : null,
    readDataSpan: readDataSpan ? parseInt(readDataSpan) : null,
    genGasConc: displayConcentration,
    stdGasInPortName: stdGasInPortName || '跨度检查'
  };
}

// 解析质控任务参数
function parseQualityControlParams(invokeTarget) {
  const parsed = parseInvokeTargetParams(invokeTarget);
  if (!parsed || parsed.methodName !== 'qualityControlTask.run') {
    return null;
  }

  const [parameter, qcType, qcConcentration] = parsed.paramValues;
  
  return {
    parameter: parameter || '',
    qcType: qcType || '',
    qcConcentration: qcConcentration ? parseFloat(qcConcentration) : null
  };
}

// 解析巡检任务参数
function parsePatrolParams(invokeTarget) {
  const parsed = parseInvokeTargetParams(invokeTarget);
  if (!parsed || parsed.methodName !== 'patrolTask.run') {
    return null;
  }

  const [patrolType] = parsed.paramValues;
  
  return {
    patrolType: patrolType || ''
  };
}

// 解析维护任务参数
function parseMaintenanceParams(invokeTarget) {
  const parsed = parseInvokeTargetParams(invokeTarget);
  if (!parsed || parsed.methodName !== 'maintenanceTask.run') {
    return null;
  }

  const [maintenanceType] = parsed.paramValues;
  
  return {
    maintenanceType: maintenanceType || ''
  };
}

function handleManualCheckOpen() {
  // 尝试从现有的invokeTarget中解析参数
  const existingParams = parseManualCheckParams(form.value.invokeTarget);
  
  manualCheckForm.value = existingParams || {
    gas: '',
    genGasTime: null,
    readDataCount: null,
    readDataSpan: null,
    genGasConc: null,
    stdGasInPortName: '跨度检查'
  };
  manualCheckOpen.value = true;
}

function handleManualCheckClose() {
  manualCheckForm.value = {
    gas: '',
    genGasTime: null,
    readDataCount: null,
    readDataSpan: null,
    genGasConc: null,
    stdGasInPortName: '跨度检查'
  };
}

function handleManualCheckConfirm() {
  proxy.$refs.manualCheckFormRef.validate(valid => {
    if (valid) {
      manualCheckOpen.value = false;
      handleManualCheckSubmit(manualCheckForm.value);
    }
  });
}

// 将秒数转换为分钟'秒'格式
function formatSecondsToMinutes(seconds) {
  if (!seconds || seconds === 0) return '0秒';
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  
  if (minutes === 0) {
    return `${remainingSeconds}秒`;
  } else if (remainingSeconds === 0) {
    return `${minutes}分钟`;
  } else {
    return `${minutes}分钟${remainingSeconds}秒`;
  }
}

// 将秒数转换为分钟'秒'格式（用于读取时间显示）
function formatReadTime(seconds) {
  if (!seconds || seconds === 0) return '0秒';
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  
  if (minutes === 0) {
    return `${remainingSeconds}秒`;
  } else if (remainingSeconds === 0) {
    return `${minutes}分钟`;
  } else {
    return `${minutes}分钟${remainingSeconds}秒`;
  }
}

// 将聚合类型转换为分钟数
function convertAggregateTypeToMinutes(aggregateType) {
  const typeMapping = {
    '1minute': 1,
    '2minute': 2,
    '3minute': 3,
    '4minute': 4,
    '5minute': 5,
    '10minute': 10,
    '15minute': 15,
    '20minute': 20,
    '30minute': 30,
    '45minute': 45,
    '1hour': 60,
    '2hour': 120,
    '3hour': 180,
    '4hour': 240,
    '1day': 1440
  };
  return typeMapping[aggregateType] || 5; // 默认5分钟
}

// 将分钟数转换为聚合类型（用于解析）
function convertMinutesToAggregateType(minutes) {
  const minutesMapping = {
    1: '1minute',
    2: '2minute',
    3: '3minute',
    4: '4minute',
    5: '5minute',
    10: '10minute',
    15: '15minute',
    20: '20minute',
    30: '30minute',
    45: '45minute',
    60: '1hour',
    120: '2hour',
    180: '3hour',
    240: '4hour'
  };
  return minutesMapping[minutes] || '5minute'; // 默认5分钟
}

// 获取聚合类型的显示名称
function getAggregateTypeDisplayName(aggregateType) {
  const displayMapping = {
    '1minute': '1分钟',
    '2minute': '2分钟',
    '3minute': '3分钟',
    '4minute': '4分钟',
    '5minute': '5分钟',
    '10minute': '10分钟',
    '15minute': '15分钟',
    '20minute': '20分钟',
    '30minute': '30分钟',
    '45minute': '45分钟',
    '1hour': '1小时',
    '2hour': '2小时',
    '3hour': '3小时',
    '4hour': '4小时'
  };
  return displayMapping[aggregateType] || aggregateType;
}

// 格式化浓度显示（用于说明信息）
function formatConcentrationDisplay(concentration, gasType) {
  if (!concentration || concentration === 0) return '0';
  
  if (gasType === 'CO') {
    // CO气体：直接显示ppm
    return `${concentration}ppm`;
  } else {
    // SO2/NO2/O3气体：显示ppb
    return `${concentration}ppb`;
  }
}

function handleManualCheckSubmit(params) {
  const { gas, genGasTime, readDataCount, readDataSpan, genGasConc, stdGasInPortName } = params;
  // 所有参数转为字符串
  const strGenGasTime = genGasTime?.toString() || '';
  const strReadDataCount = readDataCount?.toString() || '';
  const strReadDataSpan = readDataSpan?.toString() || '';
  
  // 处理气体浓度单位转换：CO保持ppm，SO2/NO2/O3从ppb转换为ppm
  let convertedConcentration;
  if (gas === 'CO') {
    // CO气体：直接使用输入的ppm值
    convertedConcentration = parseFloat(genGasConc)?.toFixed(3);
  } else {
    // SO2/NO2/O3气体：将ppb转换为ppm (1ppm = 1000ppb)
    convertedConcentration = (parseFloat(genGasConc) / 1000)?.toFixed(3);
  }
  
  // 构建 invokeTarget 调用字符串，包含新参数
  form.value.invokeTarget = `qualityControlCustomTask.run('${gas}', '${strGenGasTime}', '${strReadDataCount}', '${strReadDataSpan}', '${convertedConcentration}', '${stdGasInPortName}')`;
}

// 任务组名称映射
const JOB_GROUP_MAPPING = {
  'QualityControl': '质量控制',
  'Patrol': '设备巡检',
  'Maintenance': '设备维护',
  'ManualCheck': '人工核查',
  'CreatePartitionTables': '创建分表',
  'AggregationData': '数据聚合',
  'ExecuteSiChuanHj212RuleTask': '四川省HJ212数据推送',
  'ExecuteComHj212RuleTask': '通用HJ212数据推送'
};

// 方法名映射
const METHOD_MAPPING = {
  'qualityControlTask.run': '执行质控任务',
  'patrolTask.run': '执行巡检任务',
  'maintenanceTask.run': '执行维护任务',
  'qualityControlCustomTask.run': '执行人工核查任务',
  'qualityControlGenReportTask.run': '执行生成质控报告任务',
  'aggregationDataTask.run': '执行数据聚合任务',
  'mokeBus.send': '执行仪器发数',
  'CreatePartitionTablesTask.run': "创建分表",
  'ExecuteSiChuanHj212RuleTask.run': "执行四川省HJ212数据推送任务",
  'ExecuteComHj212RuleTask.run': "执行通用HJ212数据推送任务"
};

// 参数类型映射
const PARAM_MAPPING = {
  // 人工核查任务参数
  'gas': '气体类型',
  'genGasTime': '稳定时间',
  'readDataCount': '读取次数',
  'readDataSpan': '读取间隔',
  'genGasConc': '气体浓度',
  'stdGasInPortName': '标气入口',
  // 质控任务参数
  'parameter': '监测参数',
  'qcType': '质控类型',
  'qcConcentration': '质控浓度',
  // 生成质控报告任务
  'beginTime': '开始时间',

  // 巡检任务参数
  'patrolType': '巡检类型',
  // 维护任务参数
  'maintenanceType': '维护类型',
  // 数据聚合任务参数
  'aggreType': '聚合类型',
  'startTime': '开始时间',
  'endTime': '结束时间',
  'isTime': '指定起止时间',
  'minutes': '聚合间隔',
  'deviceId': '设备ID',
  'attributeId': '参数ID',
  // 推送任务参数
  'executeComHj212Protocol':"推送协议",
  'executeComHj212Host':"IP",
  'executeComHj212Port':"端口",
  'executeComHj212RuleId':"规则",
  'executeComHj212StartTime':"开始时间",
  'executeComHj212EndTime':"结束时间",
  'executeComHj212IsTime':"是否使用传入的时间",
  // 仪器发数任务参数

  // 其他参数
  'data': '数据',
  'time': '时间',
  'value': '值',
  'status': '状态',
  'type': '类型',
  'name': '名称',
  'id': 'ID',
  'customType':"检查类型",
  'table':"表名",
  'startWeek':"距离本周的开始周",
  'endWeek':"距离本周的结束周"
};

// 参数位置映射表（按任务类型和参数索引绑定名称）
const PARAM_ORDER_MAPPING = {
  // 人工核查任务：qualityControlCustomTask.run(gas, genGasTime, readDataCount, readDataSpan, genGasConc, stdGasInPortName)
  'qualityControlCustomTask.run': [
    'gas', 'genGasTime', 'readDataCount', 'readDataSpan', 'genGasConc', "stdGasInPortName"
  ],
  // 质控任务：qualityControlTask.run(parameter, qcType, qcConcentration)
  'qualityControlTask.run': [
    'parameter', 'qcType', 'qcConcentration'
  ],
  // 巡检任务：patrolTask.run(patrolType)
  'patrolTask.run': [
    'patrolType'
  ],
  // 维护任务：maintenanceTask.run(maintenanceType)
  'maintenanceTask.run': [
    'maintenanceType'
  ],
  // 生成质控报告任务：qualityControlGenReportTask.run(beginTime, endTime)
  'qualityControlGenReportTask.run': [
    'beginTime', 'endTime'
  ],
  // 数据聚合任务：aggregationDataTask.run(triggerType, aggreType, startTime, endTime, isTime, minutes, deviceId, attributeId)
  'aggregationDataTask.run': [
      'aggreType', 'startTime', 'endTime', 'isTime', 'minutes', 'deviceId', 'attributeId'
  ],
  // 创建分表任务
  'CreatePartitionTablesTask.run': [
    'table', 'startWeek', 'endWeek'
  ],
  // 执行SiChuanHj212Rule任务参数
  'ExecuteSiChuanHj212RuleTask.run': [
    'executeComHj212Host', 'executeComHj212Port', 'executeComHj212RuleId', 'executeComHj212StartTime', 'executeComHj212EndTime', 'executeComHj212IsTime'
  ],
  // 执行ComHj212Rule任务参数
  'ExecuteComHj212RuleTask.run': [
    'executeComHj212Host', 'executeComHj212Port', 'executeComHj212RuleId', 'executeComHj212StartTime', 'executeComHj212EndTime', 'executeComHj212IsTime'
  ],
};

// 质控类型映射
const QC_TYPE_MAPPING = {
  'zero_check': '零点核查',
  'span_check': '跨度核查',
  'multi_check': '线性核查',
  'particle_quality_control': '颗粒物自动质控',
  'conversion_check': '转换效率核查',
  'calibration': '校准',
  'precision_check': '精密度审核',
  'accuracy_check': '准确度审核'
};

// 巡检类型映射
const PATROL_TYPE_MAPPING = {
  'substation_patrol': '子站巡检',
  'instrument_status': '仪器运行状况检查'
};

// 维护类型映射
const MAINTENANCE_TYPE_MAPPING = {
  'so2_filter': 'SO2滤膜更换',
  'no2_filter': 'NO2滤膜更换',
  'o3_filter': 'O3滤膜更换',
  'co_filter': 'CO滤膜更换',
  'pm10_cutter': 'PM10切割器更换',
  'pm2.5_cutter': 'PM2.5切割器更换'
};

// 气体类型映射
const GAS_TYPE_MAPPING = {
  'SO2': '二氧化硫',
  'NO2': '二氧化氮',
  'O3': '臭氧',
  'CO': '一氧化碳'
};

// 解析Cron表达式为中文语义
const parseCronExpression = (expression) => {
  try {
    if (!expression) return '-';
    return cronstrue.toString(expression, { locale: "zh_CN", use24HourTimeFormat: true });
  } catch (error) {
    return '无效的Cron表达式';
  }
};

// 解析调用目标字符串为中文语义
const parseInvokeTarget = (target) => {
  if (!target) return '-';

  // 匹配方法名和参数（如 "qualityControlCustomTask.run(...)")
  const methodMatch = target.match(/^(\w+\.\w+)\((.*)\)$/);
  if (!methodMatch || methodMatch.length < 3) {
    return target;
  }

  const methodName = methodMatch[1]; // 方法名（如 "qualityControlCustomTask.run"）
  const paramsStr = methodMatch[2]; // 参数部分（如 "'SO2', 600, 10, 5, 0.2"）
  const paramValues = paramsStr.split(',').map(p => p.trim().replace(/^['"]|['"]$/g, '')); // 移除引号并拆分参数值

  // 1. 映射方法名
  const mappedMethod = METHOD_MAPPING[methodName] || methodName;

  // 2. 根据方法名获取参数名称列表（按位置）
  const paramNames = PARAM_ORDER_MAPPING[methodName] || [];

  // 3. 解析每个参数的名称和值
  const parsedParams = paramValues.map((value, index) => {
    // 获取参数名称（从映射表中按位置取，无则显示“参数N”）
    const paramNameKey = paramNames[index] || `参数${index + 1}`;
    const paramName = PARAM_MAPPING[paramNameKey] || paramNameKey;

    // 映射参数值（根据任务类型）
    let mappedValue = value;
    if (methodName === 'qualityControlCustomTask.run') {
      // 人工核查任务：第0个参数是气体类型
      // parseInvokeTarget 中针对 ManualCheck 类型做增强
      if (index === 0) mappedValue = GAS_TYPE_MAPPING[value] || value;
      if (index === 1) mappedValue = `${value} 秒`;
      if (index === 2) mappedValue = `${value} 次`;
      if (index === 3) mappedValue = `${value} 秒`;
      if (index === 4) {
        // 根据气体类型显示正确的浓度单位
        const gasType = paramValues[0]; // 第0个参数是气体类型
        const concentration = parseFloat(value);
        if (gasType === 'CO') {
          mappedValue = `${concentration.toFixed(3)} ppm`;
        } else {
          // SO2/NO2/O3显示ppb单位 (后台存储ppm，显示时转换为ppb)
          mappedValue = `${(concentration * 1000).toFixed(3)} ppb`;
        }
      }
      if (index === 5) mappedValue = value;
    } else if (methodName === 'qualityControlTask.run') {
      // 质控任务：第1个参数是质控类型
      if (index === 1) mappedValue = QC_TYPE_MAPPING[value] || value;
      // 第0个参数是监测参数（如PM2.5）
      if (index === 0) mappedValue = value; // 直接显示参数值（如"PM2.5"）
    } else if (methodName === 'patrolTask.run') {
      // 巡检任务：第0个参数是巡检类型
      mappedValue = PATROL_TYPE_MAPPING[value] || value;
    } else if (methodName === 'maintenanceTask.run') {
      // 维护任务：第0个参数是维护类型
      mappedValue = MAINTENANCE_TYPE_MAPPING[value] || value;
    } else if (methodName === 'aggregationDataTask.run') {
      // 聚合任务：根据参数位置处理
      if (index === 0) {
        // 聚合类型，转换为显示格式
        mappedValue = getAggregateTypeDisplayName(value);
      } else if (index === 3) {
        // 指定起止时间，false 否  true 是
        mappedValue = value === "true" ? "是" : "否";
      } else if (index === 4) {
        // 聚合间隔，"X分钟"
        mappedValue = `${value} 分钟`;
      } else if (index === 5) {
        // 设备ID，显示为"全部设备"或具体设备名
        mappedValue = value === '*' ? '全部' : value;
      } else if (index === 6) {
        // 参数ID，显示为"全部参数"或具体参数名
        mappedValue = value === '*' ? '全部' : value;
      }
    } else if (methodName === 'ExecuteSiChuanHj212RuleTask.run' || methodName === 'ExecuteComHj212RuleTask.run') {
      // HJ212推送任务：根据参数位置处理
      // 参数顺序：host, port, ruleId, startTime, endTime, isTime
      // index 0: executeComHj212Host (IP)
      // index 1: executeComHj212Port (端口)
      // index 2: executeComHj212RuleId (规则)
      // index 3: executeComHj212StartTime (开始时间)
      // index 4: executeComHj212EndTime (结束时间)
      // index 5: executeComHj212IsTime (是否使用传入的时间)
      if (index === 5) {
        // 是否使用传入的时间，false 否  true 是
        mappedValue = value === "true" ? "是" : "否";
      }
    }

    return `${paramName}：${mappedValue}`;
  });

  return `${mappedMethod}→(\n${parsedParams.join('，\n')}\n)`;
};

// 新增质控相关数据
const qualityParameters = ref([
  { value: 'PM10', label: 'PM10' },
  { value: 'PM2.5', label: 'PM2.5' },
  { value: 'SO2', label: '二氧化硫' },
  { value: 'O3', label: '臭氧' },
  { value: 'CO', label: '一氧化碳' },
  { value: 'NO2', label: '二氧化氮' },
]);
const qualityControlTypes = ref([
  { value: 'zero_check', label: '零点核查' },
  { value: 'span_check', label: '跨度核查' },
  { value: 'multi_check', label: '线性核查' },
  { value: 'particle_quality_control', label: '颗粒物监测设备的自动质控' },
  { value: 'conversion_check', label: '转换效率核查' },
  { value: 'calibration', label: '校准' },
  { value: 'precision_check', label: '精密度审核' },
  { value: 'accuracy_check', label: '准确度审核' },
]);
// 新增质控表单数据
const qcForm = ref({
  parameter: '',
  qcType: '',
  qcConcentration: null,
});
const qcRules = ref({
  parameter: [{ required: true, message: '参数不能为空', trigger: 'change' }],
  qcType: [{ required: true, message: '质控类型不能为空', trigger: 'change' }],
  qcConcentration: [{ required: true, message: '质控浓度不能为空', trigger: 'blur' }],
});
const qualityControlOpen = ref(false);
// 新增巡检类型相关数据
const patrolTypes = ref([
  { value: 'substation_patrol', label: '子站巡检' },
  { value: 'instrument_status', label: '仪器运行状况' },
]);
// 新增巡检表单数据
const patrolForm = ref({
  patrolType: '',
});

const patrolRules = ref({
  patrolType: [{ required: true, message: '巡检类型不能为空', trigger: 'change' }],
});

const patrolOpen = ref(false);
// 新增维护类型相关数据
const maintenanceTypes = ref([
  { value: 'so2_filter', label: 'SO2滤膜更换' },
  { value: 'no2_filter', label: 'NO2滤膜更换' },
  { value: 'o3_filter', label: 'O3滤膜更换' },
  { value: 'co_filter', label: 'CO滤膜更换' },
  { value: 'pm10_cutter', label: 'PM10切割器更换' },
  { value: 'pm2.5_cutter', label: 'PM2.5切割器更换' },
]);

// 新增维护表单数据
const maintenanceForm = ref({
  maintenanceType: '',
});

const maintenanceRules = ref({
  maintenanceType: [{ required: true, message: '维护类型不能为空', trigger: 'change' }],
});

const maintenanceOpen = ref(false);
const data = reactive({
  form: {
    jobName: '',
    jobGroup: '',
    invokeTarget: '',
    cronExpression: '',
  },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    jobName: undefined,
    jobGroup: undefined,
    status: undefined,
    sortBy: 'createTime', // 默认排序字段
    sortAsc: false, // 默认降序排序
  },
  rules: {
    jobName: [],
    jobGroup: [{ required: true, message: "分组不能为空", trigger: "blur" }],
    invokeTarget: [{ required: true, message: "调用目标字符串不能为空", trigger: "blur" }],
    cronExpression: [{ required: true, message: "cron执行表达式不能为空", trigger: "change" }]
  }
});
const aggregateForm = ref({
  aggregateType: '5minute', // 默认5分钟聚合
  aggregateStartTime: '',
  aggregateEndTime: '',
  aggregateIsTime: false, // 默认不启用自定义时间
  aggregateIsFilter: false, // 默认不启用设备筛选
  aggregateDeviceId: null, // 选择的设备ID
  aggregateAttributeId: null, // 选择的参数ID
});
const aggregateRules = ref({
  aggregateType: [{ required: true, message: '聚合类型不能为空', trigger: 'change' }],
  aggregateStartTime: [
    {
      validator: (rule, value, callback) => {
        // 只有当启用自定义时间时才验证必填
        if (aggregateForm.value.aggregateIsTime === 'true' && !value) {
          callback(new Error('聚合开始时间不能为空'));
        } else {
          callback();
        }
      },
      trigger: 'change'
    }
  ],
  aggregateEndTime: [
    {
      validator: (rule, value, callback) => {
        // 只有当启用自定义时间时才验证必填
        if (aggregateForm.value.aggregateIsTime === 'true' && !value) {
          callback(new Error('聚合结束时间不能为空'));
        } else {
          callback();
        }
      },
      trigger: 'change'
    }
  ],
  aggregateIsTime: [{ required: false, message: '是否启用自定义时间', trigger: 'change' }],
  aggregateDeviceId: [
    {
      validator: (rule, value, callback) => {
        // 只有当启用设备筛选时才验证必填
        if (aggregateForm.value.aggregateIsFilter === 'true' && !value) {
          callback(new Error('请选择设备'));
        } else {
          callback();
        }
      },
      trigger: 'change'
    }
  ],
  aggregateAttributeId: [
    {
      validator: (rule, value, callback) => {
        // 参数选择是可选的，不需要验证
        callback();
      },
      trigger: 'change'
    }
  ],
});
const aggregateOpen = ref(false);
const aggregateTypes = ref([
  { value: '1minute', label: '1分钟' },
  { value: '2minute', label: '2分钟' },
  { value: '3minute', label: '3分钟' },
  { value: '4minute', label: '4分钟' },
  { value: '5minute', label: '5分钟' },
  { value: '10minute', label: '10分钟' },
  { value: '15minute', label: '15分钟' },
  { value: '20minute', label: '20分钟' },
  { value: '30minute', label: '30分钟' },
  { value: '45minute', label: '45分钟' },
  { value: '1hour', label: '1小时' },
  { value: '2hour', label: '2小时' },
  { value: '3hour', label: '3小时' },
  { value: '4hour', label: '4小时' },
  { value: '1day', label: '1天' },
]);
const partitionTableList = ref(["realdata","his_data"]);

// 设备列表和属性数据
const deviceList = ref([]);
const availableAttributes = ref([]);
// 新增创建分表表单数据
const partitionForm = ref({
  table: '',
  startWeek: null,
  endWeek: null,
});
const partitionRules = ref({
  table: [{ required: true, message: '表名不能为空', trigger: 'change' }],
  startWeek: [{ required: true, message: '开始周不能为空', trigger: 'change' }],
  endWeek: [{ required: true, message: '结束周不能为空', trigger: 'change' }],
});
const partitionOpen = ref(false);
const executeComHj212Open = ref(false);
const executeComHj212Form = ref({
  executeComHj212Protocol: '',
  executeComHj212Host: '',
  executeComHj212Port: '',
  executeComHj212RuleId: '',
  executeComHj212StartTime: '',
  executeComHj212EndTime: '',
  executeComHj212IsTime: 'false',
});
const executeComHj212Rules = ref({
  executeComHj212Protocol: [{ required: true, message: '推送协议不能为空', trigger: 'change' }],
  executeComHj212Host: [{ required: true, message: '主机不能为空', trigger: 'change' }],
  executeComHj212Port: [{ required: true, message: '端口不能为空', trigger: 'change' }],
  executeComHj212RuleId: [{ required: true, message: '规则不能为空', trigger: 'change' }],
  executeComHj212StartTime: [
    {
      validator: (rule, value, callback) => {
        // 只有当启用自定义时间时才验证必填
        if (executeComHj212Form.value.executeComHj212IsTime === 'true' && !value) {
          callback(new Error('聚合开始时间不能为空'));
        } else {
          callback();
        }
      },
      trigger: 'change'
    }
  ],
  executeComHj212EndTime: [
    {
      validator: (rule, value, callback) => {
        // 只有当启用自定义时间时才验证必填
        if (executeComHj212Form.value.executeComHj212IsTime === 'true' && !value) {
          callback(new Error('聚合结束时间不能为空'));
        } else {
          callback();
        }
      },
      trigger: 'change'
    }
  ],
  executeComHj212IsTime: [{ required: false, message: '是否启用自定义时间', trigger: 'change' }],
});
// 所有推送规则列表
const allRuleList = ref([
  { value: '10001', label: '1分钟推送组' },
  { value: '10002', label: '5分钟推送组' },
  { value: '10003', label: '1小时推送组' },
  { value: '10004', label: '1天推送组' },
  { value: '10005', label: '不固定频率推送组' },
  { value: '10006', label: '质控组' },
]);
// 通用推送规则列表（只包含1分钟/5分钟/1小时）
const commonRuleList = ref([
  { value: '10001', label: '1分钟推送组' },
  { value: '10002', label: '5分钟推送组' },
  { value: '10003', label: '1小时推送组' },
]);
// 根据选择的协议动态过滤规则列表
const filteredRuleList = computed(() => {
  if (executeComHj212Form.value.executeComHj212Protocol === 'common') {
    return commonRuleList.value;
  } else {
    return allRuleList.value;
  }
});



const { form, queryParams, rules } = toRefs(data);

const jobTypeDict = {
  "QualityControl": (param,type,concentration) =>
      `qualityControlTask.run('${param}','${type}','${concentration}')`,
  "Patrol": (param) =>
      `patrolTask.run('${param}')`,
  "Maintenance": (param) =>
      `maintenanceTask.run('${param}')`,
  "ManualCheck": (gas, genGasTime, readDataCount, readDataSpan, genGasConc, stdGasInPortName) =>
      `qualityControlCustomTask.run('${gas}', ${genGasTime}, ${readDataCount}, ${readDataSpan}, ${genGasConc}, '${stdGasInPortName}')`,
  "aggregationDataTask": (aggregateType, aggregateStartTime, aggregateEndTime, aggregateIsTime, minutes, deviceId, attributeId) =>
      `aggregationDataTask.run('${aggregateType}', '${aggregateStartTime}', '${aggregateEndTime}', ${aggregateIsTime}, ${minutes}, '${deviceId}', '${attributeId}')`,
  "CreatePartitionTablesTask": (table,startWeek, endWeek) =>
      `CreatePartitionTablesTask.run('${table}',${startWeek},${endWeek})`,
  "ExecuteHj212RuleTask": (executeComHj212Protocol, executeComHj212Host, executeComHj212Port, executeComHj212RuleId, executeComHj212StartTime, executeComHj212EndTime, executeComHj212IsTime) => {
    // 根据协议类型选择不同的任务方法
    if (executeComHj212Protocol === 'sichuan') {
      return `ExecuteSiChuanHj212RuleTask.run('${executeComHj212Host}', '${executeComHj212Port}', '${executeComHj212RuleId}', '${executeComHj212StartTime}', '${executeComHj212EndTime}', ${executeComHj212IsTime})`;
    } else {
      return `ExecuteComHj212RuleTask.run('${executeComHj212Host}', '${executeComHj212Port}', '${executeComHj212RuleId}', '${executeComHj212StartTime}', '${executeComHj212EndTime}', ${executeComHj212IsTime})`;
    }
  },
}

function opencard(data){

}
/** 查询定时任务列表 */
function getList() {
  loading.value = true;
  listJob(queryParams.value).then(response => {
    jobList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 任务组名字典翻译 */
function jobGroupFormat(row, column) {
  return proxy.selectDictLabel(sys_job_group.value, row.jobGroup);
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

/** 表单重置 */
function reset() {
  form.value = {
    jobId: undefined,
    jobName: undefined,
    jobGroup: undefined,
    invokeTarget: undefined,
    cronExpression: undefined,
    cronConstrue: undefined,
    misfirePolicy: 1,
    concurrent: 1,
    status: "0"
  };
  proxy.resetForm("jobRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.jobId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

// 更多操作触发
function handleCommand(command, row) {
  switch (command) {
    case "handleRun":
      handleRun(row);
      break;
    case "handleView":
      handleView(row);
      break;
    case "handleJobLog":
      handleJobLog(row);
      break;
    default:
      break;
  }
}

// 任务状态修改
function handleStatusChange(row) {
  let text = row.status === "0" ? "启用" : "停用";
  proxy.$modal.confirm('确认要"' + text + '""' + row.jobName + '"任务吗?').then(function () {
    return changeJobStatus(row.jobId, row.status);
  }).then(() => {
    proxy.$modal.msgSuccess(text + "成功");
  }).catch(function () {
    row.status = row.status === "0" ? "1" : "0";
  });
}

/* 立即执行一次 */
function handleRun(row) {
  proxy.$modal.confirm('确认要立即执行一次"' + row.jobName + '"任务吗?').then(function () {
    return runJob(row.jobId, row.jobGroup);
  }).then(() => {
    proxy.$modal.msgSuccess("执行成功");})
  .catch(() => {});
}

/** 任务详细信息 */
function handleView(row) {
  getJob(row.jobId).then(response => {
    form.value = response.data;
    openView.value = true;
  });
}

/** cron表达式按钮操作
 *
 * 使用 cronstrue 语义解释crontab表达式
 * https://bradymholt.github.io/cRonstrue/#cronstrue-demo
 * */
function handleShowCron() {
  expression.value = form.value.cronExpression;
  openCron.value = true;

  console.log("cron: ", expression.value)
  form.value.cronConstrue = cronstrue.toString(form.value.cronExpression, { locale: "zh_CN", use24HourTimeFormat: true});
}

/** 确定后回传值 */
function crontabFill(value) {
  form.value.cronExpression = value;
}

/** 任务日志列表查询 */
function handleJobLog(row) {
  const jobId = row.jobId || 0;
  router.push('/monitor/job-log/index/' + jobId)
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加任务";

  // 调用监听函数
  setupJobNameWatch();
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const jobId = row.jobId || ids.value;
  getJob(jobId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改任务";
  });

  // 调用监听函数
  setupJobNameWatch();
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["jobRef"].validate(valid => {
    if (valid) {
      if (form.value.jobId != undefined) {
        updateJob(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addJob(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const jobIds = row.jobId || ids.value;
  proxy.$modal.confirm('是否确认删除定时任务编号为"' + jobIds + '"的数据项?').then(function () {
    return delJob(jobIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download("monitor/job/export", {
    ...queryParams.value,
  }, `job_${new Date().getTime()}.xlsx`);
}

// 自动生成任务名称的函数
const generateJobName = () => {
  // 提取自动生成名称的前缀
  const autoPrefixes = ['暂未设置执行时间周期', '周期设置错误无法解析'];
  // 检查是否为用户手动输入的名称
  const isUserInput = form.value.jobName
      ? autoPrefixes.every(prefix => !form.value.jobName.startsWith(prefix))
      : false;

  // 如果用户手动输入了名称，且名称不以自动生成的前缀开头，则不重新生成
  if (form.value.jobName && isUserInput) return;

  const executionTime = analysisCrontab(form.value.cronExpression);
  const taskDetail = parseInvokeTarget(form.value.invokeTarget);
  // 判断executionTime是否包含匹配autoPrefixes中的任意一项
  // const shortExecutionTime = (autoPrefixes.some(prefix => executionTime.startsWith(prefix))) ? "" : executionTime ;
  form.value.jobName = `${executionTime}-${taskDetail}`

  // 判断jobName的长度是否超过60个字符，如果超过则截取前60个字符
  if (form.value.jobName.length > 60) {
    form.value.jobName = form.value.jobName.substring(0, 60)+"..."
  }
};

// 定义监听函数
function setupJobNameWatch() {
  // 监听所有可能影响任务名称生成的参数
  return watch([
    () => expression.value,
    () => form.value.cronConstrue,
    () => form.value.cronExpression,
    () => form.value.invokeTarget,
    () => form.value.jobGroup,
    // 若有其他影响 parseInvokeTarget 结果的参数，也添加到这里
    () => manualCheckForm.value,
    () => manualCheckForm.value.gas,
    () => manualCheckForm.value.genGasConc,
    () => manualCheckForm.value.genGasTime,
    () => manualCheckForm.value.readDataCount,
    () => manualCheckForm.value.readDataSpan,
    () => manualCheckForm.value.stdGasInPortName,
    // 质控任务参数监听
    () => qcForm.value,
    () => qcForm.value.parameter,
    () => qcForm.value.qcConcentration,
    () => qcForm.value.qcType,
    // 巡检任务参数监听
    () => patrolForm.value,
    () => patrolForm.value.patrolType,
    // 维护任务监听参数
    () => maintenanceForm.value,
    () => maintenanceForm.value.maintenanceType,
    // HJ212推送任务参数监听
    () => executeComHj212Form.value,
    () => executeComHj212Form.value.executeComHj212Protocol,
    () => executeComHj212Form.value.executeComHj212Host,
    () => executeComHj212Form.value.executeComHj212Port,
    () => executeComHj212Form.value.executeComHj212RuleId,
    () => executeComHj212Form.value.executeComHj212StartTime,
    () => executeComHj212Form.value.executeComHj212EndTime,
    () => executeComHj212Form.value.executeComHj212IsTime,
  ], () => {
    generateJobName();
  }, { deep: true });
}

// 打开质控设置对话框
function handleQualityControlOpen() {
  // 尝试从现有的invokeTarget中解析参数
  const existingParams = parseQualityControlParams(form.value.invokeTarget);
  
  qcForm.value = existingParams || {
    parameter: '',
    qcType: '',
    qcConcentration: null,
  };
  qualityControlOpen.value = true;
}

// 关闭对话框时重置表单
function handleQualityControlClose() {
  qcForm.value = {
    parameter: '',
    qcType: '',
    qcConcentration: null,
  };
}

// 确认按钮方法（需自定义业务逻辑）
function handleQualityControlConfirm() {
  // 表单验证
  proxy.$refs.qcFormRef.validate(valid => {
    if (valid) {
      // 这里可以处理参数拼接，例如：
      // form.invokeTarget = `qualityControlTask(${qcForm.parameter}, ${qcForm.qcType}, ${qcForm.qcConcentration})`
      // 或者发送请求保存参数
      qualityControlOpen.value = false;
      // 触发自定义逻辑
      handleQualityControlSubmit(qcForm.value);
    }
  });
}

// 预留的自定义逻辑方法
function handleQualityControlSubmit(params) {
  let parameter = params.parameter;
  let qcType = params.qcType;
  let qcConcentration = params.qcConcentration;
  // 在这里编写具体的业务逻辑
  let cmd = jobTypeDict["QualityControl"](parameter, qcType, qcConcentration)
  console.log('质控参数提交:', params);
  console.log('质控参数提交:', cmd);
  form.value.invokeTarget = cmd;
}

// 打开巡检设置对话框
function handlePatrolOpen() {
  // 尝试从现有的invokeTarget中解析参数
  const existingParams = parsePatrolParams(form.value.invokeTarget);
  
  patrolForm.value = existingParams || {
    patrolType: '',
  };
  patrolOpen.value = true;
}

// 关闭对话框时重置表单
function handlePatrolClose() {
  patrolForm.value = {
    patrolType: '',
  };
}

// 确认按钮方法（需自定义业务逻辑）
function handlePatrolConfirm() {
  // 表单验证
  proxy.$refs.patrolFormRef.validate(valid => {
    if (valid) {
      patrolOpen.value = false;
      // 触发自定义巡检参数处理逻辑
      handlePatrolSubmit(patrolForm.value);
    }
  });
}

// 预留的巡检参数处理方法
function handlePatrolSubmit(params) {
  // 在这里编写巡检参数的具体处理逻辑
  let patrolType = params.patrolType;
  // 在这里编写具体的业务逻辑
  let cmd = jobTypeDict["Patrol"](patrolType)
  console.log('巡检参数提交:', params);
  console.log('巡检参数提交:', cmd);
  form.value.invokeTarget = cmd;
}
// 打开维护设置对话框
function handleMaintenanceOpen() {
  // 尝试从现有的invokeTarget中解析参数
  const existingParams = parseMaintenanceParams(form.value.invokeTarget);
  
  maintenanceForm.value = existingParams || {
    maintenanceType: '',
  };
  maintenanceOpen.value = true;
}
// 解聚合数据任务参数
function parseAggregationDataParams(invokeTarget) {
  if(invokeTarget != null){
    // 解析新格式：aggregationDataTask.run('aggreType', 'start', 'end', true/false, minutes, 'deviceId', 'attributeId')
    // 参数顺序：aggregateType, aggregateStartTime, aggregateEndTime, aggregateIsTime, minutes, deviceId, attributeId
    // 注意：aggregateIsTime 和 minutes 不带引号
    let newFormatParams = invokeTarget.match(/aggregationDataTask\.run\('([^']+)', '([^']+)', '([^']+)', (\w+), (\d+), '([^']*)', '([^']*)'\)/);
    
    if (newFormatParams && newFormatParams.length >= 8) {
      // 新格式：7个参数
      const minutes = parseInt(newFormatParams[5]);
      const aggregateType = convertMinutesToAggregateType(minutes);
      const deviceId = newFormatParams[6] || '';
      const attributeId = newFormatParams[7] || '';
      
      // 只有当 deviceId 和 attributeId 都不是 '*' 且不为空时，才认为启用了筛选
      const isFilterEnabled = (deviceId !== '' && deviceId !== '*') || (attributeId !== '' && attributeId !== '*');
      
      return {
        aggregateType: aggregateType,
        aggregateStartTime: newFormatParams[2], // start time
        aggregateEndTime: newFormatParams[3],   // end time
        aggregateIsTime: newFormatParams[4] === 'true',
        aggregateIsFilter: isFilterEnabled,
        aggregateDeviceId: deviceId === '*' ? '' : deviceId,
        aggregateAttributeId: attributeId === '*' ? '' : attributeId,
      };
    }
    
    // 兼容旧格式：aggregationDataTask.run('aggreType', 'start', 'end', true/false)
    let oldFormatParams = invokeTarget.match(/aggregationDataTask\.run\('([^']+)', '([^']+)', '([^']+)', (\w+)\)/);
    if (oldFormatParams && oldFormatParams.length >= 5) {
      return {
        aggregateType: oldFormatParams[1],
        aggregateStartTime: oldFormatParams[2],
        aggregateEndTime: oldFormatParams[3],
        aggregateIsTime: oldFormatParams[4] === 'true',
        aggregateIsFilter: false,
        aggregateDeviceId: '',
        aggregateAttributeId: '',
      };
    }
  }

  return null;
}
// 解析HJ212推送任务参数
function parseExecuteHj212RuleTaskParams(invokeTarget) {
  if(invokeTarget != null){
    // 解析ExecuteSiChuanHj212RuleTask.run 或 ExecuteComHj212RuleTask.run
    let params = invokeTarget.match(/(?:ExecuteSiChuanHj212RuleTask|ExecuteComHj212RuleTask)\.run\('([^']+)', '([^']+)', '([^']+)', '([^']+)', '([^']+)', (\w+)\)/);
    if (params) {
      // 判断是哪种协议
      const isSiChuan = invokeTarget.includes('ExecuteSiChuanHj212RuleTask');
      return {
        executeComHj212Protocol: isSiChuan ? 'sichuan' : 'common',
        executeComHj212Host: params[1],
        executeComHj212Port: params[2],
        executeComHj212RuleId: params[3],
        executeComHj212StartTime: params[4],
        executeComHj212EndTime: params[5],
        executeComHj212IsTime: params[6] === 'true' ? 'true' : 'false',
      };
    }
  }

  return null;
}
// 打开执行HJ212推送任务对话框
function  handleExecuteHj212RuleTaskOpen(){
  let params = parseExecuteHj212RuleTaskParams(form.value.invokeTarget);
  executeComHj212Open.value = true
  if (params) {
    executeComHj212Form.value = {
      executeComHj212Protocol: params.executeComHj212Protocol || '',
      executeComHj212Host: params.executeComHj212Host || '',
      executeComHj212Port: params.executeComHj212Port || '',
      executeComHj212RuleId: params.executeComHj212RuleId || '',
      executeComHj212StartTime: params.executeComHj212StartTime || '',
      executeComHj212EndTime: params.executeComHj212EndTime || '',
      executeComHj212IsTime: params.executeComHj212IsTime || 'false',
    }
  }else {
    executeComHj212Form.value = {
      executeComHj212Protocol: '',
      executeComHj212Host: '',
      executeComHj212Port: '',
      executeComHj212RuleId: '',
      executeComHj212StartTime: '',
      executeComHj212EndTime: '',
      executeComHj212IsTime: 'false',
    }
  }
}

// 处理协议变化
function handleProtocolChange() {
  // 切换协议时清空推送规则选择
  executeComHj212Form.value.executeComHj212RuleId = '';
}
// 获取设备数据
async function fetchDeviceList() {
  try {
    const response = await getNowData();
    if (response.code === 200) {
      deviceList.value = response.data || [];
    }
  } catch (error) {
    console.error('获取设备列表失败:', error);
    proxy.$modal.msgError('获取设备列表失败');
  }
}

// 处理设备选择变化
function handleDeviceChange(deviceId) {
  if (deviceId) {
    const selectedDevice = deviceList.value.find(device => device.deviceId === deviceId);
    if (selectedDevice && selectedDevice.deviceAttrs) {
      availableAttributes.value = selectedDevice.deviceAttrs;
    } else {
      availableAttributes.value = [];
    }
    // 清空之前选择的参数
    aggregateForm.value.aggregateAttributeId = '';
  } else {
    availableAttributes.value = [];
    aggregateForm.value.aggregateAttributeId = '';
  }
}

// 打开聚合数据对话框
async function handleAggregationDataTaskOpen(){
  console.log("handleAggregationDataTaskOpen", form.value)
  let params = parseAggregationDataParams(form.value.invokeTarget);
  
  // 获取设备列表
  await fetchDeviceList();
  
  aggregateOpen.value = true
  if (params) {
    // 保存参数ID，因为 handleDeviceChange 会清空它
    const savedAttributeId = params.aggregateAttributeId || '';
    
    aggregateForm.value = {
      aggregateType: params.aggregateType,
      aggregateStartTime: params.aggregateStartTime,
      aggregateEndTime: params.aggregateEndTime,
      aggregateIsTime: params.aggregateIsTime.toString(),
      aggregateIsFilter: params.aggregateIsFilter ? 'true' : 'false',
      aggregateDeviceId: params.aggregateDeviceId || '',
      aggregateAttributeId: savedAttributeId,
    }
    
    // 如果选择了设备，更新可用属性列表
    if (params.aggregateDeviceId && params.aggregateDeviceId !== '') {
      handleDeviceChange(params.aggregateDeviceId);
      // 在更新可用属性列表后，重新设置参数ID
      aggregateForm.value.aggregateAttributeId = savedAttributeId;
    }
  }else {
    aggregateForm.value = {
      aggregateType: '5minute', // 默认5分钟聚合
      aggregateStartTime: '',
      aggregateEndTime: '',
      aggregateIsTime: 'false',
      aggregateIsFilter: 'false',
      aggregateDeviceId: '',
      aggregateAttributeId: '',
    }
  }
  console.log(22,aggregateForm.value)
}
function parsePartitionParams(invokeTarget) {
  if(invokeTarget != null){
    // 解析CreatePartitionTablesTask.run('realdata','-1','1') 提取出三个参数
    let params = invokeTarget.match(/CreatePartitionTablesTask\.run\('([^']*)',([^']*),([^']*)\)/);
    if (params) {
      return {
        table: params[1],
        startWeek: parseInt(params[2]),
        endWeek: parseInt(params[3]),
      };
    }
  }
  return null;
}
function handlePartitionOpen(){
  // 尝试从现有的invokeTarget中解析参数
  const existingParams = parsePartitionParams(form.value.invokeTarget);

  partitionOpen.value = true
  if (existingParams) {
    partitionForm.value = {
      table: existingParams.table,
      startWeek: existingParams.startWeek,
      endWeek: existingParams.endWeek,
    }
  }else {
    partitionForm.value = {
      table: '',
      startWeek: null,
      endWeek: null,
    }
  }
}

// 关闭对话框时重置表单
function handleMaintenanceClose() {
  maintenanceForm.value = {
    maintenanceType: '',
  };
}
function handleAggregateClose(){
  aggregateForm.value = {
    aggregateType: '5minute', // 默认5分钟聚合
    aggregateStartTime: '',
    aggregateEndTime: '',
    aggregateIsTime: false,
    aggregateIsFilter: false,
    aggregateDeviceId: '',
    aggregateAttributeId: '',
  }
}
// 关闭执行HJ212推送任务对话框时重置表单
function handleExecuteComHj212Close(){
  executeComHj212Form.value = {
    executeComHj212Protocol: '',
    executeComHj212Host: '',
    executeComHj212Port: '',
    executeComHj212RuleId: '',
    executeComHj212StartTime: '',
    executeComHj212EndTime: '',
    executeComHj212IsTime: 'false',
  }
}
function handlePartitionClose(){
  partitionForm.value = {
    table: '',
    startWeek: null,
    endWeek: null,
  };
}
// 新增创建分表对话框确认按钮方法
function handlePartitionConfirm() {
  // 表单验证
  proxy.$refs.partitionFormRef.validate(valid => {
    if (valid) {
      partitionOpen.value = false;
      // 触发自定义创建分表参数处理逻辑
      // 开始周必须小于等于结束周
      if (partitionForm.value.startWeek > partitionForm.value.endWeek) {
        proxy.$message.error('开始周必须小于等于结束周');
        return;
      }
      handlePartitionSubmit(partitionForm.value);
    }
  });
}
// 新增创建分表对话框确认按钮方法
function handlePartitionSubmit(params) {
  // 在这里编写创建分表的具体逻辑
  console.log('创建分表参数提交:', params);
  // 在这里编写具体的业务逻辑
  let table = params.table;
  let startWeek = params.startWeek;
  let endWeek = params.endWeek;
  // 在这里编写具体的业务逻辑
  let cmd = jobTypeDict["CreatePartitionTablesTask"](table, startWeek, endWeek)
  console.log('创建分表参数提交:', params);
  console.log('创建分表参数提交:', cmd);
  form.value.invokeTarget = cmd;
}
// 确认按钮方法（需自定义业务逻辑）
function handleMaintenanceConfirm() {
  // 表单验证
  proxy.$refs.maintenanceFormRef.validate(valid => {
    if (valid) {
      maintenanceOpen.value = false;
      // 触发自定义维护参数处理逻辑
      handleMaintenanceSubmit(maintenanceForm.value);
    }
  });
}
function handleAggregateConfirm(){
  // 表单验证
  proxy.$refs.aggregateFormRef.validate(valid => {
    if (valid) {
      aggregateOpen.value = false;
      // 触发自定义维护参数处理逻辑
      handleAggregateSubmit(aggregateForm.value);
    }
  });
}

function handleExecuteComHj212Confirm(){
  // 表单验证
  proxy.$refs.executeComHj212FormRef.validate(valid => {
    if (valid) {
      executeComHj212Open.value = false;
      // 触发自定义维护参数处理逻辑
      handleExecuteComHj212Submit(executeComHj212Form.value);
    }
  });
}
function handleExecuteComHj212Submit(params) {
  let executeComHj212Protocol = params.executeComHj212Protocol;
  let executeComHj212Host = params.executeComHj212Host;
  let executeComHj212Port = params.executeComHj212Port.toString();
  let executeComHj212RuleId = params.executeComHj212RuleId;
  
  // 只有在启用自定义时间时才使用用户输入的时间，否则使用空字符串
  let executeComHj212StartTime = (params.executeComHj212IsTime === 'true') ? params.executeComHj212StartTime : '';
  let executeComHj212EndTime = (params.executeComHj212IsTime === 'true') ? params.executeComHj212EndTime : '';
  let executeComHj212IsTime = params.executeComHj212IsTime;
  
  // 在这里编写具体的业务逻辑
  let cmd = jobTypeDict["ExecuteHj212RuleTask"](executeComHj212Protocol, executeComHj212Host, executeComHj212Port, executeComHj212RuleId, executeComHj212StartTime, executeComHj212EndTime, executeComHj212IsTime)
  console.log('执行HJ212推送任务参数提交:', params);
  console.log('执行HJ212推送任务参数提交:', cmd);

  form.value.invokeTarget = cmd;
}

function handleAggregateSubmit(params){
  let aggregateType = params.aggregateType;
  let aggregateIsTime = params.aggregateIsTime;
  let aggregateIsFilter = params.aggregateIsFilter;
  
  // 只有在启用自定义时间时才使用用户输入的时间，否则使用空字符串
  let aggregateStartTime = (aggregateIsTime === 'true') ? params.aggregateStartTime : '';
  let aggregateEndTime = (aggregateIsTime === 'true') ? params.aggregateEndTime : '';
  
  // 处理设备筛选参数 - 确保所有参数都是字符串类型
  let deviceId = '*'; // 默认全部设备
  let attributeId = '*'; // 默认全部参数
  
  if (aggregateIsFilter === 'true') {
    deviceId = params.aggregateDeviceId ? params.aggregateDeviceId.toString() : '*';
    attributeId = params.aggregateAttributeId ? params.aggregateAttributeId.toString() : '*';
  }
  
  // 将聚合类型转换为分钟数
  let minutes = convertAggregateTypeToMinutes(aggregateType);
  
  // 确保所有参数都是字符串类型
  const stringParams = {
    aggregateType: aggregateType.toString(),
    aggregateStartTime: aggregateStartTime.toString(),
    aggregateEndTime: aggregateEndTime.toString(),
    aggregateIsTime: aggregateIsTime.toString(),
    minutes: minutes.toString(),
    deviceId: deviceId.toString(),
    attributeId: attributeId.toString()
  };
  
  // 在这里编写具体的业务逻辑
  let cmd = jobTypeDict["aggregationDataTask"](stringParams.aggregateType, stringParams.aggregateStartTime, stringParams.aggregateEndTime, stringParams.aggregateIsTime, stringParams.minutes, stringParams.deviceId, stringParams.attributeId)
  console.log('聚合数据参数提交:', params);
  console.log('聚合数据参数提交:', cmd);

  form.value.invokeTarget = cmd;
}
// 预留的维护参数处理方法
function handleMaintenanceSubmit(params) {
  // 在这里编写维护参数的具体处理逻辑
  console.log('维护参数提交:', params);
  // 在这里编写巡检参数的具体处理逻辑
  let maintenanceType = params.maintenanceType;
  // 在这里编写具体的业务逻辑
  let cmd = jobTypeDict["Maintenance"](maintenanceType)
  console.log('维护参数提交:', params);
  console.log('维护参数提交:', cmd);
  form.value.invokeTarget = cmd;
}

const sortConfig = reactive({
  sortBy: 'nextValidTime', // 默认排序字段
  sortAsc: false // 默认降序
});

function sortTableData() {
  const { sortBy, sortAsc } = sortConfig;
  if (!sortBy) return;

  jobList.value = [...jobList.value].sort((a, b) => {
    const valA = a[sortBy];
    const valB = b[sortBy];

    if (valA === undefined || valB === undefined) return 0;

    // 处理日期字段
    if (sortBy === 'nextValidTime' || sortBy === 'createTime') {
      const dateA = new Date(valA);
      const dateB = new Date(valB);
      return sortAsc ? dateA - dateB : dateB - dateA;
    }

    // 处理数字字段
    if (!isNaN(valA) && !isNaN(valB)) {
      return sortAsc ? valA - valB : valB - valA;
    }

    // 默认按字符串排序
    return sortAsc
        ? valA.toString().localeCompare(valB.toString())
        : valB.toString().localeCompare(valA.toString());
  });
}

function handleSortChange({ column, prop, order }) {
  if (prop === 'nextValidTime') {
    // 本地排序逻辑下次执行时间（仅当前页）
    sortConfig.sortBy = prop;
    sortConfig.sortAsc = order === 'ascending';
    sortTableData();
  } else {
    // 其他列的排序后端完成逻辑
    queryParams.value.sortBy = prop;
    queryParams.value.sortAsc = order === 'ascending';
    getList();
  }

}

</script>
<style scoped>
.ellipsis-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 200px; /* 根据需要调整最大宽度 */
}
.task-detail-tooltip {
  white-space: pre-wrap; /* 保留换行符并允许自动换行 */
}
.cron-help-text, .invoke-target-help-text {
  font-size: 12px; /* 减小字体大小 */
}
.invalid-cron, .invalid-invoke {
  color: red;
}
.valid-cron, .valid-invoke {
  color: green;
}
</style>
