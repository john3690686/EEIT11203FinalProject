package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("productDao")
public class ProductDAO {

	private SessionFactory sessionFactory;

	public ProductDAO() {
		super();
	}

	@Autowired
	public ProductDAO(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		System.out.println("SessionFactory: " + sessionFactory);//TODO Delete This line
		this.sessionFactory = sessionFactory;
	}

	public List<Product> queryAll() {
		return sessionFactory.getCurrentSession().createQuery("From Product", Product.class).list();
	}
	
	public List<Product> queryCatalogue() {
		return sessionFactory.getCurrentSession().createQuery("From Product p Where Getdate() Between p.uploadTime and downloadTime", Product.class).list();
	}
	
	public Product queryByName(String gameName) { 	// �H�C���W�٧�C����ƭ���

		try {
			Query<Product> query = sessionFactory.getCurrentSession().createQuery("from Product where productName =?0", Product.class).setParameter(0, gameName);

			List<Product> list = query.list();

			if (gameName.equalsIgnoreCase(list.get(0).getProductName())) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Product queryById(int id) {
		return sessionFactory.getCurrentSession().get(Product.class, id);
	}
	
	public Product insertProduct(Product p) {
		if(p != null) {
			sessionFactory.getCurrentSession().save(p);
		}
		return p;
	}
	
	public boolean updateById(int id, Product p) {
		Product myBean = sessionFactory.getCurrentSession().get(Product.class, id);
		if(myBean!=null) {
			myBean.setProductName(p.getProductName());
			myBean.setTag(p.getTag());
			myBean.setIntro(p.getIntro());
			myBean.setPrice(p.getPrice());
			if(p.getProductImage()!=null) {
				myBean.setProductImage(p.getProductImage());
			}
			myBean.setUploadTime(p.getUploadTime());
			myBean.setDownloadTime(p.getDownloadTime());
			return true;
		}
		return false;
	}

	public boolean deleteById(int id) {
		Product myBean = sessionFactory.getCurrentSession().get(Product.class, id);
		if( myBean!=null ) {
			sessionFactory.getCurrentSession().delete(myBean);
			return true;
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> queryAllName(String key) {		    // 回傳商品名稱的List
		Session session = sessionFactory.getCurrentSession();

		String hql = "Select productName from Product where productName like '%"+key+"%'";
		Query<String> query = session.createQuery(hql);
		List<String> list = query.list();
		
		return list;
	}	


}
