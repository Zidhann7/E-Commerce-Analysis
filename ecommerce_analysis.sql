-- E-Commerce Customer and Product Analysis
-- Database: ecommerce_df
-- Table: ecommerce

USE ecommerce_df;

-- 1. Check the imported data
SELECT *
FROM ecommerce
LIMIT 10;

-- 2. Check the total number of records
SELECT COUNT(*) AS total_records
FROM ecommerce;

-- 3. Check how many different products are in the table
SELECT COUNT(DISTINCT `Product ID`) AS total_products
FROM ecommerce;

-- 4. Check for missing values
SELECT
    SUM(CASE WHEN `Product ID` IS NULL OR `Product ID` = '' THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN `Product Name` IS NULL OR `Product Name` = '' THEN 1 ELSE 0 END) AS missing_product_name,
    SUM(CASE WHEN Category IS NULL OR Category = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS missing_discount,
    SUM(CASE WHEN `Stock Level` IS NULL THEN 1 ELSE 0 END) AS missing_stock_level
FROM ecommerce;

-- 5. Check duplicate product IDs
SELECT
    `Product ID`,
    COUNT(*) AS number_of_records
FROM ecommerce
GROUP BY `Product ID`
HAVING COUNT(*) > 1;

-- 6. Basic price information
SELECT
    COUNT(*) AS product_count,
    ROUND(AVG(Price), 2) AS average_price,
    MIN(Price) AS lowest_price,
    MAX(Price) AS highest_price
FROM ecommerce;

-- 7. Product count and average price by category
SELECT
    Category,
    COUNT(*) AS product_count,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(Discount), 2) AS average_discount
FROM ecommerce
GROUP BY Category
ORDER BY product_count DESC;

-- 8. Products with the highest prices
SELECT
    `Product ID`,
    `Product Name`,
    Category,
    Price
FROM ecommerce
ORDER BY Price DESC
LIMIT 10;

-- 9. Products with low stock
SELECT
    `Product ID`,
    `Product Name`,
    Category,
    `Stock Level`
FROM ecommerce
WHERE `Stock Level` < 50
ORDER BY `Stock Level` ASC;

-- 10. Average return rate by category
SELECT
    Category,
    ROUND(AVG(`Return Rate`), 2) AS average_return_rate
FROM ecommerce
GROUP BY Category
ORDER BY average_return_rate DESC;

-- 11. Check return-rate levels for each product
SELECT
    `Product ID`,
    `Product Name`,
    `Return Rate`,
    CASE
        WHEN `Return Rate` >= 10 THEN 'High'
        WHEN `Return Rate` >= 5 THEN 'Medium'
        ELSE 'Low'
    END AS return_rate_status
FROM ecommerce
ORDER BY `Return Rate` DESC;

-- 12. Customer age-group and gender summary
SELECT
    `Customer Age Group`,
    `Customer Gender`,
    COUNT(*) AS record_count
FROM ecommerce
GROUP BY `Customer Age Group`, `Customer Gender`
ORDER BY `Customer Age Group`, record_count DESC;

-- 13. Product records by customer location
SELECT
    `Customer Location`,
    COUNT(*) AS record_count
FROM ecommerce
GROUP BY `Customer Location`
ORDER BY record_count DESC;

-- 14. Shipping method summary
SELECT
    `Shipping Method`,
    COUNT(*) AS record_count,
    ROUND(AVG(`Shipping Cost`), 2) AS average_shipping_cost
FROM ecommerce
GROUP BY `Shipping Method`
ORDER BY average_shipping_cost DESC;

-- 15. Seasonal and non-seasonal products
SELECT
    Seasonality,
    COUNT(*) AS product_count,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(`Popularity Index`), 2) AS average_popularity
FROM ecommerce
GROUP BY Seasonality;

-- 16. Products with popularity index above the overall average
SELECT
    `Product ID`,
    `Product Name`,
    Category,
    `Popularity Index`
FROM ecommerce
WHERE `Popularity Index` > (
    SELECT AVG(`Popularity Index`)
    FROM ecommerce
)
ORDER BY `Popularity Index` DESC;

-- 17. Rank products by popularity within each category
WITH product_ranking AS (
    SELECT
        `Product ID`,
        `Product Name`,
        Category,
        `Popularity Index`,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY `Popularity Index` DESC
        ) AS category_rank
    FROM ecommerce
)
SELECT *
FROM product_ranking
ORDER BY Category, category_rank;

-- 18. Summary for products that may need attention
SELECT
    `Product ID`,
    `Product Name`,
    Category,
    `Stock Level`,
    `Return Rate`,
    `Popularity Index`
FROM ecommerce
WHERE `Stock Level` < 50
   OR `Return Rate` >= 10
ORDER BY `Return Rate` DESC, `Stock Level` ASC;

-- Note:
-- This table contains product and customer attributes, but it does not include
-- Order ID, Order Date, Customer ID, Quantity Sold or Product Cost.
-- Revenue, order volume, average order value, repeat purchases and profit
-- cannot be calculated correctly until those transaction fields are available.
-- A JOIN also requires another related table, such as an orders or suppliers table.
