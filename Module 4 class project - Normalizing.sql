/*
Arta code to check and delete duplicate records
Method 1
DELETE t
	FROM TableA t
	WHERE ID IN ( SELECT a.ID FROM TableA a, (SELECT ID, (SELECT MAX(Value) FROM TableA i WHERE o.Value=i.Value GROUP BY Value HAVING o.ID=MAX(i.ID)) AS MaxValue FROM TableA o) b
    WHERE a.ID=b.ID AND b.MaxValue IS NULL)
    
    
Method 2    
DELETE a
	FROM TableA a
	INNER JOIN
	(SELECT ID, RANK() OVER(PARTITION BY Value ORDER BY ID DESC) AS rnk FROM TableA ) b 
	ON a.ID=b.ID
	WHERE b.rnk>1
    
*/


-- starting a new database for sales_sample_data project
USE RetailStore;

SELECT * INTO RetailStore.dbo.sales_data_sample
FROM TrialRun.dbo.sales_data_sample;

ALTER TABLE sales_data_sample
ADD ID INT IDENTITY(1,1);

SELECT COUNT(ORDERNUMBER)
FROM sales_data_sample;

SELECT ORDERNUMBER, COUNT(ORDERNUMBER)
FROM sales_data_sample
GROUP BY ORDERNUMBER
HAVING COUNT(ORDERNUMBER)>1
ORDER BY ORDERNUMBER;

SELECT *
FROM sales_data_sample
WHERE ORDERNUMBER='10103';

SELECT *
FROM sales_data_sample
WHERE ORDERNUMBER='10388';

/* create 2nd table of customer data */ 
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
FROM sales_data_sample;		/* resulted in unique CUSTOMERNAME being selected */

/* add primary key */
ALTER TABLE CUSTOMERS
ADD CUSTID INT IDENTITY(100,1);

ALTER TABLE CUSTOMERS
	ADD PRIMARY KEY (CUSTID);

SELECT * FROM CUSTOMERS;

/* create 3rd table with product information */
SELECT DISTINCT PRODUCTCODE,
	PRODUCTLINE,
	MSRP,
	PRICEEACH
INTO PRODUCTS
FROM sales_data_sample;

/* looks like PRODUCTCODE can act as primary key in new table */
ALTER TABLE PRODUCTS
	ADD PRIMARY KEY (PRODUCTCODE); -- fail due to multiple PRICEEACH values for each PRODUCTCODE

SELECT DISTINCT (PRODUCTCODE)
FROM sales_data_sample;

SELECT COUNT(*) FROM PRODUCTS;

SELECT * FROM PRODUCTS;

-- going to delete the records with lower prices
/*
DELETE t
	FROM TableA t
	WHERE ID IN 
	( SELECT a.ID 
	  FROM TableA a, 
	  (SELECT ID, 
		(SELECT MAX(Value) FROM TableA i WHERE o.Value=i.Value GROUP BY Value HAVING o.ID=MAX(i.ID)) 
	   AS MaxValue FROM TableA o) b
    WHERE a.ID=b.ID AND b.MaxValue IS NULL)
*/

/*
Method 2    
DELETE a
	FROM TableA a
	INNER JOIN
	(SELECT ID, RANK() OVER(PARTITION BY Value ORDER BY ID DESC) AS rnk FROM TableA ) b 
	ON a.ID=b.ID
	WHERE b.rnk>1
*/
