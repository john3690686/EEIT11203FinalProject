package tw.gameshop.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tw.gameshop.user.model.OrderDetail;
import tw.gameshop.user.model.OrderDetailDAO;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductDAO;
import tw.gameshop.user.model.ProductService;

@Controller
@PropertySource("classpath:/bmsAccountInfo.properties")
public class BmsController {

	private ProductService pService;
	private OrderDetailDAO oDao;

	public BmsController() {
		super();
	}
	
	@Autowired
    Environment env;

	@Autowired
	public BmsController(ProductService pService, OrderDetailDAO oDao) {
		this.pService = pService;
		this.oDao = oDao;
	}

	@RequestMapping(path = "/bms/home", method = RequestMethod.GET)
	public String GoBmsHomePage() {
		return "BmsHome";
	}
	
	@RequestMapping(path = "/bms/Logout", method = {RequestMethod.POST, RequestMethod.GET})
	public String BmsLogoutSystem(HttpSession httpSession) {
		httpSession.removeAttribute("bmsLoginStatusSession");
		return "redirect:/bmsLoginPage";
	}
	
	@RequestMapping(path = "/bmsLoginPage", method = {RequestMethod.POST, RequestMethod.GET})
	public String BmsLoginSystem(@RequestParam(value = "bmsAcc", required = false)String bmsAcc, 
								@RequestParam(value = "bmsPwd", required = false)String bmsPwd, 
								HttpSession httpSession, Model model) {
		// TODO login Check
		String bmsLoginStatusSession = (String)httpSession.getAttribute("bmsLoginStatusSession");
		Map<String, String> errMsg = new HashMap<String, String>();
		if(bmsAcc != null && bmsPwd != null || bmsLoginStatusSession != null) {
			if(!env.getProperty("bms.manager.acc").equalsIgnoreCase(bmsAcc) || !env.getProperty("bms.manager.pwd").equals(bmsPwd) && bmsLoginStatusSession == null ) {
				errMsg.put("errMsg", "帳號不存在或密碼錯誤");
				model.addAttribute("errMsg", errMsg);
			}else {
				httpSession.setAttribute("bmsLoginStatusSession", "Logined");
				return "redirect:/bms/home";
			}
		}
		return "BmsLoginPage";
	}
	
	@ResponseBody
	@RequestMapping(path = {"/bms/productJsonView", "/productJsonView"}, method = RequestMethod.GET)
	public List<Product> SelectProductAllJson() throws SQLException {
		return pService.queryAll();
	}
	
	@ResponseBody
	@RequestMapping(path = "/bms/productBean", method = RequestMethod.POST)
	public List<Product> UpdateProductItem(	@RequestParam("id") String id,
										@RequestParam("pName") String pName,
										@RequestParam("price") int price,
										@RequestParam("intro") String intro,
										@RequestParam("tag") String tag,
										@RequestParam(value = "file", required = false) MultipartFile mf,
										@RequestParam("uplTime") Date uplTime,
										@RequestParam("dwlTime") Date dwlTime ){
		Product p = new Product( pName, price, intro, tag, uplTime, dwlTime);
		
		if( !mf.isEmpty() ) {
			try {
				p.setProductImage(mf.getBytes());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(id!=null && id.length()>0) {
			try {
				pService.updateById(Integer.parseInt(id), p);
			} catch(NumberFormatException e) {
				e.printStackTrace();
			}
		}else {
			pService.insertProduct(p);
		}
		return pService.queryAll();
	}
	
	@ResponseBody
	@RequestMapping(path = "/bms/product.del/{id}", method = RequestMethod.GET)
	public List<Product> DelProductItem( @PathVariable("id") String id, Model model ){
		pService.deleteById(Integer.parseInt(id));
		return pService.queryAll();
	}
	
	@ResponseBody
	@RequestMapping(path = "/tryOrderDetail", method = {RequestMethod.GET, RequestMethod.POST})
	public List<?> showOrderAll() {
		
		List<?> list = oDao.queryAllOrderDetail();
		return list;
	}

}
