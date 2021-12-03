package data.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.FollowService;
import data.service.MemberService;
import data.service.ProductLikeService;
import data.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductService service;
	
	@Autowired
	ProductLikeService plservice;
	
	@Autowired
	FollowService flservice;
	
	@Autowired
	MemberService mservice;
	
	@ResponseBody
	@GetMapping("/list")
	public ModelAndView productList(
			@RequestParam (defaultValue = "1") int currentPage,
			@RequestParam (defaultValue = "전체") String category,
			@RequestParam (required = false) String keyword) { 
	ModelAndView mview = new ModelAndView();
	
	int totalCount = service.getTotalCount(category);
	
	//페이징 처리에 필요한 변수 선언
	int perPage = 20;
	int totalPage;
	int start;
	int perBlock = 5;
	int startPage;
	int endPage;
	
	//총 페이지 갯수 구하기
	totalPage = totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작 페이지
	startPage = (currentPage-1)/perBlock*perBlock +1;
	//각 블럭의 마지막 페이지
	endPage = startPage + perBlock -1;
	
	if(endPage > totalPage) {
		endPage = totalPage;
	}
	
	//각 페이지에서 불러올 시작번호
	start = (currentPage-1)*perPage;
	
	List<ProductDTO> list = service.getList(start, perPage, category, keyword);
	
	//각 페이지에 출력할 시작번호
	int no = totalCount-(currentPage-1)*perPage;
	
	//출력에 필요한 변수들을 request에 저장
	mview.addObject("list",list);
	mview.addObject("startPage", startPage);
	mview.addObject("endPage", endPage);
	mview.addObject("totalPage", totalPage);
	mview.addObject("no", no);
	mview.addObject("currentPage", currentPage);
	mview.addObject("totalCount", totalCount);
	
	mview.addObject("category", category);
	
	mview.setViewName("/product/list");
		  
	return mview; 
	}
	 

	@GetMapping("/auth/updateForm")
	public ModelAndView updateForm(@RequestParam String idx) {
		ModelAndView mview = new ModelAndView();

		ProductDTO dto = service.getData(idx);

		mview.addObject("dto", dto);
		mview.setViewName("/product/updateForm");

		return mview;
	}

	@GetMapping("/auth/insertForm")
	public String insertForm() {

		return "/product/insertForm";
	}

	@PostMapping("/auth/insert")
	public String insertData(@ModelAttribute ProductDTO dto, HttpServletRequest request, HttpSession session, Principal principal) {
		// 로그인 안했을 경우, 종료
		String isLogin = (String)request.getSession().getAttribute("isLogin");

		if (isLogin == null) {
			return "login/loginmsg";
		}

		// 로그인 했을 경우,
		//업로드된 파일 리스트
		List<MultipartFile> mf = dto.getUpload(); 
		
		// 파일 업로드 안했을 경우,
		if (mf.get(0).getOriginalFilename().equals("")) {
			return "history.back()";
			// 파일 업로드 했을 경우,
		} else{
			// 저장할 폴더 지정
			String path = session.getServletContext().getRealPath("/photo");
			String fileplus="";
			
			for(int i=0; i<mf.size(); i++) {
				// uuid 생성
				UUID uuid = UUID.randomUUID();
				// uuid 활용해 파일이름 지정 
				String uploadfile = uuid.toString() + "_" + mf.get(i).getOriginalFilename();
				// 실제 업로드
				try {
					mf.get(i).transferTo(new File(path + "\\" + uploadfile));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				fileplus += uploadfile+",";
			}
			//마지막 컴마 제거
			fileplus = fileplus.substring(0,fileplus.length()-1);
			
			dto.setUploadfile(fileplus);
		}
		//세션에서 아이디 얻어서 dto에 저장
		String id = principal.getName();
		dto.setId(id);
		
		service.insertData(dto);
	  
		return "redirect:detail?idx="+service.getMaxIdx();
	}
	
	@GetMapping("/detail")
	public String content(@RequestParam String idx,
			@RequestParam (defaultValue = "1") int currentPage, 
			@RequestParam (required = false) String key,
			Model model, HttpServletRequest request, Principal principal) {
		//리스트에서 디테일페이지가면 조회수 올라가게
		if(key!=null) {
			service.updateReadcount(idx);
		}
		
		//해당 idx의 데이터 가져오기
		ProductDTO dto = service.getData(idx);
		//사진 ,로 split(대표 이미지)
		String []photo = dto.getUploadfile().split(",");
		
		//닉네임 가져오기
		String nick = mservice.getNick(dto.getId());
		
		//같은 카테고리 연관제품 보여주기
		String category = dto.getCategory();
		List<ProductDTO> list = service.getRelateList(category,idx);
		
		//로그인 여부
		String isLogin = "N";
		isLogin = (String)request.getSession().getAttribute("isLogin");
		
		//로그인 되어 있을 경우,
		if(isLogin!=null) {
			//로그인 아이디 가져오기
			String id = principal.getName();
			model.addAttribute("myId", id);
			
		
			//하트 버튼 클릭여부
			int likeCheck = plservice.plikeCheck(id,idx);
			model.addAttribute("likeCheck", likeCheck);
			
			//팔로우 여부
			int followCheck = flservice.followCheck(dto.getId(), id);
			System.out.println("follow?"+followCheck);
			model.addAttribute("followCheck", followCheck);
			
			if(id.equals(dto.getId())) {
				//판매상태
				String sellstatus = dto.getSellstatus();
				if(sellstatus.equals("판매중")) {
					dto.setSellstatus("selling");
				} else if(sellstatus.equals("예약중")) {
					dto.setSellstatus("reserved");
				} else {
					dto.setSellstatus("finished");
				}
			}
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		model.addAttribute("isLogin", isLogin);
		model.addAttribute("nick", nick);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("photo", photo);
		
		return "/product/detail";
	}
	
	@GetMapping("/delete")
	public String deleteData(@RequestParam String idx) {
		service.deleteData(idx);
		
		return "/product/list";
	}
	
	@ResponseBody
	@PostMapping("/updateLikecount")
	public int updateLikecount(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//product의 likecount+1
		service.updateLikecount(idx);
		//product_like의 데이터 추가
		plservice.insertPlike(id,idx);
		
		//like 수 리턴
		return service.getLikeCount(idx);
	}
	
	@ResponseBody
	@PostMapping("/updateLikeMinuscount")
	public int updateLikeMinuscount(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//product의 likecount-1
		service.updateLikeMinuscount(idx);
		
		//product_like의 데이터 삭제
		plservice.deletePlike(id,idx);
		
		//like 수 리턴
		return service.getLikeCount(idx);
	}
	
	@ResponseBody
	@PostMapping("/updateStatus")
	public void updateStatus(@RequestParam String idx, @RequestParam String status) {
		if(status.equals("selling")) {
			status = "판매중";
		} else if(status.equals("reserved")) {
			status = "예약중";
		} else if(status.equals("finished")) {
			status = "판매완료";
		}
		service.updateStatus(idx, status);
	}
}
