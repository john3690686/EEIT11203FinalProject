package tw.gameshop.user.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "profile")
public class P_Profile {

	@Id @Column(name = "userId")
	private String userId;
	
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
	
	public P_Profile(String userId, String userName, String userPwd, String nickname,
			String mail) {
		this.userId = userId;
		this.userName = userName;
		this.userPwd = userPwd;
		this.nickname = nickname;
		this.mail = mail;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
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

	public String getnickname() {
		return nickname;
	}

	public void setnickname(String nickname) {
		this.nickname = nickname;
	}

	public void setGender(Character gender) {
		this.gender = gender;
	}
	
	

}
