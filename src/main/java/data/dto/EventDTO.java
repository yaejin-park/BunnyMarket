package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("edto")
public class EventDTO {
	private String idx;
	private String title;
	private String content;
	private String photo;
	private String readcount;
	private String applycount;
	private Timestamp writeday;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
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
	public String getReadcount() {
		return readcount;
	}
	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}
	public String getApplycount() {
		return applycount;
	}
	public void setApplycount(String applycount) {
		this.applycount = applycount;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
}
