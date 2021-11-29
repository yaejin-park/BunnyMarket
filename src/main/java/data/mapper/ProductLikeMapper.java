package data.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductLikeMapper {
	public int plikeCheck(String id, String product);
	public void insertPlike(String id, String product);
	public void deletePlike(String id, String product);
}
