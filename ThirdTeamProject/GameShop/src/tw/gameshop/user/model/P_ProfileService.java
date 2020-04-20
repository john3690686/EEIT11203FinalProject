package tw.gameshop.user.model;

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
		return profileDao.createProfile(profile, profileDetail);
	}
	
	public P_Profile queryProfile(String userAccount) {
		System.out.println("Service");
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

}
