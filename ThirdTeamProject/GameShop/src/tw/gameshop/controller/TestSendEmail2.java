package tw.gameshop.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tw.gameshop.user.model.Event;
import tw.gameshop.user.model.TestEventDAO;

@Controller
public class TestSendEmail2 {

	private JavaMailSender mailSender;
	private TestEventDAO eDao;
	 
	@Autowired	
	public TestSendEmail2(JavaMailSender mailSender, TestEventDAO eDao) {
		this.mailSender = mailSender;
		this.eDao = eDao;
	}
	
	@RequestMapping(path="/email2.do", method = RequestMethod.GET)
	public String processAction() throws IOException {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			
			List<Event> events = eDao.queryAllEvent();
			byte[] img = events.get(1).getEventImage();
			ByteArrayResource rimg = new ByteArrayResource(img);
			
			String content = "<html><body><h2>spring mail test</h2><img src='cid:aaa'/></body></html>";
			helper.setText(content,true);
			helper.addInline("aaa", rimg,"image/png");
			helper.setFrom("bettylin25@gmail.com");
			helper.setTo("eeit11203@gmail.com");
			helper.setSubject("MailTest");
			
 
		}
		catch (MessagingException e) {
			throw new MailParseException(e);
		}
		mailSender.send(message);
		return "Success";
	}
}
