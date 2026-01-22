@echo off
chcp 65001 >nul
echo.
echo [信息] 开始前端构建和后端打包流程
echo.

%~d0
cd %~dp0

echo [第一步] 开始前端构建...
echo [信息] 执行前端构建脚本：build_vue_projects.py
echo.

REM 执行前端构建
python build_vue_projects.py
if %errorlevel% neq 0 (
    echo.
    echo [错误] 前端构建失败，停止后续的后端构建
    echo [提示] 请检查前端构建错误信息并修复后重试
    pause
    exit /b 1
)

echo.
echo [成功] 前端构建完成
echo.
echo [第二步] 开始后端打包...

cd ..

echo [信息] 尝试使用 Maven Daemon (mvnd) 进行打包...
where mvnd >nul 2>&1
if %errorlevel% equ 0 (
    echo [信息] 检测到 mvnd 命令，使用 Maven Daemon 进行打包...
    call mvnd clean package -Dmaven.test.skip=true
    if %errorlevel% equ 0 (
        echo [成功] 使用 mvnd 打包完成
    ) else (
        echo [警告] mvnd 打包失败，尝试使用 mvn 命令...
        call mvn clean package -Dmaven.test.skip=true
        if %errorlevel% equ 0 (
            echo [成功] 使用 mvn 打包完成
        ) else (
            echo [错误] 后端打包失败
            pause
            exit /b 1
        )
    )
) else (
    echo [信息] 未检测到 mvnd 命令，使用标准 mvn 命令进行打包...
    call mvn clean package -Dmaven.test.skip=true
    if %errorlevel% equ 0 (
        echo [成功] 使用 mvn 打包完成
    ) else (
        echo [错误] 后端打包失败
        pause
        exit /b 1
    )
)

echo.
echo [完成] 前端构建和后端打包全部成功完成！
echo [前端] Vue模块构建完成
echo [后端] Maven打包完成
echo.

pause