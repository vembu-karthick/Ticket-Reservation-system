package booking;

import jakarta.servlet.RequestDispatcher;
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

import org.json.JSONArray;
import org.json.JSONObject;

import Connect.DatabaseConnection;

/**
 * Servlet implementation class TicketRedirect
 */
@WebServlet("/addpassenger")
public class TicketRedirect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TicketRedirect() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String fromIn=request.getParameter("fromIn");
			String toIn=request.getParameter("toIn");
			String cl=request.getParameter("cl");
			String clv=request.getParameter("clv");
			String pr=request.getParameter("pr");
			String train_no=request.getParameter("train_no");
			String from =request.getParameter("from");
			String to =request.getParameter("to");
			String fromt =request.getParameter("fromt");
			String tot =request.getParameter("tot");
			String date=request.getParameter("date");
			request.setAttribute("date", date);
			request.setAttribute("from", from);
			request.setAttribute("to", to);
			request.setAttribute("fromt", fromt);
			request.setAttribute("tot", tot);
			request.setAttribute("fromIn", fromIn);
			request.setAttribute("toIn",toIn);
			request.setAttribute("cl",cl);
			request.setAttribute("clv",clv);
			request.setAttribute("pr",pr);
			request.setAttribute("train_no", train_no);
			System.out.println("gijds");
			RequestDispatcher rd=request.getRequestDispatcher("/addpass.jsp"); 
			rd.forward(request, response);
			
//			
			/*Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			
			String query;
			query="select * from ticket_details where pnr_no=?";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,pnr);
			ResultSet rs=st.executeQuery();
			JSONObject json=new JSONObject();
			if(rs.next()) {
				json.put("train", rs.getString(2));
				json.put("user", rs.getString(3));
				json.put("src", rs.getString(4));
				json.put("des", rs.getString(5));
				json.put("class", rs.getString(6));
				json.put("jd", rs.getString(7));
				json.put("bd", rs.getString(8));
				query="select * from passenger_details where pnr_no=?";
				st=con.prepareStatement(query);
				st.setString(1,pnr);
				rs=st.executeQuery();
				JSONArray jsonArr=new JSONArray();
				int i=1;
				while(rs.next()) {
					JSONObject jsonPass=new JSONObject();
					jsonPass.put("name",rs.getString(2));
					jsonPass.put("age",rs.getInt(3));
					jsonPass.put("gender",rs.getString(4));
					jsonPass.put("berth",rs.getInt(5));
					jsonPass.put("berth_t",rs.getString(6));
					jsonPass.put("status",rs.getString(7));
					jsonArr.put(jsonPass);
				}
				json.put("pass", jsonArr);
				pr.print(json);
				System.out.print(json);*/
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
