package tw.gameshop.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import tw.gameshop.user.model.Event;
import tw.gameshop.user.model.Game_Event;
import tw.gameshop.user.model.Game_EventService;
import tw.gameshop.user.model.P_Profile;
import tw.gameshop.user.model.P_ProfileDao;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductService;
import tw.gameshop.user.model.TestEventDAO;
import tw.gameshop.user.model.WishDAO;

@Service("EventNotification")
public class SendEventMailEveryDay {
	
	private SessionFactory sessionFactory;
	private WishDAO wDao;
	private P_ProfileDao pDao;
	private JavaMailSender mailSender;
	private Game_EventService eventService;
	private ProductService productService;

	@Autowired
	public SendEventMailEveryDay(@Qualifier(value="sessionFactory") SessionFactory sessionFactory,JavaMailSender mailSender, Game_EventService eventService, WishDAO wDao, P_ProfileDao pDao,ProductService productService) {
		this.sessionFactory = sessionFactory;
		this.mailSender = mailSender;
		this.eventService = eventService;
		this.wDao = wDao;
		this.pDao = pDao;
		this.productService = productService;
	}
	
	public void processAction() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(today);  //取得當天日期
		MimeMessage message = mailSender.createMimeMessage();
		sessionFactory.getCurrentSession().beginTransaction();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			List<Game_Event> list = eventService.queryAllEvent2(); //查詢推出什麼活動
			for(Game_Event event:list) {
				String eventDate = event.getStartDate();
				System.out.println("date:"+eventDate);
				if(eventDate.equals(date)) { //活動開始日期為當日的才寄信
					LinkedList<Integer> pIdList = wDao.queryByProductId(event.getProductId()); //用產品ID找出userId
					Product product = productService.queryById(event.getEventId());
					byte[] image = event.getEventImage();
					ByteArrayResource img = new ByteArrayResource(image);
					for(int i:pIdList) {
						P_Profile target = pDao.queryByUserId(i);
						String mail = target.getMail();
						String e = event.getContent();
						//寄活動給願望清單內的人
						String content = "<html><body><h3>" + e + "</h3><a href='http://localhost:8080/GameShop/searchGame?productName="+product.getProductName()+"'><img src='cid:pic'/></a></body></html>";
						helper.setText(content,true);
						helper.addInline("pic", img,"image/png");
						helper.setFrom("eeit11203@gmail.com");
						helper.setTo(mail);
						helper.setSubject(event.getEventName());
						mailSender.send(message);
					}
				}
			}
			sessionFactory.getCurrentSession().getTransaction().commit();
		}
		catch(MessagingException e) {
			throw new MailParseException(e);
		}finally {
			System.out.println("Finish");
		}
	}

}
