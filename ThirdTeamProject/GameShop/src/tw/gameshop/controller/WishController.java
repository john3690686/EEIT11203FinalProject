package tw.gameshop.controller;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductService;
import tw.gameshop.user.model.Wish;
import tw.gameshop.user.model.WishDAO;

@Controller
@SessionAttributes({"userId","nickName"})
public class WishController {
	
	private WishDAO wDao;
	private ProductService pService;

	@Autowired
	public WishController(WishDAO wDao, ProductService pService) {
		this.wDao = wDao;
		this.pService = pService;
	}
	
	@ResponseBody
	@RequestMapping(path="/addWish.controller", method=RequestMethod.GET)
	public String addWish(@RequestParam("id")String id, Model model) {
		int pId = Integer.parseInt(id);
		//get userId from session
		int userId = (int)model.getAttribute("userId");
		boolean add = wDao.queryUniqueWish(userId, pId);
		if(add) {
			wDao.insertWish(userId, pId);
			return "ok";
		}
		else {
			return "repeat";
		}
	}
	
	@RequestMapping(path="/showWish.controller", method=RequestMethod.GET)
	public String showWish(Model model) {
		//get userId from session
		int userId = (int)model.getAttribute("userId");
		List<Wish> wish = wDao.queryAllWishByUserId(userId);
		LinkedList<Product> wProduct = new LinkedList<Product>();
		for(Wish w:wish) {
			Product p = pService.queryById(w.getProductId());
			wProduct.add(p);
		}
		model.addAttribute("wish", wProduct);
		return "wish";
	}
	
	@ResponseBody
	@RequestMapping(path="/deleteWish.controller", method=RequestMethod.GET)
	public String deleteWish(@RequestParam("id")String id, Model model) {
		int pId = Integer.parseInt(id);
		int userId = (int)model.getAttribute("userId");
		wDao.deleteWish(userId, pId);
		return "ok";
	}

}
