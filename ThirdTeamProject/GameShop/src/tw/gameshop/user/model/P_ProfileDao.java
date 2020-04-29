package tw.gameshop.user.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.NoResultException;

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
		System.out.println("SessionFactory Open: " + sessionFactory.isOpen());
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
				session.save(profile);
			}
		} catch (Exception e) {
			System.out.println("Error:createProfile");
			return null;
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
			System.out.println("Error:ProfileDao.queryProfile");
			e.printStackTrace();
		}
		return totalProfile;
	}
	
	public boolean isProfileExist(String userAccount, String mail, String nickName) {
		Session session = sessionFactory.getCurrentSession();
		String hqlstr = "from P_Profile WHERE userAccount=:userAccount or mail=:mail or nickName=:nickName";
		List<P_Profile> result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery(hqlstr,P_Profile.class);
			qProfile.setParameter("userAccount", userAccount);
			qProfile.setParameter("mail", mail);
			qProfile.setParameter("nickName", nickName);
			result = qProfile.list();
			if(result.size()>0) {
				return true;
			}
		} catch (Exception e) {
			System.out.println("Error:ProfileDao.isProfileExist");
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean isAccountExist(String userAccount) {
		Session session = sessionFactory.getCurrentSession();
		String hqlstr = "from P_Profile WHERE userAccount=:userAccount";
		List<P_Profile> result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery(hqlstr,P_Profile.class);
			qProfile.setParameter("userAccount", userAccount);
			result = qProfile.list();
			if(result.size()>0) {
				return true;
			}
		}catch (Exception e) {
			System.out.println("Error:ProfileDao.isAccountExist");
			e.printStackTrace();
		}
		return false;
	}
	public boolean isNickNameExist(String nickName) {
		Session session = sessionFactory.getCurrentSession();
		String hqlstr = "from P_Profile WHERE nickName=:nickName";
		List<P_Profile> result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery(hqlstr,P_Profile.class);
			qProfile.setParameter("nickName", nickName);
			result = qProfile.list();
			if(result.size()>0) {
				return true;
			}
		}catch (Exception e) {
			System.out.println("Error:ProfileDao.isNickNameExist");
			e.printStackTrace();
		}
		return false;
	}
	public boolean isMailExist(String mail) {
		Session session = sessionFactory.getCurrentSession();
		String hqlstr = "from P_Profile WHERE mail=:mail";
		List<P_Profile> result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery(hqlstr,P_Profile.class);
			qProfile.setParameter("mail", mail);
			result = qProfile.list();
			if(result.size()>0) {
				return true;
			}
		}catch (Exception e) {
			System.out.println("Error:ProfileDao.isMailExist");
			e.printStackTrace();
		}
		return false;
	}

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

	public P_Profile processLogin(String userAccount) {
		Session session = sessionFactory.getCurrentSession();
		String hqlstr = "from P_Profile WHERE userAccount=:account";
		P_Profile result = null;
		try {
			System.out.println("UserAccount = " + userAccount);
			Query<P_Profile> qProfile = session.createQuery(hqlstr, P_Profile.class);
			qProfile.setParameter("account", userAccount);
			result = qProfile.getSingleResult();
		} catch(NoResultException e) {
			System.out.println("NoResultException");
		} catch (Exception e) {
			System.out.println("Login Error!");
			e.printStackTrace();
		}
		return result;
	}

	public boolean certificationMail(String mailCode) {
		Session session1 = sessionFactory.getCurrentSession();
		boolean isValid = false;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Query<PD_ProfileDetail> findpd = 
					session1.createQuery("from PD_ProfileDetail WHERE mailCode=:mailCode", PD_ProfileDetail.class);
			findpd.setParameter("mailCode", mailCode);
			List<PD_ProfileDetail> profileDetailList = findpd.list();
			PD_ProfileDetail profileDetail = null;
			for(PD_ProfileDetail p : profileDetailList) {
				System.out.println("count");
				profileDetail = p;
			}

			if (profileDetail != null) {
				String startingDate = profileDetail.getCodeStartingDate();
				Date applyDate = format.parse(startingDate);
				isValid = applyDate.getTime() + (8 * 24 * 60 * 60 * 1000) > new Date().getTime();
				if(isValid) {
					profileDetail.getProfile().setMailState(true);
					System.out.println("Valid Mail OK");
				}
			}
		} catch (Exception e) {
			System.out.println("Certification Error!");
			e.printStackTrace();
		}
		return isValid;
	}
	
	// edit from Betty (send email)
	public P_Profile queryByUserId(int userId) {
		Session session = sessionFactory.getCurrentSession();
		P_Profile profile = session.get(P_Profile.class, userId);
		return profile;
	}
	
	public P_Profile queryByMail(String mail) {
		Session session = sessionFactory.getCurrentSession();
		String hqlstr = "from P_Profile WHERE mail=:mail";
		P_Profile result = null;
		try {
			Query<P_Profile> qProfile = session.createQuery(hqlstr, P_Profile.class);
			qProfile.setParameter("mail", mail);
			result = qProfile.getSingleResult();
		} catch(NoResultException e) {
			System.out.println("NoResultException");
		} catch (Exception e) {
			System.out.println("Login Error!");
			e.printStackTrace();
		}
		return result;
	}
	
	// Added by Yuzuha, 2020/04/06
	public String getEmailByID(int uid) {
		return sessionFactory.getCurrentSession().get(P_Profile.class, uid).getMail();
	}

}
