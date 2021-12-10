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

import data.dto.ChatDTO;
import data.dto.ProductDTO;
import data.dto.ReviewDTO;
import data.service.FollowService;
import data.service.MemberService;
import data.service.ProductLikeService;
import data.service.ProductService;
import data.service.ReviewService;

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
	
	@Autowired 
	ReviewService rservice;
	


	@ResponseBody
	@GetMapping("/list")
	public ModelAndView productList(
			@RequestParam (defaultValue = "1") int currentPage,
			@RequestParam (defaultValue = "전체") String category,
			@RequestParam (required = false) String keyword,
			Principal principal) { 
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

		//지역가져오기
		String userId="no";
		String local="";
		String []localArr = {};
		//로그인 되어있을 경우,
		if(principal != null) {
			userId= principal.getName();
			local = mservice.getLocal(principal);
			localArr=local.split(",");
		}

		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);

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
	public ModelAndView updateForm(@RequestParam String idx, Principal principal) {
		ModelAndView mview = new ModelAndView();

		ProductDTO dto = service.getData(idx);
		
		//지역가져오기
		String userId="no";
		String local="";
		String []localArr = {};
		//로그인 되어있을 경우,
		if(principal != null) {
			userId= principal.getName();
			local = mservice.getLocal(principal);
			localArr=local.split(",");
		}

		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);

		mview.addObject("dto", dto);
		mview.setViewName("/product/updateForm");

		return mview;
	}

	@GetMapping("/auth/insertForm")
	public ModelAndView insertForm(Principal principal) {
		ModelAndView mview = new ModelAndView();
		
		//지역가져오기
		String userId=principal.getName();
		String local=mservice.getLocal(principal);
		String []localArr = local.split(",");

		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/product/insertForm");
		
		return mview;
	}

	@PostMapping("/auth/insert")
	public String insertData(@ModelAttribute ProductDTO dto, HttpServletRequest request, HttpSession session, Principal principal) {

		List<MultipartFile> mf = dto.getUpload(); 
		// 파일 업로드 안했을 경우,
		if (mf.get(0).getOriginalFilename().equals("")) {
			return "history.back()";
			// �뙆�씪 �뾽濡쒕뱶 �뻽�쓣 寃쎌슦,
		} else{
			// ���옣�븷 �뤃�뜑 吏��젙
			String path = session.getServletContext().getRealPath("/photo");
			String fileplus="";

			for(int i=0; i<mf.size(); i++) {
				// uuid �깮�꽦
				UUID uuid = UUID.randomUUID();
				// uuid �솢�슜�빐 �뙆�씪�씠由� 吏��젙 
				String uploadfile = uuid.toString() + "_" + mf.get(i).getOriginalFilename();
				// �떎�젣 �뾽濡쒕뱶
				try {
					mf.get(i).transferTo(new File(path + "\\" + uploadfile));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				fileplus += uploadfile+",";
			}
			//留덉�留� 而대쭏 �젣嫄�
			fileplus = fileplus.substring(0,fileplus.length()-1);

			dto.setUploadfile(fileplus);
		}
		//�꽭�뀡�뿉�꽌 �븘�씠�뵒 �뼸�뼱�꽌 dto�뿉 ���옣
		String id = principal.getName();
		dto.setId(id);
		
		//지역가져오기
		String userId=principal.getName();
		String local=mservice.getLocal(principal);
		String []localArr = local.split(",");

		service.insertData(dto);

		return "redirect:../detail?idx="+service.getMaxIdx();
	}
	
	@PostMapping("/auth/update")
	public String updateData(@ModelAttribute ProductDTO dto, HttpServletRequest request, HttpSession session, Principal principal,String idx) {
		//업로드된 파일 리스트
		List<MultipartFile> mf = dto.getUpload(); 
		
		// 파일 업로드 안했을 경우,
		if (mf.get(0).getOriginalFilename().equals("")) {
			//기존 사진 그대로
			String uploadfile = dto.getUploadfile();
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
		
		//지역가져오기
		String userId=principal.getName();
		String local=mservice.getLocal(principal);
		String []localArr = local.split(",");
		
		service.updateData(dto);
		
		return "redirect:../detail?idx="+dto.getIdx();
	}

	@GetMapping("/detail")
	public String content(@RequestParam String idx,
			@RequestParam (defaultValue = "1") int currentPage, 
			@RequestParam (required = false) String key,
			Model model, HttpServletRequest request, Principal principal,@ModelAttribute ProductDTO pdto,ReviewDTO rdto) {
		//由ъ뒪�듃�뿉�꽌 �뵒�뀒�씪�럹�씠吏�媛�硫� 議고쉶�닔 �삱�씪媛�寃�
		if(key!=null) {
			service.updateReadcount(idx);
		}


		//해당 idx의 데이터 가져오기
		ProductDTO dto = service.getData(idx);
		//�궗吏� ,濡� split(���몴 �씠誘몄�)
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
			//濡쒓렇�씤 �븘�씠�뵒 媛��졇�삤湲�
			String id = principal.getName();
			model.addAttribute("myId", id);

			//지역가져오기
			String userId="no";
			String local="";
			String []localArr = {};

			local = mservice.getLocal(principal);
			localArr=local.split(",");
			

			model.addAttribute("localCnt", localArr.length);
			model.addAttribute("localArr", localArr);


			//하트 버튼 클릭여부
			int likeCheck = plservice.plikeCheck(id,idx);
			model.addAttribute("likeCheck", likeCheck);

			//팔로우 여부

			int followCheck = flservice.followCheck(dto.getId(), id);
			System.out.println("follow?"+followCheck);
			model.addAttribute("followCheck", followCheck);

			if(id.equals(dto.getId())) {
				//�뙋留ㅼ긽�깭
				String sellstatus = dto.getSellstatus();
				if(sellstatus.equals("�뙋留ㅼ쨷")) {
					dto.setSellstatus("selling");
				} else if(sellstatus.equals("�삁�빟以�")) {
					dto.setSellstatus("reserved");
				} else {
					dto.setSellstatus("finished");
				}
			}
		}
		//팝업창 관련
		
		//팝업창 choose
		List<ChatDTO> poplist=rservice.getList(idx);
		model.addAttribute("poplist", poplist);
		model.addAttribute("idx", idx);
		
		//팝업창 insert
		
		String seller=principal.getName();
		model.addAttribute("seller", seller);
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		model.addAttribute("isLogin", isLogin);
		model.addAttribute("nick", nick);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("photo", photo);

		return "/product/detail";
	}

	@GetMapping("/auth/delete")
	public String deleteData(@RequestParam String idx, @RequestParam String currentPage) {
		service.deleteData(idx);

		return "redirect:../list?currentPage="+currentPage;
	}

	@ResponseBody
	@PostMapping("/updateLikecount")
	public int updateLikecount(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//product�쓽 likecount+1
		service.updateLikecount(idx);
		//product_like�쓽 �뜲�씠�꽣 異붽�
		plservice.insertPlike(id,idx);


		//like 수 리턴

		return service.getLikeCount(idx);
	}

	@ResponseBody
	@PostMapping("/updateLikeMinuscount")
	public int updateLikeMinuscount(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//product�쓽 likecount-1
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
			status = "�뙋留ㅼ쨷";
		} else if(status.equals("reserved")) {
			status = "�삁�빟以�";
		} else if(status.equals("finished")) {
			status = "�뙋留ㅼ셿猷�";
		}
		service.updateStatus(idx, status);
	}
	
	
	


	
	@PostMapping("/popinsert")
	public String insert(@ModelAttribute ReviewDTO rdto)
	{	
		rservice.ReviewInsert(rdto);
		
		return "/product/list";
	}
	

}
