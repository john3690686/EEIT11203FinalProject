package tw.gameshop.user.model;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;

@Repository
public class TestEmailDAO {
	
	private JavaMailSender mailSender;
	 
	@Autowired	
	public TestEmailDAO(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
 
	public void sendMail(String from, String to, String subject, String msg) {
		MimeMessage message = mailSender.createMimeMessage();
 
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
 
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(msg);
 
		}
		catch (MessagingException e) {
			throw new MailParseException(e);
		}
 
		mailSender.send(message);
	}

}
