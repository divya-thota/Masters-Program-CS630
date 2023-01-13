DROP TABLE Rents;
DROP TABLE Cars;
DROP TABLE Customers;

-- Q2 a)
CREATE TABLE Cars(
    carid int primary key,
    make varchar(30),
    model varchar(30),
    myear int check (myear >=2010),
    dailyfee number(6,2)
);

-- Q2 b)
CREATE TABLE Customers(
    custid int primary key,
    name varchar(30) NOT NULL,
    city varchar(30) NOT NULL,
    state char(2) NOT NULL,
    dob date NOT NULL
);


SELECT DISTINCT c.carid, c.make, c.model FROM Cars c JOIN Rents r
ON c.carid=r.carid
WHERE EXTRACT (year from r.rday)=2022
MINUS
SELECT DISTINCT c.carid, c.make, c.model FROM Cars c JOIN Rents r
ON c.carid=r.carid
WHERE EXTRACT (year from r.rday)=2021;

-- Q2 c)
CREATE TABLE Rents(
    carid int,
    custid int,
    rday date NOT NULL,
    primary key(carid,custid),
    foreign key(carid) references cars,
    foreign key(custid) references customers);

-- TEST DATA
INSERT INTO customers VALUES (1234, 'Sarvagya', 'Chicago', 'IL', TO_DATE('1991/01/01', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (1235, 'James', 'Boston', 'MA', TO_DATE('2004/02/29', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (1236, 'Chris', 'Newton', 'MA', TO_DATE('2000/12/31', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (1239, 'cyrus', 'San Francisco', 'CA', TO_DATE('1990/01/31', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (1237, 'Anderson', 'New York', 'NY', TO_DATE('2002/05/08', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (1238, 'Abby', 'Los Angeles', 'CA', TO_DATE('2000/05/05', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (1231, 'Shaam', 'Marin', 'CA', TO_DATE('1995/10/09', 'yyyy/mm/dd'));
INSERT INTO customers VALUES (2231, 'Andy', 'Seattle', 'WA', TO_DATE('2005/05/01', 'yyyy/mm/dd'));

INSERT INTO cars VALUES (4321, 'toyota', 'corolla', 2012, 30.1);
INSERT INTO cars VALUES (5321,'honda', 'civic', 2019, 21);
INSERT INTO cars VALUES (6321, 'BMW', 'x5', 2012, 50.69);

INSERT INTO rents VALUES (4321,1234, TO_DATE('2010/05/03', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (6321,1234, TO_DATE('2015/05/03', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (5321,1234, TO_DATE('2020/08/03', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (5321,1235,  TO_DATE('2020/04/03', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (6321,1236,  TO_DATE('2021/12/03', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (5321,1237,  TO_DATE('2021/12/12', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (4321,1231,  TO_DATE('2015/05/03', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (6321,1239,  TO_DATE('2018/12/01', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (4321,1238,  TO_DATE('2019/01/01', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (4321,1236,  TO_DATE('2022/01/01', 'yyyy/mm/dd'));
INSERT INTO rents VALUES (5321,1231,  TO_DATE('2022/01/01', 'yyyy/mm/dd'));

select count(*) from customers;
-- 8
select count(*) from cars;
--3

select count(*) from rents;
--11



-- Q2 d)
SELECT c.custid, c.name
FROM Customers c
WHERE NOT EXISTS (
   (SELECT k.carid FROM Cars k )
   MINUS
   (SELECT r.carid from Rents r WHERE r.custid=c.custid)
);

-- Q2 e)
INSERT INTO Cars(carid,make,model,myear,dailyfee) VALUES(1,'toyota','corolla',2020,50);

-- Q2 f)
SELECT c.carid, c.make, c.model FROM Cars c, Rents r
WHERE c.carid=r.carid and EXTRACT(YEAR FROM r.rday)=2022
MINUS
SELECT c.carid, c.make, c.model FROM Cars c, Rents r
WHERE c.carid=r.carid and EXTRACT(YEAR FROM r.rday)=2021;
