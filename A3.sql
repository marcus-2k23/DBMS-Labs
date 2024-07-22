-- assignment03.sql
-- Activity 01 Fall 2023
-- Revision History:
-- , Section 01, 18-11-2023


Print 'F23 PROG8080 Section 1';
Print 'Activity 3';
Print '';
Print '';
Print '';
Print GETDATE();
Print '';

USE SIS;

-- 1. List person number and birth date for the youngest person.

Print '*** Question 1 List person number and birth date for the youngest person.***';
Print '';
SELECT TOP 1 number, birthdate
FROM Person
ORDER BY birthdate DESC;


-- 2. List the students whose home country is USA or Canada, but not from Ontario, Canada.
Print '*** Question 2. List the students whose home country is USA or Canada, but not from Ontario, Canada.***';
Print '';
SELECT
    Student.number,
    SUBSTRING(Person.LastName, 1, 20) AS ShortLastName,
    SUBSTRING(Person.FirstName, 1, 20) AS ShortFirstName,
    Person.provinceCode,
    Person.countryCode
FROM
    Student
JOIN
    Person ON Student.number = Person.number
WHERE
    Person.countryCode IN ('USA', 'CAN')
    AND NOT EXISTS (
        SELECT 1
        FROM
            Person
        WHERE
            countryCode = 'CAN'
            AND provinceCode = 'ON'
            AND Person.number = Student.number
    )
ORDER BY
    ShortLastName,
    ShortFirstName;


-- 3. List the courses that are offered in the first semester in the ITSS program.
Print '*** Question 3. List the courses that are offered in the first semester in the ITSS program.***';
Print '';
SELECT number AS 'Course Number'
      ,hours AS 'Hours'
      ,credits AS 'Credits'
      ,name AS 'Course name'
  FROM Course AS C 
  WHERE C.number IN 
  (
	SELECT courseNumber FROM ProgramCourse AS PC
		WHERE PC.semester = 1 AND PC.programCode IN
		(
			SELECT code FROM Program AS P
			WHERE P.acronym = 'ITSS'
		)
  )
  ORDER BY number ASC;


-- 4. List the names of international students enrolled in a post-graduate certificate program.
Print '*** Question 4. List the names of international students enrolled in a post-graduate certificate program.***';
Print '';
SELECT P.number AS 'studentNumber'
	  ,P.firstName AS 'First Name'
	  ,P.lastName AS 'Last Name'
FROM PERSON AS P
WHERE P.number IN
(
	SELECT S.number FROM Student AS S
	WHERE isInternational = 1 AND S.number IN
	(
		SELECT SP.studentNumber FROM StudentProgram AS SP
		WHERE SP.programStatusCode = 'A' AND SP.programCode IN
		(
			SELECT P.code FROM Program AS P
			WHERE P.credentialCode IN
			(
				SELECT C.code FROM Credential AS C
				WHERE C.name = 'Ontario College Graduate Certificate'
			)
		)
	)
)
ORDER BY number;


-- 5. Delete the Person record for Mary Taneja.
Print '*** Question 5. Delete the Person record for Mary Taneja. ***';
Print '';
DELETE FROM Person
WHERE firstName = 'Mary' AND lastName = 'Taneja';
DELETE FROM Course
WHERE number IN ('BUS9070', 'LIBS9010');



-- 6. Insert a Person record for Mary Taneja.
Print '*** Question 6. Insert a Person record for Mary Taneja. ***';
Print '';
INSERT INTO PERSON (
    number, firstName, lastName, street,
    city, countryCode, postalCode,
    mainPhone, alternatePhone, collegeEmail, personalEmail, birthdate
)
VALUES (
    7424478, 'Mary', 'Taneja', 'FLAT NO. 206 TRIVENI APARTMENTS PITAM PURA',
    'NEW DELHI','IND', '110034', '0141-6610242', '94324060195',
    'mtaneja@conestogac.on.ca', 'mtaneja@bsnl.co.in', CONVERT(DATETIME, '1989-10-07', 120)
);
SELECT number, firstName, lastName, street,
    city, countryCode, postalCode,
    mainPhone, alternatePhone, collegeEmail, personalEmail, birthdate
FROM PERSON WHERE number = 7424478;


-- 7. Insert a Student record for Mary Taneja.
Print '*** Question 7. Insert a Student record for Mary Taneja. ***';
Print '';
INSERT INTO Student(
number, isInternational, academicStatusCode, financialStatusCode ,
sequentialNumber, balance, localStreet, localCity, localPostalCode
,localPhone
)
VALUES(
7424478, 1, 'N', 'N',
0,1130.00,'445 GIBSON ST N','Kitchener','N2M 4T4'
,'(226) 147-2985');
SELECT number, isInternational, academicStatusCode, financialStatusCode ,
sequentialNumber, balance, localStreet, localCity, localPostalCode
FROM Student WHERE number = 7424478;



-- 8. Inspect the Program table to find the program code for the CAD program.
Print '*** Question 8. Inspect the Program table to find the program code for the CAD program.***';
Print '';
SELECT CODE FROM Program WHERE acronym = 'CAD';
INSERT INTO StudentProgram(
studentNumber,programCode,
semester,programStatusCode
)
VALUES( 
7424478, (SELECT CODE FROM Program WHERE acronym = 'CAD'),1,'A');
SELECT * FROM StudentProgram
WHERE studentNumber = 7424478;



-- 9. Inspect the CourseOffering table and find the id for INFO8000 in the Fall 2020 session.
Print '*** Question 9. Inspect the CourseOffering table and find the id for INFO8000 in the Fall 2020 session. ***';
Print '';
SELECT [id]
  FROM [CourseOffering] 
  WHERE courseNumber = 'INFO8000' AND sessionCode = 'F20';
INSERT INTO CourseStudent(
CourseOfferingId,studentNumber)
VALUES(
(SELECT [id]
  FROM [CourseOffering] 
  WHERE courseNumber = 'INFO8000' AND sessionCode = 'F20'),7424478);
SELECT * FROM CourseStudent
WHERE studentNumber = 7424478;



-- 10. Insert a Course record for LIBS9010. Use a column list in your INSERT statement.
Print '*** Question 10. Insert a Course record for LIBS9010. Use a column list in your INSERT statement.***';
Print '';
INSERT INTO Course(
number, hours, credits, name, frenchName
)VALUES(
'LIBS9010', 45, 3, 'Critical Thinking Skills','Pens�e Critique');
SELECT * FROM Course WHERE number = 'LIBS9010';



-- 11. Insert a Course record for BUS9070. Do not use a column list in your INSERT statement.
Print '*** Question 11. Insert a Course record for BUS9070. Do not use a column list in your INSERT statement. ***';
Print '';
INSERT INTO Course 
VALUES(
'BUS9070', 45, 3, 'Introduction To Human Relations','Introduction aux relations humaines');
SELECT * FROM Course WHERE number = 'BUS9070';




-- 12. Update the 'Technology Enhancement Fee' to $100.00.
Print '*** Question 12. Update the Technology Enhancement Fee to $100.00. ***';
Print '';
SELECT id
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee';
UPDATE IncidentalFee
SET amountPerSemester = 100.00
WHERE id = (SELECT id
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee');
Print 'BEGIN TRANSACTION';
Print '';
BEGIN TRANSACTION;

UPDATE IncidentalFee
SET amountPerSemester = 120.00
WHERE id = (SELECT id
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee');

Print 'amountPerSemester UPDATED';
Print '';

ROLLBACK;

Print 'ROLLBACK';
Print '';
SELECT *
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee';




Print '*** Question 13 ***';
Print '';

BEGIN TRANSACTION;

UPDATE IncidentalFee
SET amountPerSemester = 190.00
WHERE id = (SELECT id
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee');

COMMIT;

SELECT *
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee';