-- Score 28/28

-- Q1
-- a) Write the SQL statement to create the table Movies. Do not forget about the key
-- constraints.
-- Movies(mid:integer, title:string, director:string, studio:string, releaseyear:integer)
-- 4/4
CREATE TABLE Movies (
  mid NUMBER(9) PRIMARY KEY,
  title VARCHAR(20),
  director VARCHAR(20),
  studio VARCHAR(20),
  releaseyear NUMBER(4)
);
-- b) Write the SQL statement to create table Customers. Add the constraint that a customer
-- must be at least 18 years old. Do not forget about the key constraints.
-- Customers(cid:integer,name:string, city: string, state:string, age:real)
-- 4/4
CREATE TABLE Customers (
  cid NUMBER(9) PRIMARY KEY,
  name VARCHAR(20),
  city VARCHAR(20),
  state VARCHAR(20),
  age REAL CHECK (age>=18)
);
-- c) Write the SQL to create table Watch. Do not forget about the key constraints.
-- Watch(cid:integer,mid:integer,watchedon:date)
-- 4/4
CREATE TABLE Watch (
  cid NUMBER(9),
  mid NUMBER(9),
  watchedon DATE,
  PRIMARY KEY(cid,mid),
  FOREIGN KEY(cid) REFERENCES Customers,
  FOREIGN KEY(mid) REFERENCES Movies
);
-- d) Write the SQL statement to create an index on column watchedon of table Watch.
-- Name that index indexWatchDate.
-- 4/4
CREATE INDEX indexWatchDate
ON Watch(watchedon);
-- e) Write the SQL statements to insert a record in table Movies, a record in table
-- Customers, and a record in table Watch. The insert statements should be written in an
-- order such that if executed in that order it will not cause an error.
-- 4/4
INSERT INTO Movies(mid, title, director, studio, releaseyear) VALUES (001, 'Brave', 'Mark Andrews', 'Walt Disney Studios', 2012);
INSERT INTO Customers(cid, name, city, state, age) VALUES (1, 'dustin', 'Boston', 'MA', 20);
INSERT INTO Watch(cid,mid,watchedon) VALUES (1,001,TO_DATE('10/10/2022', 'mm/dd/yyyy'));
-- f) Write the SQL statement to find the id and title of movies that were watched between
-- Jan 1st 2022 and July 31st 2022 (including Jan 1st and July 31st ). The result should
-- contain no duplicates.
-- 4/4
SELECT DISTINCT m.mid, m.title 
FROM Movies m, Watch w 
WHERE w.watchedon >= TO_DATE('01/01/2022','mm/dd/yyyy') 
    AND w.watchedon <= TO_DATE('07/31/2022','mm/dd/yyyy')
    AND m.mid = w.mid;
-- g) Write the SQL statement to extract the id and name of customers and the id, title and
-- director of movies they watched, as well as the date on which they watched the movie
-- (watchedon). Sort the result by watchedon in descending order
-- 4/4
SELECT c.cid, c.name, m.mid, m.title, m.director, w.watchedon
FROM Customers c, Movies m, Watch w
WHERE m.mid = w.mid
    AND c.cid = w.cid
ORDER BY w.watchedon DESC;
