# Score 2/32
# errors in code, -50%

import oracledb
import getpass
import pandas.io.sql as pdsql

# READ USERNAME, PASSWORD, DB HOST, DB NAME from command line
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ") #Enter the pass set for you to access 
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
                password=userpwd,dsn=hostname+'/'+database) #username to access 
                                                             #Oracle databses (in quotes)

#run query against DB
df = pdsql.read_sql('SELECT * FROM Students', con=connection)
#print the names of columns from the dataframe
print("Name of the columns")
print(df.columns)
#prints the shape 
print("df shape")
print(df.shape)
# prints the first 2 records
print("first 2 records from the dataframe")
print(df.head(2))
print("Average age of students")
print(df[['AGE']].agg(['mean'])) # KeyError: "None of [Index(['age'], dtype='object')] are in the [columns]"
# age needs to be AGE
# -3 points

print("Minimum and maximum gpa for students")
print(df[['GPA']].agg(['min','max'])) # KeyError: "None of [Index(['gpa'], dtype='object')] are in the [columns]"
# gpa needs to be GPA
# -3 points

print("sum of gpa values")
print(df[['GPA']].agg(['sum'])) # KeyError: "None of [Index(['gpa'], dtype='object')] are in the [columns]"
# gpa needs to be GPA
# -3 points

df_StudentsReads = pdsql.read_sql('SELECT s.sid, s.name, s.state, a.aid, a.title FROM Students s, Reads r, Articles a WHERE s.sid=r.sid AND r.aid=a.aid', con=connection)
print('Dataframe data')
print(df_StudentsReads)
print("Number of records in the dataframe")
print(df_StudentsReads.shape[0])
print("Number of columns in the dataframe")
print(df_StudentsReads.shape[1])
#print the names of columns from the dataframe
print("Name of the columns")
print(df_StudentsReads.columns)
print("get a datafarme with only students from state MA")
df_MA = df[df['STATE'] == 'MA'] # KeyError: 'state'
# state needs to be STATE
# -3 points

print(df_MA)

print("Group by to extract how many articles each student from MA read")
df_group = df_MA.groupby(['sid'])['aid'].count() # KeyError: 'Column not found: aid'
# -3 points

print(df_group)

#close the connection
connection.close()
