package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Immutable;
import org.springframework.stereotype.Component;

@Entity
@Immutable
@Table(name = "ComandPro")
@Component
public class ComandPro {

	@Id @Column(name = "comId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer comId;
	
	@Column(name = "userId")
	private Integer userId;
	
	@Column(name = "nickName")
	private String nickName;
	
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

	public Integer getComId() {
		return comId;
	}

	public void setComId(Integer comId) {
		this.comId = comId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
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

	public void setPostDatetime(String postDatetime) {
		this.postDatetime = postDatetime;
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
