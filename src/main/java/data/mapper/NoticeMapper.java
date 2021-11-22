package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.NoticeDTO;


@Mapper
public interface NoticeMapper {
	
	public void NoticeInsert(NoticeDTO dto);
	public void NoticeDelete(String idx);
	public void NoticeUpdate();
	public int NgetTotalCount();
	public List<NoticeDTO> NgetList(HashMap<String, Integer> map);
	public String NgetName(String id);
	public int getMaxidx();
	

}
