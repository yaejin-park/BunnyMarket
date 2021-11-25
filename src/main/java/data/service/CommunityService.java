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
		map.put("start", start);
		map.put("perpage", perpage);
		return mapper.getList(map);
	}
	
	public CommunityDTO getData(String idx)
	{
		return mapper.getData(idx);
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
	
	public int getTotalCount()
	{
		return mapper.getTotalCount();
	}
	public void updateReadCount(String idx)
	{
		mapper.updateReadCount(idx);
	}
	public void delete(String idx)
	{
		mapper.delete(idx);
	}
}
