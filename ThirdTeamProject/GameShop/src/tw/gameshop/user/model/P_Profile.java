package tw.gameshop.user.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "profile")
public class P_Profile {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY) 
	@Column(name = "userId")
	private int userId;
	
	@Column(name = "userAccount")
	private String userAccount;
	
	@Column(name = "userName")
	private String userName;
	
	@Column(name = "userPwd")
	private String userPwd;
	
	@Column(name = "userToken")
	private String userToken;
	
	@Column(name = "nickname")
	private String nickname;
	
	@Column(name = "mail")
	private String mail;
	
	@Column(name = "gender")
	private Character gender;
	
	@Column(name = "userImg")
	private byte[] userImg;
	
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "profile", cascade = CascadeType.ALL)
	private PD_ProfileDetail profileDetail;
	
	public P_Profile() {}
	
	public P_Profile(String userAccount, String userName, String userPwd, String nickname,
			String mail) {
		this.userAccount = userAccount;
		this.userName = userName;
		this.userPwd = userPwd;
		this.nickname = nickname;
		this.mail = mail;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public Character getGender() {
		return gender;
	}

	public void setGender(Character gender) {
		this.gender = gender;
	}

	public byte[] getUserImg() {
		return userImg;
	}

	public void setUserImg(byte[] userImg) {
		this.userImg = userImg;
	}

	public PD_ProfileDetail getProfileDetail() {
		return profileDetail;
	}

	public void setProfileDetail(PD_ProfileDetail profileDetail) {
		this.profileDetail = profileDetail;
	}

	public String getUserToken() {
		return userToken;
	}

	public void setUserToken(String userToken) {
		this.userToken = userToken;
	}
}
