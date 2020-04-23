package tw.gameshop.user.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "profile")
public class P_Profile implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY) 
	@Column(name = "userId")
	private String userId;
	
	@Column(name = "userAccount")
	private String userAccount;
	
	@Column(name = "userName")
	private String userName;
	
	@Column(name = "userPwd")
	private String userPwd;
	
	@Column(name = "userToken")
	private String userToken;
	
	@Column(name = "nickName")
	private String nickName;
	
	@Column(name = "mail")
	private String mail;
	
	@Column(name = "gender")
	private Character gender;
	
	@Column(name = "userImg")
	private byte[] userImg;
	
	@Column(name = "mailState")
	private boolean mailState;
	
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "profile", cascade = CascadeType.ALL)
	@JsonIgnore
	private PD_ProfileDetail profileDetail;
	
	public P_Profile() {}
	
	public P_Profile(String userAccount, String userName, String userPwd, 
			String nickName, String mail,Character gender, byte[] userImg) {
		this.userAccount = userAccount;
		this.userName = userName;
		this.userPwd = userPwd;
		this.nickName = nickName;
		this.mail = mail;
		this.gender = gender;
		this.userImg = userImg;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
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

	public boolean isMailState() {
		return mailState;
	}

	public void setMailState(boolean mailState) {
		this.mailState = mailState;
	}
	
}
