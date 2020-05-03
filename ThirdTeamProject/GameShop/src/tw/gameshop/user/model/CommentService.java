package tw.gameshop.user.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tw.gameshop.user.model.Comment;
import tw.gameshop.user.model.CommentDAO;

@Service
public class CommentService {

	private CommentDAO commentDao;
	
	public CommentService(){		
	}
	
	@Autowired
	public CommentService(CommentDAO commentDao) {
		this.commentDao= commentDao;
	}
	
	public Comment insertData(Comment cData) {			// �s�W����
		cData.setComment(processComment(cData.getComment()));
		return commentDao.insertData(cData);
	}
	
	public List<Comment> QueryAllByProductId(int productId) { // �H�ӫ~id�d�߸Ӱӫ~�Ҧ�����
		return commentDao.QueryAllByProductId(productId);
	}
	
	// 以comId 和 userId 修改評論
	public Comment updateData(int comId, String newComments) {	
		return commentDao.updateData(comId, processComment(newComments));
	}
	
	// 以comId 和 userId 刪除評論
	public boolean deleteData(int comId) {			
		return commentDao.deleteData(comId);
	}
	
	//防止注入
	private String processComment(String comment) {
		String newString = comment.replaceAll("&", "&amp").replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">", "&gt");
		return newString;
	}
}
