--Q1

-- a) Write the SQL statement to create the table Articles. Do not forget about the key
-- constraints.
-- Write the SQL statement to create table Students. Add the constraint that gpa should be
-- between 1 and 4 (including 1 and 4). Do not forget about the key constraints.
-- Write the SQL statement to create table Reads. Add the constraint that no attribute can
-- be null. Do not forget about the key constraints.
-- Answer for Q1 a)
-- Articles(aid:integer, title:string, author:string, pubyear:integer)
-- 4/4
CREATE TABLE Articles (
  aid NUMBER(9) PRIMARY KEY,
  title VARCHAR(20),
  author VARCHAR(20),
  pubyear NUMBER(4)
);

--Students(sid:integer,name:string, city: string, state:string, age:real, gpa:real) 
CREATE TABLE Students (
  sid NUMBER(9) PRIMARY KEY,
  name VARCHAR(20),
  city VARCHAR(20),
  state VARCHAR(20),
  age REAL,
  gpa REAL CHECK (gpa>=1 AND gpa<=4)
);

-- Reads(aid:integer,sid:integer, rday: date)
CREATE TABLE Reads (
  aid NUMBER(9),
  sid NUMBER(9),
  rday DATE NOT NULL,
  PRIMARY KEY(aid,sid),
  FOREIGN KEY(aid) REFERENCES Articles,
  FOREIGN KEY(sid) REFERENCES Students
);

-- b) Write the INSERT statements to inserts 3 students.
-- Write the INSERT statements to inserts 2 articles.
-- Answer for Q1 b)
-- 4/4
INSERT INTO Students(sid, name, city, state, age, gpa) VALUES (1, 'dustin', 'Boston', 'MA', 20, 3.5);
INSERT INTO Students(sid, name, city, state, age, gpa) VALUES (2, 'lubber', 'Orlando', 'FL', 19, 2);
INSERT INTO Students(sid, name, city, state, age, gpa) VALUES (3, 'rusty', 'Austin', 'TX', 25, 4);
INSERT INTO Articles(aid, title, author, pubyear) VALUES (001, 'How to Grow Up', 'Michelle Tea', 2012);
INSERT INTO Articles(aid, title, author, pubyear) VALUES (002, 'Personal Values', 'Mark Manson', 2014);

-- c) Write the INSERT statements to inserts some records into Reads following these
-- conditions: one of the students from (b) read all articles inserted for (b). Another
-- student from (b) read one article inserted for (b). One student from (b) read no article.
-- Answer for Q1 c)
-- 4/4

-- dustin reads all articles
INSERT INTO Reads(aid,sid,rday) VALUES (001,1,TO_DATE('10/10/2022', 'mm/dd/yyyy'));
INSERT INTO Reads(aid,sid,rday) VALUES (002,1,TO_DATE('10/11/2022', 'mm/dd/yyyy'));
-- lubber reads 1 article
INSERT INTO Reads(aid,sid,rday) VALUES (001,2,TO_DATE('10/20/2022', 'mm/dd/yyyy'));
-- rusty doesn't read any article

-- d) Write the SQL statement to create a View called MAStudents that contains all the
-- information for Students from MA
-- Answer for Q1 d)
-- 4/4
CREATE VIEW MAStudents(sid, name, city, state, age, gpa) 
AS SELECT sid, name, city, state, age, gpa 
FROM Students 
WHERE state = 'MA';

-- e) Write the SQL statement to create a View called StudentsReads that contains
-- information about the id, name and city of students and the id and title of article they
-- read.
-- Answer for Q1 e)
-- 4/4
CREATE VIEW StudentsReads(sid, name, city, aid, title) 
AS SELECT s.sid, s.name, s.city, a.aid, a.title
FROM Students s, Reads r, Articles a
WHERE s.sid=r.sid AND r.aid=a.aid; 

-- f) Write an SQL query that uses the view from (e) (view StudentsReads) to extract the
-- count of articles read by each student. Queries that do not use the view StudentsReads
-- are given no credit.
-- Answer for Q1 f)
-- 3.5/4
-- SELECT and GROUP BY name and sid
SELECT sid, COUNT(aid) 
FROM StudentsReads 
GROUP BY sid;

-- g) Write the SQL statements to drop the 2 views: StudentsReads, MAStudents
-- Answer for Q1 g)
-- 4/4
DROP VIEW StudentsReads;
DROP VIEW MAStudents;
