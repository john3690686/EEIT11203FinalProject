package tw.gameshop.user.model;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("game_EventDao")
public class Game_EventDAO {

	private SessionFactory sessionFactory;

	public Game_EventDAO() {
	}

	@Autowired
	public Game_EventDAO(@Qualifier(value ="sessionFactory") SessionFactory sessionFactory) {
		System.out.println("SessionFactory: " + sessionFactory);
		this.sessionFactory = sessionFactory;

	}

	public String queryAllEvent() {

		Session session = sessionFactory.getCurrentSession();
		Query<Game_Event> query = session.createQuery("from Game_Event", Game_Event.class);
		List<Game_Event> list = query.list();

		JSONArray jsonAr = new JSONArray();

		for (Game_Event li : list) {
			JSONObject json = new JSONObject();
			json.put("eventId", li.getEventId());
			json.put("productId", li.getProductId());
			json.put("enentName", li.getEventName());
			json.put("content", li.getContent());
			json.put("eventImage", li.getEventImage());
			json.put("startDate", li.getStartDate());
			json.put("endDate", li.getEndDate());
			jsonAr.put(json);
		}

		String jsonstr = jsonAr.toString();
		String json = jsonstr.replaceAll(":null,", ":\"null\",");
		return json;
	}
	
	
	public List<Game_Event> queryAllEvent2(){
		return sessionFactory.getCurrentSession().createQuery("from Game_Event",Game_Event.class).list();
	}
	
	public Game_Event queryEvent(int eventId) {
		return  sessionFactory.getCurrentSession().get(Game_Event.class,eventId);	
	}
	

	public Game_Event addEvent(Game_Event event) {
		Session session = sessionFactory.getCurrentSession();	
		if(event != null ) {
			session.save(event);
		}
		return event;	
	}
	

	public void deleteEvent(int eventId) {
		Session session = sessionFactory.getCurrentSession();
		Game_Event event = (Game_Event) session.get(Game_Event.class, eventId);
		session.delete(event);
	}

	public boolean upDateEvent(int eventId,Game_Event gEvent) {
		Game_Event nBean = sessionFactory.getCurrentSession().get(Game_Event.class,eventId);
		if(nBean != null) {
			nBean.setProductId(gEvent.getProductId());
			nBean.setEventName(gEvent.getEventName());
			nBean.setContent(gEvent.getContent());
			nBean.setStartDate(gEvent.getStartDate());
			nBean.setEndDate(gEvent.getEndDate());
			if(gEvent!= null) {
				nBean.setEventImage(gEvent.getEventImage());
			}		
			return true;
		}
		return false;
	}
	
	
	
	
	
	
}
