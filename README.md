# E-Commerce Customer & Sales Analytics

**Conorise Infotech | Data Analytics Internship | Project 3 – Intermediate**

This project explores an e-commerce dataset using **MySQL, Excel and Power BI**. The work focuses on understanding the product catalogue, inventory levels, pricing, discounts, customer attributes and shipping information, then presenting the results in an interactive Power BI report.

> **Data scope note:** The dataset fields currently available are product- and attribute-level fields. They do not include order IDs, order dates, customer IDs, quantities sold or product costs. For that reason, this version of the project does not claim to calculate transaction revenue, order volume, average order value, repeat purchases or profit. Those analyses require a transaction-level dataset.

---

## Project objectives

- Review and validate the imported e-commerce data.
- Analyse product count, categories, prices, discounts and inventory levels.
- Examine return-rate and popularity patterns across products and categories.
- Review customer demographic and location attributes represented in the dataset.
- Compare shipping methods and shipping costs.
- Build a Power BI report that makes the available information easier to explore.
- Identify practical areas for further investigation and improvement.

## Tools used

| Tool | Purpose |
|---|---|
| **MySQL 8.0+ / MySQL Workbench** | Inspect imported data, perform quality checks, create analytical queries and prepare views for reporting. |
| **Microsoft Excel** | Inspect the source file and review data quality and analysis results. |
| **Microsoft Power BI** | Build report pages, KPI cards, charts, tables and interactive slicers. |

## Dataset overview

The dataset is imported into MySQL Workbench using the **Table Data Import Wizard**.

| Database | Table |
|---|---|
| `ecommerce_df` | `ecommerce` |

The available fields are:

| Field | Description |
|---|---|
| `Product ID` | Product identifier |
| `Product Name` | Product name |
| `Category` | Product category |
| `Price` | Listed product price |
| `Discount` | Discount value supplied in the dataset |
| `Tax Rate` | Tax rate supplied in the dataset |
| `Stock Level` | Recorded stock level |
| `Supplier ID` | Supplier identifier |
| `Customer Age Group` | Customer age-group attribute associated with the record |
| `Customer Location` | Customer location attribute associated with the record |
| `Customer Gender` | Customer gender attribute associated with the record |
| `Shipping Cost` | Recorded shipping cost |
| `Shipping Method` | Shipping method, such as Standard or Overnight |
| `Return Rate` | Recorded return-rate value |
| `Seasonality` | Seasonal indicator |
| `Popularity Index` | Product popularity score/index |

The project uses the supplied source values. Confirm the currency and whether `Discount` and `Tax Rate` are percentages before interpreting any price calculations.

## MySQL analysis

The MySQL work is designed for the existing imported database and table. It does not need to recreate the raw table or insert example records.

The analysis includes:

1. Inspecting the imported table and checking its record count and columns.
2. Checking missing values and possible duplicate product IDs.
3. Reviewing distinct category, gender, age-group, seasonality and shipping-method values.
4. Summarising product prices, stock, discounts, return rates and popularity.
5. Comparing products and categories using `GROUP BY` and aggregate functions.
6. Creating business-friendly labels with `CASE WHEN`, such as stock and return-rate groups.
7. Using a derived category summary with a `JOIN`.
8. Using subqueries to identify products above average price or category popularity.
9. Using CTEs and window functions to summarise stock and rank products within categories.
10. Preparing a Power BI source view from the cleaned analytical view.

### Views created by the analysis script

- `vw_ecommerce_clean` – a standardised analytical view based on the imported table.
- `vw_powerbi_ecommerce_product_analysis` – a reporting view intended to be used as a source in Power BI.

The script uses MySQL 8.0+ syntax, including CTEs and window functions.

## Power BI report structure

The report is organised into three pages:

### Page 1 – E-Commerce Overview Dashboard

A high-level view of the available product and dataset attributes. Suggested content includes:

- Total distinct products
- Average listed price
- Total recorded stock
- Average discount
- Average return rate
- Average popularity index
- Product count by category
- Average price by category
- Stock by category
- Shipping method distribution

### Page 2 – Product & Inventory Analysis

A closer look at product and inventory attributes:

- Stock levels by product and category
- Average price by category
- Discount comparison
- Return-rate comparison
- Price versus popularity
- Seasonal versus non-seasonal product comparison
- Product detail table

### Page 3 – Customer & Shipping Analysis

A review of the customer and shipping attributes available in the data:

- Age-group record distribution
- Gender record distribution
- Customer-location record distribution
- Shipping method distribution
- Average shipping cost by method
- Return-rate patterns across the available demographic records
- Customer and shipping detail table

**Interpretation note:** Because there is no `Customer ID`, demographic charts count records, not distinct customers. Location counts describe records in the dataset; they are not regional sales. Shipping-cost analysis does not measure delivery speed or on-time performance because delivery dates and service-level data are not provided.

## Key questions explored

- Which categories contain the most product records?
- Which products have the highest listed prices?
- Which products have low recorded stock?
- How do average prices, discounts and return rates vary by category?
- Which products have popularity scores above the overall or category average?
- How do recorded shipping costs compare across shipping methods?
- How are the available age-group, gender and location attributes distributed?

## Data limitations and next steps

The current dataset is useful for product, inventory, pricing, shipping-cost and demographic-attribute analysis. It does **not** contain the fields needed for full transaction and profitability analysis.

To complete the broader sales requirements in the internship brief, the project would need an order or order-line dataset containing fields such as:

- `Order ID`
- `Order Date`
- `Customer ID`
- `Product ID`
- `Quantity Sold`
- `Unit Selling Price` or actual sales amount
- `Unit Cost` or product cost
- Discount amount or a clearly defined discount percentage
- Region, if regional sales analysis is required

With those fields, the analysis could be extended to revenue, order volume, average order value, new versus repeat customers, purchase frequency, regional sales and product profitability. These metrics are intentionally not estimated from the current attribute-only fields.

## Repository structure

A suggested GitHub repository structure is:

```text
E-Commerce-Customer-Sales-Analytics/
│
├── README.md
├── Dataset/
│   └── ecommerce_dataset.csv             # Add your approved source file
│
├── SQL/
│   └── Ecommerce_Analytics_ecommerce_df.sql
│
├── PowerBI/
│   └── Ecommerce_Overview_Dashboard.pbix # Add your Power BI report
│
├── Screenshots/
│   ├── page-1-overview.png
│   ├── page-2-product-inventory.png
│   └── page-3-customer-shipping.png
│
└── Report/
    └── project-summary.pdf               # Optional
```

Adjust the file names to match the files you actually upload. Only include screenshots and report files that are present in your repository.

## How to run the MySQL analysis

1. Import the approved dataset into MySQL Workbench using **Table Data Import Wizard**.
2. Confirm that the imported database is named `ecommerce_df` and the table is named `ecommerce`.
3. Open `SQL/Ecommerce_Analytics_ecommerce_df.sql` in MySQL Workbench.
4. Check the column names with:

   ```sql
   USE ecommerce_df;
   SHOW COLUMNS FROM ecommerce;
   ```

5. Make sure the column names in the script match the imported table.
6. Execute the script using the Workbench Execute button.
7. Review the query outputs and confirm that the two analytical views were created.
8. Connect Power BI to MySQL and select `vw_powerbi_ecommerce_product_analysis` as the reporting source.

Do not upload database passwords, connection secrets or other credentials to GitHub.

## Project status

This repository documents the current product/customer-attribute analysis and the Power BI report structure. Transaction-level sales and profit analysis remains dependent on receiving a dataset with the required order, customer, quantity and cost fields.

---

**Project:** E-Commerce Customer & Sales Analytics  
**Internship:** Conorise Infotech – Data Analytics Internship  
**Tools:** MySQL | Excel | Power BI
