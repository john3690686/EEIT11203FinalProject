package tw.gameshop.user.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleMessageService {
	private ArticleMessageDAO artMesDao;
	
	public ArticleMessageService() {
	}

	@Autowired
	public ArticleMessageService(ArticleMessageDAO artMesDao) {
		this.artMesDao = artMesDao;
	}
	
	public ArticleMessage addArticleMessage(int articleID, int respUserId, String messageContent) {
		return artMesDao.addArticleMessage(articleID, respUserId, messageContent);
	}
	
	public String queryArticleMessage(int articleID) {
		return artMesDao.queryArticleMessage(articleID);
	}
	
	public String queryAMTimes() {
		return artMesDao.queryAMTimes();
	}
	
	public ArticleMessage deleteAllArticleMessage(int articleID) {
		return artMesDao.deleteAllArticleMessage(articleID);
	}
	
	public List<Integer> queryMessageId(int articleID) {
		return artMesDao.queryMessageId(articleID);
	}
	
	public String querynickname(String userId) {
		return artMesDao.querynickname(userId);
	}
	
	public String queryuserId(String userAccount) {
		return artMesDao.queryuserId(userAccount);
	}
}
