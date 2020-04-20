package tw.gameshop.user.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class ArticleDAO {

	private SessionFactory sessionFactory;

	public ArticleDAO() {
	}

	@Autowired
	public ArticleDAO(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Article addArticle(int userId, String articleTitle, String articleAbstract, String articleContent) {
		Session session = sessionFactory.getCurrentSession();

		Date date = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd  hh:mm:ss");
		Article article = new Article();
		article.setUserId(userId);
		article.setArticleTitle(articleTitle);
		article.setArticleAbstract(articleAbstract);
		article.setArticleContent(articleContent);
		article.setPostDatetime(ft.format(date));

		if (article != null) {
			session.save(article);
		}

		return article;
	}

	public String queryAllData() {
		Session session = sessionFactory.getCurrentSession();
		Query<Article> query = session.createQuery("From Article", Article.class);
		List<Article> list = query.list();

		JSONArray jsonAr = new JSONArray();

		for (Article li : list) {
			JSONObject json = new JSONObject();
			json.put("articleID", li.getArticleID());
			json.put("userId", li.getUserId());
			json.put("articleTitle", li.getArticleTitle());
			json.put("articleAbstract", li.getArticleAbstract());
			json.put("articleContent", li.getArticleContent());
			json.put("postDatetime", li.getPostDatetime());
			json.put("updateDatetime", li.getUpdateDatetime());
			jsonAr.put(json);
		}

		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");
		return json;
	}
	
	public String queryMyArticle(int userId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Article> query = session.createQuery("From Article where userId = :userId", Article.class);
		query.setParameter("userId", userId);
		List<Article> list = query.list();

		JSONArray jsonAr = new JSONArray();

		for (Article li : list) {
			JSONObject json = new JSONObject();
			json.put("articleID", li.getArticleID());
			json.put("userId", li.getUserId());
			json.put("articleTitle", li.getArticleTitle());
			json.put("articleAbstract", li.getArticleAbstract());
			json.put("articleContent", li.getArticleContent());
			json.put("postDatetime", li.getPostDatetime());
			json.put("updateDatetime", li.getUpdateDatetime());
			jsonAr.put(json);
		}

		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");
		System.out.println(json);
		return json;
	}

	public String queryArticle(int articleID) {
		Session session = sessionFactory.getCurrentSession();
		Article queryArt = session.get(Article.class, articleID);

		JSONArray jsonAr = new JSONArray();
		if(queryArt != null) {
			JSONObject json = new JSONObject();
			json.put("articleID", queryArt.getArticleID());
			json.put("userId", queryArt.getUserId());
			json.put("articleTitle", queryArt.getArticleTitle());
			json.put("articleAbstract", queryArt.getArticleAbstract());
			json.put("articleContent", queryArt.getArticleContent());
			json.put("postDatetime", queryArt.getPostDatetime());
			json.put("updateDatetime", queryArt.getUpdateDatetime());
			jsonAr.put(json);
		}
		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");
		return json;
	}

}
