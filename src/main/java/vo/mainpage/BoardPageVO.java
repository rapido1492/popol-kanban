package vo.mainpage;

public class BoardPageVO {
	private int b_idx, pj_idx, m_idx, memo_seq;
	private String b_content, subject, b_date;
	private String division;
	private int priority;
	private int pwd;
	
	// 어떤 페이지에서 넘어왔는지.
	private String page;
	
	
	
	
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getPwd() {
		return pwd;
	}
	public void setPwd(int pwd) {
		this.pwd = pwd;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public int getMemo_seq() {
		return memo_seq;
	}
	public void setMemo_seq(int memo_seq) {
		this.memo_seq = memo_seq;
	}
	public String getB_date() {
		return b_date;
	}
	public void setB_date(String b_date) {
		this.b_date = b_date;
	}
	public String getB_regdate() {
		return b_date;
	}
	public void setB_regdate(String b_regdate) {
		this.b_date = b_regdate;
	}
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getPj_idx() {
		return pj_idx;
	}
	public void setPj_idx(int pj_idx) {
		this.pj_idx = pj_idx;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	
	
	
	
}
