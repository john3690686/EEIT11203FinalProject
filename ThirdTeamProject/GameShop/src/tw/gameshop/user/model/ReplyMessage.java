package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "REPLYMESSAGE")
public class ReplyMessage {

	private int replyMessageID;
	private int messageID;
	private String messageContent;
	private String postDatetime;

	@Id
	@Column(name = "replyMessageID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getReplyMessageID() {
		return replyMessageID;
	}

	public void setReplyMessageID(int replyMessageID) {
		this.replyMessageID = replyMessageID;
	}

	@Column(name = "messageID")
	public int getMessageID() {
		return messageID;
	}

	public void setMessageID(int messageID) {
		this.messageID = messageID;
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
