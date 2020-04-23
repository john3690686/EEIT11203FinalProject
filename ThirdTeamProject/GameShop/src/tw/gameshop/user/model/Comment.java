package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "comment")
@Component
public class Comment {
	
	@Id @Column(name = "comId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer comId;
	
	@Column(name = "userId")
	private Integer userId;
	
	@Column(name = "productId")
	private Integer productId;
	
	@Column(name = "comment")
	private String comment;
	
	@Column(name = "postDatetime")
	private String postDatetime;
	
	@Column(name = "reply")
	private String reply;
	
	@Column(name = "replyDatetime")
	private String replyDatetime;
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Comment() {
	}
	
	public Integer getComId() {
		return comId;
	}

	public void setComId(Integer comId) {
		this.comId = comId;
	}
	
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getPostDatetime() {
		return postDatetime;
	}

	public void setPostDatetime(String date) {
		this.postDatetime = date;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getReplyDatetime() {
		return replyDatetime;
	}

	public void setReplyDatetime(String replyDatetime) {
		this.replyDatetime = replyDatetime;
	}
	
}
