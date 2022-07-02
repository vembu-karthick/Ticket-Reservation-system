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
import java.util.ArrayList;
import java.util.Collections;

import org.json.JSONArray;
import org.json.JSONObject;
import Connect.DatabaseConnection;

@WebServlet("/journey")
public class RouteDetails extends HttpServlet { 
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String from=request.getParameter("from");
			String to=request.getParameter("to");
			String date=request.getParameter("date");
			Integer day=Integer.valueOf(request.getParameter("day"));
			
			System.out.println(date);
			System.out.println(day);
			System.out.println(from);
			System.out.println(to);
			
			HttpSession ses=request.getSession();	
			
//			from="Nagercoil";
//			to="Tirunelveli";
			PrintWriter p=response.getWriter();	
			
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			//finds route index
			String query="select t1.train_no, t1.route_id,  t2.route_id,t1.timing,t2.timing  from train_routes t1, train_routes t2 join train_days td using(train_no) where t1.train_no= t2.train_no and t1.station=? and t2.station=? and td.day=?;";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,from);
			st.setString(2,to);
			st.setInt(3, day);
			ResultSet res= st.executeQuery();
			
			// Declaration
			Integer fromIn,toIn;
			String trainNo;
			ResultSet res1,res2;
			Integer flag=0;
			JSONObject json=new JSONObject();
			JSONArray trainArr=new JSONArray();
			String [] da=new String[7];
			da[0]="SUN";
			da[1]="MON";
			da[2]="TUE";
			da[3]="WED";
			da[4]="THU";
			da[5]="FRI";
			da[6]="SAT";
		
			// Iteration for every train
			while(res.next()) {	
				String days="";
				ArrayList<Integer> dayInd = new ArrayList<Integer>();
				JSONArray routes=new JSONArray();
				JSONObject train=new JSONObject();
				//getting values from result_set
				trainNo= res.getString(1);
				fromIn = res.getInt(2);
				toIn = res.getInt(3);
				if(fromIn>=toIn) {
					break;
				}
				flag=1;
				String fromt=res.getString(4);
				String tot=res.getString(5);
				//all Stations on the route
				query="select station, timing,days,route_id,sprice,lprice,aprice from train_routes where train_no=?";
				st=con.prepareStatement(query);
				st.setString(1,trainNo);
				res1= st.executeQuery();
				int sprice=0,lprice=0,aprice=0;
				
				query="select day from train_days where train_no=?;";
				st=con.prepareStatement(query);
				st.setString(1,trainNo);
				ResultSet res3 = st.executeQuery();
				while(res3.next()) {
					dayInd.add(res3.getInt(1));
				}
				Collections.sort(dayInd);
				days+=" | ";
				for(Integer i:dayInd) {
					days+=da[i];
					days+=" | ";
				}
				
				//iteration for routes
				 
				while(res1.next()) {
					JSONObject stops=new JSONObject();
					stops.put("station",res1.getString(1));
					stops.put("timing",res1.getString(2));
					stops.put("days",res1.getString(3));
					if(res1.getInt(4)>=fromIn && res1.getInt(4)<toIn) {
						sprice+=res1.getInt(5);
						lprice+=res1.getInt(6);
						aprice+=res1.getInt(7);
						System.out.println(sprice+" "+lprice+" "+aprice);
					}
					routes.put(stops);
				}
				//Query for capacity
				query="select SL,2S,AC from train_table where train_no=? and (route_id between "+fromIn+" and " +(toIn-1)+") and date=?";
				st=con.prepareStatement(query);
				st.setString(1,trainNo);
				st.setString(2, date);
				res2= st.executeQuery();
				Integer s=Integer.MAX_VALUE,l=Integer.MAX_VALUE,a=Integer.MAX_VALUE;
				while(res2.next()) {
					
					l=Math.min(l,res2.getInt(1));
					s=Math.min(s,res2.getInt(2));
					a=Math.min(a,res2.getInt(3));		
				}
				System.out.print(l+" "+s+" "+a);
				train.put("days",days);
				train.put("fromt",fromt);
				train.put("tot", tot);
				train.put("fromIn",fromIn);
				train.put("toIn",toIn);
				train.put("from",from);
				train.put("to",to);
				train.put("spr", sprice);
				train.put("lpr", lprice);
				train.put("apr", aprice);
				train.put("date",date);
				train.put("SL",l);
				train.put("2S",s);
				train.put("AC",a);
				train.put("train_no",trainNo);
				train.put("routes",routes);
				trainArr.put(train);
			}
			json.put("train",trainArr);
			System.out.println(json);
			if(flag==0) {
				json.put("res","No train is found");
			}
			p.print(json);
		}
		catch (Exception e) {
			e.printStackTrace();
			}
	}
}