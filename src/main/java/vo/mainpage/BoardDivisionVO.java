package vo.mainpage;

public class BoardDivisionVO {
	private int board_after_id; // 보드 회원번호
	private int card_before_index; // 메모 순서
	private int b_idx;
	private int pj_idx; // 프로젝트 idx
	private int card_after_index; // 이동 후 카드 index(이동 후의 카드 리스트들 속 위치)
	private int board_before_id;// 이동 전 보드 id(이동 전, 카드를 품고 있는 보드의 id)
	private String division_after_id; // todo, doing, done
	private String division_before_id; // todo, doing, done
	private int priority;
	
	
	
	
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getDivision_after_id() {
		return division_after_id;
	}
	public void setDivision_after_id(String division_after_id) {
		this.division_after_id = division_after_id;
	}
	public String getDivision_before_id() {
		return division_before_id;
	}
	public void setDivision_before_id(String division_before_id) {
		this.division_before_id = division_before_id;
	}
	public int getBoard_after_id() {
		return board_after_id;
	}
	public void setBoard_after_id(int board_after_id) {
		this.board_after_id = board_after_id;
	}
	public int getCard_before_index() {
		return card_before_index;
	}
	public void setCard_before_index(int card_before_index) {
		this.card_before_index = card_before_index;
	}
	public int getPj_idx() {
		return pj_idx;
	}
	public void setPj_idx(int pj_idx) {
		this.pj_idx = pj_idx;
	}
	public int getCard_after_index() {
		return card_after_index;
	}
	public void setCard_after_index(int card_after_index) {
		this.card_after_index = card_after_index;
	}
	public int getBoard_before_id() {
		return board_before_id;
	}
	public void setBoard_before_id(int board_before_id) {
		this.board_before_id = board_before_id;
	}
	
	
	
	
	
}
