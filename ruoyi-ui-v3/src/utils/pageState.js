/**
 * 页面状态记忆工具
 * 用于记住用户上次访问的页面和页面状态
 */

const STORAGE_KEY = 'pageState';
const DEFAULT_STATE = {
  lastVisitedPage: '/index',
  pageHistory: [],
  userPreferences: {
    autoSwitch: false,
    rememberPosition: true
  },
  homepageDisplayMode: 'device-list' // 默认设备列表模式
};

/**
 * 获取页面状态
 */
export function getPageState() {
  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored ? { ...DEFAULT_STATE, ...JSON.parse(stored) } : DEFAULT_STATE;
  } catch (error) {
    console.warn('Failed to get page state:', error);
    return DEFAULT_STATE;
  }
}

/**
 * 保存页面状态
 */
export function savePageState(state) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
  } catch (error) {
    console.warn('Failed to save page state:', error);
  }
}

/**
 * 记录页面访问
 */
export function recordPageVisit(pagePath, pageData = {}) {
  const currentState = getPageState();
  const visitRecord = {
    path: pagePath,
    timestamp: Date.now(),
    data: pageData
  };
  
  // 更新访问历史（最多保留10条记录）
  const newHistory = [visitRecord, ...currentState.pageHistory]
    .filter((record, index, arr) => 
      arr.findIndex(r => r.path === record.path) === index
    )
    .slice(0, 10);
  
  const newState = {
    ...currentState,
    lastVisitedPage: pagePath,
    pageHistory: newHistory
  };
  
  savePageState(newState);
  return newState;
}

/**
 * 获取上次访问的页面
 */
export function getLastVisitedPage() {
  const state = getPageState();
  return state.lastVisitedPage;
}

/**
 * 获取页面访问历史
 */
export function getPageHistory() {
  const state = getPageState();
  return state.pageHistory;
}

/**
 * 清除页面状态
 */
export function clearPageState() {
  try {
    localStorage.removeItem(STORAGE_KEY);
  } catch (error) {
    console.warn('Failed to clear page state:', error);
  }
}

/**
 * 检查是否应该自动跳转
 */
export function shouldAutoSwitch() {
  const state = getPageState();
  return state.userPreferences.autoSwitch;
}

/**
 * 更新用户偏好
 */
export function updateUserPreferences(preferences) {
  const currentState = getPageState();
  const newState = {
    ...currentState,
    userPreferences: { ...currentState.userPreferences, ...preferences }
  };
  savePageState(newState);
  return newState;
}

/**
 * 保存首页显示模式
 * @param {string} mode - 'dashboard' | 'device-list'
 */
export function saveHomepageDisplayMode(mode) {
  const currentState = getPageState();
  const newState = {
    ...currentState,
    homepageDisplayMode: mode
  };
  savePageState(newState);
  return newState;
}

/**
 * 获取首页显示模式
 * @returns {string} 'dashboard' | 'device-list'
 */
export function getHomepageDisplayMode() {
  const state = getPageState();
  return state.homepageDisplayMode || 'dashboard';
}

/**
 * 清除首页显示模式记忆
 */
export function clearHomepageDisplayMode() {
  const currentState = getPageState();
  const newState = {
    ...currentState,
    homepageDisplayMode: 'dashboard'
  };
  savePageState(newState);
  return newState;
}
