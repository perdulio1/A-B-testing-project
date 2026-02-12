# Marketing A/B Test: From Statistical Success to Economic Reality

### 📌 Project Overview
This project is a comprehensive audit of a marketing A/B test involving 588,000+ users. While most analyses stop at proving "statistical significance," this project dives deeper into Unit Economics and Ad Fatigue to determine if the campaign's success in conversion actually translates into business profit.

###  Tech Stack
* Database: PostgreSQL (Cloud-based via NeonDB).
* Advanced SQL: CTEs, Window Functions (SUM() OVER, LAG), Gap Filling (generate_series).
* Statistics: Z-Test for proportions, Sample Ratio Mismatch (SRM).
* BI: Power BI (Multi-page Interactive Dashboard).

### 📖 Dataset & Business Context
Source: Kaggle - [Marketing A/B Testing](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing)

Scenario: A retail company tested a new ad campaign.
*   Test Group ('ad'): Exposed to the new creative.
*   Control Group ('psa'): Exposed to Public Service Announcements (organic baseline).
Financial Assumptions:
*   Cost per Ad View (CPA): $0.20
*   Subscription/Product Price: $50.00

###  Key Objectives
Based on the analytical workflow, the project answers four critical questions:
1. Data Integrity: Does the 96/4 sample split indicate a technical error or a deliberate design? (SRM Test).
2. Statistical Impact: Did the ads cause a reliable increase in conversion rates? (Z-Score & Lift).
3. Financial Audit: Is the campaign profitable given the $0.20/view cost? (ROAS & CAC).
4. Behavioral Analysis: At what point does showing more ads stop being profitable? (Frequency & Marginal Analysis).

### ⚙️ Project Workflow

1. Environment Setup: Initialized a cloud-based PostgreSQL (NeonDB) instance and automated data ingestion via Python (Pandas & SQLAlchemy).
2. Data Integrity Audit: Performed an SRM Test to validate the 96/4 sample split and ensure randomization wasn't compromised.
3. Statistical Benchmarking: Calculated Conversion Rates, Lift, and Z-scores to prove the ad's impact on user behavior.
4. Unit Economic Modeling: Injected financial parameters ($0.20 cost / $50 revenue) to shift from clicks to profit-based metrics.
5. Marginal Profit & Fatigue Analysis: Developed a Gap-Filling SQL model to track the "Burnout Point" — identifying exactly when ad frequency turns from an asset into a liability.
6. Insights Synthesis: Designed a Power BI Dashboard to translate technical SQL findings into strategic business recommendations.

### 🛠 Project Structure
This repository is organized into a clear pipeline, from data ingestion to the final business dashboard:

```plaintext
├── 01 Upload data/
│   ├── upload.py              # Python script for automated database ingestion
│   └── project_config.sql      # Schema setup and parameter configuration
├── 02 Analytics/
│   ├── srm_test.sql           # Sample Ratio Mismatch (SRM) validation
│   ├── ab_test_results.sql    # Statistical significance (Z-score, Lift)
│   └── marginal_analysis.sql  # Advanced SQL for gap-filling & marginal profit
├── 03 Views/
│   └── powerbi_views.sql      # "Gold Layer" views optimized for BI tools
└── 04 Power BI/
    └── Marketing_Audit.pbix   # Final interactive dashboard
```

### Phase 1: Validating the Experiment
1. **Sample Ratio Mismatch (SRM) Audit**
   The dataset shows a massive imbalance: 564,577 users in 'ad' vs 23,524 in 'psa'.
*   Analysis: I performed an SRM check to ensure this wasn't a result of a broken randomization algorithm.
*   Finding: The 96/4 split is consistent across all segments, suggesting a deliberate "Fixed Allocation" design to minimize the opportunity cost of the control group. The data is valid for further testing.

2. **The "Success" Illusion: Z-Score & Lift**
I calculated the conversion rates (CR) to measure the raw impact of the ads.
   *   Control CR (PSA): 1.79%
   *   Test CR (Ad): 2.55%
   *   Incremental Lift: +42.4%
   *   Z-Score: 8.66
Conclusion: The result is statistically significant (***Z*** > 1.96). From a purely statistical standpoint, the campaign is a "success." However, statistics do not account for costs.

### Phase 2: The Economic Reality Check
3. **Unit Economics Audit**
Using the assumptions (***Cost*** = $0.20, ***Price*** = $50), I built a financial model to evaluate the campaign's health.

|Metric|Result|Interpretation|
|------|------|--------------|
|Total Revenue|$721,450|Income from 14,429 converters|
|Total Marketing Cost|$4,000,000+|Cost of 20M+ ad impressions|
|CAC (Customer Acquisition Cost)|$235.86|We pay $235 to get a $50 customer|
|ROAS|0.18|For every $1 spent, we return only $0.18|

**Business Verdict**: The campaign pays $235.86 to acquire a customer that only brings in $50.00. Despite the statistical success, the campaign is commercially unsustainable in its current state.

### Phase 3: The Search for Efficiency (Ad Fatigue Analysis)
4. **The Frequency Trap**
A common mistake in marketing is assuming that more impressions always lead to better results. I analyzed the relationship between Total Ads Seen and Conversion Rate.
*    Observation: The Raw Conversion Rate (CR) actually increases with frequency (reaching up to 17% for users seeing 100+ ads).
*    The Problem: While conversion grows, the cost grows linearly. Showing 100 ads costs $20.00 per user ($0.20 х 100$), which eats into the $50.00 margin far faster than the conversion rate can compensate for the failure of non-buyers.

5. **Technical Highlight: Gap-Filling & Marginal Cost**
   To calculate the true cost of the campaign, I implemented a Gap-Filling SQL model using generate_series.
   *    Why? The raw data only shows where a user stopped. To calculate the true "active" cost at each impression level (e.g., the cost of the 5th ad), we must account for every user who passed through that stage, even if they didn't stop there.
   *    The Logic: I calculated the Marginal Profit for every additional ad shown:
  
     $$Marginal\ Profit = (New\ Buyers \times Price) - (Active\ Users \times Cost)$$

Key Finding: The marginal profit per ad remains negative for the first 6 impressions, peaks briefly, and then enters a long tail of diminishing returns. This proves that the "shotgun" approach of showing thousands of ads to a single user is the primary driver of the $2M+ total loss.

### 💡 Phase 4 Final: Strategic Recommendations
Based on the data, I proposed three high-impact shifts for future campaigns:
*    Implement Frequency Capping: The data suggests an optimal "cutoff" point. Beyond a certain number of impressions, the probability of conversion no longer justifies the incremental cost.
*    Bid Optimization: At a $0.20 CPA, the campaign is mathematically destined to fail unless the conversion rate exceeds 0.4% per single impression. I recommend reducing the bid or shifting to a Target CPA model.
*    Audience Pruning: Users who do not convert after the first 20–30 impressions should be excluded from the "Retargeting" pool to stop the "budget bleed."


### Conclusion 
This project demonstrates that Statistical Significance / Business Success. While the A/B test was a "winner" in the lab (Z-score 8.66), it was a "loser" in the bank (ROAS 0.18). By combining statistical rigor with Unit Economics, I was able to pinpoint exactly where the money was lost and how to fix it.

   

  
