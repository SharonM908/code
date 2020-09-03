USE TrialRun;

SELECT AVG(Jan_11) 
	FROM MonthlySales;

SELECT * 
	FROM MonthlySales 
	WHERE Jan_11 > 94072;

SELECT COUNT(*) 
	FROM POLICE;

SELECT DISTINCT County 
	FROM MonthlySales;

SELECT DISTINCT race 
	FROM police;

SELECT COUNT(*) 
	FROM POLICE 
	WHERE RACE = 'N';

/* ORDER BY */
SELECT * 
	FROM MonthlySales 
	ORDER BY County;

SELECT * 
	FROM MonthlySales 
	ORDER BY County DESC;

SELECT DISTINCT WHO_Region 
	FROM incidence
	WHERE no_of_cases >=10 AND no_of_cases<=100;

SELECT WHO_Region 
	FROM incidence 
	WHERE no_of_cases >=10 AND no_of_cases<=100;

SELECT Country, no_of_cases 
	FROM incidence 
	WHERE no_of_cases >=100 AND no_of_cases<=1000
	ORDER BY Country;

SELECT country, no_of_cases 
	FROM incidence
	WHERE no_of_Cases >= 200 AND no_of_cases <= 1000
	ORDER BY country ASC;

SELECT DISTINCT Country 
	FROM incidence 
	WHERE Country >= 'Bhutan' AND Country <= 'Cambodia'
	ORDER BY Country;

SELECT DISTINCT Country 
	FROM incidence 
	WHERE Country BETWEEN 'Bhutan' AND 'Cambodia'
	ORDER BY Country;

SELECT COUNT(Country) 
	FROM incidence 
	WHERE Country BETWEEN'Bhutan' AND 'Cambodia';

SELECT country, no_of_cases 
	FROM incidence
	WHERE Country BETWEEN 'Bhutan' AND 'Cambodia' AND Country <> 'Botswana'
	ORDER BY Country ASC;

/* UNION */
SELECT name 
	FROM police 
	WHERE armed <> 'gun'
UNION 
	SELECT name 
	FROM police 
	WHERE manner_of_death = 'shot'
	ORDER BY name;

/* INTERSECT  */
SELECT MobilePhone, FirstName
	FROM AddressBook
	WHERE FirstName = 'Mia'
INTERSECT
	SELECT MobilePhone, FirstName
	FROM PhoneList
	WHERE FirstName = 'Mia';

/* create and use views and stored procedure */
SELECT * FROM vwList;

SELECT * FROM vwList2;

SELECT * FROM vwFriends;

SELECT * FROM Friends;

SELECT * FROM AddressBook;

EXECUTE spFirstName 'Mia';

CREATE VIEW vwKilledByPolice2
AS
	SELECT name, city, age
	FROM dbo.police
	WHERE (age < 37);

SELECT * 
	FROM vwKilledByPolice2
	ORDER BY name;

select avg(age) from police;

SELECT name, city 
	FROM police
	ORDER BY name;

-- system functions
SELECT AVG(Jan_11) FROM MonthlySales;

SELECT COUNT(Year) FROM incidence;

SELECT AVG(No_of_cases) FROM incidence;

SELECT MIN(No_of_cases) FROM incidence;

SELECT COUNT(*) FROM incidence WHERE No_of_cases=0;

SELECT * FROM incidence WHERE No_of_cases=0;

SELECT SUM(No_of_cases) FROM incidence;

SELECT UPPER(Country) FROM incidence WHERE No_of_cases = 0;

SELECT LOWER(Country) FROM incidence WHERE No_of_cases = 0;

SELECT SUBSTRING(LastName,3,5) FROM AddressBook;

SELECT UPPER(SUBSTRING(LastName,3,5)) FROM AddressBook;

SELECT LEN(LastName) FROM AddressBook;

SELECT SUBSTRING(LastName,(LEN(Lastname)/2),3) FROM AddressBook;

SELECT ROUND(No_of_cases,1) FROM incidence;

SELECT ROUND(AVG(No_of_cases),4) FROM incidence;

/* CREATE FUNCTIONS */
CREATE FUNCTION SVF1(@X INT)
	RETURNS INT
	AS
	BEGIN
		RETURN @X * @X * @X
	END;

SELECT dbo.SVF1(5); -- this one works

CREATE FUNCTION CalculateAge (@DOB DATE)
	RETURNS INT
	AS
	BEGIN
		DECLARE @AGE INT
		SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE()) -   /* if DOB month > today, subtract 1 */
		CASE
			WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
				 (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
			THEN 1
			ELSE 0
		END
		RETURN @AGE
	END;

SELECT dbo.CalculateAge ('05/05/1998');

CREATE FUNCTION fLength (@FN VARCHAR(20))
	RETURNS INT
	AS
	BEGIN
		DECLARE @total INT
		SET @total = LEN(@FN)
		RETURN @total
	END;

SELECT dbo.fLength('Burch');

/* UNION */
SELECT DISTINCT(POSTALCODE) 
	FROM CUSTOMER 
	WHERE STATE <> 'CA';

SELECT * 
	FROM CUSTOMER 
	WHERE POSTALCODE='10022';

/* 1ST DATA SET */
SELECT CUSTOMERNAME, PHONE
	FROM CUSTOMER 
	WHERE STATE = 'CA';  -- returns 11 rows
/* 2ND DATA SET */
SELECT CUSTOMERNAME, PHONE			-- returns 5 rows
	FROM CUSTOMER 
	WHERE POSTALCODE = '10022';

SELECT CUSTOMERNAME, PHONE, STATE, POSTALCODE 
	FROM CUSTOMER 
	WHERE STATE = 'CA'			
UNION
SELECT CUSTOMERNAME, PHONE, STATE, POSTALCODE
	FROM CUSTOMER 
	WHERE POSTALCODE = '10022'; -- returns 16 rows

-- reversing the selects
SELECT CUSTOMERNAME, PHONE, STATE, POSTALCODE -- returns exactly the same data
	FROM CUSTOMER 
	WHERE POSTALCODE = '94217'
UNION
SELECT CUSTOMERNAME, PHONE, STATE, POSTALCODE
	FROM CUSTOMER 
	WHERE STATE = 'CA';

-- INTERSECT
SELECT NAME, RACE 
	FROM POLICE 
	WHERE RACE='W'  
INTERSECT
SELECT NAME, ARMED 
	FROM POLICE 
	WHERE ARMED='sword'; -- zero

-- try same columns in both selects
SELECT NAME, ARMED, RACE 
	FROM POLICE 
	WHERE RACE='W'
INTERSECT
SELECT NAME, ARMED, RACE 
	FROM POLICE 
	WHERE ARMED='sword'; -- 11 results

/* EXCEPT */
SELECT CUSTOMERNAME, PHONE, STATE, CONTACTFIRSTNAME 
	FROM CUSTOMER 
	WHERE STATE='CA'
EXCEPT
SELECT CUSTOMERNAME, PHONE, STATE, CONTACTFIRSTNAME 
	FROM CUSTOMER 
	WHERE CONTACTFIRSTNAME='Julie';
