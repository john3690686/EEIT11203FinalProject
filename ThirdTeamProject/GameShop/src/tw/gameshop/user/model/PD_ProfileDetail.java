package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "profileDetail")
public class PD_ProfileDetail {

	@GenericGenerator(name = "generator", strategy = "foreign", 
				parameters = @Parameter(name="property", value = "profile"))
	@Id @GeneratedValue(generator = "generator")
	@Column(name = "userId")
	private String userId;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "birthday")
	private String birthday;
	
	@Column(name = "phone")
	private String phone;
	
	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	private P_Profile profile;
	
	public PD_ProfileDetail() {}
	
	public PD_ProfileDetail(String address, String birthday, String phone) {
		this.address = address;
		this.birthday = birthday;
		this.phone = phone;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public P_Profile getProfile() {
		return profile;
	}

	public void setProfile(P_Profile p) {
		this.profile = p;
	}
	
	
}
