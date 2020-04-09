package tw.gameshop.chatroom.controller;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ChatroomController {
	@RequestMapping(path = "/Chatroom", method = RequestMethod.GET)
	public String checkSession(HttpSession session) {
		try {
			if (session.getAttribute("chatName") != null && session != null) {
				return "Chatroom";
			}else if (session.getAttribute("nickName") != null && session != null) {
				session.setAttribute("chatName", session.getAttribute("nickName"));
				return "Chatroom";
			}else {
				return "chatroom-portal";
			}
		} catch (Exception e) {
			return "chatroom-portal";
		}
	}
	
	@RequestMapping(path = "/Chatroom", method = RequestMethod.POST)
	public String guestJoinChat(@RequestParam("guest") String guest, @RequestParam("chatName") String chatName, HttpSession session) {
		if(guest.equals("(訪客)")) {
			String userName = chatName + guest;
			session.setAttribute("chatName", userName);
			return "Chatroom";
		}else {
			return "chatroom-portal";
		}
	}
	
	@RequestMapping(path = "/ChatImgProcess", method = RequestMethod.POST)
	public void processImgAction(@RequestParam("uploadedImg") MultipartFile imgPartFile, HttpServletResponse response) throws IOException, ServletException {
		
		// Resize image to less than 200px * 200px
		BufferedImage sourceImage = ImageIO.read(imgPartFile.getInputStream());
		Image thumbnail = null;
		if(sourceImage.getHeight()>sourceImage.getWidth()) {
			thumbnail = sourceImage.getScaledInstance(-1, 200, Image.SCALE_SMOOTH);
		}else {
			thumbnail = sourceImage.getScaledInstance(200, -1, Image.SCALE_SMOOTH);
		}
		BufferedImage bufferedThumbnail = new BufferedImage(thumbnail.getWidth(null), thumbnail.getHeight(null), BufferedImage.TYPE_INT_RGB);
		bufferedThumbnail.getGraphics().drawImage(thumbnail, 0, 0, null);
		ByteArrayOutputStream imgOut = new ByteArrayOutputStream(1000);
		ImageIO.write(bufferedThumbnail, "jpeg", imgOut);
		imgOut.flush();
		
		byte[] imgByte = imgOut.toByteArray();
		imgOut.close();
		
		// Base64Encode to display on webpage directly
		String imgEncoded = Base64.encodeBase64String(imgByte);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print("<img src='data:image/jpg;base64," + imgEncoded + "' style='max-height: 200px; max-width: 200px; height:auto; width:auto';/>");		
	}
	
	
	@RequestMapping(path = "/CheckRoomUser", method = RequestMethod.GET)
	public void checkChatNameUnique(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		request.setCharacterEncoding("utf-8");
		String userNameToCheck = request.getParameter("userNameToCheck");
		response.setContentType("text/html;charset=UTF-8");
		Set<String> users = ChatRoomWebSocket.getUser();
		boolean checkResult = true; 
		for (String username : users) {
			if(userNameToCheck.equals(username)) {
				checkResult = false;
			}
		}
		response.getWriter().print(checkResult);
	}
	
}
