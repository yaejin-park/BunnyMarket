package data.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.CommunityDTO;

@Mapper
public interface CommunityMapper {
	public List<CommunityDTO> getList(HashMap<String, Integer> map);
	public CommunityDTO getData(String idx);
	public void insert(CommunityDTO dto);

}
