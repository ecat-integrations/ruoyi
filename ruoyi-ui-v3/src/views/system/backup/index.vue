<template>
  <div class="app-container">
    <!-- 醒目风险提示：备份还原属于维护级操作，先把影响讲清楚 -->
    <el-alert
      type="warning"
      :closable="false"
      show-icon
      title="备份还原会短暂停止相关服务，过程中系统不可用"
      class="risk-alert"
    >
      <template #default>
        <p class="risk-text">{{ riskNotice }}</p>
      </template>
    </el-alert>

    <el-alert
      v-if="info.maintenanceRunning"
      type="error"
      :closable="false"
      show-icon
      class="risk-alert"
      title="检测到正在进行的备份或还原任务，请勿重复操作"
    >
      <template #default>
        <p class="risk-text">维护锁：{{ info.maintenanceDetail || '未知' }}</p>
      </template>
    </el-alert>

    <el-alert
      v-if="loaded && !info.guardianInstalled"
      type="info"
      :closable="false"
      show-icon
      class="risk-alert"
      title="未在当前服务器上识别到守护工具"
    >
      <template #default>
        <p class="risk-text">
          可能是在开发环境运行，或安装目录结构与该版本不一致。请在服务器上打开安装目录下的守护工具，再进入「备份还原」页。
        </p>
      </template>
    </el-alert>

    <el-card shadow="never" class="info-card">
      <template #header>
        <div class="card-header">
          <span>操作步骤</span>
          <el-button link type="primary" :icon="Refresh" @click="loadInfo">刷新</el-button>
        </div>
      </template>

      <div class="step-list">
        <div
          v-for="(step, index) in steps"
          :key="step.title"
          class="step-item"
          :class="'is-' + stepState(index)"
        >
          <div class="step-index">{{ index + 1 }}</div>
          <div class="step-body">
            <div class="step-title">{{ step.title }}</div>
            <div class="step-desc">{{ step.desc }}</div>

            <!-- 第 2 步：必须在勾选「已知悉风险」后才允许打开守护工具 -->
            <div v-if="step.action" class="step-action">
              <el-checkbox v-model="riskAcknowledged" class="ack-checkbox">
                我已知悉上述风险，并确认当前无正在进行的采集、上报等业务任务
              </el-checkbox>

              <el-tooltip
                :disabled="riskAcknowledged"
                content="请先勾选上方确认项"
                placement="top"
              >
                <span class="open-btn-wrap">
                  <el-button
                    v-hasPermi="['system:backup:open']"
                    type="primary"
                    :loading="opening"
                    :disabled="!riskAcknowledged || info.maintenanceRunning"
                    :icon="FolderOpened"
                    @click="handleOpenGuardian"
                  >
                    打开守护工具
                  </el-button>
                </span>
              </el-tooltip>

              <div class="guardian-state">
                守护工具当前：
                <el-tag v-if="info.guardianRunning" type="success" size="small">运行中</el-tag>
                <el-tag v-else type="info" size="small">未运行</el-tag>
                <span class="text-muted">（点击上方按钮后，打开「备份还原」工具窗口）</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <el-divider />

      <div class="backup-dir">
        <span class="backup-dir-label">备份存放目录</span>
        <span class="mono">{{ info.backupRoot || '未识别' }}</span>
        <el-button
          v-if="info.backupRoot"
          link
          type="primary"
          class="ml8"
          @click="copyText(info.backupRoot)"
        >
          复制
        </el-button>
        <div class="text-muted backup-dir-tip">
          所有备份都存放在该目录下，按备份时间命名的子目录即为一份快照。需要人工处置时，可在对应快照目录内查看还原说明。
        </div>
      </div>
    </el-card>

    <el-card shadow="never" class="info-card">
      <template #header>
        <div class="card-header">
          <span>可用快照</span>
          <span class="text-muted">共 {{ info.snapshotCount || 0 }} 个，最新：{{ info.latestSnapshotId || '无' }}</span>
        </div>
      </template>

      <el-table v-loading="loading" :data="info.snapshots || []" size="small" border>
        <el-table-column prop="id" label="快照 ID" min-width="190">
          <template #default="scope">
            <span class="mono">{{ scope.row.id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="备份时间" width="170">
          <template #default="scope">{{ formatTime(scope.row.createdAt) }}</template>
        </el-table-column>
        <el-table-column label="包含内容" min-width="220">
          <template #default="scope">
            <el-tag
              v-for="kind in scope.row.kinds || []"
              :key="kind"
              size="small"
              class="kind-tag"
            >
              {{ kindLabel(kind) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="大小" width="110">
          <template #default="scope">{{ scope.row.totalBytesText || '-' }}</template>
        </el-table-column>
        <el-table-column label="文件数" width="90">
          <template #default="scope">{{ scope.row.totalFiles || 0 }}</template>
        </el-table-column>
        <el-table-column label="状态" width="130">
          <template #default="scope">
            <el-tooltip
              :disabled="scope.row.valid"
              :content="scope.row.validationMessage || ''"
              placement="top"
            >
              <el-tag :type="scope.row.valid ? 'success' : 'danger'" size="small">
                {{ scope.row.valid ? '可用' : '不可用' }}
              </el-tag>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <el-empty v-if="loaded && !(info.snapshots || []).length" description="暂无快照，请打开守护工具执行一次备份" />
    </el-card>
  </div>
</template>

<script setup name="Backup">
import { ref, reactive, onMounted } from 'vue'
import { getCurrentInstance } from 'vue'
import { FolderOpened, Refresh } from '@element-plus/icons-vue'
import { getBackupInfo, openGuardianBackup } from '@/api/system/backup'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const opening = ref(false)
const loaded = ref(false)
const riskNotice = ref('')
// 风险确认门控：勾选前不允许打开守护工具
const riskAcknowledged = ref(false)

const info = reactive({
  backupRoot: '',
  guardianInstalled: false,
  guardianRunning: false,
  maintenanceRunning: false,
  maintenanceDetail: '',
  snapshots: [],
  snapshotCount: 0,
  latestSnapshotId: ''
})

// 面向使用者的引导步骤：只说做什么，不铺具体文件与目录结构
const steps = [
  {
    title: '了解影响范围',
    desc:
      '备份与还原都需要短暂停止相关服务，期间系统无法访问。\n' +
      '请安排在业务空闲时段操作，避免与采集、上报等任务重叠。备份内容涵盖数据库与运行配置，不含媒体文件。'
  },
  {
    title: '确认操作风险',
    desc: '备份还原由特定的「备份还原」工具实际执行。确认下方选项后点击按钮打开它。',
    action: true
  },
  {
    title: '执行备份或还原',
    desc:
      '备份：在工具「备份还原」页中点击「立即备份」并等待完成。\n' +
      '还原：在快照列表中选择目标快照后点击「还原」，工具会先自动保存一份当前状态再执行还原。'
  },
  {
    title: '验证结果',
    desc:
      '操作完成后按工具提示启动服务，登录系统确认功能正常。\n' +
      '如结果不符合预期，再次执行还原并选择上一份快照进行回退。'
  }
]

// 仅用于步骤序号的状态着色：1 待确认 → 2 待打开 → 3 待执行
const stepState = (index) => {
  if (index === 0) return riskAcknowledged.value ? 'done' : 'current'
  if (index === 1) return !riskAcknowledged.value ? 'todo' : (info.guardianRunning ? 'done' : 'current')
  if (index === 2) return info.guardianRunning ? 'current' : 'todo'
  return (info.snapshots || []).length ? 'done' : 'todo'
}

// 与守护工具 BackupConstants.Kind* 保持一致；刻意用业务说法，不暴露文件名
const kindLabels = {
  database: '数据库',
  'ecat-data': '运行数据',
  'backend-env': '后端配置',
  'nginx-conf': '网关配置',
  'system-config': '系统配置',
  'maven-ecat': '离线依赖包'
}

function kindLabel(kind) {
  return kindLabels[kind] || kind
}

function formatTime(value) {
  if (!value) return '-'
  // C# 输出的时间可能带 7 位小数秒，JS Date 解析不可靠，这里直接截取到秒
  const matched = String(value).match(/^(\d{4})-(\d{2})-(\d{2})[T ](\d{2}):(\d{2}):(\d{2})/)
  return matched
    ? `${matched[1]}-${matched[2]}-${matched[3]} ${matched[4]}:${matched[5]}:${matched[6]}`
    : String(value)
}

function copyText(text) {
  if (!text) return
  const done = () => proxy.$modal.msgSuccess('已复制到剪贴板')
  if (navigator.clipboard && window.isSecureContext) {
    navigator.clipboard.writeText(text).then(done).catch(() => fallbackCopy(text, done))
  } else {
    fallbackCopy(text, done)
  }
}

function fallbackCopy(text, done) {
  const textarea = document.createElement('textarea')
  textarea.value = text
  textarea.style.position = 'fixed'
  textarea.style.opacity = '0'
  document.body.appendChild(textarea)
  textarea.select()
  try {
    document.execCommand('copy')
    done()
  } catch (e) {
    proxy.$modal.msgWarning('复制失败，请手动复制：' + text)
  }
  document.body.removeChild(textarea)
}

function loadInfo() {
  loading.value = true
  getBackupInfo()
    .then((res) => {
      const data = res.data || {}
      Object.keys(info).forEach((key) => {
        if (data[key] !== undefined && data[key] !== null) {
          info[key] = data[key]
        }
      })
      // 快照列表与计数以服务端为准，避免 null 覆盖成空对象
      info.snapshots = data.snapshots || []
      info.snapshotCount = data.snapshotCount || info.snapshots.length
      if (data.riskNotice) riskNotice.value = data.riskNotice
      loaded.value = true
    })
    .finally(() => {
      loading.value = false
    })
}

function handleOpenGuardian() {
  opening.value = true
  openGuardianBackup()
    .then((res) => {
      proxy.$modal.msgSuccess(res.msg || '已请求打开守护工具')
      // 唤起后守护程序需要几秒才会弹出窗口，稍后刷新一次状态
      setTimeout(loadInfo, 3000)
    })
    .finally(() => {
      opening.value = false
    })
}

onMounted(loadInfo)
</script>

<style scoped>
.risk-alert {
  margin-bottom: 14px;
}

.risk-text {
  margin: 4px 0;
  line-height: 1.7;
}

.info-card {
  margin-bottom: 16px;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-weight: 600;
}

/* 纵向引导步骤 */
.step-list {
  padding: 4px 0 0;
}

.step-item {
  display: flex;
  gap: 12px;
  padding-bottom: 18px;
  position: relative;
}

.step-item:not(:last-child)::before {
  content: '';
  position: absolute;
  left: 13px;
  top: 30px;
  bottom: 0;
  width: 1px;
  background: #dcdfe6;
}

.step-index {
  flex: 0 0 28px;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 600;
  color: #909399;
  background: #f4f4f5;
  border: 1px solid #dcdfe6;
  z-index: 1;
}

.step-body {
  flex: 1;
  min-width: 0;
  padding-top: 3px;
}

.step-title {
  font-weight: 600;
  line-height: 1.6;
}

.step-desc {
  color: #606266;
  font-size: 13px;
  line-height: 1.8;
  margin-top: 2px;
  /* 保留 desc 中的换行（\n），便于把多条操作说明分行展示 */
  white-space: pre-line;
}

.step-action {
  margin-top: 12px;
  padding: 12px 14px;
  background: #fafafa;
  border: 1px solid #ebeef5;
  border-radius: 4px;
}

.ack-checkbox {
  display: block;
  margin-bottom: 12px;
}

.ack-checkbox :deep(.el-checkbox__label) {
  white-space: normal;
  line-height: 1.6;
}

.open-btn-wrap {
  display: inline-block;
}

.guardian-state {
  margin-top: 10px;
  font-size: 12px;
  color: #606266;
}

.step-item.is-current .step-index {
  color: #fff;
  background: #409eff;
  border-color: #409eff;
}

.step-item.is-done .step-index {
  color: #fff;
  background: #67c23a;
  border-color: #67c23a;
}

.backup-dir {
  line-height: 1.8;
}

.backup-dir-label {
  margin-right: 8px;
  color: #606266;
  font-size: 13px;
}

.backup-dir-tip {
  margin-top: 2px;
  line-height: 1.7;
}

.kind-tag {
  margin-right: 4px;
  margin-bottom: 2px;
}

.ml8 {
  margin-left: 8px;
}

.mono {
  font-family: Consolas, Monaco, 'Courier New', monospace;
  word-break: break-all;
}

.text-muted {
  color: #909399;
  font-size: 12px;
}
</style>
