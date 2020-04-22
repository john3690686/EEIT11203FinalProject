package tw.gameshop.user.model;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.Date;
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

	public P_ProfileDao() {
	}

	@Autowired
	public P_ProfileDao(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		System.out.println("SessionFactory: " + sessionFactory);
		this.sessionFactory = sessionFactory;
	}

	private String getDate() {
		String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		return date;
	}

	public P_Profile createProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		Session session = sessionFactory.getCurrentSession();

		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",
					P_Profile.class);
			qProfile.setParameter("account", profile.getUserAccount());
			List<P_Profile> result = qProfile.getResultList();
			if (result.isEmpty()) {
				profileDetail.setCodeStartingDate(getDate());
				profileDetail.setProfile(profile);
				profile.setProfileDetail(profileDetail);
				System.out.println("is nll?:\n" + profile.getUserAccount() + "\n" + profileDetail);
				session.save(profile);
			}
		} catch (Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return profile;
	}

	public P_TotalProfile queryProfile(String userAccount) {
		Session session = sessionFactory.getCurrentSession();
		P_Profile result = null;
		P_TotalProfile totalProfile = null;
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",
					P_Profile.class);
			qProfile.setParameter("account", userAccount);
			result = qProfile.getSingleResult();
			totalProfile = new P_TotalProfile(result, result.getProfileDetail());
		} catch (Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return totalProfile;
	}

	// need to test
	public boolean updateProfile(P_Profile profile) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",
					P_Profile.class);
			qProfile.setParameter("account", profile.getUserAccount());
			P_Profile result = qProfile.getSingleResult();
			if (result != null) {
				result.setUserName(profile.getUserName());
				result.setNickName(profile.getNickName());
				result.setUserPwd(profile.getUserPwd());
				result.setGender(profile.getGender());
				result.setUserImg(profile.getUserImg());
				result.setMail(profile.getMail());

				return true;
			}
		} catch (Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateProfile(P_Profile profile, PD_ProfileDetail profileDetail) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Query<P_Profile> qProfile = session.createQuery("from P_Profile WHERE userAccount=:account",
					P_Profile.class);
			qProfile.setParameter("account", profile.getUserAccount());
			P_Profile result = qProfile.getSingleResult();
			if (result != null) {
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
		} catch (Exception e) {
			System.out.println("Error:ProfileDao");
			e.printStackTrace();
		}
		return false;
	}

	public P_Profile processLogin(String userAccount, String userPwd) {
		Session session = sessionFactory.getCurrentSession();
		P_Profile result = null;
		try {
			Query<P_Profile> qProfile = session
					.createQuery("from P_Profile WHERE userAccount=:account AND userPwd=:userPwd", P_Profile.class);
			qProfile.setParameter("account", userAccount);
			qProfile.setParameter("userPwd", userPwd);
			result = qProfile.getSingleResult();

		} catch (Exception e) {
			System.out.println("Login Error!");
			e.printStackTrace();
		}
		return result;
	}

	public boolean certificationMail(String mailCode) {
		Session session = sessionFactory.getCurrentSession();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Query<P_Profile> qProfile = 
					session.createQuery("from P_Profile p WHERE p.profileDetail.mailCode=:mailCode", P_Profile.class);
			qProfile.setParameter("mailCode", mailCode);
			P_Profile result = qProfile.getSingleResult();
			System.out.println("Date:"+result.getProfileDetail().getCodeStartingDate());
//			System.out.println("UserID:" + result.getProfileDetail().getUserId());
//			System.out.println(((P_Profile)Array.get(proDetail, 0)).getUserAccount());
//			System.out.println(((PD_ProfileDetail)Array.get(proDetail, 1)).getUserId());
//			P_Profile result;
			if (result != null) {
				
				String startingDate = result.getProfileDetail().getCodeStartingDate();
				Date applyDate = format.parse(startingDate);
				boolean isValid = applyDate.getTime() + (8 * 24 * 60 * 60 * 1000) > new Date().getTime();
				if(isValid) {
					result.setMailState(true);
					return true;
				}
			}
		} catch (Exception e) {
			System.out.println("Certification Error!");
			e.printStackTrace();
		}
		return false;
	}
}
