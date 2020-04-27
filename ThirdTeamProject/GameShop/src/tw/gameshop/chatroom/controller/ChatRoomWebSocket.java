package tw.gameshop.chatroom.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Set;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONArray;
import org.json.JSONObject;

@ServerEndpoint("/websocket")
public class ChatRoomWebSocket {

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
	@OnMessage
	public void onMessage(String message, Session session) {
		String messageUser = null;
		try {
			messageUser = URLDecoder
					.decode(session.getQueryString().substring(session.getQueryString().indexOf("=") + 1), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		Set<String> keys = webSocketMap.keySet();
		// Global Message
		// Empty String is for waking WebSocket 
		if (!message.startsWith("[ToUser::") && !message.equals("")) {
			for (String key : keys) {
				if (!key.equals(messageUser)) {
					try {
						webSocketMap.get(key).sendMessage(messageUser + " 說： " + message);
					} catch (IOException e) {
						e.printStackTrace();
						continue;
					}
				}
			}
		}
		
		// Private message, which starts with "[ToUser::xxx]"
		else if(!message.equals("") && !messageUser.contains("訪客")){
			String toUser = message.substring(9, message.indexOf("]"));
			for (String key : keys) {
				if (key.equals(toUser) && !key.equals(messageUser)) {
					try {
						webSocketMap.get(key)
								.sendMessage("(私訊) " + messageUser + " 跟你說： " + message.substring(message.indexOf("]") + 1));
					} catch (IOException e) {
						e.printStackTrace();
						continue;
					}
				}
			}
		}
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

}