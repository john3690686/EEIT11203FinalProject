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
	
	// �ɤJ�ө��D��
	@RequestMapping(path="/Shop", method=RequestMethod.GET)
	public String shopIndex(Model model) {
		model.addAttribute("searchGo", new Product());
		
		List<Product> product = pService.queryCatalogue(); 				// ��ܸ�Ʈw�Ҧ��C��
		model.addAttribute("products", product);

		return "Shop";
	}
	
	// �H�C���W�٧�C������(��+�C���W�٪����})
	@RequestMapping(path="/searchGame{urlname}", method=RequestMethod.GET)
	public String findGameByName(@ModelAttribute("searchGo")Product myProduct, 
	@PathVariable("urlname")String urlName, BindingResult result, ModelMap model) throws IOException{
		
		if(result.hasErrors()) {
			return "ErrorPage";										// �ɦVweb-inf/pages/ErrorPage.jsp
		}
		
		String mygame= myProduct.getProductName();
		Product findResult = pService.queryByName(mygame);
		urlName = findResult.getProductId().toString();
			
		model.addAttribute("productName", mygame);
		model.addAttribute("intro", findResult.getIntro());
		model.addAttribute("price", findResult.getPrice());
		model.addAttribute("tag", findResult.getTag());
		
		int nowProductId = findResult.getProductId();
		model.addAttribute("comments", new Comment());				// �s�W���װ϶�
		model.addAttribute("productId", nowProductId);
																	// �j�M�ӹC���Ҧ�����
		
		List<Comment> theseComments= cService.QueryAllByProductId(nowProductId);
		model.addAttribute("",theseComments);
		
		return "searchResult";	
	}
	
	@RequestMapping(path="/productImage", method=RequestMethod.GET) // Ū���Ϥ�
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
	
	//�N�ӫ~����
	@ResponseBody
	@RequestMapping(path = "/JsonProducts.controller", method = RequestMethod.GET)
	public List<Product> processActionTest() {
		return pService.queryAll();
	}
	
}
