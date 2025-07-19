# Gold Layer Data Dictionary

This document provides a detailed data dictionary for the Gold layer of the Data Warehouse. The Gold layer contains highly curated, integrated, and optimized data designed for direct analytical consumption, business intelligence (BI) reporting, and advanced analytics.

## 1. `gold.dim_customers`

**Description**: Stores customer details enriched with demographic and geographic data

| Column Name | Data Type (Inferred) | Description |
| :---------- | :------------------- | :---------- |
| `customer_key` | `INT` (Surrogate Key) | Unique customer identifier. Primary Key. |
| `customer_id` | `INT` | CRM customer ID. |
| `customer_number` | `NVARCHAR(50)` | Consistent customer identifier. |
| `first_name` | `NVARCHAR(50)` | Customer's first name. |
| `last_name` | `NVARCHAR(50)` | Customer's last name. |
| `country` | `NVARCHAR(50)` | Customer's country. |
| `marital_status` | `NVARCHAR(50)` | Customer's marital status. |
| `gender` | `NVARCHAR(50)` | Customer's gender. |
| `birthday` | `DATE` | Customer's birth date. |
| `create_date` | `DATE` | Customer record creation date. |

## 2. `gold.dim_products`

**Description**: Provides detailed attributes for product performance and category analysis.

| Column Name | Data Type (Inferred) | Description |
| :---------- | :------------------- | :---------- |
| `product_key` | `INT` (Surrogate Key) | Unique product identifier. Primary Key. |
| `product_number` | `NVARCHAR(50)` | CRM product ID. |
| `product_name` | `NVARCHAR(50)` | Name of the product. |
| `product_cost` | `INT` | Standard product cost. |
| `product_line` | `NVARCHAR(50)` | Product line. |
| `product_start_date` | `DATETIME` | Product active date. |
| `product_end_date` | `DATETIME` | Product discontinued date. |
| `product_category` | `NVARCHAR(50)` | High-level product category. |
| `product_subcategory` | `NVARCHAR(50)` | Granular product subcategory. |


## 3. `gold.fact_sales`

**Description**:Stores aggregated and detailed sales transaction data.

| Column Name | Data Type (Inferred) | Description |
| :---------- | :------------------- | :---------- |
| `order_number` | `NVARCHAR(50)` | Unique sales order ID. |
| `product_key` | `INT` (Foreign Key) | Links to `dim_products`. |
| `customer_key` | `INT` (Foreign Key) | Links to `dim_customers`. |
| `order_date` | `DATETIME` | Order placement date. |
| `shipping_date` | `DATETIME` | Order shipment date.  |
| `due_date` | `DATETIME` | Order payment due date.  |
| `sales_amount` | `INT` | Total sales amount for item. |
| `quantity` | `INT` | Quantity of product sold. |
| `price` | `INT` | Unit price at sale. |
| `sales_amount` | `INT` | The total sales amount for the order line item (`sls_sales`). |
| `quantity` | `INT` | The quantity of the product sold in the order line item (`sls_quantity`). |
| `price` | `INT` | The unit price of the product at the time of sale (`sls_price`). |
