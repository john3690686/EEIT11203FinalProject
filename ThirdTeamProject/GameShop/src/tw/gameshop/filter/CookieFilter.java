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
		System.out.println("Filter dietroy=============");
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		if(req.getSession().getAttribute("userAccount") == null) {
			Cookie[] cookies = req.getCookies();
			String userAccount = "", userPwd = "", autoLogin = "";
			if (cookies != null && cookies.length != 0) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userAccount")) {
						userAccount = cookie.getValue();
					} else if (cookie.getName().equals("userPwd")) {
						userPwd = cookie.getValue();
					} else if (cookie.getName().equals("autoLogin")) {
						autoLogin = cookie.getValue();
					}
				}
				req.setAttribute("userAccount", userAccount);
				req.setAttribute("userPwd", userPwd);
				req.setAttribute("autoLogin", autoLogin);
			}
		}
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
