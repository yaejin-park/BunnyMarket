package data.dto;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

@Alias("cdto")
public class CommunityDTO {
	private String idx;
	private String id;
	private String city;
	private String title;
	private String content;
	private String photo;
	private String original_photo;
	private int readcount;
	private int goodcount;
	private Timestamp writeday;
	private ArrayList<MultipartFile> upload;
	private int acount;
	
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getOriginal_photo() {
		return original_photo;
	}
	public void setOriginal_photo(String original_photo) {
		this.original_photo = original_photo;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getGoodcount() {
		return goodcount;
	}
	public void setGoodcount(int goodcount) {
		this.goodcount = goodcount;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	public ArrayList<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(ArrayList<MultipartFile> upload) {
		this.upload = upload;
	}
	public int getAcount() {
		return acount;
	}
	public void setAcount(int acount) {
		this.acount = acount;
	}
	
}
