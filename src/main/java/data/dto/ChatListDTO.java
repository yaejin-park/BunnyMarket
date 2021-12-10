package data.dto;

import org.apache.ibatis.type.Alias;

@Alias("cldto")
public class ChatListDTO {
	private String idx;
	private String chat_idx;
    private String id;
    private String  product_idx;
    
    //채팅 리스트 조인
    private String profile;
    private String nickname;
    private String upload_file;
    private String last_msg;
    
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(String chat_idx) {
		this.chat_idx = chat_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(String product_idx) {
		this.product_idx = product_idx;
	}
	
	//채팅 리스트 조인
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getUpload_file() {
		return upload_file;
	}
	public void setUpload_file(String upload_file) {
		this.upload_file = upload_file;
	}
	public String getLast_msg() {
		return last_msg;
	}
	public void setLast_msg(String last_msg) {
		this.last_msg = last_msg;
	}
}
	
