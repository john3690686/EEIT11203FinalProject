package tw.gameshop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.gameshop.user.model.ArticleMessageService;
import tw.gameshop.user.model.ArticleService;
import tw.gameshop.user.model.ReplyMessageDAO;
import tw.gameshop.user.model.ReplyMessageService;

@Controller
public class ArticleController {
	
	private ArticleService aService;

	@Autowired 
	HttpServletRequest request;

	private ArticleMessageService artMesService;
	private ReplyMessageService rmService;
	
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
		String aJson = aService.queryAllData();
		request.setAttribute("aJson", aJson);
		return "Article";
	}
	
	@RequestMapping(path = "/myArticle", method = RequestMethod.GET)
	public String myArticle() {
		String aJson = aService.queryMyArticle(2);
		request.setAttribute("aJson", aJson);
		return "MyArticle";
	}
	
	@RequestMapping(path = "/processAction" , method = RequestMethod.POST)
	public String processAction(
			@RequestParam("userID") int userId,
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
		request.setAttribute("readByArticleId", readByArticleId);
		request.setAttribute("message", message);
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/processAddMessage" , method = RequestMethod.POST)
	public String processAddMessage(
			@RequestParam("requestArticleId") int articleId,
			@RequestParam("message") String messageContent) {
		int respUserId = 2;
		artMesService.addArticleMessage(articleId, respUserId, messageContent);
		String readByArticleId = aService.queryArticle(articleId);
		String message = artMesService.queryArticleMessage(articleId);
		request.setAttribute("readByArticleId", readByArticleId);
		request.setAttribute("message", message);
		return "ReadArticle";
	}
	
	@RequestMapping(path = "/addReplyMessage" , method = RequestMethod.POST)
	public String addReplyMessage(
			@RequestParam("messageID") int messageID,
			@RequestParam("messageContent") String messageContent) {
		
		System.out.println("messageID: "+messageID);
		System.out.println("messageContent: "+messageContent);
		rmService.addReply(messageID, messageContent);
		
		return "ReadArticle";
	}
}











