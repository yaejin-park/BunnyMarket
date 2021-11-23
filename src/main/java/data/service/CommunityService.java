package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.CommunityDTO;
import data.mapper.CommunityMapper;

@Service
public class CommunityService {
	@Autowired
	CommunityMapper mapper;
	
	public List<CommunityDTO> getList(int start,int perpage)
	{
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		return mapper.getList(map);
	}
	
	public CommunityDTO getData(String num)
	{
		return mapper.getData(num);
	}
	
	public void insert(CommunityDTO dto)
	{
		mapper.insert(dto);
	}
	
	public List<CommunityDTO> getAllDatas()
	{
		return mapper.getAllDatas();
	}
	
	public int getMaxNum()
	{
		return mapper.getMaxNum();
	}

}
