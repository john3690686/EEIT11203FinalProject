package tw.gameshop.user.model;

import java.util.LinkedHashMap;
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
	
	public LinkedHashMap<Orders, List<OrderDetail>> queryByOrderList(List<Orders> orders) {
		LinkedHashMap<Orders, List<OrderDetail>> record = new LinkedHashMap<Orders,List<OrderDetail>>();
		for(Orders order:orders) {
			List<OrderDetail> orderList = queryByOrderId(order.getOrderId());
			record.put(order, orderList);
		}
		return record;
	}
	
	public List<OrderDetail> queryByOrderId(int orderId) {
		Session session = sessionFactory.getCurrentSession();
		Query<OrderDetail> query = session.createQuery("from OrderDetail where orderId=?0", OrderDetail.class);
		List<OrderDetail> list = query.list();
		return list;
	}
}
