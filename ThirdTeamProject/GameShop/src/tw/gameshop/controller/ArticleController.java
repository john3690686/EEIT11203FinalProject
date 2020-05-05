package tw.gameshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

//import org.hibernate.Session;
import org.hibernate.SessionFactory;
//import org.hibernate.query.Query;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.gameshop.user.model.ArticleMessageService;
import tw.gameshop.user.model.ArticleService;
//import tw.gameshop.user.model.P_Profile;
import tw.gameshop.user.model.ReplyMessageService;

@Controller
public class ArticleController {
	
	private ArticleService aService;

	private ArticleMessageService artMesService;
	private ReplyMessageService rmService;

	private HttpSession session;

	@Autowired 
	HttpServletRequest request;

	private int userId;
	private String userAccount;
	private String nickname;

//	private SessionFactory sessionFactory;


	public ArticleController() {
	}
	
	@Autowired
	public ArticleController(
			@Qualifier(value = "sessionFactory") SessionFactory sessionFactory,
			ArticleService aService, ArticleMessageService artMesService, ReplyMessageService rmService) {
//		this.sessionFactory = sessionFactory;
		this.aService = aService;
		this.artMesService = artMesService;
		this.rmService = rmService;

		
		System.out.println(userId);
	}
	
	@RequestMapping(path = "/processArticle", method = RequestMethod.GET)
	public String showArticle() {
		
//		===============測試用偽裝userID====================
		session = request.getSession();
	
//		userAccount = "a11111";
		userAccount = (String) session.getAttribute("userAccount");
		
		userId = artMesService.queryuserId(userAccount);
		nickname = artMesService.querynickname(artMesService.queryuserId(userAccount));
		
		session.setAttribute("nickname", nickname);
		
//		===================================
		
        //熱門文章排行
        artMesService.queryAMTimes();
        
		String aJson = aService.queryAllData();
		request.setAttribute("aJson", aJson);
		return "Article";
	}
	
	@RequestMapping(path = "/myArticle", method = RequestMethod.GET)
	public String myArticle() {
		String aJson = aService.queryMyArticle(userId);
		request.setAttribute("aJson", aJson);
		return "MyArticle";
	}
	
	@RequestMapping(path = "/processAction" , method = RequestMethod.POST)
	public String processAction(
			@RequestParam("articleTitle") String articleTitle,
			@RequestParam("articleContent") String articleContent,
			@RequestParam("imgLink") String articleThumbnail) {
		
		if(articleTitle.length() > 25) {
			JSONArray jsonAr = new JSONArray();
				JSONObject json = new JSONObject();
				json.put("articleTitle", articleTitle);
				json.put("articleContent", articleContent);
				json.put("articleThumbnail", articleThumbnail);
			jsonAr.put(json);

			String errorReturnTitle = jsonAr.toString();
			postArticle();
			request.setAttribute("checkout", 99847);
			request.setAttribute("errormeg", "標題限定25字以內，請重新輸入!");
			request.setAttribute("errorReturnTitle", errorReturnTitle);
			System.out.println("======>errorReturnTitle: "+errorReturnTitle);
			request.setAttribute("errorReturnTitle", errorReturnTitle);
			return "PostArticle";			
		}
		
        String str = articleContent.replaceAll("<[a-zA-Z]+[1-9]?[^><]*>", "").replaceAll("</[a-zA-Z]+[1-9]?>", "");
        String articleAbstract;
        
        if(str.length()>50) {
        	articleAbstract = str.substring(0, 50);
        }else {
        	articleAbstract = str;
        }
        
        if(articleThumbnail.length()<1 || articleThumbnail == "null") {
        	articleThumbnail = null;
        }
                
		aService.addArticle(userId, articleTitle, articleAbstract, articleContent,articleThumbnail);
		return  "redirect:/processArticle";
	}
	
	@RequestMapping(path = "/postArticle" , method = RequestMethod.GET)
	public String postArticle() {
		request.setAttribute("checkout", 9999);
		request.setAttribute("readByArticleId", 0);
		request.setAttribute("errorReturnTitle", 0);
		return "PostArticle";
	}
	
	@RequestMapping(path = "/processQuery" , method = RequestMethod.POST)
	public String processQuery() {
		 String aJson = aService.queryAllData();
		 
		return aJson;
	}
	
	@RequestMapping(path = "/processReadArticle" , method = RequestMethod.GET)
	public String processReadArticle(@RequestParam("articleID") int articleid) {
		
		String readByArticleId = aService.queryArticle(articleid);
		String message = artMesService.queryArticleMessage(articleid);
		String remess = rmService.queryAllReply(articleid);
		request.setAttribute("readByArticleId", readByArticleId);
		request.setAttribute("message", message);
		request.setAttribute("remess", remess);
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/processAddMessage" , method = RequestMethod.POST)
	public String processAddMessage(
			@RequestParam("requestArticleId") int articleId,
			@RequestParam("message") String messageContent) {
		
//		===========USERID設定===============
		int respUserId = userId;
//		==========================
		
		artMesService.addArticleMessage(articleId, respUserId, messageContent);
		String readByArticleId = aService.queryArticle(articleId);
		String message = artMesService.queryArticleMessage(articleId);
		String remess = rmService.queryAllReply(articleId);
		request.setAttribute("readByArticleId", readByArticleId);
		request.setAttribute("message", message);
		request.setAttribute("remess", remess);
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/addReplyMessage" , method = RequestMethod.POST)
	public String addReplyMessage(
			@RequestParam("aID") int articleID,
			@RequestParam("mID") int messageID,
			@RequestParam("mContent") String messageContent) {
		
		rmService.addReply(articleID, messageID, messageContent);
		processReadArticle(articleID);
		
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/gotoUpdataPage" , method = RequestMethod.POST)
	public String gotoUpdataPage(@RequestParam("aID") int articleID) {

		String readByArticleId = aService.queryArticle(articleID);
		request.setAttribute("readByArticleId", readByArticleId);
		request.setAttribute("checkout", 19487);
		request.setAttribute("errorReturnTitle", 0);
		return "PostArticle";
	}
	
	@RequestMapping(path = "/updataArticle" , method = RequestMethod.POST)
	public String updataArticle(
			@RequestParam("articleID") int articleID,
			@RequestParam("articleTitle") String articleTitle,
			@RequestParam("articleContent") String articleContent,
			@RequestParam("imgLink") String articleThumbnail) {
		
        String str = articleContent.replaceAll("<[a-zA-Z]+[1-9]?[^><]*>", "").replaceAll("</[a-zA-Z]+[1-9]?>", "");
        String articleAbstract;
        
    	if(articleTitle.length() > 25) {
			JSONArray jsonAr = new JSONArray();
				JSONObject json = new JSONObject();
				json.put("articleID", articleID);
				json.put("articleTitle", articleTitle);
				json.put("articleContent", articleContent);
				json.put("articleThumbnail", articleThumbnail);
			jsonAr.put(json);

			String readByArticleId = jsonAr.toString();
			postArticle();
			request.setAttribute("checkout", 19487);
			request.setAttribute("errormeg", "標題限定20字以內，請重新輸入!");
			request.setAttribute("readByArticleId", readByArticleId);
			return "PostArticle";			
		}
        
        if(str.length()>50) {
        	articleAbstract = str.substring(0, 50);
        }else {
        	articleAbstract = str;
        }
        
        if(articleThumbnail.length()<1 || articleThumbnail.equals("undefined")) {
        	articleThumbnail = null;
        }
            
	
		aService.updataArticle(articleID, articleTitle, articleAbstract, articleContent, articleThumbnail);
		processReadArticle(articleID);
		
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/deleteArticle" , method = RequestMethod.POST)
	public String deleteArticle(@RequestParam("aID") int articleID) {
		
		aService.deleteArticle(articleID);
		
		List<Integer> megId = artMesService.queryMessageId(articleID);
		List<Integer> remegId = rmService.queryReplyId(articleID);
		
		for(Integer li : megId) {
			artMesService.deleteAllArticleMessage(li);
		}
		
		for(Integer li : remegId) {
			rmService.deleteAllReplyMessage(li);
		}
		
		String page = myArticle();		
		
		return page;
	}
	

	
}











