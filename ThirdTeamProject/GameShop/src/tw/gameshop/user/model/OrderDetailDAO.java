package tw.gameshop.user.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDetailDAO {

	private SessionFactory sessionFactory;

	@Autowired
	public OrderDetailDAO(@Qualifier(value="sessionFactory") SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public List<OrderDetail> queryByOrderId(int orderId) {
		Session session = sessionFactory.getCurrentSession();
		Query<OrderDetail> query = session.createQuery("from OrderDetail where orderId=?0", OrderDetail.class);
		query.setParameter(0, orderId);
		List<OrderDetail> list = query.list();
		return list;
	}
	
	/**
	 * @author kunhung
	 * @apiNote Bms OrderDetail Chart Dao
	 * @return List<Map<Object, Object>>
	 */
	public List<Map<Object, Object>> queryAllOrderDetail() {
		String hqlStr = "Select productId, count(productId) as n from OrderDetail group by productId Order by n";
		List list = sessionFactory.getCurrentSession().createQuery(hqlStr).list();
		
		List<Map<Object, Object>> resultList = new ArrayList<Map<Object, Object>>();
		
		Iterator iter = list.iterator();
		while( iter.hasNext() ) {
			Map<Object, Object> r = new HashMap<Object, Object>();
			Object[] obj = (Object[])iter.next();
			r.put("productId", obj[0]);
			r.put("NumOfSales", obj[1]);
			resultList.add(r);
		}
		return resultList;
	}
}
