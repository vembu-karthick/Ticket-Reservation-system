package login;

import jakarta.servlet.RequestDispatcher;
import Connect.DatabaseConnection;
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

/**
 * Servlet implementation class Validity
 */
@WebServlet("/login")
public class Validity extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Validity() {
        super();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
			String user=request.getParameter("user");
			String pass=request.getParameter("pass");
			HttpSession ses=request.getSession();
			PrintWriter p=response.getWriter();
			JSONObject obj=new JSONObject();
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			String query="select password,name from user_details where user_id=?;";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,user);
			ResultSet res= st.executeQuery();
			if(res.next()){
				if(res.getString(1).equals(pass)) {
					 obj.put("val", true);
					 obj.put("res", "");
					 ses.setAttribute("user",user);
				}
				else {
					obj.put("val", false);
					obj.put("res", "Password is incorrect");
				}
			}
			else{
				obj.put("val", false);
				obj.put("res", "Username is incorrect");
			}
			response.getWriter().print(obj);
    	}
		catch (Exception e) {
				e.printStackTrace();
		}
	}
}
