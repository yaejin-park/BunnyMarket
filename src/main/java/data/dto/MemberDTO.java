package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("mdto")
public class MemberDTO {
	private String idx;
	private String id;
	private String pw;
	private String name;
	private String nickname;
	private String email;
	private String addr;
	private String hp;
	private String profile;
	private String local;
	private String type;
	private Timestamp joinday;
	private String zonecode;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getLocal() {
		return local;
	}
	public void setLocal(String local) {
		this.local = local;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Timestamp getJoinday() {
		return joinday;
	}
	public void setJoinday(Timestamp joinday) {
		this.joinday = joinday;
	}
	public String getZonecode() {
		return zonecode;
	}
	public void setZonecode(String zonecode) {
		this.zonecode = zonecode;
	}
}
