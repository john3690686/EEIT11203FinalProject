package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class WishDAO {
	private SessionFactory sessionFactory;

	@Autowired
	public WishDAO(@Qualifier(value="sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public boolean insertWish(int userId, int productId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Wish wish = new Wish();
			wish.setUserId(userId);
			wish.setProductId(productId);
			session.save(wish);
			System.out.println("save your wish");
			return true;
		}catch(Exception e) {
			return false;
		}
	}
	
	public List<Wish> queryUniqueWish(int userId, int productId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Wish> query = session.createQuery("from Wish where userId=?0 and productId=?1 and accomplish=\'w\'", Wish.class);
		query.setParameter(0, userId);
		query.setParameter(1, productId);
		List<Wish> list = query.list();
		return list;
	}
	
	public boolean deleteWish(int userId, int productId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Query<Wish> query = session.createQuery("from Wish where userId=?0 and productId=?1", Wish.class);
			query.setParameter(0, userId);
			query.setParameter(1, productId);
			List<Wish> list = query.list();
			list.get(0).setAccomplish("d");
			return true;
		}catch(Exception e) {
			return false;
		}
	}
	
	public boolean updateWish(int userId, int productId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Query<Wish> query = session.createQuery("from Wish where userId=?0 and productId=?1", Wish.class);
			query.setParameter(0, userId);
			query.setParameter(1, productId);
			List<Wish> list = query.list();
			list.get(0).setAccomplish("a");
			return true;
		}catch(Exception e) {
			return false;
		}
	}
	
	public List<Wish> queryAllWishByUserId(int userId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Wish> query = session.createQuery("from Wish where userId=?0 and accomplish='w'", Wish.class);
		query.setParameter(0, userId);
		List<Wish> list = query.list();
		return list;
	}

}
