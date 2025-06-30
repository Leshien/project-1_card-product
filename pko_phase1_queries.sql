-- CARD PRODUCT PROFITABILITY

-- Revenue, costs and net profit per card type
SELECT
    c.card_type,
    COUNT(DISTINCT c.card_id) AS total_cards,
    SUM(t.amount) AS total_spend,
    SUM(t.txn_fee) AS total_fee_revenue,
    SUM(cs.cost_amount) AS total_scheme_costs,
    SUM(f.fee_amount) AS additional_fees,
    SUM(t.txn_fee) + SUM(f.fee_amount) - SUM(cs.cost_amount) AS net_margin
FROM cards c
LEFT JOIN transactions t ON c.card_id = t.card_id AND t.reversed_flag = FALSE
LEFT JOIN card_scheme_costs cs ON t.txn_id = cs.txn_id
LEFT JOIN fees f ON c.card_id = f.card_id
GROUP BY c.card_type
ORDER BY net_margin DESC;


-- MONTHLY ACTIVE CARDS

-- Count of cards with at least one transaction in each month
SELECT
    DATE_TRUNC('month', txn_date) AS month,
    COUNT(DISTINCT card_id) AS active_cards
FROM transactions
WHERE reversed_flag = FALSE
GROUP BY month
ORDER BY month;


-- CHURN SIMULATION

-- Estimate revenue impact under simulated fee increase and churn
SELECT
    ps.scenario_id,
    ps.fee_change_pct,
    ps.expected_churn_rate,
    ps.net_revenue_delta,
    COUNT(DISTINCT c.card_id) AS current_active_cards,
    ROUND((1 - ps.expected_churn_rate) * COUNT(DISTINCT c.card_id)) AS projected_active_cards,
    ROUND(SUM(c.monthly_fee) * (1 + ps.fee_change_pct) * (1 - ps.expected_churn_rate), 2) AS projected_monthly_revenue
FROM pricing_simulation ps
CROSS JOIN cards c
WHERE c.status = 'Active'
GROUP BY ps.scenario_id, ps.fee_change_pct, ps.expected_churn_rate, ps.net_revenue_delta;


