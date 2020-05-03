package tw.gameshop.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(value = "/*",
		initParams = {
				@WebInitParam(name = "mustLogin1",value = "/Shop/*"),
				@WebInitParam(name = "mustLogin2",value = "/blog/*"),
				@WebInitParam(name = "mustLogin3",value = "/comment/*")
		})
public class LoginToAction implements Filter {
	List<String> url = new ArrayList<String>();
	String servletPath;
	String contextPath;
	String requestURI;

    public LoginToAction() {
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		boolean isRequestedSessionIdValid = false;
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		servletPath = req.getServletPath();  
		contextPath = req.getContextPath();
		requestURI  = req.getRequestURI();
		isRequestedSessionIdValid = req.isRequestedSessionIdValid();
		
		System.out.println("mustLogin:"+mustLogin() + " ;checkLogin: " +  checkLogin(req));
		if (mustLogin()) {           
			if (checkLogin(req)) {   
				//  需要登入，但已經登入
				chain.doFilter(request, response);
			} else {				
				//  需要登入，尚未登入，所以送回登入畫面
				HttpSession session = req.getSession();
			    
				
				if ( ! isRequestedSessionIdValid ) {
					session.setAttribute("error", "使用逾時，請重新登入");
				} else {
					// 記住原本的"requestURI"，稍後如果登入成功，系統可以自動轉入
					// 原本要執行的程式。
					session.setAttribute("requestURI", requestURI);	
				}
				resp.sendRedirect(contextPath + "/index.html");
				return;
			}
		} else {   //不需要登入，直接去執行他要執行的程式
			chain.doFilter(request, response);
		}
		
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		Enumeration<String> e = fConfig.getInitParameterNames();
		while (e.hasMoreElements()) {
			String path = e.nextElement();
			url.add(fConfig.getInitParameter(path));
		}
	}
	
	private boolean mustLogin() {
		boolean login = false;
		for (String sURL : url) {
			if (sURL.endsWith("*")) {
				sURL = sURL.substring(0, sURL.length() - 1);
				if (sURL.startsWith(servletPath)) {
					login = true;
					break;
				}
			} else {
				if (servletPath.equals(sURL)) {
					login = true;
					break;
				}
			}
		}
		return login;
	}
	
	private boolean checkLogin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		String loginToken = (String)session.getAttribute("userAccount");
		if (loginToken == null || loginToken.length()==0) {
			return false;
		} else {
			return true;
		}
	}

}
