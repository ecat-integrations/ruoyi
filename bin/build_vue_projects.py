#!python3
# -*- coding: utf-8 -*-
"""前端一键打包：并行构建 ecat-integrations 下所有 vue-modules。

输出约定
--------
* 日志在终端里正常逐行滚动；
* 进度条全程只有一条，固定在终端最后一行，不会随日志滚走；
* 构建结束时**不擦掉进度条**，直接在同一行把它更新为最终统计
  （成功 / 失败 / 跳过 / 总耗时），也不另起一块总结输出；
* 支持 ANSI 的终端用「滚动区域(DECSTBM)」把最后一行单独留给进度条；
* 终端不支持滚动区域时退化为「单行原地刷新」；
* 输出被重定向到文件（非交互终端）时只输出普通日志，不写入任何控制字符。

中断约定
--------
* 按一次 Ctrl+C 即中止：终止所有正在跑的 npm 进程树 -> 未完成的模块记为「已取消」
  -> 进度条原位变成 [中断] 统计 -> 复位终端 -> 退出码 130；
* npm 子进程跑在独立进程组里、stdin 接空设备，因此它们不会收到我们的 Ctrl+C，
  也不会卡在 cmd.exe 那句看不见的 "Terminate batch job (Y/N)?" 上；
* 收尾期间连按 Ctrl+C 不会打断退出流程（避免反复中断导致终端残留花屏）。
"""

import concurrent.futures
import os
import platform
import re
import shutil
import signal
import subprocess
import sys
import threading
import time
import unicodedata
from pathlib import Path

# --------------------------------------------------------------------------- #
# 配置
# --------------------------------------------------------------------------- #
MAX_WORKERS = 8             # 最大并行数
SHOW_PROGRESS = True        # 是否显示底部固定进度条
PROGRESS_BAR_LENGTH = 30    # 进度条长度（字符数）
REFRESH_INTERVAL = 0.2      # 进度条刷新间隔（秒）
INTERRUPT_POLL = 0.2        # 主线程等待超时：定期回到解释器循环，保证 Ctrl+C 立刻生效
SPINNER_FRAMES = "|/-\\"    # 活动指示帧


# --------------------------------------------------------------------------- #
# 颜色（colorama 可选；未安装时按终端能力自行决定是否输出 ANSI）
# --------------------------------------------------------------------------- #
def _plain_colors():
    class _NoColor:
        def __getattr__(self, _name):
            return ""

    return _NoColor(), _NoColor()


_ANSI_RE = re.compile(r"\033\[[0-9;?]*[A-Za-z]")


def _is_tty(stream):
    try:
        return bool(stream.isatty())
    except Exception:
        return False


try:
    import colorama

    try:
        # 0.4.6+：只有老式控制台才包装 sys.stdout，避免吞掉滚动区域等高级序列
        colorama.just_fix_windows_console()
    except AttributeError:  # 兼容老版本 colorama
        colorama.init()

    _HAS_COLORAMA = True
    _Fore, _Style = colorama.Fore, colorama.Style
except ImportError:  # 没装 colorama 也能跑
    _HAS_COLORAMA = False
    _Fore, _Style = _plain_colors()

if not _is_tty(sys.stdout):
    # 输出被重定向（写日志文件、管道）时不要往里面塞颜色转义字符
    _Fore, _Style = _plain_colors()

RESET = _Style.RESET_ALL
RED = _Fore.RED
GREEN = _Fore.GREEN
YELLOW = _Fore.YELLOW
CYAN = _Fore.CYAN


# --------------------------------------------------------------------------- #
# 终端能力
# --------------------------------------------------------------------------- #
def _supports_vt(stream):
    """终端是否支持原生 ANSI 转义序列（滚动区域等高级序列依赖此能力）。"""
    if os.name != "nt":
        return _is_tty(stream)

    try:
        import ctypes
        import msvcrt
        from ctypes import wintypes

        kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
        handle = wintypes.HANDLE(msvcrt.get_osfhandle(stream.fileno()))
        mode = wintypes.DWORD()
        if not kernel32.GetConsoleMode(handle, ctypes.byref(mode)):
            return False

        vt_flag = 0x0004  # ENABLE_VIRTUAL_TERMINAL_PROCESSING
        if not mode.value & vt_flag:
            if not kernel32.SetConsoleMode(handle, mode.value | vt_flag):
                return False
            if not kernel32.GetConsoleMode(handle, ctypes.byref(mode)):
                return False
        return bool(mode.value & vt_flag)
    except Exception:
        return False


def _strip_ansi(text):
    return _ANSI_RE.sub("", text)


def _normalize_newlines(text):
    """npm 的输出里常带 \\r 进度控制符，在固定进度条区域里会把行首覆盖掉，统一清理。"""
    return text.replace("\r\n", "\n").replace("\r", "")


def _display_width(text):
    """按终端显示宽度计算（中文等全角字符占 2 列）。"""
    width = 0
    for char in _strip_ansi(text):
        width += 2 if unicodedata.east_asian_width(char) in ("W", "F") else 1
    return width


def _clip_ansi(text, max_width):
    """按显示宽度截断文本，保留 ANSI 颜色序列并在结尾补 RESET。"""
    if max_width <= 0:
        return ""
    if _display_width(text) <= max_width:
        return text

    out = []
    width = 0
    index = 0
    while index < len(text):
        match = _ANSI_RE.match(text, index)
        if match:
            out.append(match.group())
            index = match.end()
            continue
        char = text[index]
        char_width = 2 if unicodedata.east_asian_width(char) in ("W", "F") else 1
        if width + char_width > max_width:
            break
        out.append(char)
        width += char_width
        index += 1
    out.append(RESET)
    return "".join(out)


# --------------------------------------------------------------------------- #
# 底部固定进度条
# --------------------------------------------------------------------------- #
class ProgressBar:
    """底部固定进度条（线程安全）。

    pinned  模式：用滚动区域把终端最后一行留给进度条，日志只在上方滚动，
                  进度条始终停在同一行；
    inline  模式：终端不支持滚动区域时，退化为「擦掉进度条 -> 写日志 -> 重画」；
    plain   模式：非交互终端（重定向到文件等）只输出普通日志。
    """

    MIN_ROWS = 5                        # 终端太矮就不做固定进度条
    FALLBACK_SIZE = (80, 24)            # (列, 行)
    NEED_PINNED = "pinned"
    NEED_INLINE = "inline"
    NEED_PLAIN = "plain"

    def __init__(self, stream=None):
        self._stream = stream if stream is not None else sys.stdout
        self._lock = threading.RLock()
        self._stop_event = threading.Event()
        self._line = ""
        self._active = False
        self._mode = self.NEED_PLAIN
        self._tty = _is_tty(self._stream)
        self._vt = _supports_vt(self._stream)
        self._rows, self._cols = self.FALLBACK_SIZE[1], self.FALLBACK_SIZE[0]
        self._region_rows = None        # 当前生效的滚动区域高度
        self._cursor_hidden = False
        self._bottom_blank = True       # 日志区末行当前是否为空行
        self._refresh_size()

    # ---------------- 模式选择 ----------------
    def detect_mode(self, show=True):
        self._refresh_size()
        if not show or not self._tty:
            return self.NEED_PLAIN
        if self._vt and self._rows >= self.MIN_ROWS:
            return self.NEED_PINNED
        if self._vt or _HAS_COLORAMA:
            return self.NEED_INLINE
        return self.NEED_PLAIN

    @property
    def mode(self):
        return self._mode

    @property
    def width(self):
        """当前终端列数（供调用方自适应排版）。"""
        self._refresh_size()
        return self._cols

    # ---------------- 生命周期 ----------------
    def start(self, mode):
        with self._lock:
            self._mode = mode
            self._active = mode != self.NEED_PLAIN
            if not self._active:
                return
            self._refresh_size()
            if mode == self.NEED_PINNED:
                self._apply_region_locked()
                if self._vt:
                    self._write("\033[?25l")     # 隐藏光标，避免光标压在进度条上
                    self._cursor_hidden = True
            self._redraw_locked()

    def stop(self):
        with self._lock:
            self._stop_event.set()
            if not self._active:
                return
            self._active = False
            rows = self._rows
            if self._mode == self.NEED_PINNED:
                self._write(
                    f"\033[{rows};1H\033[2K"         # 清掉进度条所在行
                    "\033[r"                          # 复位滚动区域
                    f"\033[{rows - 1};1H"             # 光标回到日志区末尾
                )
                self._region_rows = None
            else:
                self._write("\r\033[K")
            if self._cursor_hidden:
                self._write("\033[?25h")              # 恢复光标
                self._cursor_hidden = False
            self._line = ""

    def finish(self, summary_line):
        """收尾：保留进度条那一行的位置，把最终统计画上去当作总结，不再另起一块输出。

        pinned 模式下总结行落在日志区最后一行，光标停在它下方的空行，
        后续输出自然向下续写；日志区末行若还压着内容，先滚一行腾出位置。
        """
        with self._lock:
            self._stop_event.set()
            if not self._active:
                self._write(summary_line + "\n")
                return
            self._active = False
            rows = self._rows
            if self._mode == self.NEED_PINNED:
                if not self._bottom_blank:
                    # 日志区末行还有内容，先在滚动区域内滚一行腾出总结的位置
                    self._write(f"\033[{rows - 1};1H\n")
                self._write(
                    "\033[r"                               # 复位滚动区域
                    f"\033[{rows};1H\033[2K"               # 擦掉进度条那行
                    f"\033[{rows - 1};1H"                  # 总结落在日志区末行
                )
                self._write(_clip_ansi(summary_line, self._cols - 1))
                self._write(f"\033[{rows};1H")             # 光标移到总结行下方的空行
                self._region_rows = None
            else:
                self._write("\r\033[K" + summary_line + "\n")
            if self._cursor_hidden:
                self._write("\033[?25h")                  # 恢复光标
                self._cursor_hidden = False
            self._line = ""

    def request_stop(self):
        self._stop_event.set()

    def should_stop(self):
        return self._stop_event.is_set()

    def wait(self, timeout):
        return self._stop_event.wait(timeout)

    # ---------------- 输出 ----------------
    def log(self, message="", end="\n"):
        """输出一行日志：进度条不会被日志淹没，也不会复制出多条。"""
        with self._lock:
            text = f"{message}{end}" if end else message
            if not self._active:
                self._write(text)
                return
            text = _normalize_newlines(text)
            if self._mode == self.NEED_PINNED:
                # 光标回到保留行上方，日志在滚动区域内向上滚动，最后一行不受影响
                self._write(f"\033[{self._rows - 1};1H" + text)
                # 以换行结尾时内容已滚到上方，日志区末行重新变空
                self._bottom_blank = text.endswith("\n")
                self._redraw_locked()
            else:
                self._write("\r\033[K" + text)
                self._redraw_locked()

    def set_line(self, line):
        """更新进度条内容（仅在内容变化时重绘，避免无谓刷新）。"""
        with self._lock:
            if not self._active or line == self._line:
                return
            self._line = line
            self._redraw_locked()

    # ---------------- 内部实现 ----------------
    def _write(self, text):
        if not text:
            return
        try:
            self._stream.write(text)
            self._stream.flush()
        except (ValueError, OSError):
            pass    # 终端已关闭等异常场景，不因此中断构建

    def _refresh_size(self):
        try:
            size = os.get_terminal_size(self._stream.fileno())
            self._cols = max(int(size.columns), 20)
            self._rows = max(int(size.lines), 1)
        except Exception:
            self._cols, self._rows = self.FALLBACK_SIZE

    def _apply_region_locked(self):
        """把终端最后一行划给进度条，其余部分作为日志滚动区域。"""
        rows = self._rows
        self._write(
            "\033[r"                                # 先复位，避免旧窗口尺寸残留
            f"\033[{rows - 1};1H"                   # 光标移到保留行上方
            "\033[J"                                # 清掉保留行与进度条行的残留内容
            f"\033[1;{rows - 1}r"                   # 设置滚动区域：1 ~ rows-1
            f"\033[{rows};1H\033[2K"
        )
        self._region_rows = rows
        self._bottom_blank = True       # 末行刚被 \033[J 清空

    def _redraw_locked(self):
        if not self._active:
            return
        self._refresh_size()
        line = _clip_ansi(self._line, self._cols - 1)
        if self._mode == self.NEED_PINNED:
            if self._rows != self._region_rows:     # 窗口被缩放，重建滚动区域
                self._apply_region_locked()
            self._write(
                f"\033[{self._rows};1H\033[2K{line}"    # 画在最后一行
                f"\033[{self._rows - 1};1H"             # 光标留在滚动区底部
            )
        else:
            self._write("\r\033[K" + line)


# --------------------------------------------------------------------------- #
# 全局输出入口
# --------------------------------------------------------------------------- #
console = None


def _log(message="", end="\n"):
    """并行阶段日志：交给进度条，保证日志滚动时进度条不掉队。"""
    if console is not None:
        console.log(message, end)
    else:
        print(message, end=end)


def _format_duration(seconds):
    seconds = int(max(seconds, 0))
    hours, remainder = divmod(seconds, 3600)
    minutes, secs = divmod(remainder, 60)
    if hours:
        return f"{hours:d}:{minutes:02d}:{secs:02d}"
    return f"{minutes:02d}:{secs:02d}"


# --------------------------------------------------------------------------- #
# 进度条内容
# --------------------------------------------------------------------------- #
def _count_statuses(all_modules):
    """按状态统计模块数量（cancelled 表示被中断、未跑完）。"""
    counts = {"success": 0, "failed": 0, "skipped": 0,
              "processing": 0, "pending": 0, "cancelled": 0}
    for module in all_modules:
        status = module.get("status", "pending")
        counts[status] = counts.get(status, 0) + 1
    return counts


def _format_progress_line(all_modules, frame, started_at):
    counts = _count_statuses(all_modules)
    total = len(all_modules)
    processing = [m["name"] for m in all_modules if m.get("status") == "processing"]

    done = counts["success"] + counts["failed"] + counts["skipped"] + counts["cancelled"]
    percent = (done / total * 100) if total else 100.0
    filled = int(PROGRESS_BAR_LENGTH * done / total) if total else PROGRESS_BAR_LENGTH

    bar = "#" * filled + "-" * (PROGRESS_BAR_LENGTH - filled)
    spinner = SPINNER_FRAMES[frame % len(SPINNER_FRAMES)]

    line = (
        f"{CYAN}{spinner}{RESET} [{GREEN}{bar}{RESET}] {percent:5.1f}%  "
        f"{GREEN}成功 {counts['success']}{RESET}  {RED}失败 {counts['failed']}{RESET}  "
        f"跳过 {counts['skipped']}  "
    )
    if counts["cancelled"]:
        line += f"{YELLOW}已取消 {counts['cancelled']}{RESET}  "
    line += (
        f"进行中 {counts['processing']}  待处理 {counts['pending']}  "
        f"耗时 {_format_duration(time.time() - started_at)}"
    )
    if processing:
        line += f"  |  {CYAN}{'、'.join(processing)}{RESET}"
    return line


def _fit_bar_length(max_width, fixed_text, preferred=PROGRESS_BAR_LENGTH):
    """按终端宽度决定进度条画多长：先保证成功/失败/跳过/总耗时这些文字不被截断。"""
    if not max_width:
        return preferred
    room = max_width - _display_width(fixed_text) - 1
    return max(0, min(preferred, room))


def _format_summary_line(all_modules, started_at, max_width=None, aborted=False):
    """构建结束后停在终端上的总结行：沿用进度条的形态，只是不再转动。

    进度条不再显示 100% 这种冗余信息（结束必为满格），长度会随终端宽度收缩；
    终端过窄时先舍弃次要的「已取消 / 共 N 个」，保证成功/失败/跳过/总耗时可见。
    """
    counts = _count_statuses(all_modules)
    success, failed, skipped = counts["success"], counts["failed"], counts["skipped"]
    cancelled = counts["cancelled"]
    total = len(all_modules)

    if aborted:
        tag, bar_color = f"{YELLOW}[中断]{RESET}", YELLOW
    elif failed:
        tag, bar_color = f"{RED}[失败]{RESET}", RED
    else:
        tag, bar_color = f"{GREEN}[完成]{RESET}", GREEN

    done = success + failed + skipped + cancelled
    bar_len = _fit_bar_length(
        max_width,
        f"{tag} [] 成功 {success}  失败 {failed}  跳过 {skipped}  已取消 {cancelled}  "
        f"共 {total} 个  总耗时 {_format_duration(time.time() - started_at)}",
    )
    bar = f"[{bar_color}{'#' * bar_len}{RESET}] " if bar_len else ""

    fields = [f"{GREEN}成功 {success}{RESET}", f"{RED}失败 {failed}{RESET}", f"跳过 {skipped}"]
    if cancelled:
        fields.append(f"{YELLOW}已取消 {cancelled}{RESET}")
    tail = f"总耗时 {_format_duration(time.time() - started_at)}"
    for stats in (
        "  ".join(fields + [f"共 {total} 个", tail]),    # 完整版
        "  ".join(fields + [tail]),                      # 窄：先舍弃「共 N 个」
        "  ".join(fields[:3] + [tail]),                  # 更窄：再舍弃「已取消」
    ):
        if not max_width or _display_width(f"{tag} {bar}{stats}") <= max_width:
            break
    return f"{tag} {bar}{stats}"


def show_progress(all_modules, bar, started_at):
    """后台线程：定时刷新底部进度条（转圈 + 耗时让进度条保持“活着”）。"""
    frame = 0
    while not bar.should_stop():
        bar.set_line(_format_progress_line(all_modules, frame, started_at))
        frame += 1
        bar.wait(REFRESH_INTERVAL)


# --------------------------------------------------------------------------- #
# 环境与模块发现
# --------------------------------------------------------------------------- #
def get_npm_path():
    """查找npm命令的完整路径"""
    # 优先使用系统PATH中查找的路径
    npm_path = shutil.which("npm")
    if npm_path:
        return npm_path

    # Windows系统的备选方案
    if platform.system() == "Windows":
        common_paths = [
            r"C:\Program Files\nodejs\npm.cmd",
            r"C:\Program Files (x86)\nodejs\npm.cmd",
        ]
        for path in common_paths:
            if os.path.exists(path):
                return path
    return "npm"


def check_environment(npm_path):
    """检查运行环境是否满足要求"""
    try:
        # 检查npm是否可用
        result = subprocess.run(
            [npm_path, "--version"],
            check=True,
            text=True,
            capture_output=True
        )
        print(f"找到npm版本: {result.stdout.strip()}")
        return True
    except (subprocess.SubprocessError, FileNotFoundError):
        print(f"{RED}错误: 未找到npm。请确保已安装Node.js并配置好PATH环境变量。{RESET}")
        return False


SKIP_DIR_NAMES = frozenset({"target", "node_modules", ".git", "dist", "build"})


def _module_display_name(vue_modules_dir: Path) -> str:
    """从路径提取集成模块名，便于区分各 vue-modules 目录"""
    parts = vue_modules_dir.parts
    for i, part in enumerate(parts):
        if part == "ecat-integrations" and i + 1 < len(parts):
            return parts[i + 1]
    return vue_modules_dir.name


def find_vue_module_dirs(directory: Path):
    """递归查找可构建的 vue-modules 目录（须含 package.json，排除 target 等）"""
    module_dirs = []

    if not directory.exists() or not directory.is_dir():
        return module_dirs

    if directory.name in SKIP_DIR_NAMES:
        return []

    # 仅收录含 package.json 的 vue-modules，避免空目录或 target 副本被计入后跳过
    if directory.name.endswith("vue-modules"):
        package_json = directory / "package.json"
        if package_json.is_file():
            module_dirs.append({
                'path': directory.resolve(),
                'name': _module_display_name(directory),
                'status': 'pending',
                'message': '',
                'start_time': 0,
                'end_time': 0
            })
            return module_dirs

    for item in directory.iterdir():
        if item.is_dir() and item.name not in SKIP_DIR_NAMES:
            module_dirs.extend(find_vue_module_dirs(item))

    return module_dirs


# --------------------------------------------------------------------------- #
# 子进程管理（中断时能立刻收掉整棵 npm 进程树）
# --------------------------------------------------------------------------- #
_abort_event = threading.Event()
_process_lock = threading.Lock()
_active_processes = set()
IS_WINDOWS = os.name == "nt"


def _is_running(proc):
    try:
        return proc.poll() is None
    except Exception:       # 句柄已释放等边界情况
        return False


def _signal_stop(proc):
    """先礼后兵：让 npm 有机会自己收尾。"""
    try:
        if IS_WINDOWS:
            # 子进程在独立进程组里，CTRL_BREAK_EVENT 只发给它那一组
            proc.send_signal(signal.CTRL_BREAK_EVENT)
        else:
            os.killpg(os.getpgid(proc.pid), signal.SIGTERM)
    except Exception:
        pass


def _kill_tree(proc):
    """强杀整棵进程树（npm -> node -> ...）。"""
    if not _is_running(proc):
        return
    try:
        if IS_WINDOWS:
            subprocess.run(
                ["taskkill", "/F", "/T", "/PID", str(proc.pid)],
                capture_output=True, check=False,
            )
        else:
            os.killpg(os.getpgid(proc.pid), signal.SIGKILL)
    except Exception:
        try:
            proc.kill()
        except Exception:
            pass


def _terminate_children(grace=1.5):
    """终止所有在跑的构建子进程，返回被处理的进程数。

    先发一次停止信号并留出 grace 秒，再对还没退出的强杀整棵树；
    期间新启动的进程（启动与中断撞在一起）也会被兜住。
    """
    handled = set()
    deadline = time.time() + grace
    while time.time() < deadline:
        with _process_lock:
            running = [p for p in _active_processes if _is_running(p)]
        if not running:
            break
        for proc in running:
            _signal_stop(proc)
            handled.add(proc)
        time.sleep(0.05)

    with _process_lock:
        running = [p for p in _active_processes if _is_running(p)]
    for proc in running:
        _kill_tree(proc)
        handled.add(proc)
    return len(handled)


def _run_quietly(action, grace=10.0):
    """执行收尾动作，期间用户连按 Ctrl+C 不会打断（避免终端残留花屏）。

    超过 grace 秒仍未结束（例如某个 npm 杀了也不退）就放行中断，
    让用户还能再次 Ctrl+C 强制退出。
    """
    deadline = time.time() + grace
    while True:
        try:
            return action()
        except KeyboardInterrupt:
            if time.time() > deadline:
                raise


def _wait_a_tick():
    """主线程等待一个很短的间隔后回到解释器循环 —— 这是 Ctrl+C 能被立刻感知的关键。

    Windows 上主线程阻塞在「无超时的等待」里时，控制台中断不会被处理，
    要等到等待自己结束才生效（表现就是按一次没反应、得反复按）。
    因此主流程改成每 INTERRUPT_POLL 秒醒来一次，中断响应稳定在 ~0.2s。
    """
    time.sleep(INTERRUPT_POLL)


def _ignore_more_interrupts():
    """进入收尾阶段后忽略后续 Ctrl+C：用户连按也不会把统计行写一半。

    注意：Windows 上无超时的等待期间中断本来就不会被处理，这里显式忽略，
    是为了让「已经决定退出」之后的连按行为完全确定。
    """
    try:
        signal.signal(signal.SIGINT, signal.SIG_IGN)
    except (ValueError, OSError, AttributeError):
        pass


# --------------------------------------------------------------------------- #
# 构建
# --------------------------------------------------------------------------- #
def process_module(module_info, npm_path):
    """处理单个模块，执行npm install和npm run dev"""
    module_dir = module_info['path']
    module_name = module_info['name']

    if _abort_event.is_set():
        module_info['status'] = 'cancelled'     # 排队中就被中断，不再开工
        return

    module_info['start_time'] = time.time()

    try:
        # 标记开始处理
        module_info['status'] = 'processing'
        _log(f"{CYAN}开始处理模块: {module_name}{RESET}")

        _log(f"{YELLOW}正在执行: npm install  ({module_name}){RESET}")
        run_command([npm_path, "install"], module_dir)
        install_time = time.time() - module_info['start_time']
        _log(f"{GREEN}模块 {module_name} 依赖安装完成 (耗时: {install_time:.2f}s){RESET}")

        if _abort_event.is_set():
            module_info['status'] = 'cancelled'
            return

        _log(f"{YELLOW}正在执行: npm run dev  ({module_name}){RESET}")
        run_command([npm_path, "run", "dev"], module_dir)
        build_time = time.time() - module_info['start_time']
        _log(f"{GREEN}模块 {module_name} 构建成功 (总耗时: {build_time:.2f}s){RESET}")

        module_info['status'] = 'success'
        module_info['end_time'] = time.time()

    except subprocess.CalledProcessError as e:
        module_info['end_time'] = time.time()
        if _abort_event.is_set():
            module_info['status'] = 'cancelled'     # 被中断杀掉，不算构建失败
            return
        error_time = time.time() - module_info['start_time']
        _log(f"{RED}模块 {module_name} 执行命令失败 (耗时: {error_time:.2f}s){RESET}")
        _log(f"{RED}错误输出: {e.stderr}{RESET}")
        module_info['status'] = 'failed'
        module_info['message'] = f"命令失败: {e.stderr}"
    except Exception as e:
        module_info['end_time'] = time.time()
        if _abort_event.is_set():
            module_info['status'] = 'cancelled'
            return
        error_time = time.time() - module_info['start_time']
        _log(f"{RED}处理模块 {module_name} 时发生未知错误 (耗时: {error_time:.2f}s){RESET}")
        _log(f"{RED}{e}{RESET}")
        module_info['status'] = 'failed'
        module_info['message'] = str(e)


def run_command(command, cwd):
    """静默执行命令，仅在失败时通过异常附带输出。

    子进程放在独立进程组、stdin 接空设备：
    * 我们按 Ctrl+C 时不会连带打断 npm，也不会让它卡在 cmd.exe 的
      "Terminate batch job (Y/N)?" 询问上（那会一直等输入而假死）；
    * 中断由 _terminate_children() 统一收尾，行为可控。
    """
    use_shell = IS_WINDOWS

    env = os.environ.copy()
    if use_shell and "nodejs" not in env["PATH"].lower():
        node_path = r"C:\Program Files\nodejs"
        if os.path.exists(node_path):
            env["PATH"] = f"{node_path};{env['PATH']}"

    kwargs = {}
    if use_shell:
        kwargs["creationflags"] = subprocess.CREATE_NEW_PROCESS_GROUP
    else:
        kwargs["start_new_session"] = True      # 等价：独立进程组

    proc = subprocess.Popen(
        command,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        stdin=subprocess.DEVNULL,
        text=True,
        encoding="utf-8",
        errors="replace",
        shell=use_shell,
        env=env,
        **kwargs,
    )
    with _process_lock:
        _active_processes.add(proc)
    if _abort_event.is_set():
        _kill_tree(proc)        # 启动与中断撞车，立刻收掉，避免漏网
    try:
        stdout, stderr = proc.communicate()
    finally:
        with _process_lock:
            _active_processes.discard(proc)

    if proc.returncode != 0:
        output = (stdout or "") + (stderr or "")
        err = subprocess.CalledProcessError(proc.returncode, command, output)
        err.stderr = output
        raise err


# --------------------------------------------------------------------------- #
# 主流程
# --------------------------------------------------------------------------- #
def _quiesce_bar(console, progress_thread):
    """停止进度条刷新线程，但保持进度条显示，等它被最终统计替换。"""
    console.request_stop()
    if progress_thread.is_alive():
        progress_thread.join(timeout=3)


def _show_result(console, all_modules, started_at, aborted=False):
    """把最终统计画在进度条原来的位置上（中断时先补一句日志）。"""
    width = None if console.mode == ProgressBar.NEED_PLAIN else console.width

    failed = [m for m in all_modules if m.get('status') == 'failed']
    if failed:
        console.log(f"{RED}失败模块详细信息:{RESET}")
        for module in failed:
            console.log(f"  - {module['name']}: {module.get('message', '未知错误')}")
            console.log(f"    路径: {module['path']}")

    console.finish(_format_summary_line(all_modules, started_at, width, aborted=aborted))


def _run_build():
    global console

    # 获取脚本所在目录的父目录，即A目录
    script_dir = Path(__file__).resolve().parent
    proj_root = script_dir.parent.parent.parent
    search_dir = proj_root / "ecat-integrations"

    # 确定npm路径
    npm_path = get_npm_path()
    if not check_environment(npm_path):
        return 1

    print(f"开始搜索Vue项目...")
    print(f"搜索目录: {search_dir}")

    # 递归查找可构建的 vue-modules 目录（须含 package.json，排除 target 等）
    all_modules = find_vue_module_dirs(search_dir)

    if not all_modules:
        print(f"{RED}未找到可构建的 Vue 模块目录（需为 *vue-modules 且含 package.json）！{RESET}")
        return 1

    print(f"搜索完成！共找到 {len(all_modules)} 个Vue模块目录。")
    print(f"开始并行处理项目，最大并行数: {MAX_WORKERS}")

    started_at = time.time()

    # 启动底部固定进度条（不支持的终端会自动降级）
    console = ProgressBar()
    mode = console.detect_mode(SHOW_PROGRESS)
    console.start(mode)

    progress_thread = threading.Thread(
        target=show_progress, args=(all_modules, console, started_at), name="progress", daemon=True
    )
    if mode != ProgressBar.NEED_PLAIN:
        progress_thread.start()

    executor = concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKERS)
    future_to_module = {
        executor.submit(process_module, module, npm_path): module
        for module in all_modules
    }

    keep_bar = True
    aborted = False
    try:
        try:
            # 收集结果。这里刻意用「带短超时的轮询」而不是 as_completed()：
            # Windows 上主线程阻塞在无超时的等待里时，控制台 Ctrl+C 不会被处理，
            # 中断要等到某个 future 恰好结束才生效 —— 表现就是「按一次没反应，得按好几次」。
            # 每 0.2s 回到解释器循环一次，Ctrl+C 才能立刻被感知并进入中断收尾。
            pending = set(future_to_module)
            while pending:
                _wait_a_tick()      # 回到解释器循环，Ctrl+C 立刻生效（见该函数说明）
                for future in [f for f in pending if f.done()]:
                    pending.discard(future)
                    module = future_to_module[future]
                    try:
                        future.result()
                    except Exception as e:
                        _log(f"{RED}警告: 处理模块 {module['name']} 时发生异常: {e}{RESET}")
                        module['status'] = 'failed'
                        module['message'] = str(e)
        except KeyboardInterrupt:
            aborted = True
            # 先把 npm 进程树收掉：否则线程池收尾会一直等它们退出
            _abort_event.set()
            kicked = _terminate_children()
            for module in all_modules:
                if module.get('status') in ('pending', 'processing'):
                    module['status'] = 'cancelled'
            console.log(
                f"{YELLOW}已收到中断信号：终止 {kicked} 个正在执行的 npm 进程，"
                f"其余未完成模块标记为已取消，正在收尾...{RESET}"
            )
            # 已经决定退出，后续连按 Ctrl+C 不再打断收尾（避免统计行写一半）
            _ignore_more_interrupts()
            executor.shutdown(wait=True)
        else:
            executor.shutdown(wait=True)
        finally:
            _quiesce_bar(console, progress_thread)

        # 直接用进度条那一行展示最终统计，结束时不擦掉进度条
        _show_result(console, all_modules, started_at, aborted=aborted)
        keep_bar = False
        if aborted:
            return 130
        return 1 if any(m.get('status') == 'failed' for m in all_modules) else 0
    finally:
        # 意外异常时兜底复位滚动区域 / 恢复光标
        if keep_bar:
            console.stop()


def main():
    try:
        return _run_build()
    except KeyboardInterrupt:
        # 兜底：搜索阶段或收尾阶段被 Ctrl+C 打断，保证终端不乱、退出码一致
        _abort_event.set()
        _run_quietly(lambda: _terminate_children(), grace=3.0)
        if console is not None:
            _run_quietly(console.stop)
        _ignore_more_interrupts()
        print(f"{YELLOW}构建已被用户中断。{RESET}")
        return 130


if __name__ == "__main__":
    sys.exit(main())
