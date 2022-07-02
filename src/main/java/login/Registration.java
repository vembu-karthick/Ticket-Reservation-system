package login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.JSONObject;

import Connect.DatabaseConnection;

/**
 * Servlet implementation class Registration
 */
@WebServlet("/registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String user=request.getParameter("user");
			String pass=request.getParameter("pass");
			String name=request.getParameter("name");
			String dob=request.getParameter("dob");
			String gender=request.getParameter("gender");
			String address=request.getParameter("address");
			String	ph =request.getParameter("ph");
			String email=request.getParameter("email");
			PrintWriter p=response.getWriter();
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			String query;
			PreparedStatement st;
			ResultSet rs;
			query="select name from user_details where user_id=?";
			st=con.prepareStatement(query);
			st.setString(1,user);
			//p.write(user);
			rs=st.executeQuery();
			JSONObject js=new JSONObject();
			if(rs.next()) {
				js.put("res", false);
				p.print(js);
			}
			else {
				query="insert into user_details(user_id,password,name,DOB,Gender,address,phone_no,email) values(?,?,?,?,?,?,?,?);";
				st=con.prepareStatement(query);
				st.setString(1,user);
				st.setString(2,pass);
				st.setString(3,name);
				st.setString(4,dob);
				st.setString(5,gender);
				st.setString(6,address);
				st.setString(7,ph);
				st.setString(8,email);
				st.executeUpdate();
				js.put("res", true);
				p.print(js);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	//	doGet(request, response);
	}
}
