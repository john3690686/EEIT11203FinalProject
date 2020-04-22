package tw.gameshop.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.ProductService;

@Controller
public class GetProductImage {

	private ProductService pService;

	@Autowired
	public GetProductImage(ProductService pService) {
		this.pService = pService;
	}
	
	@RequestMapping(path="/productImage.do", method=RequestMethod.GET)
	public void processAction(@RequestParam("Id") String Id, HttpServletResponse response, Model model) throws IOException {
		int id = Integer.parseInt(Id);
		Product myProduct = pService.queryById(id);
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

}
