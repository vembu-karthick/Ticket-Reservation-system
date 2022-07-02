package resource;
import java.util.ArrayList;

public class NumToDay {
	public static ArrayList<String> convert(int i) {
		ArrayList<String> day=new ArrayList<>(7);
		int j=0;
		day.add(0, "Sunday");
		day.add(1, "Monday");
		day.add(2, "Tuesday");
		day.add(3, "Wednesday");
		day.add(4, "Thursday");
		day.add(5, "Friday");
		day.add(6, "Saturday");
		while(i!=0){
			if(i%2==1) {
				System.out.println(day.get(j));
			}
			j++;
			i/=2;
		}
		return day;
	}
}
