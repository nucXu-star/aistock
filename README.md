# 🚀 AI 股票分析系统

**一个基于 Flask + 智谱 GLM-4 + 东方财富数据 + Supabase 的全栈 AI 股票分析平台**

## ✨ 核心功能

### 1️⃣ 智能数据获取
- **数据源**：使用 efinance（东方财富免费 API）获取实时股票行情
- **自动降级**：当数据源失效时，自动生成高保真模拟数据确保服务不中断
- **支持股票**：美股、港股、A股等多市场代码

### 2️⃣ AI 深度分析
- **AI 模型**：智谱 GLM-4（国内领先大语言模型）
- **分析维度**：
  - 📊 **Trend Summary**：一句话趋势总结（≤50字）
  - 😊 **Market Sentiment**：Bullish（看涨）/ Neutral（中立）/ Bearish（看跌）
  - ⚠️ **Risk Assessment**：High（高风险）/ Medium（中风险）/ Low（低风险）
- **格式保证**：强制 JSON 格式输出，自动清洗 Markdown 标记

### 3️⃣ 数据持久化
- **存储服务**：Supabase（PostgreSQL 数据库服务）
- **表结构**：`stock_analysis` 表存储所有分析结果
- **字段**：symbol | summary | sentiment | risk_level | created_at

---

## 📋 快速开始

### 前置要求
- Python 3.8+
- 网络连接（需要访问文件：智谱 API、东方财富、Supabase）

### 1. 安装依赖
```bash
pip install -r requirements.txt
```

### 2. 配置环境变量
```bash
# 复制模板文件
cp .env.example .env

# 编辑 .env 文件，填入你的 API 密钥
# Windows PowerShell:
notepad .env

# Mac/Linux:
nano .env
```

**需要配置的密钥：**
| 配置项 | 获取地址 | 说明 |
|------|--------|------|
| `ZHIPU_API_KEY` | https://open.bigmodel.cn/usercenter/apikeys | 智谱 AI API 密钥 |
| `SUPABASE_URL` | https://app.supabase.com/projects | Supabase 项目 URL |
| `SUPABASE_KEY` | https://app.supabase.com/projects | Supabase 匿名密钥 |

### 3. 启动服务
```bash
python app.py
```

服务将运行在 `http://localhost:5000`

### 4. 使用系统
1. 打开浏览器访问 `http://localhost:5000`
2. 输入股票代码（如：AAPL、TSLA、NVDA）
3. 点击"开始 AI 分析"按钮
4. 等待 AI 分析结果（通常 5-10 秒）
5. 查看**整体分析报告**，包括走势、情绪、风险评估

---

## 🏗️ 系统架构

```
前端 (HTML + JavaScript)
    ↓ HTTP POST
Flask 后端
    ├── 数据层：efinance API
    ├── AI 层：智谱 GLM-4 API
    └── 存储层：Supabase PostgreSQL
```

## 📊 API 端点

### POST `/api/analyze`

**请求：**
```json
{
    "symbol": "AAPL"
}
```

**响应（成功）：**
```json
{
    "symbol": "AAPL",
    "summary": "苹果股价近期震荡上升，成交量温和放大，市场情绪稳健向好。",
    "sentiment": "Bullish",
    "risk_level": "Medium"
}
```

**响应（失败）：**
```json
{
    "error": "请输入股票代码"
}
```

---

## 🔧 常见问题解决

### 问题 1：efinance 获取数据失败
**症状**：看到 `❌ efinance 获取数据失败` 日志
**原因**：网络限制、API 限流或东方财富服务降级
**解决**：系统会自动使用高保真模拟数据，保证服务继续运行 ✅

### 问题 2：Supabase 连接失败
**症状**：看到 `Supabase 初始化失败` 日志
**原因**：未配置有效的 Supabase 密钥或网络不通
**解决**：检查 `.env` 中的 `SUPABASE_URL` 和 `SUPABASE_KEY` 是否正确

### 问题 3：智谱 API 返回格式错误
**症状**：看到 `JSON 解析失败` 错误
**原因**：AI 返回了包含 Markdown 标记的响应
**解决**：系统已内置正则清洗机制，自动剥离 ```json 标记

### 问题 4：需要使用代理
**解决**：编辑 `app.py` 第 14 行，设置代理 URL：
```python
proxy = 'http://your-proxy:port'
```

---

## 📝 Supabase 数据库设置

如果你需要手动创建 `stock_analysis` 表：

```sql
CREATE TABLE stock_analysis (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    symbol VARCHAR(20) NOT NULL,
    summary TEXT,
    sentiment VARCHAR(20),
    risk_level VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建索引以提升查询速度
CREATE INDEX idx_stock_symbol ON stock_analysis(symbol);
CREATE INDEX idx_stock_created_at ON stock_analysis(created_at DESC);
```

---

## 📦 项目文件结构

```
ai-stock-analyzer/
├── app.py                      # 后端 Flask 应用（核心逻辑）
├── requirements.txt            # 依赖列表
├── .env.example               # 环境配置模板
├── README.md                  # 本文档
└── templates/
    └── index.html             # 前端页面
```

---

## 🚨 安全建议

1. **不要提交 `.env` 文件到 Git**
   ```bash
   # .gitignore
   .env
   .env.local
   __pycache__/
   *.pyc
   ```

2. **使用强密钥**
   - Supabase：使用行级安全（RLS）策略
   - 智谱 API：定期轮换密钥

3. **生产环境**
   - 改为 `FLASK_ENV=production`
   - 禁用 `debug=True`
   - 使用 Gunicorn 等 WSGI 服务器

---

## 🎯 后续扩展方向

- [ ] 支持更多股票市场（港股、A股、加密货币）
- [ ] 添加历史分析对比功能
- [ ] 支持邮件推送预警
- [ ] 集成技术指标 (MACD、RSI、KDJ)
- [ ] 前端图表展示
- [ ] API 限流和用户认证

---

## 📄 许可证

MIT License

---

## 📞 支持

如有问题，请检查 Flask 控制台日志以获取详细错误信息。

**祝您使用愉快！** 🎉

