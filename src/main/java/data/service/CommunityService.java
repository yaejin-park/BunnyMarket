package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.CommunityDTO;
import data.dto.MemberDTO;
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
	public void update(CommunityDTO dto)
	{
		mapper.update(dto);
	}
	public MemberDTO getMemData(@RequestParam String idx)
	{
		return mapper.getMemData(idx);
	}
	public int goodCheck(String id, String idx) {
		return mapper.goodCheck(id, idx);
	}
	public int getGoodCount(@RequestParam String idx) {
		return mapper.getGoodCount(idx);
	}
	public void updateGoodcount(@RequestParam String idx) {
		mapper.updateGoodcount(idx);
	}
	public void updateGoodCancel(@RequestParam String idx) {
		mapper.updateGoodCancel(idx);
	}
	public void insertGood(String id, String idx){
		mapper.insertGood(id,idx);
	}
	public void deleteGood(String id, String idx) {
		mapper.deleteGood(id, idx);
	}
}
