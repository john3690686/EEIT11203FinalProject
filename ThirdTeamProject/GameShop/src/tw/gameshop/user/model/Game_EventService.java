package tw.gameshop.user.model;

import java.sql.Date;
import java.util.List;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class Game_EventService {

	@Autowired
	private Game_EventDAO eventDao;

	public Game_EventService() {
	}

	public Game_EventService(Game_EventDAO eventDao) {
		this.eventDao = eventDao;
	}

	public String queryAllEvent() {
		return eventDao.queryAllEvent();
	}
	
	public List<Game_Event> queryAllEvent2(){
		return eventDao.queryAllEvent2();
	}
	
	public Game_Event queryEvent(int eventId) {
		return eventDao.queryEvent(eventId);
	}

	public Game_Event addEvent(Game_Event event) {
		return eventDao.addEvent(event);
	}
	
	public void deleteEvent(int eventId) {
		eventDao.deleteEvent(eventId);
	}
	
	public boolean upDateEvent(int eventId,Game_Event gEvent) {
		return eventDao.upDateEvent(eventId, gEvent);
	}

}
