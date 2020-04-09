package tw.gameshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import tw.gameshop.user.model.PD_ProfileDetail;
import tw.gameshop.user.model.P_Profile;
import tw.gameshop.user.model.P_ProfileService;

@Controller
public class TestController {
	
	private P_ProfileService pservice;

	public TestController() {}
	 
	@Autowired
	public TestController(P_ProfileService pservice) {
		this.pservice = pservice;
	}
	
	@RequestMapping(path = "/processImg" , method = RequestMethod.POST)
	public String processImageAction(@RequestParam("userImg") MultipartFile userImg) {
		try {
			
			byte[] img = userImg.getBytes();
			System.out.println(img);
			return "Success";
		}catch(Exception e){
			System.out.println("Error!!");
			e.printStackTrace();
			return "";
		}
	}
	@RequestMapping(path = "/processProfile" , method = RequestMethod.POST)
	public String processAction(
			@RequestParam("userId") String userId,
			@RequestParam("userName") String userName,
			@RequestParam("userPwd") String userPwd,
			@RequestParam("nickname") String nickname,
			@RequestParam("mail") String mail,
			@RequestParam("userImg") MultipartFile userImg) {
		
		System.out.println("Controller start");
		try {
			P_Profile p = new P_Profile(userId, userName, userPwd, nickname, mail);
			p.setUserImg(userImg.getBytes());
			PD_ProfileDetail pd = new PD_ProfileDetail("add4", "2020-03-03", "0900123456");
			pservice.createProfile(p,pd);
//			P_Profile qp = pservice.queryProfile("uid1");
//			System.out.println(qp.getUserName());
			System.out.println("process end");
			return "Success";
		}catch(Exception e){
			System.out.println("Error!!");
			e.printStackTrace();
			return "";
		}
		
	}
}
