package tw.gameshop.user.model;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDetailDAO {

	private SessionFactory sessionFactory;

	@Autowired
	public OrderDetailDAO(@Qualifier(value="sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public List<OrderDetail> queryByOrderId(int orderId) {
		Session session = sessionFactory.getCurrentSession();
		Query<OrderDetail> query = session.createQuery("from OrderDetail where orderId=?0", OrderDetail.class);
		query.setParameter(0, orderId);
		List<OrderDetail> list = query.list();
		return list;
	}
	
	public List queryAllOrderDetail() {
		String hqlStr = "Select productId, count(productId) as n from OrderDetail group by productId Order by n";
		return sessionFactory.getCurrentSession().createQuery(hqlStr).list();
	}
}
