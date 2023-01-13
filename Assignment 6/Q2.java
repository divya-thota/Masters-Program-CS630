// Score 72/72

import java.io.*;
import java.sql.*;
import java.util.Scanner;

/*
 * This class establishes a connection the the DB.
 * If connection is established successfully, the connection is closed and program exits.
 *
 */
class Q2{

	/*
	 * Main method. Entry point.
	 */
	public static void main(String args[]) {
		// instantiate a db connection
		Connection conn = null;
        // create a db connection
		conn = getConnection();
		// if conn is null, then it means a connection could not be established. Exit the program with 1 code.
		if (conn==null)
			System.exit(1);

        Scanner input = new Scanner(System.in);
		try {
            // Runs a query against the database to extract all information about Customers. It prints 
            // the extracted information to screen.
            Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select cid, name, city, state, age from Customers");
		    // if the result has any record print each record, line by line
		    if (rs.next()){
		    	do{
		        	System.out.println(
					"Cid = " + rs.getInt("cid")+
					", Name = " + rs.getString("name")+
					", City = " + rs.getString("city")+
                    ", State = " + rs.getString("state")+
					", Age = " + rs.getInt("age")
		        	);
		      	}while(rs.next());
	 	    }	
		    else
			System.out.println("No Records Retrieved");

            // Runs a query against the database to extract the id and name of Customers and the id 
            // and title of Movies they watched as well as the date they watched the movies 
            // (watchedon attr.). It prints the extracted information to screen.
            ResultSet rs1 = stmt.executeQuery("SELECT c.cid, c.name, m.mid, m.title, w.watchedon FROM Customers c, Movies m, Watch w WHERE m.mid = w.mid AND c.cid = w.cid");
		    // if the result has any record print each record, line by line
		    if (rs1.next()){
		    	do{
		        	System.out.println(
					"Cid = " + rs1.getInt("cid")+
					", Name = " + rs1.getString("name")+
					", Mid = " + rs1.getInt("mid")+
                    ", Title = " + rs1.getString("title")+
					", Watchedon = " + rs1.getString("watchedon") //ELEPHANT
		        	);
		      	}while(rs1.next());
	 	    }	
		    else
			System.out.println("No Records Retrieved");

            // Runs a query against the database to find out how many movies are in the db. It prints the result to screen.
            ResultSet rs2 = stmt.executeQuery("select count(mid) from Movies");
            if (rs2.next()){
                System.out.println("count(mid):");
                int countMid = rs2.getInt(1);
                System.out.println(countMid);
            }

            // Runs a query against the Oracle db to extract the metadata for table Customers. It prints the result to screen.
            DatabaseMetaData md=conn.getMetaData();
            ResultSet crs = md.getColumns(null,null,"CUSTOMERS", null);
            System.out.println("Table: CUSTOMERS");
            while (crs.next()) {
                System.out.println(
                    "COL_NAME="+crs.getString("COLUMN_NAME")+
                    ", TYPE="+crs.getString("TYPE_NAME")
                );
            }

            // Prompts the username to enter a year. It returns the id, title and director of the movies 
            // that were released in that year
            System.out.print("Enter a year: ");
            int release_year=input.nextInt();
            ResultSet rs3 = stmt.executeQuery("select mid, title, director from Movies where releaseyear ="+release_year);
            // if the result has any record print each record, line by line
		    if (rs3.next()){
		    	do{
		        	System.out.println(
					"Mid = " + rs3.getInt("mid")+
					", Title = " + rs3.getString("title")+
					", Director = " + rs3.getString("director")
		        	);
		      	}while(rs3.next());
	 	    }	
		    else
			    System.out.println("No Records Retrieved");

            // Closes the db connection. Prints a message and exits the program.
            if (conn != null) {
                conn.close();
            }
            System.out.print("Execution Successful!!");

		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
        
	/*
	 * Method used to create a db connection.
	 * Returns: a Connection object. It returns null if a connection could not be established.
	 *
	 */
	public static Connection getConnection(){

		// first we need to load the driver
		String jdbcDriver = "oracle.jdbc.OracleDriver";
		try {
			Class.forName(jdbcDriver); 
		} catch (Exception e) {
			e.printStackTrace();
		}


		// Get username and password
		// prompt user to enter the information
		Scanner input = new Scanner(System.in);
		System.out.print("Username:");
		String username = input.nextLine();
		System.out.print("Password:");
		//the following lines are used to mask the password
		Console console = System.console();
		String password = new String(console.readPassword());
		// the host name of the Oracle server
		System.out.print("Hostname:");
		String hostname = input.nextLine();
		// the database name
		System.out.print("DB name:");
		String oracleDBName = input.nextLine();
		// create the connection string	
		String connString = "jdbc:oracle:thin:@" + hostname + ":1521:"
				+ oracleDBName;

		System.out.println("Connecting to the database...");
	
		Connection conn;
		// Connect to the database
		try{
			conn = DriverManager.getConnection(connString, username, password);
			System.out.println("Connection Successful");
		}
		catch(SQLException e){
			// if an error occurs, print the error and return null.
			System.out.println("Connection ERROR");
			e.printStackTrace();	
			return null;
		}
		return conn;
	}
}
