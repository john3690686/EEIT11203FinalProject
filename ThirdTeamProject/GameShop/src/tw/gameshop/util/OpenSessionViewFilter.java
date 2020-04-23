package tw.gameshop.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;

import org.hibernate.SessionFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


@WebFilter(
		urlPatterns = {"/*"},
		initParams = {
				@WebInitParam(name = "sessionFactoryBeanName", value = "sessionFactory")
		}
)
public class OpenSessionViewFilter implements Filter {

	private SessionFactory sessionFactory;
	private WebApplicationContext context;

	@Override
	public void init(FilterConfig config) throws ServletException {
		String sessionFactoryBeanName = config.getInitParameter("sessionFactoryBeanName");
		ServletContext application = config.getServletContext();
		context = WebApplicationContextUtils.getWebApplicationContext(application);
		sessionFactory = (SessionFactory) context.getBean(sessionFactoryBeanName);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			chain.doFilter(request, response);
			sessionFactory.getCurrentSession().getTransaction().commit();
		} catch (Exception e) {
			sessionFactory.getCurrentSession().getTransaction().rollback();
			System.out.println("Transaction RollBack.");
			e.printStackTrace();
			chain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {
		((ConfigurableApplicationContext)context).close();
	}

}
