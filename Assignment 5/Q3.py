# Score 24/30

import oracledb
import getpass

# read input arguments: username, pasword, db host, db name
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ")  
hostname = input("Enter the hostname:")
database = input("Enter the database:")

'''
if hostname does not have / at the end, then add it.

Establish the connection to DBMS
'''
if (hostname[-1]=='/'):
    connection = oracledb.connect(user=username,
                password=userpwd,dsn=hostname+database)
elif (hostname[-1]!='/'):
    connection = oracledb.connect(user=username, 
                password=userpwd,dsn=hostname+'/'+database)
                                                             

curs = connection.cursor() #creates a cursor that will be needed to access the databases

#### GET LIST OF ALL TABLES THAT BELONG TO THIS USERNAME ######

print("Tables created by this user:")
for table in curs.execute("SELECT table_name FROM user_tables"):
    print(table)


# your tables don't drop at all
# -6 points
#IF TABLE Reads EXISTS, DROP IT
curs.execute("select count(*) from user_tables where table_name='Reads'") # Reads needs to be READS
has_Reads=curs.fetchone()
if has_Reads[0]==1:
    curs.execute("DROP TABLE Reads")
    print("Table Reads dropped.")

#IF TABLE Articles EXISTS, DROP IT
curs.execute("select count(*) from user_tables where table_name='Articles'") # Articles needs to be ARTICLES
has_Articles=curs.fetchone()
if has_Articles[0]==1:
    curs.execute("DROP TABLE Articles")
    print("Table Articles dropped.")

#IF TABLE Students EXISTS, DROP IT
curs.execute("select count(*) from user_tables where table_name='Students'") # Students needs to be STUDENTS
has_Students=curs.fetchone()
if has_Students[0]==1:
    curs.execute("DROP TABLE Students")
    print("Table Students dropped.")


######### CREATE TABLES #######
print("Before creating table Students.")
curs.execute("CREATE TABLE Students (sid NUMBER(9) PRIMARY KEY, name VARCHAR(20), city VARCHAR(20), state VARCHAR(20), age REAL, gpa REAL CHECK (gpa>=1 AND gpa<=4))")
print("After creating table Students.")
print("Before creating table Articles.")
curs.execute("CREATE TABLE Articles (aid NUMBER(9) PRIMARY KEY, title VARCHAR(20), author VARCHAR(20), pubyear NUMBER(4))")
print("After creating table Articles.")
print("Before creating table Reads.")
curs.execute("CREATE TABLE Reads (aid NUMBER(9),sid NUMBER(9),rday DATE NOT NULL,PRIMARY KEY(aid,sid),FOREIGN KEY(aid) REFERENCES Articles,FOREIGN KEY(sid) REFERENCES Students)")
print("After creating table Reads.")

###### INSERT RECORDS INTO TABLES #####
print("Inserting 2 records into Students.")
curs.execute("INSERT INTO Students(sid, name, city, state, age, gpa) VALUES (1, 'dustin', 'Boston', 'MA', 20, 3.5)")
curs.execute("INSERT INTO Students(sid, name, city, state, age, gpa) VALUES (2, 'lubber', 'Orlando', 'FL', 19, 2)")
print("Inserting 2 records into Articles.")
curs.execute("INSERT INTO Articles(aid, title, author, pubyear) VALUES (001, 'How to Grow Up', 'Michelle Tea', 2012)")
curs.execute("INSERT INTO Articles(aid, title, author, pubyear) VALUES (002, 'Personal Values', 'Mark Manson', 2014)")
print("Inserting 2 records into Reads.")
curs.execute("INSERT INTO Reads(aid,sid,rday) VALUES (001,1,TO_DATE('10/10/2022', 'mm/dd/yyyy'))")
curs.execute("INSERT INTO Reads(aid,sid,rday) VALUES (002,1,TO_DATE('10/11/2022', 'mm/dd/yyyy'))")
print("After inserting data.")

###### QUERY TABLES #####
print("Query that extracts all articles")
for row in curs.execute("SELECT aid, title, author, pubyear FROM Articles"):
    print(row)

print("Query that extracts all Students")
for row in curs.execute("SELECT sid, name, city, state, age, gpa FROM Students"):
    print(row)

print("Query that extracts all Reads")
for row in curs.execute("SELECT aid,sid,rday FROM Reads"):
    print(row)

print("Committing transaction.")
connection.commit()
print("Closing connection.")
connection.close()
