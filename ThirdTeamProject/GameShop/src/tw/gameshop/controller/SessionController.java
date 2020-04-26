package tw.gameshop.controller;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import tw.gameshop.user.model.PD_ProfileDetail;
import tw.gameshop.user.model.P_Profile;
import tw.gameshop.user.model.P_ProfileService;
import tw.gameshop.user.model.P_TotalProfile;

@Controller
@SessionAttributes(names = { "userAccount", "userName", "nickName", "errorMessage" })
public class SessionController {

	private P_ProfileService pservice;
	Pattern regUserAccount = Pattern.compile("^(?=.*[a-zA-Z0-9]).*{6,18}$");
	Pattern regUserPwd = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*{6,12}$");
	Pattern regMail = Pattern.compile("^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z]+$");

	public SessionController() {
	}

	@Autowired
	public SessionController(P_ProfileService pservice) {
		this.pservice = pservice;
	}

	// 註冊
	@RequestMapping(path = "/register", method = RequestMethod.POST)
	public String processAction(@RequestParam("userAccount") String userAccount,
			@RequestParam("userName") String userName, @RequestParam("userPwd") String userPwd,
			@RequestParam("nickName") String nickName, @RequestParam("mail") String mail,
			@RequestParam("gender") Character gender, @RequestParam("userImg") MultipartFile userImg,
			@RequestParam("birthday") String birthday, @RequestParam("address") String address,
			@RequestParam("phone") String phone, Model model) {

		try {
			boolean ckeckInput = regUserAccount.matcher(userAccount).matches() && regUserPwd.matcher(userPwd).matches()
					&& regMail.matcher(mail).matches();

			if (ckeckInput) {
				if (!pservice.isProfileExist(userAccount, mail, nickName)) {
					P_Profile profile = new P_Profile(userAccount, userName, userPwd, nickName, mail, gender,
							userImg.getBytes());
					PD_ProfileDetail profile2 = new PD_ProfileDetail(address, birthday, phone);
					pservice.createProfile(profile, profile2);
					model.addAttribute("titleMessage", "註冊成功");
					return "home";
				}
			}

		} catch (Exception e) {
			System.out.println("Error!!");
			e.printStackTrace();
		}
		return "ErrorPage";
	}

	// 登入
	@RequestMapping(value = "/processLogin", method = RequestMethod.POST)
	public String processLogin(@RequestParam(name = "userAccount") String userAccount,
			@RequestParam(name = "userPwd") String userPwd, Model model, HttpServletRequest request) {
		System.out.println("processLogin");
		P_Profile profile = null;
		boolean ckeckInput = regUserAccount.matcher(userAccount).matches() && regUserPwd.matcher(userPwd).matches();
		if (ckeckInput) {
			profile = pservice.processLogin(userAccount, userPwd);
			if (profile != null) {
				if (profile.isMailState()) {
					HttpSession session = request.getSession();
					session.setAttribute("userAccount", profile.getUserAccount());
					session.setAttribute("userName", profile.getUserName());
					session.setAttribute("nickName", profile.getNickName());
					session.setAttribute("userImg", profile.getUserImg());
					System.out.println("Login Successfully");
					return "redirect:/index.html";
				}else {
					model.addAttribute("errorMessage", "尚未進行信箱認證，請至信箱確認");
					return "redirect:/error";
				}
			}
		}
		model.addAttribute("errorMessage", "資料不正確");
		return "redirect:/error";
	}

	// 測試session
	@RequestMapping(value = "/session.detail", method = RequestMethod.GET)
	public String processTest() {
		return "testsession";
	}

	@RequestMapping(value = "/myProfile", method = RequestMethod.GET)
	public String showProfileDetail() {

		return "profiledetail";
	}

	@ResponseBody
	@RequestMapping(value = "/serchProfile", method = RequestMethod.POST)
	public P_TotalProfile queryProfile(Model model) {
		System.out.println("myProfile");
		P_TotalProfile profile = null;
		profile = pservice.queryProfile((String) model.getAttribute("userAccount"));
		return profile;
	}

	@ResponseBody
	@RequestMapping(value = "/modifyProfile", method = RequestMethod.POST)
	public P_Profile modifyProfile(@RequestParam("userAccount") String userAccount,
			@RequestParam("userName") String userName, @RequestParam("userPwd") String userPwd,
			@RequestParam("nickName") String nickName, @RequestParam("mail") String mail,
			@RequestParam("gender") Character gender, @RequestParam("userImg") MultipartFile userImg,
			@RequestParam("birthday") String birthday, @RequestParam("address") String address,
			@RequestParam("phone") String phone) throws IOException {

		boolean isExist = pservice.isProfileExist(userAccount, mail, nickName);
		boolean checkInput = regUserAccount.matcher(userAccount).matches() && regUserPwd.matcher(userPwd).matches()
				&& regMail.matcher(mail).matches();
		P_Profile profile = null;
		if (checkInput && isExist) {
			profile = new P_Profile();
			PD_ProfileDetail proDetail = new PD_ProfileDetail();
			profile.setUserAccount(userAccount);
			profile.setUserName(userName);
			profile.setNickName(nickName);
			profile.setUserPwd(userPwd);
			profile.setUserImg(userImg.getBytes());
			profile.setMail(mail);
			profile.setGender(gender);
			proDetail.setAddress(address);
			proDetail.setBirthday(birthday);
			proDetail.setPhone(phone);
			pservice.updateProfile(profile, proDetail);
		}

		return profile;
	}

	@RequestMapping(value = "/certification/{mailCode}", method = RequestMethod.GET)
	public String certificationMail(@PathVariable("mailCode") String mailCode) {
		boolean isPass = pservice.certificationMail(mailCode);
		if (isPass) {
			return "CertificationMailSuccess";
		}
		return "ErrorPage";
	}
}
