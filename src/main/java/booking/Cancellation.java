package booking;

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

import com.mysql.cj.protocol.Resultset;

import Connect.DatabaseConnection;

/**
 * Servlet implementation class Cancellation
 */
@WebServlet("/cancel")
public class Cancellation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cancellation() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			
			HttpSession ses=request.getSession();
			if(ses.getAttribute("user")==null){
				 response.sendRedirect(request.getContextPath());
			}
			PrintWriter out=response.getWriter();
			Integer berth=Integer.valueOf(request.getParameter("berth"));
			String pnr=request.getParameter("pnr");
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			String query="select class,journey_date,src,des,train_no from ticket_details where pnr_no=?";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,pnr);
			ResultSet res= st.executeQuery();
			res.next();
			String cl=res.getString(1);
			String jd=res.getString(2);
			String src=res.getString(3);
			String des=res.getString(4);
			String train_no=res.getString(5);
			query="update passenger_details set status='CD' where pnr_no=? and berth=?";
			st=con.prepareStatement(query);
			st.setString(1,pnr);
			st.setInt(2,berth);
			st.executeUpdate();
			query="select route_id from train_routes where train_no=? and station in(?,?);";
			st=con.prepareStatement(query);
			st.setString(2,src);
			st.setString(1,train_no);
			st.setString(3,des);
			res= st.executeQuery();
			res.next();
			Integer fromIn=res.getInt(1);
			res.next();
			Integer toIn=res.getInt(1);
			query="insert into cancelled_tickets(train_no,date,fromIn,toIn,class,berth) values(?,?,?,?,?,?)";
			st=con.prepareStatement(query);
			st.setString(1, train_no);
			st.setString(2,jd);
			st.setInt(3,fromIn);
			st.setInt(4,toIn);
			st.setString(5,cl);
			st.setInt(6, berth);
			st.executeUpdate();
			query="update train_table set "+cl+"= "+cl+"+"+1+" where train_no =? and date=? and (route_id between ? and ?)";
			System.out.print(query);
			st=con.prepareStatement(query);
			st.setString(1, train_no);
			st.setString(2,jd);
			st.setInt(3,fromIn);
			st.setInt(4, toIn-1);
			st.executeUpdate();
			out.print("Your ticket has been cancelled");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
