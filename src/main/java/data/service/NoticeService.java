package data.service;




import java.util.HashMap;


import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import data.dto.NoticeDTO;

import data.mapper.NoticeMapper;

@Service
public class NoticeService {
	
	@Autowired
	NoticeMapper Nmapper;
	
	public int NgetTotalCount()
	{
		return Nmapper.NgetTotalCount();
	}
	
	public List<NoticeDTO> NgetList(int start,int perpage)
	{
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		return Nmapper.NgetList(map);
		
	}
	
	
	public void NoticeInsert(NoticeDTO dto)
	{
		Nmapper.NoticeInsert(dto);
	}
	
	
	public int getMaxidx()
	{
		return Nmapper.getMaxidx();
	}
	
	public void NoticeDelete(String idx)
	{
		 Nmapper.NoticeDelete(idx);
	}
	
	public void updateReadCount(String idx)
	{
		 Nmapper.updateReadCount(idx);
	}
	
	public NoticeDTO getData(String idx)
	{
		return Nmapper.getData(idx);
	}
	
	
	public void NoticeUpdate(NoticeDTO dto)
	{
		 Nmapper.NoticeUpdate(dto);
	}
	
}
	

