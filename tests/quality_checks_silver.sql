/*
=====================================================================
Quality Checks
=====================================================================
Script purpose:
    This script performs quality checks for data consistency, accuracy, and standardization
    across the 'silver' schema tables. It includes checks for:
    - Unwanted spaces in string fields
    - NULL or negative values in numeric fields
    - Data standardization and consistency
    - Invalid date ranges and orders
    - Data consistency across related tables
Usage notes:
    - Run these checks after loading data into the 'silver' schema.
    - Investigate any discrepancies found during the checks.
=====================================================================
*/

PRINT '=========================================='
PRINT 'All checks on silver.crm_cust_info'
PRINT '------------------------------------------'

-- Check for Duplicate Records
SELECT
    cst_key,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_key
HAVING COUNT(*) > 1 OR cst_key IS NULL;

-- Check for Unwanted Spaces in String Fields
SELECT *
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) OR cst_lastname != TRIM(cst_lastname)
OR cst_marital_status != TRIM(cst_marital_status)
OR cst_gndr != TRIM(cst_gndr);

-- Check for NULLs or Negative Numbers in Numeric Fields
SELECT cst_id 
FROM silver.crm_cust_info
WHERE cst_id < 0 OR cst_id IS NULL;

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_cust_info
WHERE cst_create_date < '1924-01-01';

PRINT '=========================================='
PRINT 'All checks on silver.crm_cust_info completed'
PRINT '==========================================='

PRINT 'All checks on silver.crm_prod_info'
PRINT '------------------------------------------'

-- Check for Duplicate Records
SELECT
    prd_key,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_key
HAVING COUNT(*) > 1 OR prd_key IS NULL;

-- Check for Unwanted Spaces in String Fields
SELECT *
FROM silver.crm_prd_info   
WHERE prd_nm != TRIM(prd_nm) OR prd_line != TRIM(prd_line);

-- Check for NULLs or Negative Numbers in Numeric Fields
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt < '1924-01-01' OR prd_end_dt < '1924-01-01'

PRINT '=========================================='
PRINT 'All checks on silver.crm_prod_info completed'
PRINT '==========================================='

PRINT 'All checks on silver.crm_sales_details'
PRINT '------------------------------------------'
SELECT * from silver.crm_sales_details
SELECT * from bronze.crm_sales_details

-- Check for Invalid Dates
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Check for Unwanted Spaces in String Fields
SELECT *
FROM silver.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num) or sls_prd_key != TRIM(sls_prd_key);

-- Check for NULLs or Negative Numbers in Numeric Fields
SELECT 
    sls_sales
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_quantity < 0 OR sls_quantity IS NULL OR sls_price < 0 OR sls_price IS NULL;

-- Check for Invalid Date Ranges
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt < '1924-01-01' OR sls_ship_dt < '1924-01-01' OR sls_due_dt < '1924-01-01'
OR sls_order_dt >  sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Check for Data Accuracy
SELECT *
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);

-- Check for Data Integrity
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales != ABS(sls_price) * sls_quantity;

PRINT '=========================================='
PRINT 'All checks on silver.crm_sales_details completed'
PRINT '==========================================='
PRINT 'All checks on silver.erp_cust_az12'
PRINT '------------------------------------------'

-- Check for Duplicate Records
SELECT
    cid,
    COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;

-- Check for Unwanted Spaces in String Fields
SELECT *
FROM silver.erp_cust_az12
WHERE gen != TRIM(gen) 

-- Check for Invalid Dates
SELECT *
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();

-- Check for Data Standardization & Consistency
SELECT DISTINCT 
gen
FROM silver.erp_cust_az12

PRINT '=========================================='
PRINT 'All checks on silver.erp_cust_az12 completed'
PRINT '==========================================='
PRINT 'All checks on silver.erp_loc_a101'
PRINT '------------------------------------------'

select * from silver.erp_loc_a101
-- Check for Duplicate Records
SELECT
    cid 
FROM silver.erp_loc_a101
GROUP BY cid        
HAVING COUNT(*) > 1 OR cid IS NULL;

-- Check for Unwanted Spaces in String Fields
SELECT *
FROM silver.erp_loc_a101
WHERE cntry != TRIM(cntry) 

-- Check for Data Standardization & Consistency
SELECT DISTINCT
cntry 
FROM silver.erp_loc_a101

PRINT '=========================================='
PRINT 'All checks on silver.erp_loc_a101 completed' 
PRINT '==========================================='
PRINT 'All checks on silver.px_cat_g1v2'
PRINT '------------------------------------------'

-- Check for Duplicate Records
SELECT
    id 
FROM silver.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1 OR id IS NULL;

-- Check for Unwanted Spaces in String Fields
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Check for Data Standardization & Consistency
SELECT DISTINCT
id
FROM silver.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1 OR id IS NULL;

SELECT DISTINCT 
cat, subcat, maintenance
FROM silver.erp_px_cat_g1v2
GROUP BY cat, subcat, maintenance
HAVING COUNT(*) > 1 OR cat IS NULL OR subcat IS NULL OR maintenance IS NULL;

PRINT '=========================================='
PRINT 'All checks on silver.erp_px_cat_g1v2 completed'
PRINT '==========================================='
