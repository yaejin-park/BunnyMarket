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
			@RequestParam (defaultValue = "전") String category,
			@RequestParam (required = false) String keyword) { 
	ModelAndView mview = new ModelAndView();
	
	int totalCount = service.getTotalCount(category);
	
	//�럹�씠吏� 泥섎━�뿉 �븘�슂�븳 蹂��닔 �꽑�뼵
	int perPage = 20;
	int totalPage;
	int start;
	int perBlock = 5;
	int startPage;
	int endPage;
	
	//珥� �럹�씠吏� 媛��닔 援ы븯湲�
	totalPage = totalCount/perPage+(totalCount%perPage==0?0:1);
	//媛� 釉붾윮�쓽 �떆�옉 �럹�씠吏�
	startPage = (currentPage-1)/perBlock*perBlock +1;
	//媛� 釉붾윮�쓽 留덉�留� �럹�씠吏�
	endPage = startPage + perBlock -1;
	
	if(endPage > totalPage) {
		endPage = totalPage;
	}
	
	//媛� �럹�씠吏��뿉�꽌 遺덈윭�삱 �떆�옉踰덊샇
	start = (currentPage-1)*perPage;
	
	List<ProductDTO> list = service.getList(start, perPage, category, keyword);
	
	//媛� �럹�씠吏��뿉 異쒕젰�븷 �떆�옉踰덊샇
	int no = totalCount-(currentPage-1)*perPage;
	
	//異쒕젰�뿉 �븘�슂�븳 蹂��닔�뱾�쓣 request�뿉 ���옣
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

		List<MultipartFile> mf = dto.getUpload(); 
		
		// �뙆�씪 �뾽濡쒕뱶 �븞�뻽�쓣 寃쎌슦,
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
		
		service.insertData(dto);
	  
		return "redirect:../detail?idx="+service.getMaxIdx();
	}
	
	@GetMapping("/detail")
	public String content(@RequestParam String idx,
			@RequestParam (defaultValue = "1") int currentPage, 
			@RequestParam (required = false) String key,
			Model model, HttpServletRequest request, Principal principal) {
		//由ъ뒪�듃�뿉�꽌 �뵒�뀒�씪�럹�씠吏�媛�硫� 議고쉶�닔 �삱�씪媛�寃�
		if(key!=null) {
			service.updateReadcount(idx);
		}
		
		//�빐�떦 idx�쓽 �뜲�씠�꽣 媛��졇�삤湲�
		ProductDTO dto = service.getData(idx);
		//�궗吏� ,濡� split(���몴 �씠誘몄�)
		String []photo = dto.getUploadfile().split(",");
		
		//�땳�꽕�엫 媛��졇�삤湲�
		String nick = mservice.getNick(dto.getId());
		
		//媛숈� 移댄뀒怨좊━ �뿰愿��젣�뭹 蹂댁뿬二쇨린
		String category = dto.getCategory();
		List<ProductDTO> list = service.getRelateList(category,idx);
		
		//濡쒓렇�씤 �뿬遺�
		String isLogin = "N";
		isLogin = (String)request.getSession().getAttribute("isLogin");
		
		//濡쒓렇�씤 �릺�뼱 �엳�쓣 寃쎌슦,
		if(isLogin!=null) {
			//濡쒓렇�씤 �븘�씠�뵒 媛��졇�삤湲�
			String id = principal.getName();
			model.addAttribute("myId", id);
			
		
			//�븯�듃 踰꾪듉 �겢由��뿬遺�
			int likeCheck = plservice.plikeCheck(id,idx);
			model.addAttribute("likeCheck", likeCheck);
			
			//�뙏濡쒖슦 �뿬遺�
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
		
		//like �닔 由ы꽩
		return service.getLikeCount(idx);
	}
	
	@ResponseBody
	@PostMapping("/updateLikeMinuscount")
	public int updateLikeMinuscount(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//product�쓽 likecount-1
		service.updateLikeMinuscount(idx);
		
		//product_like�쓽 �뜲�씠�꽣 �궘�젣
		plservice.deletePlike(id,idx);
		
		//like �닔 由ы꽩
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
}
