package data.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {
	
	public void NoticeInsert();
	public void NoticeDelete();
	public void NoticeUpdate();
	

}
