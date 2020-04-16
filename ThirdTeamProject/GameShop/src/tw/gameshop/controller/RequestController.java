package tw.gameshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

@Controller
@RequestMapping("/logout")
public class RequestController {

	//登出
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String processLogout(HttpServletRequest request,HttpServletResponse response, SessionStatus status) {
		System.out.println("logout");
		System.out.println(request.getContextPath());
		status.setComplete();
		HttpSession session = request.getSession();
		session.invalidate();
		System.out.println(session);
		return "redirect:/index.html";
	}
}
