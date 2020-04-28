package tw.gameshop.user.model;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class TestEventDAO {

	private SessionFactory sessionFactory;
	
	@Autowired
	private TestEventDAO(@Qualifier(value="sessionFactory")SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public List<Event> queryAllEvent() {
		Query<Event> query = sessionFactory.getCurrentSession().createQuery("from Event",Event.class);
		return query.list();
	}
	
}
