package tw.gameshop.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@WebFilter("/*")
public class CookieFilter implements Filter {

    public CookieFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		Cookie[] cookies = req.getCookies();
		String userAccount = "", userPwd = "", autoLogin = "";
		System.out.println("do filter");
		if (cookies != null && cookies.length != 0) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("userAccount")) {
					userAccount = cookie.getValue();
					System.out.println("Filter Account:"+userAccount);
				} else if (cookie.getName().equals("userPwd")) {
					userPwd = cookie.getValue();
					System.out.println("Filter password:"+userPwd);
				} else if (cookie.getName().equals("autoLogin")) {
					autoLogin = cookie.getValue();
					System.out.println("Filter autoLogin:"+autoLogin);
				}
			}
			if(req.getSession(false) != null) {
				req.changeSessionId();
			}
			
			req.setAttribute("userAccount", userAccount);
			req.setAttribute("userPwd", userPwd);
			req.setAttribute("autoLogin", autoLogin);
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
