package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.NoticeDTO;


@Mapper
public interface NoticeMapper {
	
	public void NoticeInsert(NoticeDTO dto);
	public void NoticeDelete(String idx);
	public void NoticeUpdate(NoticeDTO dto);
	public int NgetTotalCount();
	public List<NoticeDTO> NgetList(HashMap<String, Integer> map);
	public int getMaxidx();
	public void updateReadCount(String idx);
	public NoticeDTO getData(String idx);

}
