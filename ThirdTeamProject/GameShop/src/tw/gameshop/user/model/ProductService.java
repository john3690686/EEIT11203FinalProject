package tw.gameshop.user.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
	private ProductDAO pDao;

	public ProductService() {
	}
	
	@Autowired
	public ProductService(ProductDAO pDao) {
		this.pDao = pDao;
	}
	
	public Product queryByName(String gameName) {
		return pDao.queryByName(gameName);
	}
	
	public Product queryById(int id) {
		return pDao.queryById(id);
	}
	
	public List<Product> queryCatalogue() {
		return pDao.queryCatalogue();
	}
	
	public List<Product> queryAll() {
		return pDao.queryAll();		
	}
	
	public Product addProduct(Product p) {
		return pDao.insertProduct(p);
	}
	
	public boolean updateById(int id, Product p) {
		return pDao.updateById(id, p);
	}
	
	public boolean deleteById(int id) {
		return pDao.deleteById(id);
	}
}
