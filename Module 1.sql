CREATE TABLE Student
(
	ID INT,
	NAME VARCHAR(100),
	GRADE INT
);

ALTER TABLE Student 
	ADD Address VARCHAR(75);

INSERT INTO Student VALUES
	( 1001, 'Joe Smith', 79, '123 Main Street' );

INSERT INTO Student VALUES
	( 1002, 'Jane Smith', 75, '124 2nd Street' ),
	( 1003, 'Joe Smyth', 84, '126 Main Street' ),
	( 1004, 'Jayne Doe', 92, '95 3rd Ave' ),
	( 1005, 'Bob Jones', 90, '456 Nowhere Road' );

SELECT * FROM STUDENT;

CREATE TABLE Courses
(
	ID VARCHAR(15),
	Name VARCHAR(50),
	InstructorID INT,
	MaxStudent INT
);

INSERT INTO Courses VALUES
	('DBA9213','Database Fundamentals',201,25),
	('DBA9223','Database Advanced Concepts',254,20),
	('EXC9213','MS Excel Basics',162,40),
	('EXC9223','MS Excel Advanced Concepts',114,25); 

UPDATE Courses SET InstructorID = 201 WHERE InstructorID = 254;

SELECT * FROM Courses;

SELECT * FROM Student;

TRUNCATE TABLE Student;

SELECT * FROM Student;

DROP TABLE Student;