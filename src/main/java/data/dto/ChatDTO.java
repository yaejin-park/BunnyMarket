package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;


@Alias("chdto")
public class ChatDTO {
	private String idx;
	private String product_idx;
	private String seller_id;
	private String buyer_id;
	private String chat_file;
	private Timestamp last_time;
	private String state;
	private MemberDTO mdto;
	private String nickname;
	private String id;
	private String profile;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public MemberDTO getMdto() {
		return mdto;
	}
	public void setMdto(MemberDTO mdto) {
		this.mdto = mdto;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	//txt
	private String sender;
	private String time;
	private String msg;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(String product_idx) {
		this.product_idx = product_idx;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getBuyer_id() {
		return buyer_id;
	}
	public void setBuyer_id(String buyer_id) {
		this.buyer_id = buyer_id;
	}
	public String getChat_file() {
		return chat_file;
	}
	public void setChat_file(String chat_file) {
		this.chat_file = chat_file;
	}
	public Timestamp getLast_time() {
		return last_time;
	}
	public void setLast_time(Timestamp last_time) {
		this.last_time = last_time;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public ChatDTO() {
		
	}
	
	public ChatDTO(String sender, String time, String msg) {
		super();
		this.sender = sender;
		this.time = time;
		this.msg = msg;
	}
}
