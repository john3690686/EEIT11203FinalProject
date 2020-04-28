package tw.gameshop.user.model;

import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class OrdersDAO {
	private SessionFactory sessionFactory;

	@Autowired
	public OrdersDAO(@Qualifier(value="sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	public boolean addOrder(int userId, int totalPrice, LinkedList<Product> cart) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Orders order = new Orders();
			order.setUserId(userId);
			order.setPurchase(totalPrice);
			order.setBuyDatetime(new Date());
			Set<OrderDetail> orderDetail = new HashSet<OrderDetail>();
			for(Product p:cart) {
				OrderDetail detail = new OrderDetail();
				detail.setProductId(p.getProductId());
				detail.setPrice(p.getPrice());
				detail.setOrders(order);
				orderDetail.add(detail);
			}
			order.setOrderDetails(orderDetail);
			session.save(order);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public List<Orders> queryOrderRecord(int userId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Orders> query = session.createQuery("from Orders where userId=?0", Orders.class);
		List<Orders> list = query.list();
		return list;
	}
}
