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
from queue import Queue
import colorama

# 初始化colorama用于彩色输出
colorama.init()

# 全局配置
MAX_WORKERS = 4  # 最大并行数
SHOW_PROGRESS = True  # 是否显示进度条
PROGRESS_BAR_LENGTH = 30  # 进度条长度

def main():
    # 获取脚本所在目录的父目录，即A目录
    script_dir = Path(__file__).resolve().parent
    a_dir = script_dir.parent
    search_dir = a_dir / "ecat-integrations"

    # 确定npm路径
    npm_path = get_npm_path()
    if not check_environment(npm_path):
        return

    print(f"开始搜索Vue项目...")
    print(f"搜索目录: {search_dir}")

    # 递归查找所有以vue-modules结尾的目录，排除target目录
    vue_module_dirs = find_vue_module_dirs(search_dir)

    if not vue_module_dirs:
        print("未找到以vue-modules结尾的目录！")
        return

    print(f"搜索完成！共找到 {len(vue_module_dirs)} 个Vue模块目录。")

    # 自动模式处理所有项目
    print(f"开始并行处理项目，最大并行数: {MAX_WORKERS}")
    a = time.time()

    # 存储所有模块信息，用于状态统计
    all_modules = find_vue_module_dirs(search_dir)
    total = len(all_modules)

    # 启动进度显示线程
    if SHOW_PROGRESS:
        progress_thread = threading.Thread(target=show_progress, args=(all_modules,))
        progress_thread.daemon = True
        progress_thread.start()

    # 使用线程池并行处理项目
    with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        future_to_module = {
            executor.submit(process_module, module, npm_path, all_modules): module
            for module in all_modules
        }

        # 收集结果
        for future in concurrent.futures.as_completed(future_to_module):
            module = future_to_module[future]
            try:
                future.result()
            except Exception as e:
                module_name = module['name']
                print(f"\n{colorama.Fore.RED}警告: 处理模块 {module_name} 时发生异常: {e}{colorama.Style.RESET_ALL}")
                module['status'] = 'failed'
                module['message'] = str(e)

    # 等待进度线程完成
    if SHOW_PROGRESS:
        # 发送结束信号
        time.sleep(1)  # 等待最后一次更新

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

def find_vue_module_dirs(directory: Path):
    """递归查找所有以vue-modules结尾的目录，排除target目录"""
    module_dirs = []

    if not directory.exists() or not directory.is_dir():
        return module_dirs

    # 排除target目录
    if directory.name == "target":
        return []

    # 检查当前目录是否以vue-modules结尾
    if directory.name.endswith("vue-modules"):
        module_dirs.append({
            'path': directory,
            'name': directory.name,
            'status': 'pending',
            'message': '',
            'start_time': 0,
            'end_time': 0
        })

    # 递归检查所有子目录
    for item in directory.iterdir():
        if item.is_dir():
            module_dirs.extend(find_vue_module_dirs(item))

    return module_dirs

def process_module(module_info, npm_path, all_modules):
    """处理单个模块，执行npm install和npm run dev"""
    module_dir = module_info['path']
    module_name = module_info['name']
    module_info['start_time'] = time.time()

    try:
        # 标记开始处理
        module_info['status'] = 'processing'
        print(f"\n{colorama.Fore.CYAN}开始处理模块: {module_name} (路径: {module_dir}){colorama.Style.RESET_ALL}")

        # 检查package.json是否存在
        package_json = module_dir / "package.json"
        if not package_json.exists():
            module_info['status'] = 'skipped'
            module_info['message'] = "缺少package.json文件"
            return

        # 执行npm install命令
        print(f"{colorama.Fore.YELLOW}正在执行: npm install  in {module_name}{colorama.Style.RESET_ALL}")
        run_command([npm_path, "install"], module_dir)
        install_time = time.time() - module_info['start_time']
        print(f"{colorama.Fore.GREEN}模块 {module_name} 依赖安装完成！(耗时: {install_time:.2f}秒){colorama.Style.RESET_ALL}")

        # 执行npm run dev命令
        print(f"{colorama.Fore.YELLOW}正在执行: npm run dev  in {module_name}{colorama.Style.RESET_ALL}")
        run_command([npm_path, "run", "dev"], module_dir)
        build_time = time.time() - module_info['start_time']
        print(f"{colorama.Fore.GREEN}模块 {module_name} 构建成功！(总耗时: {build_time:.2f}秒){colorama.Style.RESET_ALL}")

        module_info['status'] = 'success'
        module_info['end_time'] = time.time()

    except subprocess.CalledProcessError as e:
        error_time = time.time() - module_info['start_time']
        print(f"{colorama.Fore.RED}模块 {module_name} 执行命令失败！(耗时: {error_time:.2f}秒){colorama.Style.RESET_ALL}")
        print(f"{colorama.Fore.RED}错误输出: {e.stderr}{colorama.Style.RESET_ALL}")
        module_info['status'] = 'failed'
        module_info['message'] = f"命令失败: {e.stderr}"
        module_info['end_time'] = time.time()
    except Exception as e:
        error_time = time.time() - module_info['start_time']
        print(f"{colorama.Fore.RED}处理模块 {module_name} 时发生未知错误！(耗时: {error_time:.2f}秒){colorama.Style.RESET_ALL}")
        print(f"{colorama.Fore.RED}{e}{colorama.Style.RESET_ALL}")
        module_info['status'] = 'failed'
        module_info['message'] = str(e)
        module_info['end_time'] = time.time()

def run_command(command, cwd):
    """执行命令并实时输出结果，处理环境变量差异"""
    print(f"执行命令: {' '.join(command)}")

    # 根据操作系统设置shell参数
    use_shell = platform.system() == "Windows"

    # 复制当前环境变量
    env = os.environ.copy()

    # 如果是Windows且找不到npm，尝试添加常见路径
    if use_shell and "nodejs" not in env["PATH"].lower():
        node_path = r"C:\Program Files\nodejs"
        if os.path.exists(node_path):
            env["PATH"] = f"{node_path};{env['PATH']}"

    process = subprocess.Popen(
        command,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        encoding='utf-8',
        text=True,
        bufsize=1,
        shell=use_shell,
        env=env  # 显式传递环境变量
    )
    # 实时输出命令执行结果，显示所属模块
    for line in iter(process.stdout.read, ''):
        # 为日志添加模块标识
        module_log = f"[模块: {os.path.basename(cwd)}] {line}"
        sys.stdout.write(module_log)
        sys.stdout.flush()

    process.wait()
    if process.returncode != 0:
        raise subprocess.CalledProcessError(process.returncode, command)

def show_progress(all_modules):
    """显示进度条，直接从模块列表获取状态，确保统计准确"""
    total = len(all_modules)
    last_update = time.time()
    last_status = ""

    while True:
        # 每1秒更新一次进度条
        if time.time() - last_update < 1:
            time.sleep(0.1)
            continue
        last_update = time.time()

        # 直接从模块列表计算状态
        pending_count = sum(1 for m in all_modules if m.get('status') == 'pending')
        processing_count = sum(1 for m in all_modules if m.get('status') == 'processing')
        success_count = sum(1 for m in all_modules if m.get('status') == 'success')
        failed_count = sum(1 for m in all_modules if m.get('status') == 'failed')
        skipped_count = sum(1 for m in all_modules if m.get('status') == 'skipped')

        # 计算进度百分比
        completed = success_count + failed_count + skipped_count
        percent = (completed / total) * 100 if total > 0 else 0

        # 构建进度条
        filled_length = int(PROGRESS_BAR_LENGTH * percent / 100)
        bar = f"{colorama.Fore.GREEN}█{colorama.Style.RESET_ALL}" * filled_length + '-' * (PROGRESS_BAR_LENGTH - filled_length)

        # 显示状态行（覆盖当前行）
        status_line = f"\r进度: [{bar}] {percent:.1f}% | "
        status_line += f"{colorama.Fore.GREEN}成功: {success_count}{colorama.Style.RESET_ALL} | "
        status_line += f"{colorama.Fore.RED}失败: {failed_count}{colorama.Style.RESET_ALL} | "
        status_line += f"跳过: {skipped_count} | 处理中: {processing_count} | 待处理: {pending_count}"

        # 仅在状态变化时更新
        if status_line != last_status or percent >= 100:
            sys.stdout.write(status_line)
            sys.stdout.flush()
            last_status = status_line

        # 所有模块处理完成后退出
        if percent >= 100:
            break

    # 确保进度条完整
    sys.stdout.write("\n")
    sys.stdout.flush()

if __name__ == "__main__":
    main()
