DROP TABLE Write;
DROP TABLE Books;
DROP TABLE Authors;
-- Q1 a)
create table Books(
     bid int primary key,
     bname varchar(30),
     author varchar(30),
     pubyear int,
     pubcompany varchar(30)
);

create table Authors(
     aid int primary key,
     name varchar(30),
     rating int,
     state char(2)
);

create table Write(
    aid int,
    bid int,
    primary key(aid,bid),
    foreign key(aid) references authors,
    foreign key(bid) references books
);

--- TEST CASES
INSERT INTO books VALUES (4321, 'times here', 'Bill', 1999, 'penguin');
INSERT INTO books VALUES (5321,'short selling', 'Jordy', 1990, 'simon');
INSERT INTO books VALUES (6321, 'Tonights show', 'Bill', 2012, 'Cambridge');
INSERT INTO books VALUES (7321, 'James Potter', 'Rowling', 2000, 'London');
INSERT INTO books VALUES (8321, 'School maths', 'Sharma', 1990, 'penguin');
INSERT INTO books VALUES (9321, 'Travelling', 'Sood', 2018, 'Tata Press');
INSERT INTO books VALUES (1321, 'trains', 'Agatha', 1991, 'simon');
INSERT INTO books VALUES (2321, 'crisis', 'Sydney', 1999, 'simon');
INSERT INTO books VALUES (3321, 'people in peril', 'Sydney', 2020, 'penguin');
INSERT INTO books VALUES (0321, 'Physics', 'Chauhan', 2021, 'Tata Press');
INSERT INTO books VALUES (1322, 'crashes', 'Jordy', 1999, 'penguin');
INSERT INTO books VALUES (2322, 'happiness in wild', 'Matt', 2020, 'penguin');
INSERT INTO books VALUES (2323, 'Harry', 'Matt', 2021, '');
INSERT INTO books(bid,bname,author,pubyear) VALUES (2324, 'hello here', 'Joe', 2020);

INSERT INTO authors VALUES (1234, 'Bill', 23, 'IL');
INSERT INTO authors VALUES (1235, 'Jordy', 30, 'MA');
INSERT INTO authors VALUES (1236, 'Rowling', 18, 'MA');
INSERT INTO authors VALUES (1239, 'Sharma', 26, 'MA');
INSERT INTO authors VALUES (1237, 'Sood', 42, 'NY');
INSERT INTO authors VALUES (1238, 'Agatha', 25, 'CA');
INSERT INTO authors VALUES (1231, 'Sydney', 36, 'CA');
INSERT INTO authors VALUES (2231, 'Chauhan', 18, 'MA');
INSERT INTO authors VALUES (3231, 'Matt', 42, 'MA');
INSERT INTO authors VALUES (3232, 'Sarvagya', 30, 'TE');

INSERT INTO write VALUES (1234, 4321);
INSERT INTO write VALUES (1234, 6321);
INSERT INTO write VALUES (1235, 5321);
INSERT INTO write VALUES (1239, 8321);
INSERT INTO write VALUES (1237, 9321);
INSERT INTO write VALUES (1238, 1321);
INSERT INTO write VALUES (1231, 2321);
INSERT INTO write VALUES (1231, 3321);
INSERT INTO write VALUES (1235, 1322);
INSERT INTO write VALUES (1236, 7321);
INSERT INTO write VALUES (2231, 0321);
INSERT INTO write VALUES (3231, 2322);
INSERT INTO write VALUES (3231, 2323);


select count(*) from books;
-- 14
select count(*) from authors;
--10
select count(*) from write;
--13


-- Q1 b)
SELECT *
FROM Books
WHERE pubcompany IS NOT NULL;


-- Q1 c)
SELECT *
FROM Books
WHERE pubcompany IS NULL;



-- Q1 d)
SELECT COUNT(*), state, rating
FROM Authors
GROUP BY state, rating;


--Q1 e)
SELECT a.name, b.bid, b.bname
FROM Authors a JOIN Write w on a.aid=w.aid
     JOIN Books b on b.bid=w.bid;



-- Q1 f)
SELECT *
FROM Authors a LEFT JOIN Write w on a.aid=w.aid;


-- Q1 g)

INSERT INTO Books(bid,bname,author,pubyear,pubcompany) VALUES (1,'travel','joe',2020,'penguin');
INSERT INTO Authors(aid,name,rating,state) VALUES (10,'Joe Willis',8,'MA');
INSERT INTO Write(aid,bid) VALUES (1,10);

-- Q1 h)
UPDATE Books SET author='mary', pubyear=2019
WHERE bid=1;

--- Q1 i)

UPDATE Books SET pubyear=2000 WHERE pubcompany='penguin';

-- Q1 j)
UPDATE Authors SET rating=10;


-- Q1 k)
DELETE FROM Authors a
WHERE a.aid not in (SELECT w.aid from Write w);

-- Q1 l)
-- If bname contains null values, count(*) will return a higher number than count(bname). count(*) will count the number
-- of records. COUNT(bname) will only count the number of records in which bname is not null.

-- Q1 m)
ALTER TABLE Authors
ADD age number(4,2);


-- Q1 n)
DROP TABLE Write;
DROP TABLE Authors;
DROP TABLE Books;

create table Authors(
     aid int primary key,
     name varchar(30),
     rating int check (rating >=1 AND rating <=5),
     state char(2)
);
