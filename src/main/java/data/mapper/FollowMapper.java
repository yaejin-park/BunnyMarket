package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.FollowDTO;

@Mapper
public interface FollowMapper {
	public int followCheck(String followee, String follower);
	public void insertFollow(String followee, String follower);
	public void deleteFollow(String followee, String follower);
	
	//follow list
	public List<FollowDTO> getFollowList(String idx);
}
