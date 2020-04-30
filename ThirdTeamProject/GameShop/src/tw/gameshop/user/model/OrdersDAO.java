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
	
	// Change to int by Yuzuha, 2020/04/06
	// I need created orderId to parse to ECPayController to use with ECPay form
	public int addOrder(int userId, int totalPrice, LinkedList<Product> cart) {
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
			int orderIdCreated = (int) session.save(order);
			return orderIdCreated;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	/**
	 * Added by Yuzuha, 2020/04/06
	 * Get Data by orderId
	 * @param orderId
	 * @return
	 */
	public Orders getOrderDataById(int orderId) {
		return sessionFactory.getCurrentSession().get(Orders.class, orderId);
	}
	
	/**
	 * Added by Yuzuha, 2020/04/06
	 * Use Order Bean to update itself, be careful not to insert bean with invalid data or null for not nullable columns.
	 * @param orderBean
	 * @return -1 for error, 0 for no exist bean, others for successful operation
	 */
	public int updateOrderData(Orders orderBean) {
		Orders checkBean = sessionFactory.getCurrentSession().get(Orders.class, orderBean.getOrderId());
		if (checkBean!=null) {
			try {
				return (int) sessionFactory.getCurrentSession().save(orderBean);
			} catch (Exception e) {
				System.out.println("[DEBUG][OrdersDAO] Failed to update order entry ID: " + orderBean.getOrderId()+ ", check your bean data for type error or unallowed nulls");
				e.printStackTrace();
				return -1;
			}
			
		}else {
			return 0;
		}
	}
	
	/**
	 * Added by Yuzuha, 2020/04/06
	 * Change payStatus by matching hash.
	 * @param orderBean
	 * @return -1 for error, 0 for no exist bean, others for successful operation
	 */
	public int SetOrderPayStatusByHash(String hash, String result) {
		Query<Orders> query = sessionFactory.getCurrentSession().createQuery("FROM Orders WHERE hash = :hash", Orders.class).setParameter("hash", hash);
		Orders myBean = query.uniqueResult();
		if (myBean!=null) {
			try {
				myBean.setPayResult(result);
				return (int) sessionFactory.getCurrentSession().save(myBean);
			} catch (Exception e) {
				System.out.println("[ERROR][OrdersDAO] Failed to update order entry ID: " + myBean.getOrderId()+ " for ECPay result...");
				e.printStackTrace();
				return -1;
			}
		}else {
			return 0;
		}
	}
	
	/**
	 * Added by Yuzuha, 2020/04/06
	 * Get Orders Data by hash, in order to change payStatus.
	 * @param orderBean
	 * @return -1 for error, 0 for no exist bean, others for successful operation
	 */
	public Orders GetOrderPayStatusByHash(String hash) {
		Query<Orders> query = sessionFactory.getCurrentSession().createQuery("FROM Orders WHERE hash = :hash", Orders.class).setParameter("hash", hash);
		return query.uniqueResult();
	}
	
	public List<Orders> queryOrderRecord(int userId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Orders> query = session.createQuery("from Orders where userId=?0", Orders.class);
		query.setParameter(0, userId);
		List<Orders> list = query.list();
		return list;
	}
}