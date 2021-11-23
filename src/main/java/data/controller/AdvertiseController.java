package data.controller;

import java.io.File;
import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.Date;
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
	public ModelAndView list() {
		ModelAndView mview=new ModelAndView();
		
		mview.setViewName("/advertise/list");
		return mview;
	}
	
	@GetMapping("/form")
	public String from() {
		return "/advertise/writeForm";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute AdvertiseDTO dto, HttpSession session,
				@RequestParam MultipartFile selectImg) {
		//uuid 생성
		UUID uuid=UUID.randomUUID();
		
		//이미지 업로드 폴더 지정
		String path=session.getServletContext().getRealPath("/photo");
		System.out.println(path);
		
		//업로드 이미지 파일명
		//SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		
		//이미지 업로드 안했을때
		if(dto.getPhotoUpload().getOriginalFilename().equals("")) {
			dto.setPhoto("no");
		}else {	//이미지 업로드 했을때
			//String photoupload="f"+sdf.format(new Date())+dto.getPhotoUpload().getOriginalFilename();
			String photo=uuid.toString()+"_"+dto.getPhotoUpload().getOriginalFilename();
			dto.setPhoto(photo);
			//실제 업로드
			try {
				dto.getPhotoUpload().transferTo(new File(path+"\\"+photo));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//insert
		service.insertAdvertise(dto);
		//return "redirect:detail?idx="+service.getMaxNum();
		return "redirect:list";
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
	public String delete() {
		return "redirect:list?currentPage=";
	}
}
