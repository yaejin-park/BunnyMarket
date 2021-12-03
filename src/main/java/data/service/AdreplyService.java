package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.AdreplyDTO;
import data.mapper.AdreplyMapper;

@Service
public class AdreplyService {
	@Autowired
	AdreplyMapper mapper;
	
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	
	public int getMaxIdx() {
		return mapper.getMaxIdx();
	}
	
	public void updateRestep(int regroup, int restep) {
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("regroup", regroup);
		map.put("restep", restep);
		return;
	}
	
	public void insertReply(AdreplyDTO dto) {
		int idx=dto.getIdx();	//0:새글, 1보다 큰 값:답글
		int regroup=dto.getRegroup();
		int restep=dto.getRestep();
		int relevel=dto.getRelevel();
		
		if(idx==0) {
			regroup=getMaxIdx()+1;	//idx 의 최대값+1
			restep=0;
			relevel=0;
		}else {
			this.updateRestep(regroup, restep);	//같은 그룹중 전달받은 restep 보다 큰 글들은 모두 +1
			//전달받은 step과 level +1
			restep++;
			relevel++;
		}
		//바뀐 값들을 다시 dto에 넣는다
		dto.setRegroup(regroup);
		dto.setRestep(restep);
		dto.setRelevel(relevel);
		
		//insert
		mapper.insertReply(dto);
	}
	
	public void updateReply(AdreplyDTO dto) {
		mapper.updateReply(dto);
	}
	
	public void deleteReply(int idx) {
		mapper.deleteReply(idx);
	}
	
	public AdreplyDTO getReply(int idx) {
		return mapper.getReply(idx);
	}
	
	public List<AdreplyDTO> getReplyList(int idx) {
		return mapper.getReplyList(idx);
	}
}
