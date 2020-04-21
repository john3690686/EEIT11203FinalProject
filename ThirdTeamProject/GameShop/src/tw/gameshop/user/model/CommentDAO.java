package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDAO {
	
	private SessionFactory sessionFactory;
	
	@Autowired
	public CommentDAO(@Qualifier(value="sessionFactory")SessionFactory sessionFactory) {
		this.sessionFactory= sessionFactory;
	}
	
	public Comment insertData(Comment cData) {				 // 新增評論
		Session session = sessionFactory.getCurrentSession();		

		session.save(cData);
		return cData;
	}
	public List<Comment> QueryAllByProductId(int productId) { // 以商品id搜尋該商品所有評論

		Session session = sessionFactory.getCurrentSession();
		Query<Comment> query = session.createQuery("from Comment where productId =?0", Comment.class);
		query.setParameter(0, productId);

		List<Comment> list = query.list();
		
		return list;
	}
	
}
