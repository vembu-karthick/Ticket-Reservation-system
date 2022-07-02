package Train;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import Connect.DatabaseConnection;

/**
 * Servlet implementation class Confirmation
 */
@WebServlet("/confirm")
public class Confirmation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			HttpSession ses=request.getSession();
			if(ses.getAttribute("user")==null){
				 response.sendRedirect(request.getContextPath());
			}
		//	ArrayList<String> name=new ArrayList<>();
		//	String[] name=new String[6];
			String fromIn=request.getParameter("fromIn");
			String toIn=request.getParameter("toIn");
			String cl=request.getParameter("cl");
			String clv=request.getParameter("clv");
			Integer pr=Integer.valueOf(request.getParameter("pr"));
			String train_no=request.getParameter("train_no");
			String date=request.getParameter("date");
			String arr=request.getParameter("arr");
			
			
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			//finds route index
			String query="select station,timing from train_routes where train_no = ? and route_id in(?,?);";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,train_no);
			st.setString(2,fromIn);
			st.setString(3,toIn);
			ResultSet res= st.executeQuery();
			
			res.next();
			request.setAttribute("from",res.getString(1));
			request.setAttribute("fromt",res.getString(2));
			
			res.next();
			request.setAttribute("to",res.getString(1));			
			request.setAttribute("tot",res.getString(2));
			
			Integer seats=0;
			seats=arr.length();
			System.out.println(arr);
			JSONArray objArr=new JSONArray();
			
			for(int i=0;i<arr.length();i++) {
				JSONObject obj=new JSONObject();
				obj.put("name", request.getParameter("name"+arr.charAt(i)));
				obj.put("age", request.getParameter("age"+arr.charAt(i)));
				obj.put("gender", request.getParameter("gender"+arr.charAt(i)));
				objArr.put(obj);	
				System.out.print(request.getParameter("name"+arr.charAt(i)));
			}
			
			System.out.println(pr+" "+seats);
			System.out.println(objArr);
			pr=pr*seats;
			request.setAttribute("js",objArr);
			request.setAttribute("cl",cl);
			request.setAttribute("clv",clv);
			request.setAttribute("pr",pr);
			request.setAttribute("date", date);
			request.setAttribute("seats", seats);
			request.setAttribute("train_no", train_no);
			request.setAttribute("address",request.getParameter("address"));
			request.setAttribute("ph",request.getParameter("ph"));
			request.setAttribute("email",request.getParameter("email"));
			RequestDispatcher rd=request.getRequestDispatcher("/Confirm.jsp"); 
			rd.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		
	}

}
