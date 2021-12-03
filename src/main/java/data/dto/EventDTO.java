package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("edto")
public class EventDTO {
	private String idx;
	private String title;
	private String content;
	private String photo;
	private String original_photo;
	private String category;
	private Timestamp event_start;
	private Timestamp event_end;
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
	public String getOriginal_photo() {
		return original_photo;
	}
	public void setOriginal_photo(String original_photo) {
		this.original_photo = original_photo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Timestamp getEvent_start() {
		return event_start;
	}
	public void setEvent_start(Timestamp event_start) {
		this.event_start = event_start;
	}
	public Timestamp getEvent_end() {
		return event_end;
	}
	public void setEvent_end(Timestamp event_end) {
		this.event_end = event_end;
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
