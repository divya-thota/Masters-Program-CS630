--ANSWER FOR Q3 a)
CREATE TABLE songs (
	songid   NUMBER(9) PRIMARY KEY,
        title        VARCHAR(40),
        release   DATE
);

CREATE TABLE singers (
	singerid  NUMBER(9) PRIMARY KEY,
        name       VARCHAR(40),
        city          VARCHAR(40),
        state       VARCHAR(30)
);

CREATE TABLE singsin(
	singerid 	NUMBER(9),
	songid 	NUMBER(9),
	PRIMARY KEY(singerid,songid),
	FOREIGN KEY (singerid) REFERENCES singers,
	FOREIGN KEY (songid) REFERENCES songs
);


--ANSWER FOR Q3 b)
SELECT name
FROM singers
WHERE state='MA'
ORDER BY name DESC;



-- ANSWER for Q3  c)

SELECT s.name, so.title, so.release
FROM SINGERS s, SONGS so, SINGSIN si
WHERE s.singerid=si.singerid AND so.songid=si.songid;



-- ANSWER for Q3 d)
SELECT COUNT(*)
FROM singers
WHERE singers.city='Boston' AND singers.state='MA';


--ANSWER for Q3  e)
SELECT * from singers
WHERE name LIKE 'A%'
order by state ASC;



-- ANSWER for Q3) f
SELECT s.name, s.city, s.state
FROM SINGERS s, SONGS so, SINGSIN si
WHERE s.singerid=si.singerid AND so.songid=si.songid AND LOWER(so.title) LIKE LOWER('%joy%');

-- ANSWER FOR  Q3 g)
SELECT s.name,s.city, s.state
FROM SINGERS s, SONGS so, SINGSIN si
WHERE s.singerid=si.singerid AND so.songid=si.songid AND so.release < TO_DATE('09/01/2021', 'mm/dd/yyyy');


-- ANSWER FOR Q3 h)
SELECT DISTINCT s.name, s.state
FROM SINGERS s, SONGS so, SINGSIN si
WHERE s.singerid=si.singerid AND so.songid=si.songid AND so.release >= TO_DATE('01/01/2020', 'mm/dd/yyyy')
     AND so.release <= TO_DATE('12/31/2020', 'mm/dd/yyyy');


-- ANSWER FOR Q3 i)
SELECT s.singerid,s.name, s.city
FROM SINGERS s, SONGS so, SINGSIN si
WHERE s.singerid=si.singerid AND so.songid=si.songid
       AND s.state='MA'
       AND so.release >= TO_DATE('01/01/2020', 'mm/dd/yyyy')
       AND so.release <= TO_DATE('07/31/2022', 'mm/dd/yyyy')
ORDER BY s.name DESC;



-- ANSWER FOR Q3 j)
SELECT COUNT(DISTINCT s.singerid)
FROM SINGERS s, SONGS so, SINGSIN si
WHERE s.singerid=si.singerid AND so.songid=si.songid
       AND so.release > TO_DATE('12/10/2021', 'mm/dd/yyyy');


