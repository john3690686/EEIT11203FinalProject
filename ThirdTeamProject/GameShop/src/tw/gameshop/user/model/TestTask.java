package tw.gameshop.user.model;

import java.util.LinkedList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("task1")
public class TestTask {
	private TestEmailDAO ed;
	private TestEventDAO eDao;
	private WishDAO wDao;
	private P_ProfileDao pDao;
	
	@Autowired
	public TestTask(TestEmailDAO ed,TestEventDAO eDao, WishDAO wDao, P_ProfileDao pDao) {
		this.ed = ed;
		this.eDao = eDao;
		this.wDao = wDao;
		this.pDao = pDao;
	}
	
//	public void processAction2() {
//		List<Event> list = eDao.queryAllEvent(); //查詢推出什麼活動
//		for(Event event:list) {
//			LinkedList<Integer> pIdList = wDao.queryByProductId(event.getProductId()); //用產品ID找出userId
//			for(int i:pIdList) {
//				P_Profile target = pDao.queryByUserId(i);
//				String mail = target.getMail();
//				System.out.println("event name:"+event.getEventName());
//				//ed.sendMail("bettylin25@gmail.com", mail, event.getEventName(), event.getContent()); //寄活動給願望清單內的人
//			}
//		}
//	}
	
	public void processAction() {
		System.out.println("execute==========================");
		List<Event> list = eDao.queryAllEvent();
		System.out.println("Event:" + list.get(0).getEventName());
	}

}
