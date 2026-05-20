#!python3
# -*- coding: utf-8 -*-
import os
import subprocess
import shutil
import concurrent.futures
import platform
from pathlib import Path
import time
import sys
import threading
import colorama

# 初始化colorama用于彩色输出
colorama.init()

# 全局配置
MAX_WORKERS = 4  # 最大并行数
SHOW_PROGRESS = True  # 是否显示进度条
PROGRESS_BAR_LENGTH = 30  # 进度条长度

# 底部固定进度条（并行构建阶段使用）
console = None


class BottomProgressBar:
    """进度条固定在终端最底行，普通日志在其上方滚动"""

    def __init__(self):
        self._lock = threading.Lock()
        self._line = ""
        self._active = False
        self._stop_event = threading.Event()

    def log(self, message="", end="\n"):
        with self._lock:
            if self._active and self._line:
                sys.stdout.write("\r\033[K")
            sys.stdout.write(message)
            if end:
                sys.stdout.write(end)
            if self._active and self._line:
                sys.stdout.write(self._line)
            sys.stdout.flush()

    def set_line(self, line):
        with self._lock:
            self._line = line
            if self._active:
                sys.stdout.write("\r\033[K" + line)
                sys.stdout.flush()

    def start(self):
        with self._lock:
            self._active = True
            sys.stdout.write("\n")
            if self._line:
                sys.stdout.write(self._line)
            sys.stdout.flush()

    def stop(self):
        with self._lock:
            self._active = False
            self._line = ""
            sys.stdout.write("\r\033[K")
            sys.stdout.flush()

    def request_stop(self):
        self._stop_event.set()

    def wait(self, timeout):
        return self._stop_event.wait(timeout)

    def should_stop(self):
        return self._stop_event.is_set()

def main():
    global console
    console = BottomProgressBar()

    # 获取脚本所在目录的父目录，即A目录
    script_dir = Path(__file__).resolve().parent
    proj_root = script_dir.parent.parent.parent
    search_dir = proj_root / "ecat-integrations"

    # 确定npm路径
    npm_path = get_npm_path()
    if not check_environment(npm_path):
        return

    print(f"开始搜索Vue项目...")
    print(f"搜索目录: {search_dir}")

    # 递归查找可构建的 vue-modules 目录（须含 package.json，排除 target 等）
    all_modules = find_vue_module_dirs(search_dir)

    if not all_modules:
        print("未找到可构建的 Vue 模块目录（需为 *vue-modules 且含 package.json）！")
        return

    print(f"搜索完成！共找到 {len(all_modules)} 个Vue模块目录。")

    # 自动模式处理所有项目
    print(f"开始并行处理项目，最大并行数: {MAX_WORKERS}")
    a = time.time()

    total = len(all_modules)

    progress_thread = None
    if SHOW_PROGRESS:
        console.start()
        progress_thread = threading.Thread(
            target=show_progress, args=(all_modules, console), name="progress"
        )
        progress_thread.start()

    # 使用线程池并行处理项目
    with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        future_to_module = {
            executor.submit(process_module, module, npm_path): module
            for module in all_modules
        }

        # 收集结果
        for future in concurrent.futures.as_completed(future_to_module):
            module = future_to_module[future]
            try:
                future.result()
            except Exception as e:
                module_name = module['name']
                _log(f"{colorama.Fore.RED}警告: 处理模块 {module_name} 时发生异常: {e}{colorama.Style.RESET_ALL}")
                module['status'] = 'failed'
                module['message'] = str(e)

    if SHOW_PROGRESS and progress_thread:
        console.request_stop()
        progress_thread.join(timeout=3)
        console.stop()

    # 统计结果
    success = sum(1 for m in all_modules if m.get('status') == 'success')
    skipped = sum(1 for m in all_modules if m.get('status') == 'skipped')
    failed = total - success - skipped

    print(f"\n{colorama.Fore.GREEN}所有模块处理完成！{colorama.Style.RESET_ALL}")
    print(f"成功: {colorama.Fore.GREEN}{success}{colorama.Style.RESET_ALL} / {total}")
    print(f"失败: {colorama.Fore.RED}{failed}{colorama.Style.RESET_ALL} / {total}")
    print(f"跳过: {skipped} / {total}")
    b = time.time()
    print(f"总耗时: {b-a:.2f}秒")

    # 输出失败模块详细信息
    if failed > 0:
        print(f"\n{colorama.Fore.RED}失败模块详细信息:{colorama.Style.RESET_ALL}")
        for module in all_modules:
            if module.get('status') == 'failed':
                print(f"  - {module['name']}: {module.get('message', '未知错误')}")
                print(f"    路径: {module['path']}")

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
        print(f"{colorama.Fore.RED}错误: 未找到npm。请确保已安装Node.js并配置好PATH环境变量。{colorama.Style.RESET_ALL}")
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

def _log(message):
    """并行阶段日志：有进度条时写入其上方，否则直接 print"""
    if SHOW_PROGRESS and console is not None:
        console.log(message)
    else:
        print(message)


def process_module(module_info, npm_path):
    """处理单个模块，执行npm install和npm run dev"""
    module_dir = module_info['path']
    module_name = module_info['name']
    module_info['start_time'] = time.time()

    try:
        # 标记开始处理
        module_info['status'] = 'processing'
        _log(f"{colorama.Fore.CYAN}开始处理模块: {module_name}{colorama.Style.RESET_ALL}")

        _log(f"{colorama.Fore.YELLOW}正在执行: npm install  ({module_name}){colorama.Style.RESET_ALL}")
        run_command([npm_path, "install"], module_dir)
        install_time = time.time() - module_info['start_time']
        _log(f"{colorama.Fore.GREEN}模块 {module_name} 依赖安装完成 (耗时: {install_time:.2f}s){colorama.Style.RESET_ALL}")

        _log(f"{colorama.Fore.YELLOW}正在执行: npm run dev  ({module_name}){colorama.Style.RESET_ALL}")
        run_command([npm_path, "run", "dev"], module_dir)
        build_time = time.time() - module_info['start_time']
        _log(f"{colorama.Fore.GREEN}模块 {module_name} 构建成功 (总耗时: {build_time:.2f}s){colorama.Style.RESET_ALL}")

        module_info['status'] = 'success'
        module_info['end_time'] = time.time()

    except subprocess.CalledProcessError as e:
        error_time = time.time() - module_info['start_time']
        _log(f"{colorama.Fore.RED}模块 {module_name} 执行命令失败 (耗时: {error_time:.2f}s){colorama.Style.RESET_ALL}")
        _log(f"{colorama.Fore.RED}错误输出: {e.stderr}{colorama.Style.RESET_ALL}")
        module_info['status'] = 'failed'
        module_info['message'] = f"命令失败: {e.stderr}"
        module_info['end_time'] = time.time()
    except Exception as e:
        error_time = time.time() - module_info['start_time']
        _log(f"{colorama.Fore.RED}处理模块 {module_name} 时发生未知错误 (耗时: {error_time:.2f}s){colorama.Style.RESET_ALL}")
        _log(f"{colorama.Fore.RED}{e}{colorama.Style.RESET_ALL}")
        module_info['status'] = 'failed'
        module_info['message'] = str(e)
        module_info['end_time'] = time.time()

def run_command(command, cwd):
    """静默执行命令，仅在失败时通过异常附带输出"""
    use_shell = platform.system() == "Windows"

    env = os.environ.copy()
    if use_shell and "nodejs" not in env["PATH"].lower():
        node_path = r"C:\Program Files\nodejs"
        if os.path.exists(node_path):
            env["PATH"] = f"{node_path};{env['PATH']}"

    result = subprocess.run(
        command,
        cwd=cwd,
        capture_output=True,
        text=True,
        encoding="utf-8",
        shell=use_shell,
        env=env,
    )
    if result.returncode != 0:
        output = (result.stdout or "") + (result.stderr or "")
        err = subprocess.CalledProcessError(result.returncode, command, output)
        err.stderr = output
        raise err

def _format_progress_line(all_modules):
    total = len(all_modules)
    pending_count = sum(1 for m in all_modules if m.get('status') == 'pending')
    processing_count = sum(1 for m in all_modules if m.get('status') == 'processing')
    success_count = sum(1 for m in all_modules if m.get('status') == 'success')
    failed_count = sum(1 for m in all_modules if m.get('status') == 'failed')
    skipped_count = sum(1 for m in all_modules if m.get('status') == 'skipped')

    completed = success_count + failed_count + skipped_count
    percent = (completed / total) * 100 if total > 0 else 0

    filled_length = int(PROGRESS_BAR_LENGTH * percent / 100)
    bar = f"{colorama.Fore.GREEN}█{colorama.Style.RESET_ALL}" * filled_length + '-' * (PROGRESS_BAR_LENGTH - filled_length)

    line = f"进度: [{bar}] {percent:.1f}% | "
    line += f"{colorama.Fore.GREEN}成功: {success_count}{colorama.Style.RESET_ALL} | "
    line += f"{colorama.Fore.RED}失败: {failed_count}{colorama.Style.RESET_ALL} | "
    line += f"跳过: {skipped_count} | 处理中: {processing_count} | 待处理: {pending_count}"
    return line, percent


def show_progress(all_modules, bar):
    """在终端底行刷新进度条"""
    last_status = ""

    while not bar.should_stop():
        status_line, percent = _format_progress_line(all_modules)
        if status_line != last_status or percent >= 100:
            bar.set_line(status_line)
            last_status = status_line
        if percent >= 100:
            break
        bar.wait(1.0)

if __name__ == "__main__":
    main()
