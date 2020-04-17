package vo.mypage;

public class MyPage_MemoBoardVO {
	
	private int b_idx;
	private int pj_idx;
	private int m_idx;
	private String b_content;
	private String b_date;
	private int memo_seq;
	private String division;
	private int priority;
	private String subject;
	private int readhit;
	private int ref;
	private int step;
	private String pj_name;

	
	
	public String getPj_name() {
		return pj_name;
	}
	public void setPj_name(String pj_name) {
		this.pj_name = pj_name;
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
	public String getB_date() {
		return b_date;
	}
	public void setB_date(String b_date) {
		this.b_date = b_date;
	}
	public int getMemo_seq() {
		return memo_seq;
	}
	public void setMemo_seq(int memo_seq) {
		this.memo_seq = memo_seq;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getReadhit() {
		return readhit;
	}
	public void setReadhit(int readhit) {
		this.readhit = readhit;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}

}
