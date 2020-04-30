package tw.gameshop.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.Set;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sun.mail.smtp.SMTPTransport;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutOneTime;
import tw.gameshop.user.model.ModelForEmailAfterPay;
import tw.gameshop.user.model.OrderDetail;
import tw.gameshop.user.model.Orders;
import tw.gameshop.user.model.OrdersService;
import tw.gameshop.user.model.P_ProfileService;
import tw.gameshop.user.model.ProductService;

/**
 * Controller to deal with ECPay functions
 * @author Yuzuha
 * This controller get orderId from previous call, pick up order data, redir user to ECPay server, check data from ECPay and sends mail to inform pay result
 */

@Controller
@SessionAttributes(names = { "cart", "userId" })
public class ECPayController {
	public static AllInOne all;
	
	private ProductService productService;
	private OrdersService ordersService;
	private P_ProfileService profileService;
	
	private String Header = "<!DOCTYPE html>\n" + 
			"<html lang=\"zh-TW\">\n" + 
			"<head>\n" + 
			"    <meta charset=\"UTF-8\">\n" + 
			"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" + 
			"</head>";
	
	private String success = "<body style=\"margin: 0px; padding: 0px; background-image: linear-gradient(to bottom right, #1f4274, #576a85); min-width: 650px;\">\n" + 
			"    <div align=\"center\">\n" + 
			"    <table style=\"width: 600px;\">\n" + 
			"        <tr>\n" + 
			"            <th style=\"text-align: center; color: white; font-size: 30px;\">\n" + 
			"                <p>Welcome to GameShop</p>\n" + 
			"            </th>\n" + 
			"        </tr>\n" + 
			"        <tr style=\"text-align: center; color: lightgoldenrodyellow; font-size: 22px;\">\n" + 
			"            <td>\n" + 
			"            <p>\n" + 
			"                Thank You for your purchase at GmaeShop.<br>\n" + 
			"                You've purchase the following items on [::DATE::]\n" + 
			"            </p>\n" + 
			"        </td>\n" + 
			"        </tr>\n" + 
			"    </table>\n" + 
			"    <table id=\"content\" style=\"width: 800px; border-collapse: collapse;\">";
	
	private String gameList = "<tr>\n" + 
			"            <td rowspan=\"2\" style=\"width: 230px;\">\n" + 
			"                <img src=\"[::img::]\" style=\"max-height: 230px; width: 230px;\"/>\n" + 
			"            </td>\n" + 
			"            <td style=\"width: 20px;\">\n" + 
			"            </td>\n" + 
			"            <td>\n" + 
			"                <span style=\"color: white; font-weight: bold; font-size: 24px;\">[::Name::]</span>\n" + 
			"            </td>\n" + 
			"            <td rowspan=\"2\" style=\"vertical-align: middle;\">\n" + 
			"                <a href=\"[::FileLocation::]\" download>\n" + 
			"                <button type=\"submit\" style=\"border-radius: 5px; font-size: 25px; background-color: darkred; color: white;\">Download</button>\n" + 
			"                </a>\n" + 
			"            </td>\n" + 
			"        </tr>\n" + 
			"        <tr>\n" + 
			"            <td style=\"width: 20px;\"></td>\n" + 
			"            <td><span style=\"color: white; font-size: 12px;\">\n" + 
			"                Product Key:\n" + 
			"            </span><br>\n" + 
			"                <span style=\"color: yellow; font-weight: bold; font-size: 20px;\">\n" + 
			"                [::ProductKey::]\n" + 
			"            </span>\n" + 
			"            </td>\n" + 
			"        </tr>\n" + 
			"        <tr><td><br></td></tr>";
	
	private String fail = "<body style=\"margin: 0px; padding: 0px; background-image: linear-gradient(to bottom right, #1f4274, #576a85); min-width: 650px;\">\n" + 
			"    <div align=\"center\">\n" + 
			"    <table style=\"width: 600px;\">\n" + 
			"        <tr>\n" + 
			"            <th style=\"text-align: center; color: white; font-size: 30px;\">\n" + 
			"                <p>Welcome to GameShop</p>\n" + 
			"            </th>\n" + 
			"        </tr>\n" + 
			"        <tr style=\"text-align: center; color: lightgoldenrodyellow; font-size: 22px;\">\n" + 
			"            <td>\n" + 
			"            <p>\n" + 
			"                感謝您在GameShop購買下列遊戲，但是付款未成功<br>\n" + 
			"                日期: [::DATE::]\n" + 
			"            </p>\n" + 
			"        </td>\n" + 
			"        </tr>\n" + 
			"    </table>\n" + 
			"    <table id=\"content\" style=\"width: 800px; border-collapse: collapse;\">";
	
	private String failGameList = "<tr>\n" + 
			"            <td rowspan=\"2\" style=\"width: 230px;\">\n" + 
			"                <img src=\"[::img::]\" style=\"max-height: 230px; width: 230px;\"/>\n" + 
			"            </td>\n" + 
			"            <td style=\"width: 20px;\">\n" + 
			"            </td>\n" + 
			"            <td>\n" + 
			"                <span style=\"color: white; font-weight: bold; font-size: 24px;\">[::Name::]</span>\n" + 
			"            </td>\n" + 
			"            <td rowspan=\"2\" style=\"vertical-align: middle;\">\n" + 
			"            </td>\n" + 
			"        </tr>\n" + 
			"        <tr>\n" + 
			"            <td style=\"width: 20px;\"></td>\n" + 
			"            <td><span style=\"color: yellow; font-weight: bold; font-size: 20px;\">\n" + 
			"                Failed\n" + 
			"            </span>\n" + 
			"            </td>\n" + 
			"        </tr>\n" + 
			"        <tr><td><br></td></tr>";
	
	private String End = " </table>    \n" + 
			"   \n" + 
			"</div>\n" + 
			"\n" + 
			"</body>\n" + 
			"</html>";

	@Autowired
	public ECPayController(ProductService productService, OrdersService ordersService, P_ProfileService profileService) {
		this.productService = productService;
		this.ordersService = ordersService;
		this.profileService = profileService;
	}

	@GetMapping("PayOrder")
	@ResponseBody
	public String orderAndPay(@ModelAttribute("userId") int userId, Model model, @RequestParam("orderId") int orderId, HttpServletRequest request) {
		// Print DEBUG
		System.out.println("[DEBUG][ECPayController] Accquired userId from session: " + userId);
		System.out.println("[DEBUG][ECPayController] Accquired orderId from request parameter: " + orderId);

		// Get order data from SQL
		Orders orderBean = ordersService.getOrderDataById(orderId);
		
		// Create data needed to send to ECPay Server
		// Total amount
		int totalAmount = orderBean.getPurchase();
		// FormId for ECPay
		String hash = UUID.randomUUID().toString().replace("-", "").substring(0, 20);
		// Items of purchased
		String ItemList = "";
		Set<OrderDetail> orderDetails = orderBean.getOrderDetails();
		int i = 1;
		for (OrderDetail details : orderDetails) {
			ItemList += i + ". " + productService.getProductNameById(details.getProductId()) + "#";
			i++;
		}
		ItemList = ItemList.substring(0, ItemList.length()-1);
		Date buyDate = orderBean.getBuyDatetime();

		System.out.println("[DEBUG][ECPayController] ItemList is: " + ItemList);
		System.out.println("[DEBUG][ECPayController] Order hash is: " + hash);
		System.out.println("[DEBUG][ECPayController] Total amount is:" + totalAmount);
		System.out.println("[DEBUG][ECPayController] Date of purchase is:" + buyDate);

		orderBean.setHash(hash);
		orderBean.setPayResult("P"); // "P" is for Pending, "Y" is for Complete, "N" id s for Failed
		ordersService.updateOrderData(orderBean);

		String Url = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		System.out.println("[DEBUG][ECPayController] Current Server remote address is:" + Url);
		String payForm = generateECPayCreditCardPayForm(hash, buyDate, ItemList, "none", totalAmount, Url);
		return payForm;
	}
	
	@PostMapping("confirmPay")
	@ResponseBody
	public int confirmPay(@RequestParam("MerchantTradeNo") String MerchantTradeNo, @RequestParam("RtnCode") int RtnCode, HttpServletRequest request) {
		System.out.println("[DEBUG][ECPayController] Controller received message from ECPay Server!!");
		System.out.println("[DEBUG][ECPayController] Accquired MerchantTradeNo: " + MerchantTradeNo);
		System.out.println("[DEBUG][ECPayController] Accquired RtnCode: " + RtnCode);
		if(RtnCode==1) {
			ordersService.SetOrderPayStatusByHash(MerchantTradeNo, "Y");
		}else{	
			ordersService.SetOrderPayStatusByHash(MerchantTradeNo, "N");
		}
		// Get Order details and send mail to inform buyer payment status
		Orders myBean = ordersService.GetOrderPayStatusByHash(MerchantTradeNo);
		String mailTo = profileService.getEmailByID(myBean.getUserId());
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = sdf.format(myBean.getBuyDatetime());
		myBean.getOrderDetails();
		String itemList = "";
		String serverLocation = "http://"+request.getServerName()+request.getContextPath();
		Set<OrderDetail> orderDetails = myBean.getOrderDetails();
		int i = 1;
		List<ModelForEmailAfterPay> myList = new ArrayList<ModelForEmailAfterPay>();
		for (OrderDetail details : orderDetails) {
			ModelForEmailAfterPay myModel = new ModelForEmailAfterPay();
			myModel.setName(productService.getProductNameById(details.getProductId()));
			if(RtnCode==1) {
				myModel.setKey(createKey());
			}
			myList.add(myModel);
			
			itemList += i + ". " + productService.getProductNameById(details.getProductId()) + "<br>";
			i++;
		}
		itemList += "總價: " + myBean.getPurchase() + "<br>";
		sendPayResultMail(RtnCode, itemList, mailTo, myList, dateString, serverLocation);
		
		// Return "I've heard you" to ECPay server(required by ECPay).
		return 1;
	}
	
	public String generateECPayCreditCardPayForm(String TradeNo, Date BuyDate, String ItemName, String ReturnURL, int TotalAmount, String Url) {
		try {
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String TradeDate = sdFormat.format(BuyDate);
			all = new AllInOne();
			AioCheckOutOneTime obj = new AioCheckOutOneTime();
			obj.setMerchantTradeNo(TradeNo);
			obj.setMerchantTradeDate(TradeDate);
			obj.setTotalAmount(String.valueOf(TotalAmount));
			obj.setTradeDesc("test Description");
			obj.setItemName(ItemName);
			obj.setClientBackURL(Url+ "/index.html");
			obj.setReturnURL(Url+ "/confirmPay");
			obj.setNeedExtraPaidInfo("N");
			System.out.println("[DEBUG][ECPayController] Payment Type is:" + obj.getChoosePayment());
			String form = all.aioCheckOut(obj, null);
			return form;
		}catch (Exception e) {
			System.out.println("[ERROR][ECPayController] Failed to initialize ECPay Object");
			e.printStackTrace();
			return null;
		}
	}
	
	public void sendPayResultMail(int result, String itemList, String mailTo, List<ModelForEmailAfterPay> modelList, String buyDate, String serverLocation) {
		final String SMTP_SERVER = "smtp.gmail.com";	// smtp server address, ex: smtp.gmail.com
		final String USERNAME = "eeit11203@gmail.com";		// smtp username, ex: xxx@gmail.com
		final String PASSWORD = "P@ssW0rd"; 	// smtp password
		final String EMAIL_FROM = "GameShop";	// smtp sender name, required
		String EMAIL_TO = mailTo;
		final String EMAIL_SUBJECT = "GameShop 付款結果通知";
		Properties prop = System.getProperties();
		prop.put("mail.smtp.host", SMTP_SERVER); // optional, defined in SMTPTransport
		prop.put("mail.smtp.port", "587");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", "true"); // TLS
		Session session = Session.getInstance(prop, null);
		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(EMAIL_FROM));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(EMAIL_TO, false));
			msg.setSubject(EMAIL_SUBJECT);
			StringBuffer text = new StringBuffer();
			
			if (result == 1) {
				text.append(Header);
				text.append(success.replace("[::DATE::]", buyDate));
				for(ModelForEmailAfterPay myList:modelList) {
					text.append(
							gameList.replace("[::Name::]", myList.getName()).replace("[::img::]", (serverLocation+"/img/"+myList.getName()+".jpg")).replace("[::ProductKey::]", myList.getKey()));
				}
				text.append(End);
			}else {
				text.append(Header);
				text.append("<h2>GameShop</h2>");
				text.append(fail.replace("[::DATE::]", buyDate));
				for(ModelForEmailAfterPay myList:modelList) {
					text.append(
							failGameList.replace("[::Name::]", myList.getName()).replace("[::img::]", (serverLocation+"/img/"+myList.getName()+".jpg")));
				}
				text.append(End);
			}
			msg.setContent(text.toString(), "text/html;charset=UTF-8");
			msg.setSentDate(new Date());
			SMTPTransport t = (SMTPTransport) session.getTransport("smtp");
			t.connect(SMTP_SERVER, USERNAME, PASSWORD);
			t.sendMessage(msg, msg.getAllRecipients());
			System.out.println("[DEBUG][ECPayController] SMTP Response: " + t.getLastServerResponse());
			t.close();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		
	}
	
	private String createKey() {
		String key = "";
		for(int i=0;i<25;) {
			int rand = new Random().nextInt(43);
			if(rand<10||rand>17) {
				char c = (char) (rand+'0');
				key += c;
				i++;
				if(i%5==0&&i!=25) {
					key += "-";
				}
			}
		}
		return key;
	}

}
