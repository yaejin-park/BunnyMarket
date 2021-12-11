package data.controller;

import java.io.File;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.dto.NoticeDTO;
import data.mapper.NoticeMapper;
import data.service.MemberService;
import data.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService Nservice;
	@Autowired
	MemberService Mservice;

	@Autowired
	NoticeMapper Nmapper;

	@GetMapping("/list")
	public ModelAndView list(
			@RequestParam(defaultValue = "1") int currentPage,
			Principal principal
	)

	{
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
	      String userId = "no";
	      String local = "";
	      String[] localArr = {};
	      if(principal != null) {
	         userId = principal.getName();
	         local =Mservice.getLocal(principal);
	         localArr = local.split(",");
	      }
	      mview.addObject("localCnt",localArr.length);
	      mview.addObject("localArr",localArr);

		int totalCount = Nservice.NgetTotalCount();

		int perPage = 5; 
		int totalPage; 
		int start; 
		int perBlock = 5; 
		int startPage; 
		int endPage; 

		
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		
		start = (currentPage - 1) * perPage;
		
		List<NoticeDTO> list = Nservice.NgetList(start, perPage);

		int num = totalCount - (currentPage - 1) * perPage;
		

		String admin="no";
		if(principal != null) {
			admin=Mservice.currentUserType(principal);
		}
		
		mview.addObject("admin", admin);
		mview.addObject("list", list);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("num", num);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/notice/list");
		return mview;
	}


	@PostMapping("insert")
	public String insert(@ModelAttribute NoticeDTO dto, HttpSession session,@RequestParam ArrayList<MultipartFile> upload) {
		
		
		String path=session.getServletContext().getRealPath("/photo");
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		
		
		String photo="";
		
		if(upload.get(0).getOriginalFilename().equals(""))
			photo="no";
		else {
			
			for(MultipartFile f:upload)
			{
				String fName="f"+sdf.format(new Date())+f.getOriginalFilename();
				photo+=fName+",";
				
				try {
					f.transferTo(new File(path+"/"+fName));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
			photo=photo.substring(0,photo.length()-1);
		}
	
		dto.setPhoto(photo);
		

		// insert
		Nservice.NoticeInsert(dto);
		
		return "redirect:content?idx=" + Nservice.getMaxidx();

	}
	

	@GetMapping("/delete")
	public String delete(String idx, String currentPage, HttpSession session) {
		
		String path=session.getServletContext().getRealPath("/photo");
		String uploadfile=Nservice.getData(idx).getPhoto();
		File file=new File(path+"/"+uploadfile);
		file.delete();

		Nservice.NoticeDelete(idx);
		return "redirect:list?currentPage=" + currentPage;
	}

	@RequestMapping("checkboxdel")
	@ResponseBody
	public void deleteReport(String arrdata) {
		Nservice.NoticeDelete(arrdata);
	}

	@GetMapping("/updateform")
	public ModelAndView updatForm(String idx, String currentPage) {
		ModelAndView mview = new ModelAndView();
		NoticeDTO dto = Nservice.getData(idx);
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		mview.setViewName("/notice/updateform");
		return mview;
	}

	@PostMapping("/update")
	public String update(@ModelAttribute NoticeDTO dto, String currentPage, HttpSession session,@RequestParam ArrayList<MultipartFile> upload) {
		
		
		
	
		
		String path=session.getServletContext().getRealPath("/photo");
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		
		
		

		String photo="";
		
		
		if(upload.get(0).getOriginalFilename().equals(""))
			photo="no";
		else {
			
			for(MultipartFile f:upload)
			{
				String fName="f"+sdf.format(new Date())+f.getOriginalFilename();
				photo+=fName+",";
				
				try {
					f.transferTo(new File(path+"/"+fName));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
			photo=photo.substring(0,photo.length()-1);
		}
	
		dto.setPhoto(photo);
		
		


		

		Nservice.NoticeUpdate(dto);
		return "redirect:content?idx="+dto.getIdx()+"&currentPage="+currentPage;

	}

	@GetMapping("/writeform")
	public String writeform() {
		return "/notice/insertform";
	}

	@GetMapping("/content")
	public ModelAndView content(@RequestParam String idx, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String key,
			Principal principal)

	{
		ModelAndView mview = new ModelAndView();
		if (key != null)
			Nservice.updateReadCount(idx);

		NoticeDTO dto = Nservice.getData(idx);
		
		
		

		int dotLoc=dto.getPhoto().lastIndexOf('.');
		String ext=dto.getPhoto().substring(dotLoc+1);
		if(ext.equalsIgnoreCase("jpg")||ext.equalsIgnoreCase("gif")||
				ext.equalsIgnoreCase("png")||ext.equalsIgnoreCase("jpeg"))
			mview.addObject("bupload", true);
		else
			mview.addObject("bupload", false);
		
		String before=Nservice.before(idx);
		String next=Nservice.next(idx);
		String beforetitle=Nservice.beforetitle(idx);
		String nexttitle=Nservice.nexttitle(idx);
		
		
		String admin="no";
		if(principal != null) {
			admin=Mservice.currentUserType(principal);
		}
		
		mview.addObject("admin", admin);
		mview.addObject("beforetitle", beforetitle);
		mview.addObject("nexttitle", nexttitle);
		mview.addObject("before", before);
		mview.addObject("next", next);
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		
		mview.setViewName("/notice/content");
		return mview;
		
		
	
	}
	
	@GetMapping("/test")
	public String test() {
		return "/notice/test";
	}
	
	


}
