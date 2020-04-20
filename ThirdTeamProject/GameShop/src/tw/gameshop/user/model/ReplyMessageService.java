package tw.gameshop.user.model;

import org.springframework.stereotype.Service;

@Service
public class ReplyMessageService {
	
	private ReplyMessageDAO reMessage;

	public ReplyMessageService() {
	}
	
	public ReplyMessageService(ReplyMessageDAO reMessage) {
		this.reMessage = reMessage;
	}
}
