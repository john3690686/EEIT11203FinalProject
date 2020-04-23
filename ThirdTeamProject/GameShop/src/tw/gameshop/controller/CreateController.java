package tw.gameshop.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gameshop.user.model.ComandPro;
import tw.gameshop.user.model.ComandProService;
import tw.gameshop.user.model.Comment;
import tw.gameshop.user.model.CommentService;

@Controller
@SessionAttributes(names = { "cart", "userId" })
public class CreateController {

	private CommentService cService;
	private Comment comment;
	private ComandProService proService;

	public CreateController() {
	}

	@Autowired
	public CreateController(CommentService cService, Comment comment, ComandProService proService) {
		this.cService = cService;
		this.proService = proService;
		this.comment = comment;
	}

	// 新增評論, 完成後連接到顯示評論的網頁
	@ResponseBody
	@RequestMapping(path = "/commentgo", method = { RequestMethod.GET, RequestMethod.POST })
	public String createCom(@RequestParam("id") String id, @RequestParam("comments") String scomment, ModelMap model) {

		int productid = Integer.parseInt(id);
		int userId = (int) model.getAttribute("userId");
		// 接session內的userId
		comment.setUserId(userId);
		comment.setProductId(productid);
		comment.setComment(scomment);

		Date date = new Date();
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date2 = sdFormat.format(date);
		comment.setPostDatetime(date2);

		cService.insertData(comment);

		return "新增成功!";
	}

	// 修改評論
	@ResponseBody
	@RequestMapping(path = "/updateComment", method = RequestMethod.POST)
	public String UpdateCom(@RequestParam("showComId") String id, @RequestParam("comments") String newComments,
			ModelMap model) {
		int comId = Integer.parseInt(id);
		int userId = (int) model.getAttribute("userId");
		// 接session內的userId
		comment.setUserId(userId);
		cService.updateData(comId, newComments);
		return "update!";
	}

	// 刪除指定id評論
	@ResponseBody
	@RequestMapping(path = "/deleteCom", method = RequestMethod.GET)
	public String deleteCom(@RequestParam("id") String id, ModelMap model) {

		int comId = Integer.parseInt(id);
		int userId = (int) model.getAttribute("userId");

		// 接session內的userId
		comment.setUserId(userId);
		cService.deleteData(comId);

		return "deleted!";
	}

	// 查詢所有評論
	@ResponseBody
	@RequestMapping(path = "/searchCom2", method = { RequestMethod.GET, RequestMethod.POST })
	public List<ComandPro> searchNickname(@RequestParam("id") String id) {
		int productid = Integer.parseInt(id);
		List<ComandPro> nickNameList = (List<ComandPro>) proService.QueryAllByProductId(productid);

		return nickNameList;
	}

}
