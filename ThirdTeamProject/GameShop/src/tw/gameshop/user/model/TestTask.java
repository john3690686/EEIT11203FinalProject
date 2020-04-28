package tw.gameshop.user.model;

import java.text.SimpleDateFormat;
import java.util.Date;
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
	private SessionFactory sessionFactory;
	
	@Autowired
	public TestTask(@Qualifier(value="sessionFactory") SessionFactory sessionFactory,TestEmailDAO ed,TestEventDAO eDao, WishDAO wDao, P_ProfileDao pDao) {
		this.sessionFactory = sessionFactory;
		this.ed = ed;
		this.eDao = eDao;
		this.wDao = wDao;
		this.pDao = pDao;
	}
	
	public void processAction() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(today);
		System.out.println("today:"+date); //取得當天日期
		sessionFactory.getCurrentSession().beginTransaction();
		List<Event> list = eDao.queryAllEvent(); //查詢推出什麼活動
		for(Event event:list) {
			String date1 = sdf.format(event.getStartDate());
			System.out.println("event date:"+date1);
			if(date1.equals(date)) { //活動開始日期為當日的才寄信
				LinkedList<Integer> pIdList = wDao.queryByProductId(event.getProductId()); //用產品ID找出userId
				for(int i:pIdList) {
					P_Profile target = pDao.queryByUserId(i);
					String mail = target.getMail();
					System.out.println("event name:"+event.getEventName());
					System.out.println("Send mail:"+mail);
					//ed.sendMail("bettylin25@gmail.com", mail, event.getEventName(), event.getContent()); //寄活動給願望清單內的人
				}
				
			}
		}
		sessionFactory.getCurrentSession().getTransaction().commit();
	}
}
