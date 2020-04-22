package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	
	private SessionFactory sessionFactory;

	@Autowired
	public ProductDAO(@Qualifier(value="sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public Product queryByName(String gameName) { 	// �H�C���W�٧�C����ƭ���

		try {
			Session session = sessionFactory.getCurrentSession();
			Query<Product> query = session.createQuery("from Product where productName =?0", Product.class);
			query.setParameter(0, gameName);

			List<Product> list = query.list();
			String result = list.get(0).getProductName();

			if (gameName.equalsIgnoreCase(result)) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	public List<Product> queryAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product", Product.class);
		List<Product> list = query.list();
		return list;
	}
	
	public Product queryById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Product myProduct = session.get(Product.class, id);
		return myProduct;
	}

}
