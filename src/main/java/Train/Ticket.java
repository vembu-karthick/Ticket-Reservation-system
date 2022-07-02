package Train;

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
 * Servlet implementation class ticket
 */
@WebServlet("/upcoming")
public class Ticket extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Ticket() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession ses=request.getSession();	
			
			if(ses.getAttribute("user")==null){
				 response.sendRedirect(request.getContextPath());
			}
			String user=(String) ses.getAttribute("user");
			String type=request.getParameter("type");
			PrintWriter p=response.getWriter();	
			
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			//find completion
			
			String query;
			if(type.equals("up")) {
			System.out.print("upgoekl");
				query="select * from ticket_details join train_routes tr using(train_no) where user_id=? and src=station and journey_date>=CURRENT_DATE()";
			}
			else{
				query="select * from ticket_details where user_id=? and journey_date<CURRENT_DATE();";
			}
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,user);
			ResultSet res= st.executeQuery();
				
			JSONObject json=new JSONObject();
			JSONArray ticketArr=new JSONArray();
	
			// Iteration for every train
			while(res.next()) {
				JSONObject ticket=new JSONObject();
				//getting values from result_set
				ticket.put("train_no",res.getString(1));
				ticket.put("pnr_no",res.getString(2));
				ticket.put("src",res.getString(4));
				ticket.put("des",res.getString(5));
				ticket.put("class",res.getString(6));
				ticket.put("jd",res.getString(7));
				ticket.put("bd",res.getString(8));
				ticket.put("pr",res.getInt(9));
				ticket.put("pass",res.getInt(10));
				ticketArr.put(ticket);
			}
			json.put("tickets",ticketArr);
			System.out.println(json);
			p.print(json);
		}
		catch (Exception e) {
			e.printStackTrace();
			}
	}

}
