package tw.gameshop.controller;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tw.gameshop.user.model.Event;
import tw.gameshop.user.model.P_Profile;
import tw.gameshop.user.model.P_ProfileDao;
import tw.gameshop.user.model.TestEmailDAO;
import tw.gameshop.user.model.TestEventDAO;
import tw.gameshop.user.model.WishDAO;

@Controller
public class TestSendEmail {
	
	private TestEmailDAO ed;
	private TestEventDAO eDao;
	private WishDAO wDao;
	private P_ProfileDao pDao;
	
	@Autowired
	public TestSendEmail(TestEmailDAO ed,TestEventDAO eDao, WishDAO wDao, P_ProfileDao pDao) {
		this.ed = ed;
		this.eDao = eDao;
		this.wDao = wDao;
		this.pDao = pDao;
	}
	
	@RequestMapping(path="/email.do", method = RequestMethod.GET)
	public String processAction() {
		ed.sendMail("bettylin25@gmail.com", "bettylin50@gmail.com", "JavaMailTest22222", "Java寄信測試22222");
		return "Success";
	}
	
	@RequestMapping(path="/event.do", method = RequestMethod.GET)
	public String processEvent() {
		List<Event> list = eDao.queryAllEvent();
		for(Event event:list) {
			System.out.println("product:" + event.getProductId());
			System.out.println("eventName:" + event.getEventName());
		}
		return "Success";
	}
	
	//not test
	@RequestMapping(path="/eventSend.action", method = RequestMethod.GET)
	public String processSendUser() {
		List<Event> list = eDao.queryAllEvent();
		for(Event event:list) {
			LinkedList<Integer> pIdList = wDao.queryByProductId(event.getProductId());
			for(int i:pIdList) {
				P_Profile target = pDao.queryByUserId(i);
				String mail = target.getMail();
				ed.sendMail("bettylin25@gmail.com", mail, event.getEventName(), event.getContent());
			}
		}
		return "Success";
	}

}
