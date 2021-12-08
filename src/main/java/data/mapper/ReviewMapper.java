package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;



@Mapper
public interface ReviewMapper {
	
	public List<String> getTime(String id);

	

}
