package tw.gameshop.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONArray;
import org.json.JSONObject;

@ServerEndpoint("/websocket")
public class ChatRoomWebSocket {
	private static final String SQL_USER_NAME = "SA";
	private static final String SQL_USER_PWD = "P@ssW0rd";
	
	// Store users to Map
	private static HashMap<String, ChatRoomWebSocket> webSocketMap = new HashMap<String, ChatRoomWebSocket>();

	private Session session;
	private String userName;

	// User Connect
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		try {
			this.userName = URLDecoder.decode(session.getQueryString().substring(session.getQueryString().indexOf("=") + 1), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		webSocketMap.put(this.userName, this);
		refreshUserList();
	}

	// Send JSON message to all users on user list changed
	public void refreshUserList() {
		// Make a JSON array with all user name
		JSONArray jArray = new JSONArray();
		Set<String> keys = webSocketMap.keySet();
		for (String key : keys) {
			JSONObject jObject = new JSONObject();
			jObject.put("chatUsers", key);
			jArray.put(jObject);
		}

		// Send JSON data to all users
		for (String key : keys) {
			try {
				webSocketMap.get(key).sendMessage(jArray.toString());
			} catch (IOException e) {
				e.printStackTrace();
				continue;
			}
		}
	}

	// User disconnect
	@OnClose
	public void onClose() {
		webSocketMap.remove(this.userName);
		refreshUserList();
	}

	// Process received message
	@SuppressWarnings("unused")
	@OnMessage
	public void onMessage(String message, Session session) {
		String messageUser = null;
		try {
			messageUser = URLDecoder
					.decode(session.getQueryString().substring(session.getQueryString().indexOf("=") + 1), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		String fromIP = message.substring(message.indexOf("[ip::")+5, message.indexOf("]"));
		message = message.substring(0, message.indexOf("[ip::")) + message.substring(message.indexOf("]")+1);
		String toUser = "Everyone";
		
		Set<String> keys = webSocketMap.keySet();
		// Global Message
		// Empty String is for waking WebSocket 
		if (!message.contains("[ToUser::") && !message.equals("")) {
			for (String key : keys) {
				if (!key.equals(messageUser)) {
					try {
						webSocketMap.get(key).sendMessage("<td class='tdName'>" + messageUser + "： </td><td><p class='otherSpeaksMsg'>" + message + "</p></td>");
					} catch (IOException e) {
						e.printStackTrace();
						continue;
					}
				}
			}
		}
		
		// Private message, which starts with "[ToUser::xxx]"
		else if(!message.equals("") && !messageUser.contains("訪客")){
			toUser = message.substring(9, message.indexOf("]"));
			for (String key : keys) {
				if (key.equals(toUser) && !key.equals(messageUser)) {
					try {
						webSocketMap.get(key)
								.sendMessage("<td class='tdNamePriv'>" + messageUser + " (私訊): </td><td><p class='otherSpeaksMsg'>" + message.substring(message.indexOf("]") + 1) + "</p></td>");
					} catch (IOException e) {
						e.printStackTrace();
						continue;
					}
				}
			}
		}
		
		// Write message to SQL server(JDBC)(CAUTION:: Logs can be huge if lots of pics!!!)
//		if(!message.equals("")&&!message.isEmpty()) {
//			writeToSQL(fromIP, messageUser, toUser, message);
//		}
		
	}	
		
	@OnError
	public void onError(Session session, Throwable error) {
		error.printStackTrace();
	}

	public void sendMessage(String message) throws IOException {
		// this.session.getBasicRemote().sendText(message);
		this.session.getAsyncRemote().sendText(message);
	}

	public static synchronized Set<String> getUser() {
		return webSocketMap.keySet();
		
	}
	
	// Write to SQL server(JDBC)
	public void writeToSQL(String sendIP, String send, String target, String message) {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String connUrl = "jdbc:sqlserver://localhost:1433;databaseName=GameShop";
			Connection conn = DriverManager.getConnection(connUrl, SQL_USER_NAME, SQL_USER_PWD);
			String qryStmt = "Insert chatRecord(send, sendIP, target, message) values(?,?,?,?)";
			PreparedStatement stmt = conn.prepareStatement(qryStmt);
			stmt.setString(1, send);
			stmt.setString(2, sendIP);
			stmt.setString(3, target);
			stmt.setString(4, message);
			stmt.execute();
			conn.close();
		}catch (Exception e) {
			System.out.println("SQL write error!!");
		}	
	}

}