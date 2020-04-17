package vo.mypage;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

public class MyPage_ProjectVO2 {
	
	private int pj_idx=0;
	private String pj_name="basic project";
	private String pj_open="open";
	private String pj_sdate="none";
	private String pj_ddate="1996-01-17";
	private String pj_contents="empty";
	private String pj_leader="Unknown";
	private String pj_progress="1now";
	private String pj_dday="0";
	
	
	public String getPj_progress() {
		return pj_progress;
	}
	public void setPj_progress(String pj_progress) {
		this.pj_progress = pj_progress;
	}
	public String getPj_dday() {
		return pj_dday;
	}
	public void setPj_dday(String pj_dday) {
		this.pj_dday = pj_dday;
	}
	public String getPj_leader() {
		return pj_leader;
	}
	public void setPj_leader(String pj_leader) {
		this.pj_leader = pj_leader;
	}
	public int getPj_idx() {
		return pj_idx;
	}
	public void setPj_idx(int pj_idx) {
		this.pj_idx = pj_idx;
	}
	public String getPj_name() {
		return pj_name;
	}
	public void setPj_name(String pj_name) {
		this.pj_name = pj_name;
	}
	public String getPj_open() {
		return pj_open;
	}
	public void setPj_open(String pj_open) {
		this.pj_open = pj_open;
	}
	public String getPj_sdate() {
		return pj_sdate;
	}
	public void setPj_sdate(String pj_sdate) {
		this.pj_sdate = pj_sdate;
	}
	public String getPj_ddate() {
		return pj_ddate;
	}
	public void setPj_ddate(String pj_ddate) {
		this.pj_ddate = pj_ddate;
	}
	public String getPj_contents() {
		return pj_contents;
	}
	public void setPj_contents(String pj_contents) {
		this.pj_contents = pj_contents;
	}
	 	   
	
}
