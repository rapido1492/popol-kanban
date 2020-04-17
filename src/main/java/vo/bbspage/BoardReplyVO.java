package vo.bbspage;

public class BoardReplyVO {
	private int b_idx;
	private int m_idx;
	private int reidx;
	private String rewriter;
	private String content;
	private String regdate;
	private String filename;
	
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getReidx() {
		return reidx;
	}
	public void setReidx(int reidx) {
		this.reidx = reidx;
	}
	public String getRewriter() {
		return rewriter;
	}
	public void setRewriter(String rewriter) {
		this.rewriter = rewriter;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
}
