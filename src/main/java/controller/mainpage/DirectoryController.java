/**
 * 신이룸
 */

package controller.mainpage;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Provider.Service;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import dao.mainpage.DirectoryDAO;
import vo.mainpage.DirectoryVO;

@Controller
public class DirectoryController {

	// @Autowired로 자동으로 객체 생성된 것으로 밑에서 파라미터로 받을 필요가 없다. 

	// web상의 절대경로를 가져오기위한 클래스
	@Autowired // 자동주입(Spring으로부터 application정보를 자동으로 받는다), 빈객체를 생성하지 않아도 됨.
	ServletContext application;

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpServletResponse response;

	DirectoryDAO directorydao;

	public DirectoryController() {
	}

	public DirectoryController(DirectoryDAO directorydao) {
		this.directorydao = directorydao;
	}

	// 리스트 뿌리는 곳
	@RequestMapping("/directory_list.do")
	public String list(Model model) {
		// 여기서 셀렉트해서 가져오기.
		List<DirectoryVO> list = directorydao.selectList();
		System.out.println("리스트 다시가져옴."); 
		model.addAttribute("list", list);
		return Common.BoardPage.BOARD_VIEW_PATH + "directory_page.jsp";
	}//list()

	// 부분 검색
	@RequestMapping("/dir_searching.do")
	public String searching(Model model, String search) {
		// 여기서 셀렉트해서 가져오기.
		System.out.println("search : "+search);

		if(search == "") {
			List<DirectoryVO> list = directorydao.selectList();
			model.addAttribute("list", list);
			return Common.BoardPage.BOARD_VIEW_PATH + "directory_page.jsp";
		}

		List<DirectoryVO> list1 = directorydao.wordSelect(search);
		model.addAttribute("list", list1);
		//		request.setAttribute("list", list1);

		return Common.BoardPage.BOARD_VIEW_PATH + "directory_page.jsp";
	}

	// 파일등록 view로 가기.
	@RequestMapping("/directory_reg.do")
	public String dir_reg() {
		return Common.BoardPage.BOARD_VIEW_PATH + "directory_reg_form.jsp";
	}

	// 파일 등록하는 곳
	@RequestMapping("/directory_insert.do")
	public String insert( DirectoryVO vo, Model model ) {
		vo.setM_idx(1);
		vo.setB_idx(1);
		vo.setPj_idx(1);


		int result = 0;
		String webPath = "/resources/upload/"; // 절대경로
		String savePath = application.getRealPath(webPath);


		// 사용자가 업로드한 팡리정보
		List<MultipartFile> file_array = vo.getFiles();

		for( int i = 0 ; i < file_array.size() ; i++) {

			MultipartFile file = file_array.get(i);
			String file_name = "no_file";//실제이름

			if( !file.isEmpty() ) { // 잘 받아왔으면.
				file_name = file.getOriginalFilename(); //업로드 된 실제 파일 네임
				System.out.println("file_name : " + file_name);
				String realname = file_name;
				vo.setFile_title(realname);
			} 

			long time = System.currentTimeMillis(); // 호출 되었을떄의 시간

			file_name = String.format("%d_%s", time, file_name);
			File saveFile = new File(savePath, file_name); // filename이라는 폴더를 만들겠다는 뜻 // 저장할 파일의 경로

			if(!saveFile.exists()) {
				// 저장할 경로가 존재하지 않는다면 새로운 폴더를 생성
				saveFile.mkdirs();
			} 

			long memory = 0;
			if (!saveFile.exists()) {
				System.err.println("파일이 없음...");
			}
			memory = file_array.get(i).getSize();
			System.out.println(file_name + " bytes : " + file_array.get(i).getSize());

			vo.setFile_name(file_name);
			vo.setFile_memory(memory);


			try {

				// 업로드를 요청받은 파일은 MultipartResolver클래스가
				// 지정한 임시 저장소에 있는데, 임시 저장소에 있는 파일은 일정 시간이 지나면 사라지므로
				// 내가 지정해놓은 경로로 복사를 해둬야 한다.
				// resolver의 단점중 하나이고, 파일이름이 동일할때도 생각해야 한다.
				file.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			int res = directorydao.insert(vo);

		}//for

		List<DirectoryVO> list = directorydao.selectList();
		model.addAttribute("list", list);
		return Common.BoardPage.BOARD_VIEW_PATH + "directory_page.jsp"; 
	}// 파일 업로드

	// 삭제
	@RequestMapping("/directory_del.do")
	@ResponseBody
	public String delete(int[] file_idx) {

		String result = "no"; // 삭제 실패시

		int res = directorydao.delete(file_idx);

		if( res != 0) {
			result = "yes"; // 삭제 성공시
		}

		// ResponseBody를 썻기 때문에 경로가 아닌 값을 넣으면 된다.
		return result;

	}

	// 다운로드
	@RequestMapping("/dir_download.do")
	@ResponseBody
	public String fileDown(String file_name) throws IOException{

		//업로드한 파일이 있는 경로
		String webPath = "/resources/upload/"; // 절대경로
		String realPath = application.getRealPath(webPath);
		System.out.println("realPath : " + realPath); 

		        // 파라미터로 받은 파일 이름.
		        String requestFileNameAndPath = file_name;
		         System.out.println(requestFileNameAndPath); 
		        // 서버에서 파일찾기 위해 필요한 파일이름(경로를 포함하고 있음)
		        // 한글 이름의 파일도 찾을 수 있도록 하기 위해서 문자셋 지정해서 한글로 바꾼다.
		        String UTF8FileNameAndPath = new String(requestFileNameAndPath.getBytes("8859_1"), "UTF-8");
		         
		        // 파일이름에서 path는 잘라내고 파일명만 추출한다.
//		            String UTF8FileName = UTF8FileNameAndPath.substring(UTF8FileNameAndPath.lastIndexOf("/") + 1).substring(UTF8FileNameAndPath.lastIndexOf(File.separator) + 1);
		         
		        // 브라우저가 IE인지 확인할 플래그.
//		            boolean MSIE = request.getHeader("user-agent").indexOf("MSIE") != -1;
		         
		        // 파일 다운로드 시 받을 때 저장될 파일명
		        String fileNameToSave = requestFileNameAndPath;
		     
		        // IE,FF 각각 다르게 파일이름을 적용해서 구분해주어야 한다.
		       /*if(MSIE){
		            // 브라우저가 IE일 경우 저장될 파일 이름
		            // 공백이 '+'로 인코딩된것을 다시 공백으로 바꿔준다.
		            fileNameToSave = URLEncoder.encode(UTF8FileName, "UTF8").replaceAll("\\+", " ");
		        }else{
		            // 브라우저가 IE가 아닐 경우 저장될 파일 이름
		            fileNameToSave = new String(UTF8FileName.getBytes("UTF-8"), "8859_1");
		        }*/
		     
		        // 파일이 바로 실행되지 않고 다운로드가 되게 하기 위해서 컨텐트 타입을 8비트 바이너리로 설정한다.
		        response.setContentType("application/octet-stream");
		         
		        // 저장될 파일명을 지정한다.
		        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameToSave + "\";");
		         
		        // 파일패스 및 파일명을 지정한다.
		        //  String filePathAndName = pageContext.getServletContext().getRealPath("/") + UTF8FileNameAndPath;
		        String filePathAndName = realPath + UTF8FileNameAndPath;
		        File file = new File(filePathAndName);
		         
		        // 버퍼 크기 설정
		        byte bytestream[] = new byte[2048000];
		     
		        // response out에 파일 내용을 출력한다.
		        if (file.isFile() && file.length() > 0){
		             
		            FileInputStream fis = new FileInputStream(file);
		            BufferedInputStream bis = new BufferedInputStream(fis);
		            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		                 
		            int read = 0;
		                 
		            while ((read = bis.read(bytestream)) != -1){
		                bos.write(bytestream , 0, read);
		            }
		             
		            bos.close();
		            bis.close();
		            
				}
		return "aa";  
	}











}
































