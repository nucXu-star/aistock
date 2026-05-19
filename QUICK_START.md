# 🚀 快速开始指南 - AI 股票分析系统

## 5 分钟快速部署

### 前置条件
- ✅ 已安装 Python 3.8+ 
- ✅ 已安装 Git (可选)
- ✅ 有效的网络连接

---

## Windows 用户 (最简单)

### 方式 1：自动安装 (推荐)

1. **双击运行** `install.bat` 文件
2. 脚本会自动：
   - 创建 Python 虚拟环境
   - 安装所有依赖包
   - 复制 `.env` 配置文件

3. **编辑配置文件** `(.env)`：
   ```
   ZHIPU_API_KEY=你的智谱 API 密钥
   SUPABASE_URL=你的 Supabase URL
   SUPABASE_KEY=你的 Supabase 匿名密钥
   ```

4. **启动服务**：
   - 脚本会自动执行 `python app.py`
   - 打开浏览器访问 `http://localhost:5000`

### 方式 2：手动安装

```powershell
# 打开 PowerShell，进入项目目录

# 1. 创建虚拟环境
python -m venv venv

# 2. 激活虚拟环境
.\venv\Scripts\Activate.ps1

# 3. 安装依赖
pip install -r requirements.txt

# 4. 配置 .env 文件
# 编辑 .env 文件，填入你的 API 密钥

# 5. 启动应用
python app.py
```

---

## Mac / Linux 用户

### 方式 1：自动安装 (推荐)

```bash
# 1. 给脚本添加执行权限
chmod +x install.sh

# 2. 运行安装脚本
./install.sh

# 脚本会自动完成所有配置，然后启动服务
```

### 方式 2：手动安装

```bash
# 1. 创建虚拟环境
python3 -m venv venv

# 2. 激活虚拟环境
source venv/bin/activate

# 3. 安装依赖
pip install -r requirements.txt

# 4. 配置 .env 文件
cp .env.example .env
nano .env  # 编辑配置文件

# 5. 启动应用
python3 app.py
```

---

## 🔑 获取 API 密钥

### 1. 智谱 AI API 密钥

1. 访问 https://open.bigmodel.cn/
2. 注册或登录账号
3. 进入 "API 密钥" 页面
4. 创建新的 API 密钥
5. 复制密钥内容到 `.env` 中的 `ZHIPU_API_KEY`

### 2. Supabase 配置

1. 访问 https://app.supabase.com/
2. 创建新项目或选择现有项目
3. 在 "Settings" → "API" 中找到：
   - **Project URL** → 复制到 `.env` 中的 `SUPABASE_URL`
   - **anon key** → 复制到 `.env` 中的 `SUPABASE_KEY`

4. 在 SQL 编辑器中运行 `supabase_init.sql` 初始化数据库

---

## 🌐 使用系统

### 第一次运行

```
http://localhost:5000
```

你会看到以下界面：

```
┌──────────────────────────────┐
│  📈 AI 股票分析面板          │
├──────────────────────────────┤
│ ┌─────────────────────────┐  │
│ │ 输入美股代码 (AAPL)  [分析] │
│ └─────────────────────────┘  │
│                              │
│ (分析结果将显示在这里)       │
└──────────────────────────────┘
```

### 使用步骤

1. **输入股票代码**
   - 支持：AAPL、TSLA、NVDA 等美股代码
   - 也支持：0700（港股）、600000（A股）等
   
2. **点击 "开始 AI 分析" 按钮**
   
3. **等待分析完成** (通常 5-10 秒)

4. **查看结果**
   ```
   📊 AAPL 分析报告
   市场情绪: Bullish (绿色徽章)
   风险评估: Medium (橙色)
   AI 深度总结: 苹果股价近期上升趋势明显...
   ```

---

## 🛠️ 常见问题

### Q1: 启动时显示 "Module not found" 错误
**原因**：依赖包未完全安装
**解决**：
```bash
pip install -r requirements.txt --upgrade
```

### Q2: 无法连接到 API
**原因**：网络问题或代理设置
**解决**：
- 检查网络连接
- 如需代理，编辑 `app.py` 第 14 行设置代理地址

### Q3: AI 返回结果为空
**原因**：智谱 API 超过配额或网络中断
**解决**：
- 检查 `ZHIPU_API_KEY` 是否正确
- 检查 API 配额是否充足
- 系统会自动降级使用模拟数据

### Q4: 数据未保存到 Supabase
**原因**：Supabase 配置不正确或网络问题
**解决**：
- 确认 `SUPABASE_URL` 和 `SUPABASE_KEY` 正确
- 确认数据库表已创建（运行 `supabase_init.sql`）
- 检查 Supabase 的 RLS 策略是否启用

### Q5: 端口 5000 已被占用
**原因**：其他应用占用了该端口
**解决**：
编辑 `app.py` 最后一行，改为其他端口：
```python
app.run(debug=True, port=5001)  # 改为 5001 或其他端口
```

---

## 📊 数据流示意

```
用户输入 (AAPL)
    ↓
[后端] 通过 efinance 获取行情数据
    ↓
[后端] 调用智谱 GLM-4 分析
    ↓
[后端] 将结果存入 Supabase
    ↓
[前端] 展示分析结果
    - 趋势总结
    - 市场情绪 (Bullish/Neutral/Bearish)
    - 风险评估 (High/Medium/Low)
```

---

## 📁  项目文件说明

```
ai-stock-analyzer/
├── app.py                  # 🔴 核心后端逻辑（重要）
├── templates/
│   └── index.html         # 🔵 前端页面（重要）
├── requirements.txt        # 依赖列表
├── .env.example           # 环境配置模板
├── .gitignore             # Git 忽略文件
├── README.md              # 详细文档
├── FEATURE_CHECKLIST.md   # 功能完成清单
├── install.bat            # Windows 安装脚本
├── install.sh             # Mac/Linux 安装脚本
└── supabase_init.sql      # 数据库初始化脚本
```

---

## ✅ 验证检查表

- [ ] Python 已安装
- [ ] 虚拟环境已创建
- [ ] 依赖包已安装
- [ ] `.env` 已配置（ZHIPU_API_KEY、SUPABASE_*）
- [ ] Supabase 数据库已初始化
- [ ] 服务启动成功 (http://localhost:5000)
- [ ] 能够输入股票代码
- [ ] 分析结果正常显示
- [ ] 数据成功保存到 Supabase

---

## 🚀 下一步

### 基础版本已完成，可选扩展：

- [ ] 添加数据库查询历史功能
- [ ] 集成前端图表库 (Chart.js)
- [ ] 添加技术指标计算 (MACD、RSI 等)
- [ ] 实现邮件预警通知
- [ ] 部署到云平台 (Heroku、Replit 等)

---

## 📞 需要帮助？

查看以下资源：
- 📘 **详细文档**：打开 `README.md`
- 📋 **功能清单**：打开 `FEATURE_CHECKLIST.md`
- 💬 **日志信息**：查看 Flask 控制台输出

---

## 🎉 恭喜！

你已成功部署 AI 股票分析系统！

**现在可以开始分析你感兴趣的股票了！** 📈

