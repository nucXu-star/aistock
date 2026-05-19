-- AI 股票分析系统 - Supabase 数据库初始化脚本
-- 在 Supabase SQL 编辑器中运行此脚本

-- 1. 创建主表：stock_analysis
CREATE TABLE IF NOT EXISTS stock_analysis (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    symbol VARCHAR(20) NOT NULL,
    summary TEXT,
    sentiment VARCHAR(20),
    risk_level VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. 创建索引以提升查询性能
CREATE INDEX IF NOT EXISTS idx_stock_analysis_symbol ON stock_analysis(symbol);
CREATE INDEX IF NOT EXISTS idx_stock_analysis_created_at ON stock_analysis(created_at DESC);

-- 3. 启用行级安全 (RLS) - 可选但推荐
ALTER TABLE stock_analysis ENABLE ROW LEVEL SECURITY;

-- 4. 创建 RLS 策略 - 允许所有用户读取
CREATE POLICY "允许开放读取"
    ON stock_analysis
    FOR SELECT
    USING (true);

-- 5. 创建 RLS 策略 - 允许所有用户插入
CREATE POLICY "允许开放插入"
    ON stock_analysis
    FOR INSERT
    WITH CHECK (true);

-- 6. 验证表结构
-- 运行此查询检查表是否创建成功
-- SELECT * FROM stock_analysis LIMIT 1;

-- 7. 查看表统计
-- SELECT
--     tablename,
--     pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
-- FROM pg_tables
-- WHERE tablename = 'stock_analysis';

