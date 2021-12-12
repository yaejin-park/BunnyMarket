package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.FaqDTO;

@Mapper
public interface FaqMapper {
	public FaqDTO getData(String idx);
	public void insertFaq(FaqDTO dto);
	public List<FaqDTO> getList(HashMap<String, Integer> map);
	public int getTotalCount();
	public int getTotalCountByCategory(String category);
	public FaqDTO getCategory(String category);
	public List<FaqDTO> getListByCategory(HashMap<String, Object>map);
	public void updateFaq(FaqDTO dto);
	public int getMaxNum();
	public void deleteFaq(String num);
}
