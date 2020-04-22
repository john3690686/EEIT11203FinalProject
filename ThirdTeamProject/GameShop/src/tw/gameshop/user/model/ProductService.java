package tw.gameshop.user.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

	private ProductDAO productsDao;

	@Autowired
	public ProductService(ProductDAO productsDao) {
		this.productsDao = productsDao;
	}
	
	public Product queryByName(String gameName) {
		return productsDao.queryByName(gameName);
	}
	
	public List<Product> queryAll(){
		return productsDao.queryAll();
	}
	
	public Product queryById(int id) {
		return productsDao.queryById(id);
	}

}
