USE TrialRun;

SELECT * 
	FROM sales_data_sample;

SELECT COUNT(*) 
	FROM sales_data_sample;

SELECT DISTINCT ORDERNUMBER 
	FROM sales_data_sample; -- results 307

SELECT ORDERNUMBER, COUNT(ORDERNUMBER)
	FROM sales_data_sample
	GROUP BY ORDERNUMBER
	HAVING COUNT(ORDERNUMBER)>1
	ORDER BY ORDERNUMBER;

ALTER TABLE sales_data_sample
	ADD ID INT IDENTITY(1,1);

-- add primary keys at the end

/* confirm ID number */ 
SELECT MAX(ID) 
	FROM sales_data_sample;

/* use SELECT INTO to create a new table with only customer data */
SELECT DISTINCT CUSTOMERNAME,
	PHONE,
	ADDRESSLINE1,
	ADDRESSLINE2,
	CITY,
	STATE,
	POSTALCODE,
	COUNTRY,
	TERRITORY,
	CONTACTFIRSTNAME,
	CONTACTLASTNAME
	INTO CUSTOMERS
	FROM sales_data_sample;

/* add attribute as candidate for primary key */
ALTER TABLE CUSTOMERS
	ADD CUSTID INT IDENTITY(100,1);

SELECT COUNT(*) 
	FROM CUSTOMERS;

/* create 2nd table for order information */ 
-- learn about the table and the information stored

SELECT DISTINCT ORDERNUMBER, ORDERLINENUMBER 
	FROM sales_data_sample 
	ORDER BY ORDERNUMBER;
-- combination of ORDERNUMBER and ORDERLINENUMBER is unique

SELECT ORDERNUMBER, COUNT(ORDERNUMBER)  -- results 291 have more than 1 item on the order
	FROM sales_data_sample
	GROUP BY ORDERNUMBER
	HAVING COUNT(ORDERNUMBER) >1;

SELECT ORDERNUMBER, COUNT(ORDERNUMBER)  -- results 16 have only 1 item on the order
	FROM sales_data_sample
	GROUP BY ORDERNUMBER
	HAVING COUNT(ORDERNUMBER) =1;

SELECT ORDERNUMBER,
	   ORDERLINENUMBER,
	   QUANTITYORDERED,
	   PRICEEACH,
	   PRODUCTCODE,
	   CUSTOMERNAME,
	   SALES,
	   ORDERDATE,
	   STATUS
	INTO ORDERS
	FROM sales_data_sample;
	   
SELECT COUNT(*) FROM ORDERS;

SELECT * FROM ORDERS;

SELECT DISTINCT ORDERNUMBER FROM ORDERS;

/* create 3rd table with product information */
USE RetailStore;

SELECT DISTINCT PRODUCTCODE,
	PRODUCTLINE,
	MSRP
	INTO PRODUCTS
	FROM sales_data_sample;		-- results 109

/* PRODUCTCODE can act as primary key */
SELECT DISTINCT (PRODUCTCODE)		
	FROM sales_data_sample;
-- results 109

SELECT DISTINCT PRODUCTCODE 
	FROM PRODUCTS;  
-- results 109 - got them all

SELECT * 
	FROM PRODUCTS;
-- results show duplicate valeus in both MSRP and PRODUCTLINE -> new tables

SELECT MSRP, COUNT(MSRP)	
	FROM PRODUCTS
	GROUP BY MSRP
	HAVING COUNT(MSRP)>1; 
-- results show 20 duplicates, needs another table

SELECT DISTINCT MSRP
	INTO MSRP_VALUES
	FROM PRODUCTS;

SELECT COUNT(*)
	FROM MSRP_VALUES;

-- new table needs an attribute to be primary key, set key at end
ALTER TABLE MSRP_VALUES
	ADD MSRPID INT IDENTITY(100,1);

SELECT * 
	FROM MSRP_VALUES;

/* normalizing PRODUCTS by removing PRODUCTLINE */
SELECT COUNT(PRODUCTLINE)
	FROM PRODUCTS;
-- results 109

SELECT DISTINCT PRODUCTLINE
	FROM PRODUCTS;
-- results show 7 unique, must create another table

SELECT DISTINCT PRODUCTLINE
	INTO AVAILPRODLINES
	FROM PRODUCTS;

-- new table needs an attribute that can be primary key
ALTER TABLE AVAILPRODLINES
	ADD PRODLINEID INT IDENTITY(100,1);

SELECT *
	FROM AVAILPRODLINES;

/* checking that CUSTOMERS IS 1NF - Country and Territory both repeat*/
SELECT * 
	FROM CUSTOMERS;

SELECT DISTINCT TERRITORY	
	FROM CUSTOMERS;
-- 4 unique 

SELECT DISTINCT COUNTRY
	FROM CUSTOMERS
	WHERE TERRITORY = 'apac';
-- 19 unique countries

SELECT TERRITORY, STATE, COUNTRY, CITY
	FROM CUSTOMERS
	WHERE COUNTRY = 'AUSTRIA';
-- 17 states

SELECT DISTINCT CITY
	FROM CUSTOMERS;
-- 73 cities

SELECT ID, COUNTRY, TERRITORY
	FROM sales_data_sample;

SELECT CUSTID, COUNTRY, TERRITORY
	FROM CUSTOMERS
	WHERE TERRITORY = 'Japan';

-- more to do for 1NF

-- create primary keys for new tables
ALTER TABLE sales_data_sample
	ADD PRIMARY KEY (ID);

ALTER TABLE CUSTOMERS
	ADD PRIMARY KEY (CUSTID);

ALTER TABLE PRODUCTS
	ADD PRIMARY KEY (PRODUCTCODE);

ALTER TABLE MSRP_VALUES
	ADD PRIMARY KEY (MSRPID);

ALTER TABLE ORDERS
	ADD ORDID INT IDENTITY(100,1);

ALTER TABLE ORDERS
	ADD PRIMARY KEY (ORDID);

ALTER TABLE ORDERS
	ADD CUSTID INT;

ALTER TABLE ORDERS
	ADD FOREIGN KEY (CUSTID) 
	REFERENCES CUSTOMER(CUSTID); 



