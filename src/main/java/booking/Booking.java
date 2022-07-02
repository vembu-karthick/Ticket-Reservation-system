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
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import Connect.DatabaseConnection;

/**
 * Servlet implementation class Booking
 */
@WebServlet("/final")
public class Booking extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Booking() {
        super();
        // TODO Auto-generated constructor stub
    }
    private String getPNR()
    {
		String NumericString = "0123456789";
        StringBuilder sb = new StringBuilder(7);
        for (int i = 0; i < 7; i++) {
            int index = (int)(NumericString.length()* Math.random());
            sb.append(NumericString .charAt(index));
        }
        return sb.toString();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	try {
		HttpSession ses=request.getSession();
		
		if(ses.getAttribute("user")==null){
			 response.sendRedirect(request.getContextPath());
		}
		PrintWriter out=response.getWriter();
		String from=request.getParameter("from");
		String to=request.getParameter("to");
		String cl=request.getParameter("cl");
		String date=request.getParameter("date");
		Integer seats=Integer.valueOf(request.getParameter("seats"));
		Integer pr=Integer.valueOf(request.getParameter("pr"));
		String train_no=request.getParameter("train_no");
		String address=request.getParameter("address");
		String ph=request.getParameter("ph");
		String email=request.getParameter("email");
		String js=request.getParameter("js");
		String user=(String) ses.getAttribute("user");
		Integer sts=Integer.MAX_VALUE;
		Connection con=DatabaseConnection.initializeDatabase("train_reservation");
		
		String query="select route_id from train_routes where train_no=? and station in(?,?);";
		PreparedStatement st=con.prepareStatement(query);
		st.setString(1,train_no);
		st.setString(2,from);
		st.setString(3, to);
		ResultSet res= st.executeQuery();
		res.next();
		Integer fromIn=res.getInt(1);
		res.next();
		Integer toIn=res.getInt(1);
		
		int[] frIn=new int[seats];
		int[] tIn=new int[seats];
		query="select berth,count(berth),fromIn,toIn from cancelled_tickets where train_no =? and date=? and class=? and fromIn>=? and toIn<=?";
		System.out.print(query);
		st=con.prepareStatement(query);
		st.setString(1, train_no);
		st.setString(2,date);
		st.setString(3,cl);
		st.setInt(4,fromIn);
		st.setInt(5, toIn-1);
		res= st.executeQuery();
		int seat=seats;
		int flag=0;
		int i=0;
		int  arrseat[]=new int[seats];
		while(res.next() && seat!=0) {
			if(res.getInt(2)>=seat) {
				flag=1;
				arrseat[i]=res.getInt(1);
				frIn[i]=res.getInt(3);
				tIn[i]=res.getInt(4);
				System.out.println(frIn[i]+" "+tIn[i]);
				i++;
				seat--;
			}
			else {
				break;
			}
		}
		seat=i;
		if(flag==0) {
		Integer jsLen=js.length()-1;
		char c[]=js.toCharArray();
		System.out.println(c);
		js=String.valueOf(c);
		System.out.println(js);
			query="select "+cl+" from train_table where train_no =? and date=? and (route_id between ? and ?)";
			System.out.print(query);
			st=con.prepareStatement(query);
			st.setString(1, train_no);
			st.setString(2,date);
			st.setInt(3,fromIn);
			st.setInt(4, toIn-1);
			res= st.executeQuery();
			while(res.next()){
				sts=Math.min(res.getInt(1),sts);
			}
		}
		JSONObject result= new JSONObject();
		String[] b_st=new String[8];
		b_st[0]="L";
		b_st[1]="M";
		b_st[2]="U";
		b_st[3]="SL";
		b_st[4]="SU";
		b_st[5]="U";
		b_st[6]="M";
		b_st[7]="L";
		
		System.out.println(user);
		if(sts>=seats || seat==seats){
			String pnr_no=getPNR();
			query="insert into ticket_details(pnr_no,train_no,user_id,src,des,class,journey_date,booking_date,price,passenger,address,phone_no,email) values(?,?,?,?,?,?,?,current_date(),?,?,?,?,?);";
			st=con.prepareStatement(query);
			st.setString(1,pnr_no);
			st.setString(2,train_no);
			st.setString(3,user);
			st.setString(4,from);
			st.setString(5,to);
			st.setString(6,cl);
			st.setString(7,date);
			st.setInt(8,pr);
			st.setInt(9,seats);
			st.setString(10,address);
			st.setString(11,ph);
			st.setString(12,email);
			st.executeUpdate();
			System.out.print(js);
			JSONArray json=new JSONArray(js);
			for(int i1=0;i1<json.length();i1++) {
				JSONObject pass=json.getJSONObject(i1);
				query="insert into passenger_details(pnr_no,name,age,gender,berth,berth_type,status)values(?,?,?,?,?,?,?)";
				st=con.prepareStatement(query);
				st.setString(1,pnr_no);
				st.setString(2,pass.getString("name"));
				st.setInt(3,pass.getInt("age"));
				st.setString(4,pass.getString("gender"));
				if(flag==0) {
					st.setInt(5,sts);
					st.setString(6,b_st[(sts%8)-1]);
				}
				else {
					--seat;
					int s=arrseat[seat];
					st.setInt(5,s);
					st.setString(6,b_st[(sts%8)-1]);
				}
				st.setString(7,"CN");
				sts--;
				st.executeUpdate();
			}
			query="update train_table set "+cl+"= "+cl+"-"+seats+" where train_no =? and date=? and (route_id between ? and ?)";
			System.out.print(query);
			st=con.prepareStatement(query);
			st.setString(1, train_no);
			st.setString(2,date);
			st.setInt(3,fromIn);
			st.setInt(4, toIn-1);
			st.executeUpdate();
			result.put("result", "Your Ticket has been booked");
		}
		else {
			result.put("result", "Unable to book");
		}
		if(flag!=0) {
			System.out.println(fromIn+" "+toIn);
		for(int j=0;j<i;j++) {
			query="delete from cancelled_tickets where train_no =? and date=? and class=? and fromIn=? and toIn=? and berth=?";
			st=con.prepareStatement(query);
			st.setString(1, train_no);
			st.setString(2,date);
			st.setString(3,cl);
			st.setInt(4,frIn[j]);
			st.setInt(5,tIn[j]);
			st.setInt(6,arrseat[j]);
			Integer fir=st.executeUpdate();
			System.out.print(fir);
			System.out.println(frIn[i]+" "+tIn[i]);
			if(frIn[j]!=fromIn){
			query="insert into cancelled_tickets(train_no,date,fromIn,toIn,class,berth) values(?,?,?,?,?,?)";
			st=con.prepareStatement(query);
			st.setString(1, train_no);
			st.setString(2,date);
			st.setInt(3,frIn[j]);
			st.setInt(4,fromIn);
			st.setString(5,cl);
			st.setInt(6, arrseat[j]);
			Integer sec=st.executeUpdate();
			System.out.print(sec);
			}
			if(tIn[j]!=toIn) {
				query="insert into cancelled_tickets(train_no,date,fromIn,toIn,class,berth) values(?,?,?,?,?,?)";
				st=con.prepareStatement(query);
				st.setString(1, train_no);
				st.setString(2,date);
				st.setInt(3,toIn);
				st.setInt(4,tIn[j]);
				st.setString(5,cl);
				st.setInt(6, arrseat[j]);
				Integer thi=st.executeUpdate();
				System.out.print(thi);
			}
			}
		}
		out.print(result);
	}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
