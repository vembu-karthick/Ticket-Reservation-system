package Connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DatabaseConnection {
	public static Connection initializeDatabase(String db) throws SQLException, ClassNotFoundException
	{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/"+db;
		String user="root";
		String pwd="root";
		Connection con=DriverManager.getConnection(url, user, pwd);
		return con;
	}
}
