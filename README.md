# Marketing A/B Test

###  Project Overview
This project is a comprehensive analysis of the existing dataset, but with a key difference: it includes a 'legend' about the cost per impression and profit per conversion. I did this in order to turn a regular dataset into a full-fledged scenario, and to be able to make business conclusions or recommendations.


###  Tech Stack
* Database: SQL, NeonDB
* Statistics: Z-Test for proportions, Sample Ratio Mismatch (SRM)
* BI: Power BI 


###  Dataset & Business Context
Source: Kaggle - [Marketing A/B Testing](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing)

Scenario: A retail company tested a new ad campaign.
*   Test Group ('ad'): Exposed to the new creative.
*   Control Group ('psa'): Exposed to Public Service Announcements (organic baseline).
Financial Assumptions:
*   Cost per Ad View (CPA): $0.20
*   Subscription/Product Price: $50.00


## Execution & Results


Here are the main questions, the answers to which are the final result:
1. Can the data distribution in the test be trusted?
2. Did the advertising really increase sales, or is it just a coincidence?
3. Is this campaign financially profitable?
4. What can be improved?




![Dashboard Screen](screenshot.png)



The distribution of data in this test can be trusted, because despite the large gap in the number of users (96% saw the ad, and 4% did not), the SRM test confirmed that this was not a technical failure, but a planned experiment structure.

The advertising really affected sales and this is definitely not a coincidence, because we got a Z-score of 8.66, which is much higher than the critical limit, and the conversion itself in the test group increased to 2.55% versus 1.79% in the control, which is a statistically confirmed success.

Financially, this campaign is a complete failure, because at a cost of 20 cents per impression, we got an ROAS of only 25%. The cost of attracting one buyer is up to $ 194, which is 4 times higher than the profit.

Final tips:
The most important improvement should be the implementation of Frequency Capping at the level of 100 units, because after this limit the probability of conversion drops, and advertising costs are guaranteed to exceed the $50 margin.
The peak of effectiveness falls on 50–100 impressions, based on this it is recommended:
1. automatically rotate advertising creatives every 15–20 touches to “break through” the audience’s attention faster and shift this peak to the area of ​​fewer impressions, which will significantly reduce the cost of customer acquisition (CAC).
2. Abandon the fixed rate of $0.20 in favor of the cascade retargeting model, where expensive premium channels are used only for the first 10 contacts, and the long “warm-up” in the area of ​​50+ impressions is transferred to the cheapest banner networks and In-app advertising. This approach will allow you to maintain the high touch frequency necessary for this product, but will reduce the average cost per impression by several times, which is the only way to fix a loss-making campaign.



