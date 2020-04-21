package tw.gameshop.user.model;

public class P_ModifyProfile {

	private String userAccount;
	
	private String userName;
	
	private String userPwd;

	private String nickName;
	
	private String mail;
	
	private Character gender;
	
	private byte[] userImg;
	
	private String address;
	
	private String birthday;
	
	private String phone;

	public P_ModifyProfile() {}
	
	public P_ModifyProfile(P_Profile profile, PD_ProfileDetail proDetail) {
		this.userAccount = profile.getUserAccount();
		this.userName = profile.getUserName();
		this.userPwd = profile.getUserPwd();
		this.nickName = profile.getNickName();
		this.mail = profile.getMail();
		this.gender = profile.getGender();
		this.userImg = profile.getUserImg();
		this.address = profile.getProfileDetail().getAddress();
		this.birthday = profile.getProfileDetail().getBirthday();
		this.phone = profile.getProfileDetail().getPhone();
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
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

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
