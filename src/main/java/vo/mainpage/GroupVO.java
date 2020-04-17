package vo.mainpage;

public class GroupVO {
	// 이름도 가져오기. 
	private int m_idx, pj_idx, g_idx;
	private String m_name;
	
	
	public int getPj_idx() {
		return pj_idx;
	}
	public void setPj_idx(int pj_idx) {
		this.pj_idx = pj_idx;
	}
	public int getG_idx() {
		return g_idx;
	}
	public void setG_idx(int g_idx) {
		this.g_idx = g_idx;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	
	
	
}
