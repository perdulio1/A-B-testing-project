CREATE TABLE marketing_ab (
    index_id SERIAL,           
    user_id INTEGER PRIMARY KEY,
    test_group VARCHAR(20),    
    converted BOOLEAN,         
    total_ads INTEGER,         
    most_ads_day VARCHAR(20),  
    most_ads_hour INTEGER      
);