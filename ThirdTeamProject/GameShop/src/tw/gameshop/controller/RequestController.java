package tw.gameshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class RequestController {

	//首頁
	@RequestMapping("/index.html")
	public String toHome() {
		return "home";
	}
	
	@RequestMapping("/error")
	public String errorPage() {
		return "ErrorPage";
	}

	//登出
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String processLogout(HttpServletRequest request, HttpServletResponse response, SessionStatus status) {
		System.out.println("logout");
		status.setComplete();
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/index.html";
	}

	
}
