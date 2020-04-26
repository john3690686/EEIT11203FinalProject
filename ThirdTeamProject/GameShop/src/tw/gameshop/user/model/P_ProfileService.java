package tw.gameshop.user.model;

import java.util.Properties;
import java.util.UUID;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class P_ProfileService {
	
	private P_ProfileDao profileDao;
	//密鑰
	private String key1 = "jyuntai20200426w";
    private String key2 = "ThisIsASecretKet";

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
		
		//加密
		profile.setUserPwd(encrypt(profile.getUserPwd()));
		return profileDao.createProfile(profile, profileDetail);
	}
	
	public P_TotalProfile queryProfile(String userAccount) {
		P_TotalProfile result = profileDao.queryProfile(userAccount);
		System.out.println("encrypt password : "+result.getUserPwd());
		System.out.println("decrypt : " + decrypt(result.getUserPwd()));
		return result;
	}
	
	public boolean updateProfile(P_Profile profile) {
		profile.setUserPwd(encrypt(profile.getUserPwd()));
		return profileDao.updateProfile(profile);
	}
	
	public boolean updateProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		profile.setUserPwd(encrypt(profile.getUserPwd()));
		return profileDao.updateProfile(profile, profileDetail);
	}
	
	public P_Profile processLogin(String userAccount, String userPwd) {
		String encPwd = encrypt(userPwd);
		return profileDao.processLogin(userAccount, encPwd);
	}
	
	public boolean certificationMail(String mailCode) {
		return profileDao.certificationMail(mailCode);
	}
	
	public boolean isProfileExist(String userAccount, String mail, String nickName) {
		return profileDao.isProfileExist(userAccount, mail, nickName);
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
	
	//加密處理
	private String encrypt(String value) {
        try {
            IvParameterSpec iv = new IvParameterSpec(key2.getBytes("UTF-8"));
 
            SecretKeySpec skeySpec = new SecretKeySpec(key1.getBytes("UTF-8"),"AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
            byte[] encrypted = cipher.doFinal(value.getBytes());
            System.out.println("encrypted string:"+ Base64.encodeBase64String(encrypted));
            return Base64.encodeBase64String(encrypted);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
	
	//解密
	private String decrypt(String encrypted) {
        try {
            IvParameterSpec iv = new IvParameterSpec(key2.getBytes("UTF-8"));

            SecretKeySpec skeySpec = new SecretKeySpec(key1.getBytes("UTF-8"),"AES");
            
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
            byte[] original = cipher.doFinal(Base64.decodeBase64(encrypted));
 
            return new String(original);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

}
