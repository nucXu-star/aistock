@echo off
REM AI 股票分析系统 - 快速安装脚本（Windows）

echo.
echo ========================================
echo   AI 股票分析系统 - 快速安装指南
echo ========================================
echo.

REM 检查 Python 是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Python 环境，请先安装 Python 3.8+
    echo 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [✓] 已检测到 Python 环境
echo.

REM 检查虚拟环境
if exist venv (
    echo [✓] 虚拟环境已存在，准备激活...
    call venv\Scripts\activate.bat
) else (
    echo [进行中] 创建 Python 虚拟环境...
    python -m venv venv
    call venv\Scripts\activate.bat
    echo [✓] 虚拟环境创建成功
)

echo.
echo [进行中] 安装依赖包（这可能需要 2-5 分钟）...
pip install --upgrade pip -q
pip install -r requirements.txt -q

if errorlevel 1 (
    echo [错误] 依赖安装失败，请检查网络连接
    pause
    exit /b 1
)

echo [✓] 依赖安装完成
echo.

REM 检查 .env 文件
if not exist .env (
    echo [进行中] 复制 .env 配置文件...
    copy .env.example .env >nul
    echo [⚠️ ] 已创建 .env 文件，请编辑并填入你的 API 密钥
    echo 需要配置的项目:
    echo   - ZHIPU_API_KEY (智谱 AI API 密钥)
    echo   - SUPABASE_URL (Supabase 项目 URL)
    echo   - SUPABASE_KEY (Supabase 匿名密钥)
    echo.
    pause
) else (
    echo [✓] .env 配置文件已存在
)

echo.
echo ========================================
echo   安装完成！准备启动服务
echo ========================================
echo.
echo 服务将运行在: http://localhost:5000
echo 按 Ctrl+C 停止服务
echo.

python app.py

