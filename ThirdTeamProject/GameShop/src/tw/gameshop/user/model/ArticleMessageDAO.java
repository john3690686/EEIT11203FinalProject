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
public class ArticleMessageDAO {

	private SessionFactory sessionFactory;

	public ArticleMessageDAO() {
	}
	
	@Autowired
	public ArticleMessageDAO(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public ArticleMessage addArticleMessage(int articleID, int respUserId, String messageContent) {
		Session session = sessionFactory.getCurrentSession();
		Date date = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		ArticleMessage artMessage = new ArticleMessage();
		artMessage.setArticleID(articleID);
		artMessage.setRespUserId(respUserId);
		artMessage.setMessageContent(messageContent);
		artMessage.setPostDatetime(ft.format(date));
		if (artMessage != null) {
			session.save(artMessage);
		}
		
		return artMessage;
	}
	
	public String queryArticleMessage(int articleID) {
		Session session = sessionFactory.getCurrentSession();
		Query<ArticleMessage> query = session.createQuery("From ArticleMessage where articleID = :articleID order by postDatetime", ArticleMessage.class);
		query.setParameter("articleID", articleID);
		List<ArticleMessage> list = query.list();

		JSONArray jsonAr = new JSONArray();

		for (ArticleMessage li : list) {
			JSONObject json = new JSONObject();
			json.put("messageID", li.getMessageID());
			json.put("articleID", li.getArticleID());
			json.put("respUserId", li.getRespUserId());
			json.put("messageContent", li.getMessageContent());
			json.put("postDatetime", li.getPostDatetime());
			
			jsonAr.put(json);
		}

		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");
		return json;
	}
	
}
