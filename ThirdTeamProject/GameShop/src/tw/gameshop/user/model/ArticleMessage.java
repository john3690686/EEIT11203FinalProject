package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ARTICLEMESSAGE")
public class ArticleMessage {
	private int messageID;
	private int articleID;
	private int respUserId;
	private String messageContent;
	private String postDatetime;
	
	@Id
	@Column(name = "messageID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getMessageID() {
		return messageID;
	}

	
	public void setMessageID(int messageID) {
		this.messageID = messageID;
	}
	
	@Column(name = "articleID")
	public int getArticleID() {
		return articleID;
	}

	public void setArticleID(int articleID) {
		this.articleID = articleID;
	}

	@Column(name = "respUserId")
	public int getRespUserId() {
		return respUserId;
	}

	public void setRespUserId(int respUserId) {
		this.respUserId = respUserId;
	}


	@Column(name = "messageContent")
	public String getMessageContent() {
		return messageContent;
	}


	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	@Column(name = "postDatetime")
	public String getPostDatetime() {
		return postDatetime;
	}


	public void setPostDatetime(String postDatetime) {
		this.postDatetime = postDatetime;
	}





}
