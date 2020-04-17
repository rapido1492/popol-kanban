package vo.mainpage;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class DirectoryVO {
	private int file_idx, pj_idx, b_idx, m_idx, pwd;
	private long file_memory;
	private List<MultipartFile> files;
	private String file_title;
	private String file_name; // 실제이름
	
	
	
	public String getFile_title() {
		return file_title;
	}
	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public int getPj_idx() {
		return pj_idx;
	}
	public void setPj_idx(int pj_idx) {
		this.pj_idx = pj_idx;
	}
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public int getPwd() {
		return pwd;
	}
	public void setPwd(int pwd) {
		this.pwd = pwd;
	}
	public long getFile_memory() {
		return file_memory;
	}
	public void setFile_memory(long file_memory) {
		this.file_memory = file_memory;
	}
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	
	
}
