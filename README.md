
# Card Product Analytics – SQL Portfolio Project

This project simulates the role of a Business Analyst at a financial institution. It showcases data modeling, reporting, and analytical capabilities across SQL and Power BI.

## Project Overview

The analysis covers:
- Card product profitability & usage
- Customer segmentation & churn modeling
- Financial reconciliation with card scheme costs
- Simulation of pricing strategy impacts

Built with PostgreSQL and mock data generated using Python and Faker.

##  Data Schema

Tables:
- `customers` – customer demographics and segments
- `cards` – issued debit/credit cards and monthly fees
- `transactions` – individual card transactions
- `fees` – one-off and recurring fees (e.g. annual fee, overlimit)
- `card_scheme_costs` – costs charged by Visa/Mastercard
- `pricing_simulation` – future pricing strategy scenarios

##  Phase 1 Analytics

- Product-level profitability (`pko_phase1_queries.sql`)
- Monthly active card tracking
- Pricing impact simulation

##  Phase 2 Analytics

- Cohort retention by card issue date (`pko_phase2_queries.sql`)
- Reconciliation logic for scheme cost vs. transaction value
- Customer spend-based segmentation

##  Files Included

- `*.csv` – Mock data files
- `pko_portfolio_schema.sql` – PostgreSQL DDL
- `pko_portfolio_import.sql` – Data import script
- `pko_phase1_queries.sql` – Core KPIs & profit queries
- `pko_phase2_queries.sql` – Retention, reconciliation, segmentation
- `README.md` – This project summary

##  Contact

Made by Michał Kowalczyk for portfolio purposes. For questions or collaboration, reach out via kowalczykmj95@gmail.com
