package data.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FollowMapper {
	public int followCheck(String followee, String follower);
	public void insertFollow(String followee, String follower);
	public void deleteFollow(String followee, String follower);
}
