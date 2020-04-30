package tw.gameshop.user.model;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service component
 * @author Yuzuha
 *
 */

@Service
public class OrdersService {

	private OrdersDAO ordersDao;
	
	@Autowired
	public OrdersService(OrdersDAO ordersDao) {
		this.ordersDao = ordersDao;
	}
	
	public int addOrder(int userId, int totalPrice, LinkedList<Product> cart) {
		return ordersDao.addOrder(userId, totalPrice, cart);
	}
	
	public Orders getOrderDataById(int orderId) {
		return ordersDao.getOrderDataById(orderId);
	}
	
	public int updateOrderData(Orders orderBean) {
		return ordersDao.updateOrderData(orderBean);
	}
	
	public int SetOrderPayStatusByHash(String hash, String result) {
		return ordersDao.SetOrderPayStatusByHash(hash, result);
	}
	
	public Orders GetOrderPayStatusByHash(String hash) {
		return ordersDao.GetOrderPayStatusByHash(hash);
	}
	
	public List<Orders> queryOrderRecord(int userId){
		return ordersDao.queryOrderRecord(userId);
	}
}
