CREATE TABLE project_config (
    parameter_name TEXT PRIMARY KEY,
    parameter_value DECIMAL(10, 2)
);

INSERT INTO project_config VALUES 
('cost_per_ad', 0.20),
('subscription_price', 50.00);