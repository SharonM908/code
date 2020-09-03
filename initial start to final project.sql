/* start of final project */

USE TrialRun;

SELECT studentID, first_Name, lastName
	INTO studentName
	FROM gradeRecordModuleV;

SELECT studentID, midtermexam, finalExam
	INTO studentExamGrades
	FROM gradeRecordModuleV;

SELECT studentID, ASSIGNMENT1, ASSIGNMENT2
	INTO studentAssGrade
	FROM gradeRecordModuleV;

SELECT studentID, grade
	INTO letterGrade
	FROM gradeRecordModuleV;

USE University;

SELECT * FROM LetterGrade;

SELECT DISTINCT Grade from LetterGrade;

SELECT DISTINCT Grade
	INTO Grade
	FROM LetterGrade;

SELECT * 
	FROM Grade;

SELECT * FROM GradeValues;

SELECT Grade from LetterGrade;

ALTER TABLE Grade
	ADD GradeID INT IDENTITY(100,1);

ALTER TABLE Grade
	ADD PRIMARY KEY (GradeID);

ALTER TABLE LetterGrade
	ADD GradeID INT;

UPDATE LetterGrade 
	SET LetterGrade.GradeID = GradeValues.GradeID
	WHERE LetterGrade.Grade = GradeValues.Grade;

SELECT * FROM GradeValues;

SELECT DISTINCT Lettergrade.Grade, GradeValues.GradeID
	FROM LetterGrade INNER JOIN GradeValues ON LetterGrade.Grade = GradeValues.Grade
	ORDER BY GradeID;


