---- Answer for Q2 a)
CREATE TABLE Books (
        bid NUMBER(9) primary key,
        bname VARCHAR(30),
        author VARCHAR(30),
        pubyear NUMBER(9),
        pubcompany VARCHAR(30)
);

CREATE TABLE Students (
        sid NUMBER(9) primary key,
        sname VARCHAR(20),
        age NUMBER(4,2),
        state CHAR(2)
);

CREATE TABLE Reads(
        sid NUMBER(9),
        bid NUMBER(9),
        year NUMBER(9),
        primary key(sid,bid),
        foreign key(sid) references Students,
        foreign key(bid) references Books
);


--- Answer for Q2) b)

INSERT INTO Books(bid,bname, author,pubyear, pubcompany) VALUES(1,'Travel','Joe',2020,'penguin');
INSERT INTO Students(sid, sname, age,state) VALUES(100,'mary',20,'MA');
INSERT INTO Reads(sid,bid,year) VALUES(100,1,2021);


--- Answer for Q2) c)
SELECT *
FROM Students s
WHERE s.state='MA' AND (s.age <25 OR s.age >35);


--- Answer for Q2) d)
SELECT count(*)
FROM Books b
WHERE b.author LIKE 'B%';

--- Answer for Q2 e)
SELECT *
FROM Books b
WHERE b.pubyear = (SELECT min(b2.pubyear) FROM Books b2);

--- Answer for Q2 f)
SELECT AVG(s.age),s.state
FROM Students s
GROUP BY s.state
HAVING COUNT(*)>=50;


--- Answer for Q2 g
SELECT s.sid, s.sname
FROM Students s
WHERE NOT EXISTS (
   (SELECT b.bid FROM Books b)
   MINUS
   (SELECT b2.bid FROM BOOKS b2, Reads r
    WHERE b2.bid=r.bid AND r.sid=s.sid)
);

-- Answer for Q2 h)

SELECT DISTINCT s.sid, s.sname, s.state
FROM Students s
WHERE NOT EXISTS (
   (SELECT b.bid FROM Books b WHERE b.pubcompany='penguin')
   MINUS
   (SELECT b2.bid FROM BOOKS b2, Reads r
    WHERE b2.bid=r.bid AND r.sid=s.sid)
)
ORDER BY s.sname DESC;

--- Answer for  Q2 i)
(SELECT s.sid, s.sname
FROM Students s, Reads r, Books b
WHERE s.sid=r.sid AND r.bid=b.bid and b.pubcompany='penguin')
MINUS
(SELECT s.sid, s.sname
FROM Students s, Reads r, Books b
WHERE s.sid=r.sid AND r.bid=b.bid and b.pubcompany='simon');


--- Answer for Q2 j)
SELECT s.sname
FROM Students s, Reads r, Books b
WHERE s.sid=r.sid AND r.bid=b.bid AND b.pubyear=r.year;


--- Answer for Q2) k)
(SELECT sid, sname
FROM Students)
MINUS
(SELECT DISTINCT s.sid, s.sname
FROM Students s
WHERE NOT EXISTS (
   (SELECT b.bid FROM Books b WHERE b.pubcompany='penguin' AND b.pubyear=2020)
   MINUS
   (SELECT b2.bid FROM BOOKS b2, Reads r
    WHERE b2.bid=r.bid AND r.sid=s.sid)
)
);

---- Answer for Q2 l)

SELECT b.bid, b.bname
FROM Books b
WHERE b.pubcompany='penguin' AND
      NOT EXISTS (
       (SELECT s.sid FROM Students s)
       MINUS
       (SELECT s2.sid FROM Students s2, Reads r
        WHERE s2.sid=r.sid AND  b.bid=r.bid)
);





