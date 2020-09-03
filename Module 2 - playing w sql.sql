SELECT * FROM AddressBook

SELECT * FROM Courses

SELECT * FROM Friends

SELECT * FROM Planets

UPDATE Planets SET PlanetType = 'Ice Giant'
WHERE IndividualID = 1014


ALTER TABLE Planets
DROP COLUMN TimeCreated

SELECT DF_Planets_TimeCreated FROM Planets

SELECT AVG(Radius) FROM Planets;

ALTER TABLE Planets
ALTER COLUMN Radius int;

SELECT FirstName, LastName, MobilePhone
INTO PhoneList
FROM AddressBook;

SELECT * FROM AddressBook;

SELECT * FROM PhoneList;