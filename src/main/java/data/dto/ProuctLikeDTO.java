package data.dto;

import org.apache.ibatis.type.Alias;

@Alias("pldto")
public class ProuctLikeDTO {
	private String idx;
	private String product;
	private String id;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
