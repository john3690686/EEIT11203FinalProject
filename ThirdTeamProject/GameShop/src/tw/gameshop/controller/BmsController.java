package tw.gameshop.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductDAO;

@Controller
public class BmsController {

	private ProductDAO productDao;

	public BmsController() {
		super();
	}

	@Autowired
	public BmsController(ProductDAO pDao) {
		this.productDao = pDao;
	}
	
	@RequestMapping(path = "/bms/home", method = RequestMethod.GET)
	public String GoBmsHomePage() {
		return "BmsHome";
	}
	
	@ResponseBody
	@RequestMapping(path = "/bms/productJsonView", method = RequestMethod.GET)
	public List<Product> SelectProductAllJson() throws SQLException {
		return productDao.queryAll();
	}
	
	@ResponseBody
	@RequestMapping(path = "/bms/productBean", method = RequestMethod.POST)
	public String UpdateProductItem(	@RequestParam("id") String id,
										@RequestParam("pName") String pName,
										@RequestParam("price") int price,
										@RequestParam("intro") String intro,
										@RequestParam("tag") String tag,
										@RequestParam("file") MultipartFile mf,
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
				productDao.updateById(Integer.parseInt(id), p);
			} catch(NumberFormatException e) {
				e.printStackTrace();
			}
		}else {
			productDao.insertProduct(p);
		}
		return "redirect:/productlist";
	}
	
	@RequestMapping(path = "/bms/product.del/{id}", method = RequestMethod.GET)
	public String DelProductItem( @PathVariable("id") String id, Model model ){
		productDao.deleteById(Integer.parseInt(id));
		return "success";
	}

}
