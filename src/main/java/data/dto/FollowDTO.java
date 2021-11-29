package data.dto;

import org.apache.ibatis.type.Alias;

@Alias("fldto")
public class FollowDTO {
	private String idx;
	private String followee;
	private String follower;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getFollowee() {
		return followee;
	}
	public void setFollowee(String followee) {
		this.followee = followee;
	}
	public String getFollower() {
		return follower;
	}
	public void setFollower(String follower) {
		this.follower = follower;
	}
}
