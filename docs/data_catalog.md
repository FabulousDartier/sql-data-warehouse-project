# Gold Layer Data Dictionary

This document provides a detailed data dictionary for the Gold layer of the Data Warehouse. The Gold layer contains highly curated, integrated, and optimized data designed for direct analytical consumption, business intelligence (BI) reporting, and advanced analytics.

## 1. `gold.dim_customers`

**Description**: A conformed dimension table containing unique customer information, integrated and standardized from CRM and ERP source systems.

| Column Name | Data Type (Inferred) | Description |
| ----- | ----- | ----- |
| `customer_key` | `INT` (Surrogate Key) | Unique, system-generated identifier for each customer. Primary Key of this dimension. |
| `customer_id` | `INT` | Natural key from the CRM system (`cst_id`). Used for lineage and potential joins back to source. |
| `customer_number` | `NVARCHAR(50)` | Natural key from CRM (`cst_key`) or ERP (`cid`). A consistent identifier across source systems. |
| `first_name` | `NVARCHAR(50)` | Customer's first name. |
| `last_name` | `NVARCHAR(50)` | Customer's last name. |
| `country` | `NVARCHAR(50)` | Customer's country, derived from ERP location data (`cntry`). |
| `marital_status` | `NVARCHAR(50)` | Customer's marital status, from CRM (`cst_marital_status`). |
| `gender` | `NVARCHAR(50)` | Customer's gender, conformed from CRM (`cst_gndr`) and ERP (`gen`) sources. |
| `birthday` | `DATE` | Customer's birth date, derived from ERP data (`bdate`). |
| `create_date` | `DATE` | Date when the customer record was first created in the CRM system (`cst_create_date`). |

## 2. `gold.dim_products`

**Description**: This table provides detailed attributes for product performance and category analysis.

| Column Name | Data Type (Inferred) | Description |
| ----- | ----- | ----- |
| `product_key` | `INT` (Surrogate Key) | Unique, system-generated identifier for each product. Primary Key of this dimension. |
| `product_number` | `NVARCHAR(50)` | Natural key from the CRM product ID (`prd_key`). Used for lineage and potential joins back to source. |
| `product_name` | `NVARCHAR(50)` | Name of the product (`prd_nm`). |
| `product_cost` | `INT` | Standard cost of the product (`prd_cost`). |
| `product_line` | `NVARCHAR(50)` | Product line or family (`prd_line`). |
| `product_start_date` | `DATETIME` | Date and time when the product became active or available (`prd_start_dt`). |
| `product_end_date` | `DATETIME` | Date and time when the product was discontinued or became inactive (`prd_end_dt`). |
| `product_category` | `NVARCHAR(50)` | High-level product category, derived from ERP product catalog (`cat`). |
| `product_subcategory` | `NVARCHAR(50)` | More granular product subcategory, derived from ERP product catalog (`subcat`). |

## 3. `gold.fact_sales`

**Description**: A fact view providing aggregated and detailed sales transaction data.

| Column Name | Data Type (Inferred) | Description |
| ----- | ----- | ----- |
| `order_number` | `NVARCHAR(50)` | The unique identifier for each sales order (`sls_ord_num`). Natural key for the sales transaction. |
| `product_key` | `INT` (Foreign Key) | Foreign Key linking to `gold.dim_products`, representing the specific product sold. |
| `customer_key` | `INT` (Foreign Key) | Foreign Key linking to `gold.dim_customers`, representing the customer who placed the order. |
| `order_date` | `INT` | Date when the order was placed (`sls_order_dt`). *Note: Original type is INT, consider converting to DATE/DATETIME for usability.* |
| `shipping_date` | `INT` | Date when the order was shipped (`sls_ship_dt`). *Note: Original type is INT, consider converting to DATE/DATETIME for usability.* |
| `due_date` | `INT` | Date when the payment for the order is due (`sls_due_dt`). *Note: Original type is INT, consider converting to DATE/DATETIME for usability.* |
| `sales_amount` | `INT` | The total sales amount for the order line item (`sls_sales`). |
| `quantity` | `INT` | The quantity of the product sold in the order line item (`sls_quantity`). |
| `price` | `INT` | The unit price of the product at the time of sale (`sls_price`). |
