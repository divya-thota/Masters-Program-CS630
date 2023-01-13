---------------------
---Question 1
--------------------

--drop table Has_account;
--drop table Customers;
--drop table Accounts;


--Answer for Q1 a)---

CREATE TABLE Customers(
      cid NUMBER(9) primary key,
      firstname varchar(20),
      lastname varchar(20),
      city varchar(20),
      state char(2)
);

CREATE TABLE Accounts(
      aid NUMBER(9) primary key,
      atype varchar(20),
      amount NUMBER(10,2)
);

CREATE TABLE Has_account(
     cid NUMBER(9),
     aid NUMBER(9),
     since date,
     primary key(cid,aid),
     foreign key(cid) references Customers,
     foreign key(aid) references Accounts
);



--- Answer for Q1 b)
SELECT DISTINCT c.cid, c.firstname, c.lastname
FROM Customers c, Has_account h, Accounts a
WHERE c.cid=h.cid AND a.aid=h.aid AND
      c.state='MA' AND a.amount >1000
ORDER by c.lastname ASC;


--- Answer for Q1 c)
SELECT count(*), atype
FROM Accounts
GROUP by atype;


--- Answer for Q1 d)
select count(*),c.cid
FROM Customers c, Has_account h
WHERE c.cid = h.cid AND
      state='MA'
GROUP BY c.cid
HAVING COUNT(*) >=3;



--- Answer for Q1 e)
SELECT c.cid, c.firstname
FROM Customers c
WHERE 2 <= ( SELECT count(*) FROM Has_account h, Accounts a
             WHERE h.aid=a.aid AND a.atype='checking' AND h.cid=c.cid);

--- Answer for Q1 f)
SELECT c.cid, c.firstname, c.lastname
FROM Customers c, Has_account h
WHERE c.cid=h.cid AND EXTRACT(year from h.since)=2018
INTERSECT
SELECT c.cid, c.firstname, c.lastname
FROM Customers c, Has_account h
WHERE c.cid=h.cid AND EXTRACT(year from h.since)=2020;

---Answer for Q1 g)
SELECT c.cid, c.lastname
FROM Customers c
WHERE NOT EXISTS ( SELECT * from Has_account h
                   WHERE h.cid=c.cid AND since > TO_DATE('01/01/2020','mm/dd/yyyy')
               );

--- Answer for Q1 h)
select c.cid, c.lastname
FROM Customers c, Has_account h, Accounts a
WHERE c.cid=h.cid AND h.aid=a.aid AND a.atype='checking' AND
      EXISTS ( SELECT * FROM Has_account h2, Accounts a2
               WHERE h2.aid=a2.aid AND c.cid=h2.cid AND a2.atype='savings');

--- Answer for Q1 i)
SELECT c.cid, c.lastname
FROM Customers c
WHERE 20000 <= ( SELECT SUM(a.amount) FROM
                   Has_account h, Accounts a
                  WHERE c.cid=h.cid AND h.aid = a.aid );

-- Answer for Q1 j)
SELECT a.aid
FROM Accounts a
WHERE a.atype='checking'
      AND 2<= (SELECT COUNT(*) FROM Has_account h
               WHERE a.aid=h.aid);

