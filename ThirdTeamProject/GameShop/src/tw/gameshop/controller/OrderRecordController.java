package tw.gameshop.controller;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gameshop.user.model.OrderDetail;
import tw.gameshop.user.model.OrderDetailDAO;
import tw.gameshop.user.model.OrderRecordBean;
import tw.gameshop.user.model.Orders;
import tw.gameshop.user.model.OrdersDAO;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductService;

@Controller
@SessionAttributes("userId")
public class OrderRecordController {
	private OrdersDAO orderDao;
	private OrderDetailDAO odDao;
	private ProductService pService;

	@Autowired
	public OrderRecordController(OrdersDAO orderDao, OrderDetailDAO odDao, ProductService pService) {
		this.orderDao = orderDao;
		this.odDao = odDao;
		this.pService = pService;
	}
	
	@RequestMapping(path="/toOrderRecord",method = RequestMethod.GET)
	public String processToRecordPage() {
		return "OrderRecord";
	}
	
	@ResponseBody
	@RequestMapping(path = "/getOrderRecord", method = RequestMethod.GET)
	public LinkedList<LinkedList<OrderRecordBean>> orderRecord(Model model) {
		//��ession userId
		int userId = (int)model.getAttribute("userId");
        List<Orders> list = orderDao.queryOrderRecord(userId);
        
		LinkedList<LinkedList<OrderRecordBean>> orderList = new LinkedList<LinkedList<OrderRecordBean>>();
		for(Orders order:list) {
			List<OrderDetail> orderDetail = odDao.queryByOrderId(order.getOrderId());
			LinkedList<OrderRecordBean> record = new LinkedList<OrderRecordBean>();
			for(OrderDetail od:orderDetail) {
				OrderRecordBean orb = new OrderRecordBean();
				orb.setProductId(od.getProductId());
				orb.setPrice(od.getPrice());
				Product product = pService.queryById(od.getProductId());
				orb.setProductName(product.getProductName());
				orb.setUserId(order.getUserId());
				orb.setOrderId(order.getOrderId());
				orb.setBuyDate(order.getBuyDatetime());
				orb.setPayResult(order.getPayResult());
				record.add(orb);
			}
			orderList.add(record);
		}
		return orderList;
	}

}
