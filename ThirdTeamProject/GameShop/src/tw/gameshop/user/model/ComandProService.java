package tw.gameshop.user.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ComandProService {

	private ComandProDAO comandProDAO;

	public ComandProService(){		
	}
	
	@Autowired
	public ComandProService(ComandProDAO comandProDAO) {
		this.comandProDAO= comandProDAO;
	}

	public List<ComandPro> QueryAllByProductId(int productId) { // 以商品id查詢該商品所有評論
		return comandProDAO.QueryAllByProductId(productId);
	}

	
	
}
