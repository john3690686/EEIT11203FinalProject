package tw.gameshop.user.model;

import java.text.SimpleDateFormat;
import java.util.Date;
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
	// 密鑰
	private String key1 = "jyuntai20200426w";
	private String key2 = "ThisIsASecretKet";

	public P_ProfileService() {
	}

	@Autowired
	public P_ProfileService(P_ProfileDao profileDao) {
		this.profileDao = profileDao;
	}

	public P_Profile createProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		// Produce UniqueCode
		String produceCode = UUID.randomUUID().toString().replace("-", "");
		profileDetail.setMailCode(produceCode);

		// Send Mail
		new Thread(new Runnable() {
			@Override
			public void run() {
				String content = 
						"<h1>嗨," + profile.getUserName() + "!</h1>感謝您在 GAME SHOP 上註冊了一個新帳號！在開始前，我們必須確定是您本人申請這隻帳號的。"
						+ "請點選底下的連結以驗證您的電子郵件地址：" + "<a href='http://localhost:8080/GameShop/certification/" + produceCode
						+ "'>按此驗證電子郵件</a>";
				sendMail(profile.getMail(), content);
			}
		}).start();

		// 加密

		profile.setUserPwd(encrypt(profile.getUserPwd()));
		return profileDao.createProfile(profile, profileDetail);
	}

	public P_TotalProfile queryProfile(String userAccount) {
		P_TotalProfile result = profileDao.queryProfile(userAccount);
		return result;
	}
	public boolean updateProfile(P_Profile profile) {
		return profileDao.updateProfile(profile);
	}
	public boolean updateProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		profile.setUserPwd(encrypt(profile.getUserPwd()));
		return profileDao.updateProfile(profile, profileDetail);
	}

	public P_Profile processLogin(String userAccount, String userPwd) {
		
		P_Profile profile = profileDao.processLogin(userAccount);
		
		if (profile == null) {
			return null;
		}
		String dataPwd = profile.getUserPwd();
		if (dataPwd.equals(userPwd)) {
			return profile;
		}
		String password = decrypt(dataPwd).split("\\+")[0];
		System.out.println("Input Password : " + userPwd);
		System.out.println("dataPwd : "+dataPwd);
		System.out.println("decrypt Password : " + password);
		if (password.equals(userPwd)) {
			System.out.println(passwordSalt("newpassword : "+password));
			String newPwd = encrypt(passwordSalt(password));
			
			profile.setUserPwd(newPwd);
			updateProfile(profile);
			return profile;
		}

		return null;
	}
	
	public void forgetMail(String mail) {
		P_Profile profile = profileDao.queryByMail(mail);
		String password = decrypt(profile.getUserPwd().split("\\+")[0]);
		String content = "你的密碼是:( " + password + " )，請定時更改您的密碼並妥善保管，以防資料外洩。";
		sendMail(mail, content);
	}
	
	public boolean certificationMail(String mailCode) {
		return profileDao.certificationMail(mailCode);
	}

	public boolean isProfileExist(String userAccount, String mail, String nickName) {
		return profileDao.isProfileExist(userAccount, mail, nickName);
	}
	public boolean isAccountExist(String userAccount) {
		return profileDao.isAccountExist(userAccount);
	}
	public boolean isNickNameExist(String nickName) {
		return profileDao.isNickNameExist(nickName);
	}
	public boolean isMailExist(String mail) {
		return profileDao.isMailExist(mail);
	}
	public String getEmailByID(int uid) {
		return profileDao.getEmailByID(uid);
	}
	
	private void sendMail(String tomail, String content) {
		// Recipient's email ID needs to be mentioned.
		String to = tomail;

		// Sender's email ID needs to be mentioned
		String from = "j.t.hung1988@gmail.com";
		final String username = "j.t.hung1988@gmail.com";
		final String password = "uzadfzpqhfgaqgzd";

		// Assuming you are sending email through relay.jangosmtp.net
		String host = "smtp.gmail.com";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587");

		// Get the Session object.
		Session session = Session.getInstance(props, new Authenticator() {
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
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

			// Set Subject: header field
			message.setSubject("GameShopCompany");

			// Now set the actual message
			message.setContent(content, "text/html;charset=UTF-8");

			// Send message
			Transport.send(message);

			System.out.println("Sent message successfully....");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

	// password * salt
	private String passwordSalt(String password) {
		String dateTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
		String newPwd = password + "+" + dateTime;
		return newPwd;
	}

	// 加密處理
	private String encrypt(String password) {
		String pwdsalt = passwordSalt(password);
		try {
			IvParameterSpec iv = new IvParameterSpec(key2.getBytes("UTF-8"));

			SecretKeySpec skeySpec = new SecretKeySpec(key1.getBytes("UTF-8"), "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
			byte[] encrypted = cipher.doFinal(pwdsalt.getBytes());
			System.out.println("encrypted string:" + Base64.encodeBase64String(encrypted));
			return Base64.encodeBase64String(encrypted);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	// 解密
	private String decrypt(String encrypted) {
		try {
			IvParameterSpec iv = new IvParameterSpec(key2.getBytes("UTF-8"));

			SecretKeySpec skeySpec = new SecretKeySpec(key1.getBytes("UTF-8"), "AES");

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
			byte[] original = cipher.doFinal(Base64.decodeBase64(encrypted));
			String result = new String(original);
			String password = result.split("\\+")[0];
			System.out.println("decrypt password:" + password);
			return password;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
