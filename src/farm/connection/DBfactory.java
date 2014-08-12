package farm.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBfactory {
	public Connection DBconnection(){
		Connection con=null;
		try{		
			Class.forName("com.mysql.jdbc.Driver");	
			con=DriverManager.getConnection("jdbc:mysql://localhost:3307/farming", "root","root123");		
		}catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
