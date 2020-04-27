<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室</title>
<script src="scripts/jquery-3.3.1.min.js" type="text/javascript"></script>

<style type="text/css">
* { margin: 0px auto; }
ul,li { padding:0; margin:0; }
ul { list-style:none; }
#chat-room { width: 800px; margin-top: 50px;}
#chat-room .lefter { float:left; width:200px; height:600px; border:1px solid #ccc; overflow: hidden; }
#chat-room .lefter h2 { background:black; color:white; border-bottom:1px solid #eee; font-size:18px; line-height:30px; text-align:center; font-weight: bold;}
#chat-room .lefter ul { overflow-y:auto; height: 569px; }
#chat-room .lefter ul li {  padding:10px; font-weight:bold; font-size: 14px;}
#chat-room .lefter .self{ background-color: lightgray; }
#chat-room .lefter .users{ background-color: lightpink;}
.spacer { height:8px; overflow:hidden; }
#chat-room .righter { float:right;   width:550px; display:inline; margin:5px; }
#chat-room .righter #chatHistory { height:460px; border:1px solid #ccc; padding:5px; overflow-y:scroll;}
#chat-room #sysMessage {font-size: 16px; font-weight: bolder; line-height: 26px;}
#chat-room .righter .reply .text { border:1px solid #ccc; width:380px; margin-right:5px; padding:4px; vertical-align:middle; font-size: 20px;}
#chat-room .righter .reply label { vertical-align:middle; font-size: 20px;}
#chat-room .righter .mySpeaks { clear:both; float : right;}
#chat-room .righter .mySpeaksMsg { border-radius: 10px; background-color: lightgreen; font-size: 16px; padding: 5px 10px 5px 10px;}
#chat-room .righter .errorSpeaks { clear:both; float: right;display:inline; border-radius: 10px; background-color: red; color:white; font-size: 16px; padding: 5px 10px 5px 10px; margin-bottom: 10px;}
#chat-room .righter .otherSpeaks { clear:both; float: left;}
#chat-room .righter .otherSpeaksMsg { border-radius: 10px; background-color: lightgray; font-size: 16px; padding: 5px 10px 5px 10px;}
#chat-room .righter .timeStamp { vertical-align: bottom; font-size: 10px; color: gray}
#sendMsg { background:#8a9cc2; border:1px solid #29447e; font-size: 20px; padding: 3px; color: white; font-weight: bold;}
#sendImg { background:darkgreen; border:1px solid #29447e; font-size: 16px; padding: 3px; color: white; font-weight: bold;}
#cancelImg { font-size: 16px;}
#uploadedImg {font-size: 16px;}
</style>
</head>
<body>
	<div id="chat-room">
		<div class="lefter">
			<h2>聊天室目前成員</h2>
			<ul id="userlist"></ul>
		</div>
		
		<div class="righter">
		
			<div id="chatHistory"></div>
			
			<div class="spacer"></div>
			<div><span id="sysMessage"></span></div>
			
			<div class="reply">
				<input id="username" hidden="hidden" value='${sessionScope.chatName}' type="text"/>
				<span class="sernTo"></span><select id="toUser"></select><div></div>
				<input type="text" class="text" id="sendMessage" name="content" />
				<input type="button" id="sendMsg" value="送出文字"  onclick="sendMsg();"/><br>
				傳送圖片: <input id="uploadedImg" type="file" name="uploadedImg" > 
				<input id="cancelImg" type="button" value="取消" onclick="$('#uploadedImg').val('');">
				<input id="sendImg" type="button" value="傳圖" onclick="sendImg();"><br>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var websocket = null;
		var userName = $("#username").val();
		//var preventTimeOut = checkSetInterval(userName);

		// Send empty string to wake server.
		// ngrok timeout 5 min.
		function checkSetInterval(userName){
			
				setInterval(function() {
					websocket.send("");
					// console.log("hi"); 		
				}, 250000);
			
		}	
		
	    // Check Browser WebSocket Support
		if ('WebSocket' in window) {
			websocket = new WebSocket("ws://" + window.location.host + '${pageContext.request.contextPath}' + "/websocket?username=" + userName);
		}else {
			alert('不支援的瀏覽器! 請改用Firefox或Chrome');
		}
		

		// WebSocket Error
		websocket.onerror = function () {
			setMessageInnerHTML("WebSocket 連接失敗，請稍後再試<br>如果沒有解決，請通知站方進行修復");
		};

		// WebSocket Open Connection
		websocket.onopen = function () {
			setMessageInnerHTML("哈囉, " + userName + " , 請在下方輸入訊息");
			console.log("Connect On: " + new Date());
		}

		// On message recieving
		websocket.onmessage = function (event) {
			var jsonData = NaN;
			try {
				// If message is JSON, which means server update user list
				jsonData = JSON.parse(event.data);
				var listStr = "";
				var toUserStr = "<option value='0'>所有人</option>";
				for(i=0; i< jsonData.length; i++){
					if(jsonData[i].chatUsers != userName ) {
						listStr += "<li class='users'>" + jsonData[i].chatUsers + "</li>";
						toUserStr += "<option value='" + jsonData[i].chatUsers + "'>" + jsonData[i].chatUsers + "</option>";
					}else {
						// Do not add oneself to chat selection list, and highlight user
			    		listStr += "<li class='self'>" + jsonData[i].chatUsers + "(自己)</li>";
					}
				}
				$("#userlist").html(listStr);	// Update user list
				if(!userName.includes("訪客")){
					$("#toUser").html(toUserStr);	// Update selectable chat target
					$(".sernTo").html("傳送給: ");
				}else {
					$("#toUser").html("<option value='0'>所有人</option>").attr("hidden", "hidden")
				}
			} catch (e) {
				// If message is not JSON, it means pure message for user
				var time = new Date();
				var timeStamp = time.getMonth() + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
				document.getElementById('chatHistory').innerHTML+= "<table class='otherSpeaks'><tr><td><p class='otherSpeaksMsg'>"+event.data+"</p></td><td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>";
				updateScroll();
			} finally{
				updateScroll();
			}
		}


		websocket.onclose = function () {
			setMessageInnerHTML("WebSocket 關閉了，請重新整理頁面試試");
			console.log("Close On: " + new Date());
		}

		// Close WebSocket when browser window close
		window.onbeforeunload = function () {
			websocket.close();
		}

		// Print WebSocket Message to message session.
		function setMessageInnerHTML(innerHTML) {
			document.getElementById('sysMessage').innerHTML= innerHTML + '<br/>';
		}

		function sendMsg(){
			if($("#sendMessage").val().trim() !="" && !$("#sendMessage").val().includes("[ToUser::")){
				var messageToSend = "";
				var myMessage = "";
				if($("#toUser").val() != 0){
					messageToSend += "[ToUser::" + $("#toUser").val() + "]";
					myMessage += "(私訊給 " + $("#toUser").val() + " ) ";
				}
				myMessage += $("#sendMessage").val().replace("<", "&lt;").replace(">", "&gt;");
				messageToSend += $("#sendMessage").val().replace("<", "&lt;").replace(">", "&gt;");
				$("#sendMessage").val("");
				websocket.send(messageToSend);
				var time = new Date();
				var timeStamp = time.getMonth() + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
				$("#chatHistory").append("<table class='mySpeaks'><tr><td class='timeStamp'><p>" + timeStamp + "</p></td><td><p class='mySpeaksMsg'>我: " + myMessage + "</p></td></tr><table>");
			}else if($("#sendMessage").val().includes("[ToUser::")) {
				$("#chatHistory").append("<p class='errorSpeaks'>無效的輸入指令</p></br>");
				$("#sendMessage").val("");
			}
			updateScroll();
		};

		function changeTarget(user) {
			$("#toUser").val(user);
		}

		document.getElementById("sendMessage").addEventListener("keyup", function(event) {
		  // Number 13 is the "Enter" key on the keyboard
		  if (event.keyCode === 13) {
		    // Cancel the default action, if needed
		    event.preventDefault();
		    // Trigger the button element with a click
		    document.getElementById("sendMsg").click();
		  }
		}); 

		function sendImg() {
			var formData = new FormData();
			formData.append('uploadedImg', $('#uploadedImg')[0].files[0]);
			$('#uploadedImg').val("");
			$.ajax({
				url: "ChatImgProcess",
				enctype: "multipart/form-data",
				type: "post",
				contentType: false, //required
			    processData: false, // required
			    mimeType: 'multipart/form-data',
			    data: formData,
			    success: function(data) {
			    	var messageToSend = "";
					var myMessage = "";
			    	if($("#toUser").val() != 0){
						messageToSend += "[ToUser::" + $("#toUser").val() + "]";
						myMessage += "(私訊給 " + $("#toUser").val() + " ) ";
					}
			    	messageToSend += data;
			    	myMessage += data;
			    	websocket.send(messageToSend);
			    	$('#uploadedImg').val("");
			    	var time = new Date();
					var timeStamp = time.getMonth() + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
			    	$("#chatHistory").append("<table class='mySpeaks'><tr><td class='timeStamp'><p>" + timeStamp + "</p></td><td><p class='mySpeaksMsg'>我: " + myMessage + "</p></td></tr></table>");
			    	updateScroll();
				}
			})
			updateScroll();
		}

		function updateScroll() {	
			$("#chatHistory").scrollTop($("#chatHistory")[0].scrollHeight);					
		}
		
	</script>
</body>
</html>