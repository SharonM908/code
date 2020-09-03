USE University;

-- check for duplicates
SELECT COUNT(*) FROM GradeRecord;
-- 54 rows

SELECT DISTINCT StudentID 
	FROM GradeRecord;
-- 54 rows, therefore no duplicates

ALTER TABLE GradeRecord
	ADD PRIMARY KEY (StudentID);

/* starting to 2NF, remove student name */
SELECT StudentID,
	   Firstname,
	   Lastname
	INTO StudentInfo
	FROM GradeRecord;

SELECT StudentID, Midtermexam, Finalexam
	INTO ExamMarks
	FROM GradeRecord;

SELECT StudentID, Assignment1, Assignment2
	INTO AssignmentMarks
	FROM GradeRecord;

SELECT StudentID, Grade
	INTO LetterGrade
	FROM GradeRecord;

/* set Primary and Foreign key constraints */
ALTER TABLE StudentInfo
	ADD CONSTRAINT pk_StudentID PRIMARY KEY (StudentID);

ALTER TABLE AssignmentMarks
	ADD CONSTRAINT fk_StudentID FOREIGN KEY (StudentID)
	REFERENCES StudentInfo(StudentID);

ALTER TABLE ExamMarks
	ADD CONSTRAINT fk_StudentID_EM FOREIGN KEY (StudentID)
	REFERENCES StudentInfo(StudentID);

ALTER TABLE LetterGrade
	ADD CONSTRAINT fk_StudentID_LG FOREIGN KEY (StudentID)
	REFERENCES StudentInfo(StudentID);

-- consolidate into one table
USE University;
SELECT StudentInfo.StudentID, StudentInfo.FirstName, StudentInfo.LastName,
		ExamMarks.Midtermexam, ExamMarks.Finalexam, 
		AssignmentMarks.Assignment1, AssignmentMarks.Assignment2,
		LetterGrade.Grade
		INTO NewTable
		FROM StudentInfo INNER JOIN AssignmentMarks
		ON StudentInfo.StudentID = AssignmentMarks.StudentID
		INNER JOIN ExamMarks
		ON StudentInfo.StudentID = ExamMarks.StudentID
		INNER JOIN LetterGrade
		ON StudentInfo.StudentID = LetterGrade.StudentID;

SELECT COUNT(*) FROM NewTable;

-- successful completion









