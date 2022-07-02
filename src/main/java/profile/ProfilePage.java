package profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.JSONArray;
import org.json.JSONObject;

import Connect.DatabaseConnection;

/**
 * Servlet implementation class ProfilePage
 */
@WebServlet("/profile")
public class ProfilePage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfilePage() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession ses=request.getSession();	
			String user=(String) ses.getAttribute("user");
			PrintWriter p=response.getWriter();		
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			//find completion
			
			String query;
			query="select * from user_details where user_id=?;";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,user);
			ResultSet res= st.executeQuery();
				
			JSONObject json=new JSONObject();
			
			// Iteration for every train
			while(res.next()) {
				
				//getting values from result_set
				json.put("user_id",res.getString(1));
				json.put("name",res.getString(3));
				json.put("dob",res.getString(4));
				json.put("gender",res.getString(5));
				json.put("address",res.getString(6));
				json.put("phone_no",res.getString(7));
				json.put("email_id",res.getString(8));
			}
			System.out.println(json);
			p.print(json);
		}
		catch (Exception e) {
			e.printStackTrace();
			}
	}

}
