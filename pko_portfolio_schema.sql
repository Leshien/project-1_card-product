
    CREATE TABLE customers (
        customer_id INT PRIMARY KEY,
        age INT,
        gender VARCHAR(10),
        account_open_date DATE,
        segment VARCHAR(20)
    );
    

    CREATE TABLE cards (
        card_id VARCHAR(20) PRIMARY KEY,
        customer_id INT REFERENCES customers(customer_id),
        card_type VARCHAR(30),
        issue_date DATE,
        status VARCHAR(15),
        monthly_fee NUMERIC(6,2)
    );
    

    CREATE TABLE transactions (
        txn_id UUID PRIMARY KEY,
        card_id VARCHAR(20) REFERENCES cards(card_id),
        txn_date DATE,
        merchant_category VARCHAR(50),
        amount NUMERIC(10,2),
        txn_fee NUMERIC(8,2),
        reversed_flag BOOLEAN
    );
    

    CREATE TABLE card_scheme_costs (
        txn_id UUID REFERENCES transactions(txn_id),
        scheme VARCHAR(20),
        cost_type VARCHAR(30),
        cost_amount NUMERIC(8,2)
    );
    

    CREATE TABLE fees (
        card_id VARCHAR(20) REFERENCES cards(card_id),
        fee_type VARCHAR(30),
        fee_date DATE,
        fee_amount NUMERIC(8,2)
    );
    

    CREATE TABLE pricing_simulation (
        scenario_id INT PRIMARY KEY,
        fee_change_pct NUMERIC(5,4),
        expected_churn_rate NUMERIC(5,4),
        net_revenue_delta NUMERIC(12,2)
    );
    