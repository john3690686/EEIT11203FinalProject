package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class ComandProDAO {

	private SessionFactory sessionFactory;
	
	@Autowired
	public ComandProDAO(@Qualifier(value="sessionFactory")SessionFactory sessionFactory) {
		this.sessionFactory= sessionFactory;
	}
	
	public List<ComandPro> QueryAllByProductId(int productId) { // 以商品id搜尋該商品所有評論

			Session session = sessionFactory.getCurrentSession();
			Query<ComandPro> query = session.createQuery("from ComandPro where productId =?0", ComandPro.class);
			query.setParameter(0, productId);

			List<ComandPro> list = query.list();
			int result = list.get(0).getProductId();
			
			if (productId==result) {
				return list;
			}
			return null;
	}
	
}
