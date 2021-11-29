package data.dto;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;


@Alias("ndto")
public class NoticeDTO {
	
	private int idx;
	private String title;
	private String content;
	private int readcount;
	private Timestamp writeday;
	private MultipartFile upload;
	private String uploadfile;
	
	
	
	
	public String getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(String uploadfile) {
		this.uploadfile = uploadfile;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}


	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
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
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	
	
	
	
	

}
