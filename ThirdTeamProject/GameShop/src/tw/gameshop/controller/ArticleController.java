package tw.gameshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.gameshop.user.model.Article;
import tw.gameshop.user.model.ArticleMessageService;
import tw.gameshop.user.model.ArticleService;
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

	public ArticleController() {
	}
	
	@Autowired
	public ArticleController(ArticleService aService, ArticleMessageService artMesService, ReplyMessageService rmService) {
		this.aService = aService;
		this.artMesService = artMesService;
		this.rmService = rmService;
	}
	
	@RequestMapping(path = "/processArticle", method = RequestMethod.GET)
	public String showArticle() {
		
//		===============測試用偽裝userID====================
		session = request.getSession();
		session.setAttribute("userId", 2);
		userId = Integer.parseInt(session.getAttribute("userId").toString());
        System.out.println("===================>userid by session:"+session.getAttribute("userId"));
        System.out.println("===================>userid by userId:"+userId);
        
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
			@RequestParam("articleContent") String articleContent) {
		
        String str = articleContent.replaceAll("<[a-zA-Z]+[1-9]?[^><]*>", "").replaceAll("</[a-zA-Z]+[1-9]?>", "");
        String articleAbstract;
        
        if(str.length()>100) {
        	articleAbstract = str.substring(0, 99);
        }else {
        	articleAbstract = str;
        }
                
		aService.addArticle(userId, articleTitle, articleAbstract, articleContent);
		return  "redirect:/processArticle";
	}
	
	@RequestMapping(path = "/postArticle" , method = RequestMethod.GET)
	public String postArticle() {
		request.setAttribute("checkout_1", 99847);
		request.setAttribute("readByArticleId", 0);
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
		request.setAttribute("checkout_2", 19487);
		
		return "PostArticle";
	}
	
	@RequestMapping(path = "/updataArticle" , method = RequestMethod.POST)
	public String updataArticle(
			@RequestParam("articleID") int articleID,
			@RequestParam("articleTitle") String articleTitle,
			@RequestParam("articleContent") String articleContent			
			) {
		
        String str = articleContent.replaceAll("<[a-zA-Z]+[1-9]?[^><]*>", "").replaceAll("</[a-zA-Z]+[1-9]?>", "");
        String articleAbstract;
        
        if(str.length()>100) {
        	articleAbstract = str.substring(0, 99);
        }else {
        	articleAbstract = str;
        }
		
		aService.updataArticle(articleID, articleTitle, articleAbstract, articleContent);
		processReadArticle(articleID);
		
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/deleteArticle" , method = RequestMethod.POST)
	public String deleteArticle(@RequestParam("aID") int articleID) {
		
		aService.deleteArticle(articleID);
		String page = myArticle();		
		
		return page;
	}
	
}











