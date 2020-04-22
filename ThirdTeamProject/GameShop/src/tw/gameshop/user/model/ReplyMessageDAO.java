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
public class ReplyMessageDAO {

	private SessionFactory sessionFactory;

	public ReplyMessageDAO() {
	}

	@Autowired
	public ReplyMessageDAO(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public ReplyMessage addReply(int articleID, int messageID, String messageContent) {
		Session session = sessionFactory.getCurrentSession();
		Date date = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		ReplyMessage rm = new ReplyMessage();
		rm.setArticleID(articleID);
		rm.setMessageID(messageID);
		rm.setMessageContent(messageContent);
		rm.setPostDatetime(ft.format(date));

		if (rm != null) {
			session.save(rm);
		}

		return rm;
	}

	public String queryAllReply(int articleID) {
		Session session = sessionFactory.getCurrentSession();
		Query<ReplyMessage> query = session.createQuery("From ReplyMessage where articleID = :articleID order by postDatetime", ReplyMessage.class);
		query.setParameter("articleID", articleID);
		List<ReplyMessage> list = query.list();

		JSONArray jsonAr = new JSONArray();

		for (ReplyMessage li : list) {
			JSONObject json = new JSONObject();
			json.put("replyMessageID", li.getReplyMessageID());
			json.put("articleId", li.getArticleID());
			json.put("messageID", li.getMessageID());
			json.put("messageContent", li.getMessageContent());
			json.put("postDatetime", li.getPostDatetime());

			jsonAr.put(json);
		}

		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");

		return json;
	}

}
