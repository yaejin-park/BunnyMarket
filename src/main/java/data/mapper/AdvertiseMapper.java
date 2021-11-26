package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.AdvertiseDTO;

@Mapper
public interface AdvertiseMapper {
	public int getTotalCount();
	//목록
	public List<AdvertiseDTO> getList(HashMap<String, Integer> map);
	//조회수
	public void updateReadCount(String idx);
	
	public AdvertiseDTO getData(String idx);
	public int getMaxIdx();
	
	//insert
	public void insertAdvertise(AdvertiseDTO dto);
	//update
	public void updateAdvertise(AdvertiseDTO dto);
	//delete
	public void deleteAdvertise(String idx);
}
