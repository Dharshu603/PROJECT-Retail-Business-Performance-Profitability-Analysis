
-- Create table for superstore data
CREATE TABLE superstore_sales (
    OrderID TEXT,
    OrderDate TEXT,
    ShipDate TEXT,
    ShipMode TEXT,
    CustomerID TEXT,
    CustomerName TEXT,
    Segment TEXT,
    Country TEXT,
    City TEXT,
    State TEXT,
    PostalCode TEXT,
    Region TEXT,
    ProductID TEXT,
    Category TEXT,
    SubCategory TEXT,
    ProductName TEXT,
    Sales REAL,
    Quantity INTEGER,
    Discount REAL,
    Profit REAL
);

-- 1. Total Sales, Profit, Orders, Quantity
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT OrderID) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity
FROM superstore_sales;

-- 2. Sales and Profit by Category
SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 3. Profit by Sub-Category (to find loss-makers)
SELECT 
    SubCategory,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY SubCategory
ORDER BY Total_Profit ASC;

-- 4. Sales Trend (Month-Year wise)
SELECT 
    SUBSTR(OrderDate, 1, 7) AS MonthYear,
    ROUND(SUM(Sales), 2) AS Monthly_Sales,
    ROUND(SUM(Profit), 2) AS Monthly_Profit
FROM superstore_sales
GROUP BY MonthYear
ORDER BY MonthYear;

-- 5. Sales by Region
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 6. Average Discount and Total Profit by Sub-Category (for Scatter Plot)
SELECT 
    SubCategory,
    ROUND(AVG(Discount), 2) AS Avg_Discount,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    SUM(Quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY SubCategory
ORDER BY Avg_Discount;

-- 7. Top 10 Products by Sales
SELECT 
    ProductName,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales
GROUP BY ProductName
ORDER BY Total_Sales DESC
LIMIT 10;

-- 8. Loss-Making Products
SELECT 
    ProductName,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY ProductName
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC;
