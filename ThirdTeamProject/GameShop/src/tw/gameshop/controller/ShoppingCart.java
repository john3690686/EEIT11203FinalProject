package tw.gameshop.controller;

import java.util.Iterator; 
import java.util.LinkedList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gameshop.user.model.OrdersDAO;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductService;
import tw.gameshop.user.model.WishDAO;

@Controller
@SessionAttributes(names = {"cart","userId"})
public class ShoppingCart {
	private ProductService pService;
	private OrdersDAO oDao;
	private WishDAO wDao;

	@Autowired
	public ShoppingCart(ProductService pService, OrdersDAO oDao, WishDAO wDao) {
		this.pService = pService;
		this.oDao = oDao;
		this.wDao = wDao;
	}
	
	@ResponseBody
	@RequestMapping(path="/add.controller", method = RequestMethod.GET)
	public String addProduct(@RequestParam("id") String id, Model model) {
		int Id = Integer.parseInt(id);
		//用Id查出一筆產品資料
		Product myProduct = pService.queryById(Id);
		//取出session的"cart"，購物車內的產品
		LinkedList<Product> cart = (LinkedList<Product>)model.getAttribute("cart");
		//判斷購物車內是否有東西，沒有就new LinkedList<Products>，有就繼續存入新加入的產品
		if(cart==null) {
			LinkedList<Product> ncart = new LinkedList<Product>();
			ncart.add(myProduct);
			model.addAttribute("cart",ncart);
		}else {
			//檢查重複購買的商品
			boolean check = true;
			for(Product p:cart) {
				if(p.getProductId()==myProduct.getProductId()) {
					check = false;
				}
			}
			if(check) {
				cart.add(myProduct);
				model.addAttribute("cart",cart);
			}else {
				System.out.println("repeat product");
			}

		}
		return "ok";
	}
	@ResponseBody
	@RequestMapping(path="/show.controller", method=RequestMethod.POST)
	public LinkedList<Product> showCart(Model model) {
		//取出session的"cart"，購物車內的產品
		LinkedList<Product> cart = (LinkedList<Product>)model.getAttribute("cart");
		return cart;
	}
	
	@ResponseBody
	@RequestMapping(path="/delete.controller", method=RequestMethod.GET)
	public void removeProduct(@RequestParam("id") String Id, Model model){
		int pId = Integer.parseInt(Id); 
		LinkedList<Product> cart = (LinkedList<Product>)model.getAttribute("cart");
		//刪除購物車內的商品
		for(Iterator<Product> itr = cart.iterator();itr.hasNext();) {
			Product myProduct = itr.next();
			if(myProduct.getProductId()==pId) {
				itr.remove();
			}
		}
		model.addAttribute("cart",cart);
	}
	
	@RequestMapping(path="/prePay.controller", method=RequestMethod.GET)
	public String processPayPage() {
		return "payPage";
	}
	
	@RequestMapping(path="/pay.controller", method=RequestMethod.GET)
	public String pay(@RequestParam("price") String price, Model model) {
		int totalPrice = Integer.parseInt(price);
		LinkedList<Product> cart = (LinkedList<Product>)model.getAttribute("cart");
		//呼叫OrdersDao的addOrder方法，將訂單和訂單明細存入DB，成功存入回傳true
		int userId = (int)model.getAttribute("userId");
		
		boolean status = oDao.addOrder(userId, totalPrice, cart);
		for(Product myProduct:cart) {
			wDao.updateWish(userId, myProduct.getProductId());
		}
		System.out.println("status:" + status);
		return "pay";
	}
}
