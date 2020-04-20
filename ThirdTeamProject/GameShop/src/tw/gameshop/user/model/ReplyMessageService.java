package tw.gameshop.user.model;

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
	
	public ReplyMessage addReply(int messageID, String messageContent) {
		return reMessage.addReply(messageID, messageContent);
	}
	
	public String queryReplyById(int messageID) {
		return reMessage.queryReplyById(messageID);
	}
}
