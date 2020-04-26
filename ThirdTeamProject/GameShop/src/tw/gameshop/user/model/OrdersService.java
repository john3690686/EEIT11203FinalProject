package tw.gameshop.user.model;

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
}
