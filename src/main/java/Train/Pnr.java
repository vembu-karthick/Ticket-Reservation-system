package Train;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.JSONArray;
import org.json.JSONObject;

import Connect.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/pnr_status")
public class Pnr extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Pnr() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String pnr=request.getParameter("pnr");
			Connection con=DatabaseConnection.initializeDatabase("train_reservation");
			PrintWriter pr=response.getWriter();
			String query;
			query="select * from ticket_details where pnr_no=?";
			PreparedStatement st=con.prepareStatement(query);
			st.setString(1,pnr);
			ResultSet rs=st.executeQuery();
			JSONObject json=new JSONObject();
			if(rs.next()) {
				System.out.print("hi");
				json.put("train", rs.getString(2));
				json.put("user", rs.getString(3));
				json.put("src", rs.getString(4));
				json.put("des", rs.getString(5));
				json.put("class", rs.getString(6));
				json.put("jd", rs.getString(7));
				json.put("bd", rs.getString(8));
				json.put("pr", rs.getString(9));
				json.put("passn", rs.getString(10));
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
				
			}
			else {
				json.put("res", "Your PNR has been flushed");
			}
			System.out.print(json);
			pr.print(json);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
