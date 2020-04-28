package tw.gameshop.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tw.gameshop.user.model.Event;
import tw.gameshop.user.model.OrderDetail;
import tw.gameshop.user.model.OrderDetailDAO;
import tw.gameshop.user.model.Orders;
import tw.gameshop.user.model.OrdersDAO;
import tw.gameshop.user.model.TestEventDAO;

@Controller
public class TestSendEmail2 {

	private JavaMailSender mailSender;
	private TestEventDAO eDao;
	private OrderDetailDAO odDao;
	private OrdersDAO oDao;

	@Autowired
	public TestSendEmail2(JavaMailSender mailSender, TestEventDAO eDao, OrderDetailDAO odDao, OrdersDAO oDao) {
		this.mailSender = mailSender;
		this.eDao = eDao;
		this.odDao = odDao;
		this.oDao = oDao;
	}

	@RequestMapping(path = "/email2.do", method = RequestMethod.GET)
	public String processAction() throws IOException {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			List<Event> events = eDao.queryAllEvent();
			byte[] img = events.get(1).getEventImage();
			ByteArrayResource rimg = new ByteArrayResource(img);

			String content = "<html><body><h2>spring mail test</h2><img src='cid:aaa'/></body></html>";
			helper.setText(content, true);
			helper.addInline("aaa", rimg, "image/png");
			helper.setFrom("bettylin25@gmail.com");
			helper.setTo("eeit11203@gmail.com");
			helper.setSubject("MailTest");

		} catch (MessagingException e) {
			throw new MailParseException(e);
		}
		mailSender.send(message);
		return "Success";
	}

	@RequestMapping(path = "/record.do", method = RequestMethod.GET)
	public String testGetOrder() {
		List<Orders> list = oDao.queryOrderRecord(1);
		LinkedHashMap<Orders, List<OrderDetail>> record = odDao.queryByOrderList(list);
		Set<Entry<Orders, List<OrderDetail>>> set = record.entrySet();
		Iterator<Entry<Orders, List<OrderDetail>>> i = set.iterator();
		while (i.hasNext()) {
			Map.Entry me = (Map.Entry) i.next();
			System.out.print(me.getKey() + ": ");
			System.out.println(me.getValue());
		}
		return "Success";
	}
}
