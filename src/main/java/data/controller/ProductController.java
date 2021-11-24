package data.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductService service;

	
	@GetMapping("list") public ModelAndView productList(
			@RequestParam int start,@RequestParam int perpage) { 
		
	ModelAndView mview = new ModelAndView();
	
	List<ProductDTO> list = service.getList(start, perpage);
	
	mview.addObject("list", list);
	mview.setViewName("/product/list");
		  
	return mview; 
	}
	 

	@GetMapping("/updateForm")
	public ModelAndView updateForm(@RequestParam String idx) {
		ModelAndView mview = new ModelAndView();

		ProductDTO dto = service.getData(idx);

		mview.addObject("dto", dto);
		mview.setViewName("/product/updateForm");

		return mview;
	}

	@GetMapping("/insertForm")
	public String insertForm() {

		return "/product/insertForm";
	}

	@PostMapping("/insert")
	public String insertData(@ModelAttribute ProductDTO dto, HttpSession session) {
		// 로그인 안했을 경우, 종료
//		String loginok = (String) session.getAttribute("loginok");
//
//		if (loginok == null) {
//			return "login/loginmsg";
//		}

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
//		//세션에서 아이디 얻어서 dto에 저장
//		String id = (String)session.getAttribute("myid");
//		dto.setId(id);
//		
		service.insertData(dto);
	  
		return "redirect:detail?idx="+service.getMaxIdx();
	}
	
	@GetMapping("/detail")
	public String content(@RequestParam String idx, Model model) {
		ProductDTO dto = service.getData(idx);
		String []photo = dto.getUploadfile().split(",");
		
		model.addAttribute("dto", dto);
		model.addAttribute("photo", photo);
		
		return "/product/detail";
	}
	
	@GetMapping("/delete")
	public String deleteData(@RequestParam String idx) {
		service.deleteData(idx);
		
		return "/product/list";
	}

}
