package tw.gameshop.user.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyMessageService {
	
	private ReplyMessageDAO reMessage;

	public ReplyMessageService() {
	}
	
	@Autowired
	public ReplyMessageService(ReplyMessageDAO reMessage) {
		this.reMessage = reMessage;
	}
	
	public ReplyMessage addReply(int articleID, int messageID, String messageContent) {
		return reMessage.addReply(articleID, messageID, messageContent);
	}
	
	public String queryAllReply(int articleID) {
		return reMessage.queryAllReply(articleID);
	}
	
	public ReplyMessage deleteAllReplyMessage(int replyMessageID) {
		return reMessage.deleteAllReplyMessage(replyMessageID);
	}
	
	public List<Integer> queryReplyId(int articleID) {
		return reMessage.queryReplyId(articleID);
	}
}
