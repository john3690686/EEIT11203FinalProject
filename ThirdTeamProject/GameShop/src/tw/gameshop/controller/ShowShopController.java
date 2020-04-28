package tw.gameshop.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gameshop.user.model.Comment;
import tw.gameshop.user.model.CommentService;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductService;

@Controller
public class ShowShopController {
	
	private ProductService pService;
	private CommentService cService;
	
	public ShowShopController() {
	}
	
	@Autowired
	public ShowShopController(ProductService pService, CommentService cService) {
		this.pService = pService;
		this.cService = cService;
	}
	
	// 商品主頁
	@RequestMapping(path="/Shop", method=RequestMethod.GET)
	public String shopIndex(Model model) {
		model.addAttribute("searchGo", new Product());
		
		List<Product> product = pService.queryCatalogue(); 		
		model.addAttribute("products", product);

		return "Shop";
	}
	
	// 以遊戲名稱搜尋產品
	@RequestMapping(path="/searchGame{urlname}", method=RequestMethod.GET)
	public String findGameByName(@ModelAttribute("searchGo")Product myProduct, 
	@PathVariable("urlname")String urlName, BindingResult result, ModelMap model) throws IOException{
		
//		if(result.hasErrors()) {
//		System.out.println("error");
//		return "Shop";										// 回到商店主頁
//	}
		
		String mygame= myProduct.getProductName();
		Product findResult = pService.queryByName(mygame);
		
		if (findResult!=null) {
			urlName = findResult.getProductId().toString();
			
			model.addAttribute("productName", mygame);
			model.addAttribute("intro", findResult.getIntro());
			model.addAttribute("price", findResult.getPrice());
			model.addAttribute("tag", findResult.getTag());
		
			int nowProductId = findResult.getProductId();
			model.addAttribute("comments", new Comment());				
			model.addAttribute("productId", nowProductId);
																	
			List<Comment> theseComments= cService.QueryAllByProductId(nowProductId);
			model.addAttribute("",theseComments);
		
			return "searchResult";
			
		}else {	
			return "Shop";          // 搜尋空白或失敗會回到商店主頁
		}
}
	
	@RequestMapping(path="/productImage", method=RequestMethod.GET) 
	public void processAction(@RequestParam("gamename") String gamename, HttpServletResponse response, Model model) throws IOException {

		Product myProduct = pService.queryByName(gamename);
		response.setContentType("image/png");
		ServletOutputStream os = response.getOutputStream();
		byte[] image = myProduct.getProductImage();
		InputStream ISimage = new ByteArrayInputStream(image);
		byte[] bytes = new byte[8192];
		int len = 0;
		while ((len  = ISimage.read(bytes)) != -1) {
			os.write(bytes, 0, len);
		}
	}
	
	// 搜尋所有商品
	@ResponseBody
	@RequestMapping(path = "/JsonProducts.controller", method = RequestMethod.GET)
	public List<Product> processActionTest() {
		return pService.queryAll();
	}
	
	// 回傳資料庫內的遊戲名稱(快速完成用)
	@ResponseBody
	@RequestMapping(path = "/showProductName", method = RequestMethod.GET)
	public List<String> showProductName(@RequestParam("jsondata")String key){
		return pService.queryAllName(key);
	}
	
	
}
