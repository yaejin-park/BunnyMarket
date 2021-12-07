package data.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.CommunityDTO;
import data.dto.MemberDTO;

@Mapper
public interface CommunityMapper {
	public List<CommunityDTO> getList(HashMap<String, Integer> map);
	public CommunityDTO getData(String idx);
	public void insert(CommunityDTO dto);
	public List<CommunityDTO> getAllDatas();
	public int getMaxNum();
	public int getTotalCount();
	public void updateReadCount(String idx);
	public void delete(String idx);
	public void update(CommunityDTO dto);
	public MemberDTO getMemData(String idx);
	public int goodCheck(String id,String idx);
	public int getGoodCount(String idx);
	public void updateGoodcount(String idx);
	public void updateGoodCancel(String idx);
	public void insertGood(String id, String idx);
	public void deleteGood(String id, String idx);
}
