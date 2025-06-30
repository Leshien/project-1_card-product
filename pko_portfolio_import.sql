
-- Adjust path if running outside of psql or in a different environment
-- Assumes CSV files are located at a known directory (e.g., '/path/to/data')

\COPY customers FROM 'customers.csv' DELIMITER ',' CSV HEADER;
\COPY cards FROM 'cards.csv' DELIMITER ',' CSV HEADER;
\COPY transactions FROM 'transactions.csv' DELIMITER ',' CSV HEADER;
\COPY card_scheme_costs FROM 'card_scheme_costs.csv' DELIMITER ',' CSV HEADER;
\COPY fees FROM 'fees.csv' DELIMITER ',' CSV HEADER;
\COPY pricing_simulation FROM 'pricing_simulation.csv' DELIMITER ',' CSV HEADER;
