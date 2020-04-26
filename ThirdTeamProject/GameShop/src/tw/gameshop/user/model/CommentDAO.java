package tw.gameshop.user.model;

import java.text.SimpleDateFormat;
import java.util.Date;
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
	public CommentDAO(@Qualifier(value = "sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Comment insertData(Comment cData) { // �s�W����
		Session session = sessionFactory.getCurrentSession();

		session.save(cData);
		return cData;
	}

	public List<Comment> QueryAllByProductId(int productId) { // �H�ӫ~id�j�M�Ӱӫ~�Ҧ�����

		Session session = sessionFactory.getCurrentSession();
		Query<Comment> query = session.createQuery("from Comment where productId =?0", Comment.class);
		query.setParameter(0, productId);

		List<Comment> list = query.list();

		return list;
	}

	// 以comid, user id 查詢並修改評論內容
	public Comment updateData(int comId, String newComments) {
		Session session = sessionFactory.getCurrentSession();
		Query<Comment> query = session.createQuery("from Comment where comId =?0", Comment.class);
		
		query.setParameter(0, comId);
		
		List<Comment> comList = query.list();
		Comment result = comList.get(0);
		result.setComment(newComments);
		//update date
		Date date = new Date();
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date2 = sdFormat.format(date);
		result.setPostDatetime(date2);
		session.save(result);
		
		return result;
}
	// 用comid刪除評論
	public boolean deleteData(int comId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Comment> query = session.createQuery("from Comment where comId =?0", Comment.class);
		
		query.setParameter(0, comId);
		
		List<Comment> comList = query.list();
		Comment result = comList.get(0);

		session.delete(result);
		return true;
	}

}
