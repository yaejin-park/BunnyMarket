package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("rdto")
public class ReviewDTO {
	private String reviwer;
	private String reviewee;
	private String content;
	private String star;
	private Timestamp writeday;
	private String product_idx;
	
	public String getReviwer() {
		return reviwer;
	}
	public void setReviwer(String reviwer) {
		this.reviwer = reviwer;
	}
	public String getReviewee() {
		return reviewee;
	}
	public void setReviewee(String reviewee) {
		this.reviewee = reviewee;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	public String getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(String product_idx) {
		this.product_idx = product_idx;
	}
}
