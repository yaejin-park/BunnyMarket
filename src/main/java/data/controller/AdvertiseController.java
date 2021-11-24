package data.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.dto.AdvertiseDTO;
import data.service.AdvertiseService;

@Controller
@RequestMapping("/advertise")
public class AdvertiseController {
	@Autowired
	AdvertiseService service;
	
	@GetMapping("/list")
	public ModelAndView list(@RequestParam(defaultValue = "1") int currentPage) {
		ModelAndView mview=new ModelAndView();
		int totalCount=service.getTotalCount();
		
		//페이징에 필요한 변수들
		int perPage=10;
		int totalPage;
		int start;
		int perBlock=5;
		int startPage;
		int endPage;
		
		//총 페이지 개수
		totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
		//각 블럭의 시작페이지
		startPage=(currentPage-1)/perBlock*perBlock+1;
		endPage=startPage+perBlock-1;
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		//각 페이지에서 불러올 시작번호
		start=(currentPage-1)*perPage;
		
		//각 페이지에서 필요한 게시글 가져오기
		List<AdvertiseDTO> list=service.getList(start, perPage);
		//list에 각 글에 대한 작성자 추가
		for(AdvertiseDTO a:list) {			
			
		}
		
		//시작번호
		//int no=totalCount-(currentPage-1)*perPage;
		
		//출력에 필요한 변수들 request에 저장
		mview.addObject("list", list);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		//mview.addObject("no", no);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);

//		AdvertiseDTO dto=service.getData(idx);
//		String []thumbnail=dto.getPhoto().split(",");
//		mview.addObject("dto", dto);
//		mview.addObject("thumbnail", thumbnail);
		
		mview.setViewName("/advertise/list");
		return mview;
	}
	
	@GetMapping("/form")
	public String from() {
		return "/advertise/writeForm";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute AdvertiseDTO dto,HttpSession session) {
		//uuid 생성
		UUID uuid=UUID.randomUUID();
		
		List<MultipartFile> mf=dto.getPhotoupload();
		
		//이미지 업로드 안했을때
		if(mf.get(0).getOriginalFilename().equals("")) {
			dto.setPhoto("no");
		}else {	//이미지 업로드 했을때
			//이미지 업로드 폴더 지정
			String path=session.getServletContext().getRealPath("/photo");
			String photoplus="";
			System.out.println(path);
			
			for(int i=0;i<mf.size();i++) {
				String photo=uuid.toString()+"_"+mf.get(i).getOriginalFilename();
				//실제 업로드
				try {
					mf.get(i).transferTo(new File(path+"\\"+photo));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				photoplus += photo+",";
			}
			//마지막 콤마 제거
			photoplus = photoplus.substring(0, photoplus.length()-1);
			dto.setPhoto(photoplus);
		}
		//insert
		service.insertAdvertise(dto);
		return "redirect:detail?idx="+service.getMaxIdx();
		//return "redirect:list";
	}
	
	@GetMapping("/detail")
	public ModelAndView detail(@RequestParam String idx,
				@RequestParam(defaultValue = "1") int currentPage,
				@RequestParam(required = false) String key) {
		ModelAndView mview=new ModelAndView();
		
		//조회수 증가
		if(key!=null) {
			service.updateReadCount(idx);
		}
		
		AdvertiseDTO dto=service.getData(idx);
		
		//id,,,
		
		mview.addObject("dto", dto);
		mview.addObject("currnetPage", currentPage);
		
		//이미지
		String []dbimg=dto.getPhoto().split(",");
		mview.addObject("dbimg", dbimg);
		
		mview.setViewName("/advertise/detail");
		return mview;
	}
	
	@GetMapping("/updateform")
	public ModelAndView updateForm() {
		ModelAndView mview=new ModelAndView();
		mview.setViewName("/updateForm");
		return mview;
	}
	
	@PostMapping("/update")
	public String update() {
		return "redirect:detail?num=";
	}
	
	@GetMapping("/delete")
	public String delete(String idx, String currentPage,
				HttpSession session, AdvertiseDTO dto) {
		//글삭제시 저장된 이미지도 삭제
		String path=session.getServletContext().getRealPath("/photo");
		//업로드된 이미지명
		String uploadimg=service.getData(dto.getIdx()).getPhoto();
		//File 객체 생성
		File file=new File(path+"\\"+uploadimg);
		//이미지 삭제
		file.delete();
		
		service.deleteAdvertise(idx);
		return "redirect:list?currentPage="+currentPage;
	}
}
