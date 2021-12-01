package data.dto;

import org.apache.ibatis.type.Alias;

@Alias("cldto")
public class ChatListDTO {
	private String idx;
	private String chat_idx;
    private String id;
    private String  product_idx;
    
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
}
