# Marketing A/B Test: From Statistical Success to Economic Reality

#### 📌 Project Overview
This project is a comprehensive audit of a marketing A/B test involving 588,000+ users. While most analyses stop at proving "statistical significance," this project dives deeper into Unit Economics and Ad Fatigue to determine if the campaign's success in conversion actually translates into business profit.

#### 📖 Dataset & Business Context
Source: Kaggle - [Marketing A/B Testing](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing)

Scenario: A retail company tested a new ad campaign.
*   Test Group ('ad'): Exposed to the new creative.
*   Control Group ('psa'): Exposed to Public Service Announcements (organic baseline).
Financial Assumptions:
*   Cost per Ad View (CPA): $0.20
*   Subscription/Product Price: $50.00

####  Key Objectives
Based on the analytical workflow, the project answers four critical questions:
1. Data Integrity: Does the 96/4 sample split indicate a technical error or a deliberate design? (SRM Test).
2. Statistical Impact: Did the ads cause a reliable increase in conversion rates? (Z-Score & Lift).
3. Financial Audit: Is the campaign profitable given the $0.20/view cost? (ROAS & CAC).
4. Behavioral Analysis: At what point does showing more ads stop being profitable? (Frequency & Marginal Analysis).

####  Tech Stack
* Database: PostgreSQL (Cloud-based via NeonDB).
* Advanced SQL: CTEs, Window Functions (SUM() OVER, LAG), Gap Filling (generate_series).
* Statistics: Z-Test for proportions, Sample Ratio Mismatch (SRM).
* BI: Power BI (Multi-page Interactive Dashboard).


### Phase 1: Validating the Experiment
1.1 **Sample Ratio Mismatch (SRM) Audit**
   The dataset shows a massive imbalance: 564,577 users in 'ad' vs 23,524 in 'psa'.
*   Analysis: I performed an SRM check to ensure this wasn't a result of a broken randomization algorithm.
*   Finding: The 96/4 split is consistent across all segments, suggesting a deliberate "Fixed Allocation" design to minimize the opportunity cost of the control group. The data is valid for further testing.

1.2 **The "Success" Illusion: Z-Score & Lift**
   I calculated the conversion rates (CR) to measure the raw impact of the ads.
   *   Control CR (PSA): 1.79%
   *   Test CR (Ad): 2.55%
   *   Incremental Lift: +42.4%
   *   Z-Score: 8.66
Conclusion: The result is statistically significant (***Z*** > 1.96). From a purely statistical standpoint, the campaign is a "success." However, statistics do not account for costs.

### Phase 2: The Economic Reality Check
2.1 **Unit Economics Audit**
Using the assumptions (***Cost*** = $0.20, ***Price*** = $50), I built a financial model to evaluate the campaign's health.

|Metric|Result|Interpretation|
|------|------|--------------|
|Total Revenue|$721,450|Income from 14,429 converters|
|Total Marketing Cost|$4,000,000+|Cost of 20M+ ad impressions|
|CAC (Customer Acquisition Cost)|$235.86|We pay $235 to get a $50 customer|
|ROAS|0.18|For every $1 spent, we return only $0.18|


  
