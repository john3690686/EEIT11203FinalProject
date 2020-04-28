package tw.gameshop.user.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleService {
	private ArticleDAO artDao;

	public ArticleService() {
	}

	@Autowired
	public ArticleService(ArticleDAO artDao) {
		this.artDao = artDao;
	}

	public Article addArticle(int userId, String articleTitle, String articleAbstract, String articleContent) {
		return artDao.addArticle(userId, articleTitle,articleAbstract, articleContent);
	}
	
	public String queryAllData() {
		return artDao.queryAllData();
	}
	
	public String queryMyArticle(int userId) {
		return artDao.queryMyArticle(userId);
	}
	
	public String queryArticle(int articleID) {
		return artDao.queryArticle(articleID);
	}
	
	public Article updataArticle(int articleID, String articleTitle, String articleAbstract, String articleContent) {
		return artDao.updataArticle(articleID, articleTitle, articleAbstract, articleContent);
	}
	
	public Article deleteArticle(int articleID) {
		return artDao.deleteArticle(articleID);
	}
	
}
