-- COHORT RETENTION

-- Retention cohorts by month of card issue
WITH cohort_base AS (
    SELECT
        customer_id,
        MIN(DATE_TRUNC('month', issue_date)) AS cohort_month
    FROM cards
    GROUP BY customer_id
),
activity AS (
    SELECT
        c.customer_id,
        DATE_TRUNC('month', ca.issue_date) AS cohort_month,
        DATE_TRUNC('month', t.txn_date) AS activity_month
    FROM cards ca
    JOIN transactions t ON ca.card_id = t.card_id AND t.reversed_flag = FALSE
    JOIN customers c ON ca.customer_id = c.customer_id
)
SELECT
    cohort_month,
    activity_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM activity
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;


-- RECONCILIATION LOGIC

-- Reconcile card transactions and scheme costs to find mismatches
SELECT
    t.txn_id,
    t.amount AS transaction_amount,
    cs.cost_amount AS scheme_cost,
    t.amount - cs.cost_amount AS discrepancy
FROM transactions t
LEFT JOIN card_scheme_costs cs ON t.txn_id = cs.txn_id
WHERE t.reversed_flag = FALSE
  AND (cs.cost_amount IS NULL OR ABS(t.amount - cs.cost_amount) > 1);


-- CUSTOMER SEGMENTATION

-- Segment customers based on average transaction amount
WITH spending AS (
    SELECT
        c.customer_id,
        AVG(t.amount) AS avg_spend,
        COUNT(t.txn_id) AS txn_count
    FROM customers c
    JOIN cards ca ON c.customer_id = ca.customer_id
    JOIN transactions t ON ca.card_id = t.card_id
    WHERE t.reversed_flag = FALSE
    GROUP BY c.customer_id
)
SELECT
    customer_id,
    avg_spend,
    txn_count,
    CASE
        WHEN avg_spend > 100 THEN 'High Spender'
        WHEN avg_spend > 30 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS segment
FROM spending
ORDER BY avg_spend DESC;


