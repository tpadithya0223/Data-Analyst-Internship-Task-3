/* SUPERSTORE BUSINESS PERFORMANCE ANALYSIS
   Prepared for: Internship Task 3
   Table Name: train
*/

-- 1. DATA INTEGRITY CHECK
-- Purpose: To ensure all 9,800 records from the CSV were successfully imported.
SELECT COUNT(*) AS total_transactions 
FROM train;

-- 2. PRODUCT CATEGORY DEEP-DIVE
-- Purpose: Extracting all sales data specifically for 'Technology' to analyze tech trends.
SELECT * FROM train 
WHERE Category = 'Technology';

-- 3. HIGH-VALUE INVENTORY
-- Purpose: Identifying the top 5 most expensive products sold to understand luxury demand.
SELECT "Product Name", Sales 
FROM train 
ORDER BY Sales DESC 
LIMIT 5;

-- 4. REGIONAL PERFORMANCE SUMMARY (The Main Report)
-- Purpose: A snapshot of how different regions perform across different product lines.
SELECT 
    Region, 
    Category, 
    ROUND(SUM(Sales), 2) AS Total_Revenue, 
    ROUND(AVG(Sales), 2) AS Average_Transaction_Value 
FROM train 
GROUP BY Region, Category
ORDER BY Region ASC, Total_Revenue DESC;

-- 5. THE "STAR" CATEGORIES
-- Purpose: Filtering to find only categories that have crossed the 100,000 revenue milestone.
SELECT Category, SUM(Sales) AS Total_Revenue
FROM train
GROUP BY Category
HAVING SUM(Sales) > 100000;

-- 6. [NEW] PROFITABILITY ANALYSIS 
-- Purpose: Identifying which Sub-Categories are actually making the most profit.
SELECT "Sub-Category", SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM train
GROUP BY "Sub-Category"
ORDER BY Total_Profit DESC;

-- 7. [NEW] LOYALTY CHECK (Interview Question Prep)
-- Purpose: Finding our Top 5 Customers based on their lifetime spend with the store.
SELECT "Customer Name", COUNT("Order ID") AS Number_of_Orders, SUM(Sales) AS Lifetime_Value
FROM train
GROUP BY "Customer Name"
ORDER BY Lifetime_Value DESC
LIMIT 5;