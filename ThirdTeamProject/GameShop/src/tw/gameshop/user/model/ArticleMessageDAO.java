package tw.gameshop.user.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
		Query<ArticleMessage> query = session.createQuery(
				"From ArticleMessage where articleID = :articleID order by postDatetime", ArticleMessage.class);
		query.setParameter("articleID", articleID);
		List<ArticleMessage> list = query.list();

		
		JSONArray jsonAr = new JSONArray();

		for (ArticleMessage li : list) {
			JSONObject json = new JSONObject();
			json.put("messageID", li.getMessageID());
			json.put("articleID", li.getArticleID());
			json.put("respUserId", li.getRespUserId());
			int userId = li.getRespUserId();
			String nickname = querynickname(userId);
			json.put("nickname", nickname);
			
			json.put("messageContent", li.getMessageContent());
			json.put("postDatetime", li.getPostDatetime());

			jsonAr.put(json);
		}

		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");
		return json;
	}

	public String queryAMTimes() {
		Session session = sessionFactory.getCurrentSession();

		Query<?> query = session
				.createQuery("SELECT am.articleID, COUNT(*) FROM ArticleMessage as am group by am.articleID");
		List<?> list = query.list();

		JSONArray jsonAr = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			Object[] row = (Object[]) list.get(i);
			JSONObject json = new JSONObject();
			json.put("articleID", row[0]);
			json.put("AMTimes", row[1]);
			
			jsonAr.put(json);
		}
		
		String jsonstr = jsonAr.toString();

		return jsonstr;
	}

	public ArticleMessage deleteAllArticleMessage(int messageID) {
		Session session = sessionFactory.getCurrentSession();

		ArticleMessage queryArtMeg = session.get(ArticleMessage.class, messageID);

		if (queryArtMeg != null) {
			session.delete(queryArtMeg);
		}
		return queryArtMeg;
	}

	
	public List<Integer> queryMessageId(int articleID) {
		Session session = sessionFactory.getCurrentSession();
		
		Query<ArticleMessage> query = session.createQuery(
				"From ArticleMessage where articleID = :articleID order by postDatetime", ArticleMessage.class);
		query.setParameter("articleID", articleID);
		List<ArticleMessage> list = query.list();
		List<Integer> megId = new ArrayList<>();;
		

		for (ArticleMessage li : list) {
			megId.add(li.getMessageID());
		}

		return megId;
	}
	
	public String querynickname(int userId) {
		Session session = sessionFactory.getCurrentSession();
		Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userId=:userId", P_Profile.class);
		qProfile.setParameter("userId", userId);
		List<P_Profile> plist = qProfile.list();
		String nickname = null;
		for (P_Profile pli : plist) {
			nickname = pli.getNickName();
		}
		return nickname;
	}
	
	public int queryuserId(String userAccount) {
		Session session = sessionFactory.getCurrentSession();
		Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:userAccount", P_Profile.class);
		qProfile.setParameter("userAccount", userAccount);
		List<P_Profile> plist = qProfile.list();
		int userId = 0;
		for (P_Profile pli : plist) {
			userId = pli.getUserId();
		}
		return userId;
	}
	
}
