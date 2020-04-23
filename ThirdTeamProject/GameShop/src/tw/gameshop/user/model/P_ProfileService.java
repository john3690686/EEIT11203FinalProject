package tw.gameshop.user.model;

import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class P_ProfileService {
	
	private P_ProfileDao profileDao;

	public P_ProfileService(){
	}
	
	@Autowired
	public P_ProfileService(P_ProfileDao profileDao){
		this.profileDao = profileDao;
		
	}
	
	public P_Profile createProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		//Produce UniqueCode
		String produceCode = UUID.randomUUID().toString().replace("-", "");
		profileDetail.setMailCode(produceCode);
		
		//Send Mail
		new Thread(new Runnable() {
			@Override
			public void run() {
				sendMail(profile.getUserName(),profile.getMail(),produceCode);
			}
		}).start();
		return profileDao.createProfile(profile, profileDetail);
	}
	
	public P_TotalProfile queryProfile(String userAccount) {
		
		return profileDao.queryProfile(userAccount);
	}
	
	public boolean updateProfile(P_Profile profile) {
		return profileDao.updateProfile(profile);
	}
	
	public boolean updateProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		return profileDao.updateProfile(profile, profileDetail);
	}
	
	public P_Profile processLogin(String userAccount, String userPwd) {
		
		return profileDao.processLogin(userAccount, userPwd);
	}
	
	public boolean certificationMail(String mailCode) {
		return profileDao.certificationMail(mailCode);
	}
	
	
	private void sendMail(String userName, String mail, String produceCode){
	      // Recipient's email ID needs to be mentioned.
	      String to = mail;//change accordingly

	      // Sender's email ID needs to be mentioned
	      String from = "j.t.hung1988@gmail.com";//change accordingly
	      final String username = "j.t.hung1988@gmail.com";//change accordingly
	      final String password = "uzadfzpqhfgaqgzd";//change accordingly

	      // Assuming you are sending email through relay.jangosmtp.net
	      String host = "smtp.gmail.com";

	      Properties props = new Properties();
	      props.put("mail.smtp.auth", "true");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.host", host);
	      props.put("mail.smtp.port", "587");

	      // Get the Session object.
	      Session session = Session.getInstance(props,
	      new Authenticator() {
	         protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(username, password);
	         }
	      });

	      try {
	         // Create a default MimeMessage object.
	         Message message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.setRecipients(Message.RecipientType.TO,
	         InternetAddress.parse(to));

	         // Set Subject: header field
	         message.setSubject("Testing Subject");

	         // Now set the actual message
	         message.setContent("<h1>嗨," + userName + 
	         		"!</h1>感謝您在 GAME SHOP 上註冊了一個新帳號！在開始前，我們必須確定是您本人申請這隻帳號的。"
	         		+ "請點選底下的連結以驗證您的電子郵件地址："
	         		+ "<a href='http://localhost:8080/GameShop/certification/" + produceCode + "'>按此驗證電子郵件</a>","text/html;charset=UTF-8");

	         // Send message
	         Transport.send(message);

	         System.out.println("Sent message successfully....");

	      } catch (MessagingException e) {
	            throw new RuntimeException(e);
	      }
	   }

}
