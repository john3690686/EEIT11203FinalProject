package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class P_ProfileDao {

	private SessionFactory sessionFactory;
	
	public P_ProfileDao(){}
	
	@Autowired
	public P_ProfileDao(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		System.out.println("SessionFactory: " + sessionFactory);
       this.sessionFactory = sessionFactory;
	}
	
	public P_Profile createProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		Session session = sessionFactory.getCurrentSession();
		
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",P_Profile.class);
			qProfile.setParameter("account", profile.getUserAccount());
			List<P_Profile> result = qProfile.getResultList();
			if(result.isEmpty()) {
				profileDetail.setProfile(profile);
				profile.setProfileDetail(profileDetail);
				System.out.println("is nll?:\n" + profile.getUserAccount() + "\n" + profileDetail);
				session.save(profile);
			}
		}catch(Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return profile;
	}
	
	public P_Profile queryProfile(String userAccount) {
		Session session = sessionFactory.getCurrentSession();
		P_Profile result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",P_Profile.class);
			qProfile.setParameter("account", userAccount);
			result = qProfile.getSingleResult();
		}catch(Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return result;
	}
	
	//need to test
	public boolean updateProfile(P_Profile profile) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",P_Profile.class);
			qProfile.setParameter("account", profile.getUserAccount());
			P_Profile result = qProfile.getSingleResult();
			if(result!=null) {
				result.setUserName(profile.getUserName());
				result.setNickName(profile.getNickName());
				result.setUserPwd(profile.getUserPwd());
				result.setGender(profile.getGender());
				result.setUserImg(profile.getUserImg());
				result.setMail(profile.getMail());
				
				return true;
			}
		}catch(Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",P_Profile.class);
			qProfile.setParameter("account", profile.getUserAccount());
			P_Profile result = qProfile.getSingleResult();
			if(result!=null) {
				result.setUserName(profile.getUserName());
				result.setNickName(profile.getNickName());
				result.setUserPwd(profile.getUserPwd());
				result.setGender(profile.getGender());
				result.setUserImg(profile.getUserImg());
				result.setMail(profile.getMail());
				result.getProfileDetail().setAddress(profileDetail.getAddress());
				result.getProfileDetail().setBirthday(profileDetail.getBirthday());
				result.getProfileDetail().setPhone(profileDetail.getPhone());
				return true;
			}
		}catch(Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return false;
	}
	
	public P_Profile processLogin(String userAccount, String userPwd) {
		Session session = sessionFactory.getCurrentSession();
		P_Profile result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account AND userPwd=:userPwd",P_Profile.class);
			qProfile.setParameter("account", userAccount);
			qProfile.setParameter("userPwd", userPwd);
			result = qProfile.getSingleResult();
			
		}catch(Exception e) {
			
		}
		return result;
	}
}
