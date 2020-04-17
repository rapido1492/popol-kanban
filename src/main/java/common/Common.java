package common;

public class Common {
	
	public static class MyPage{
		public static final String VIEW_PATH = "/WEB-INF/views/mypage/";
	}
	public static class BoardPage{
		public static final String BOARD_VIEW_PATH = "/WEB-INF/views/mainpage/";
	}
	
	// 창현
	//객체 관리를 편리하게 하기 위한 클래스
		public static final String VIEW_PATH = "WEB-INF/views/board/";
		
		//여러개의 게시판을 가지고 있을 때, 게시판마다 한 페이지당 보여줘야 하는 갯수가 다른 경우
		//다음과 같이 게시판 별로 상수화 시켜 놓으면 관리하기 편리해진다.
		public static class Board{
			//한 페이지당 보여줄 게시물 수
			public final static int BLOCKLIST = 10;
			
			//한 화면에 보여지는 페이지 메뉴 수 지정
			//◀1 2 3 4 5▶
			//◀1 2 3 ▶
			
			public final static int BLOCKPAGE = 5;
		}
		
		//예를 들어 공지사항 게시판이 추가로 존재한다면...
		public static class Notice {
			public final static int BLOCKLIST = 5;
			public final static int BLOCKPAGE = 3;
		}
		
		public static class loginPage{
			public static final String VIEW_PATH = "/WEB-INF/views/login/";
		}
		public static class signupPage{
			public static final String VIEW_PATH = "/WEB-INF/views/signup/";
		}
}
