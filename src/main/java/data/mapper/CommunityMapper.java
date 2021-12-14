package data.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ComReplyDTO;
import data.dto.CommunityDTO;
import data.dto.EventReplyDTO;
import data.dto.MemberDTO;

@Mapper
public interface CommunityMapper {
	public List<CommunityDTO> getList(int start,int perpage,String keyword,String city);
	public CommunityDTO getData(String idx);
	public void insert(CommunityDTO dto);
	public List<CommunityDTO> getAllDatas();
	public int getMaxNum();
	public int getTotalCount(String keyword,String city);
	public void updateReadCount(String idx);
	public void delete(String idx);
	public void update(CommunityDTO dto);
	public MemberDTO getMemData(String idx);
	public int goodCheck(String userId,String idx);
	public int getGoodCount(String idx);
	public void updateGoodCount(String idx);
	public void updateGoodCancel(String idx);
	public void insertReplyData(ComReplyDTO dto);
	public void updateReplyStep(int restep, int regroup);
	public List<ComReplyDTO> getReplyList(String idx);
	public String getMaxReply(String idx);
	public void deleteReply(String idx);
}
