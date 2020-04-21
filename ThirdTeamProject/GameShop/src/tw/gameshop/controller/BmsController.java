package tw.gameshop.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
	
	@RequestMapping(path = {"/", "/bms"}, method = RequestMethod.GET)
	public String GoBmsHomePage() {
		return "BmsHome";
	}
	
	/* Call Url path:'/product.all'
	 * return > direct: ProductView.jsp
	 */
	@RequestMapping(path = "/productlist", method = RequestMethod.GET)
	public String SelectProductAll(ModelMap model) throws SQLException {
		List<Product> list = productDao.queryCatalogue();
		model.addAttribute("productlist",list);
		return "BmsProductListView";
	}
		
	/* Call Url path:'/product.all/json'
	 * return: Json ( List<Product> )
	 */
	@ResponseBody
	@RequestMapping(path = "/productJsonView", method = RequestMethod.GET)
	public List<Product> SelectProductAllJson() throws SQLException {
		return productDao.queryAll();
	}

	@RequestMapping(path = "/productImageView/{id}", method = RequestMethod.GET)
	public void ImageView( @PathVariable("id")String rsqId, HttpServletResponse response, Model model) throws IOException {
        int id = Integer.parseInt(rsqId);
        Product myProduct = productDao.queryById(id);
        response.setContentType("image/png");
        ServletOutputStream os = response.getOutputStream();
        byte[] image = myProduct.getProductImage();
        InputStream ISimage = new ByteArrayInputStream(image);
        byte[] bytes = new byte[8192];
        int len = 0;
        System.out.println("ImageView");
        while ((len  = ISimage.read(bytes)) != -1) {
            os.write(bytes, 0, len);
        }
    }
	
	@RequestMapping(path = "/product.newPage", method = RequestMethod.GET)
	public String uploadById() {
		return "BmsUplPage";
	}
	
	@RequestMapping(path = "/product.upl/{id}", method = RequestMethod.GET)
	public String uploadById(@PathVariable("id") String id, Model model) {
		if( id != null ) {
			model.addAttribute("product",productDao.queryById(Integer.parseInt(id)));
		}
		return "BmsUplPage";
	}
	
	@ResponseBody
	@RequestMapping(path = "/json.product.view/{id}", method = RequestMethod.GET)
	public Product jsonProductViewById(@PathVariable("id") String id, Model model) {
		if( id != null ) {
			return productDao.queryById(Integer.parseInt(id));
		}
		return null;
	}
	
	@RequestMapping(path = "/productBean", method = RequestMethod.POST)
	public String UpdateProductItem(	@RequestParam("id") String id,
										@RequestParam("pName") String pName,
		Model model,					@RequestParam("price") int price,
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
	
	@RequestMapping(path = "/product.del/{id}", method = RequestMethod.GET)
	public String DelProductItem( @PathVariable("id") String id, Model model ){
		productDao.deleteById(Integer.parseInt(id));
		return "redirect:/productlist";
	}
	
}
