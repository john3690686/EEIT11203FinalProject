<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室</title>
<link rel="stylesheet" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
 
<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">

<link rel="stylesheet" href="css/chatroom.css">
<!-- 2020/04/30 ERROR:: X-Content-Type-Options: nosniff 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1jquery.min.js"></script>
-->
    <!-- Bootstrap CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">
    <script src="js/jquery-3.5.0.min.js"></script>
    <script src="js/gameshop.js"></script>
    
    
<style type="text/css">

footer{
     border-radius: 2px 2px 2px 2px;
	background: -webkit-linear-gradient( #3C3C3C, rgb(19, 18, 18));
     background-repeat: no-repeat;
     position: relative;
     width: 100%;
     height: 180px;
     left: 0;
     right: 0;
     bottom: 0;
     text-align: center;
     z-index: 6666;
     clear: both;
 }
 
.tdName {vertical-align: top; color: white;}
.tdNamePriv  {vertical-align: top; color: yellow;}
</style>
</head>
<body bgcolor="red">

<!-- login form -->
<div class="loginDiv">
	<div class="loginForm">
		<fieldset>
			<legend>登入帳號 </legend>
			<div class="warning"><img src="img/Info_icon.png" title="需擁有帳號，方能使用願望清單與評論功能" style="vertical-align:middle">公用電腦請記得登出，或開啟無痕模式</div><br/>
			<form action="processLogin" method="POST">

				<label for="userAccount">帳號:</label><input type="text" id="loginAccount" name="userAccount" value="${userAccount}"><br/>
				<label for="userPwd">密碼:</label><input type="password" id="loginPwd" name="userPwd" value="${userPwd}"><br/>
				<input type="checkbox" name="autoLogin" id="autoLogin" ${autoLogin}><span>記住我</span><br/>
				
				<br/>
			</form>
			<button class="loginconfirm">登入</button>
				<input type="button" class="cancel_btn" value="取消"><br/>
			   <!-- 登入頁加入新申請帳號 -->
				<input type="button" class="registerbutton" id="register2" value="申請新帳號">
				<p><a href="forget_password">忘記密碼?</a></p>
		</fieldset>
	</div>
	
</div>

<!--Navigator-->
    <nav>
        <ul class="ul1">
            <li><a href="index.html">HOME</a>
            <li><a href="Event">NEWS</a>
            <li><a id="navShop" href="Shop">SHOP</a>
            <li><a href="processArticle">BLOG</a>
            <li><a href="Chatroom">CHAT</a>
            <li id="hello"><a href="myProfile">會員中心</a>
        </ul>
        <a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>	
    </nav>

	<div id="chat-room">
		<div class="lefter">
			<h2>聊天室目前成員</h2>
			<ul id="userlist"></ul>
		</div>
		
		<div class="righter">
		
			<div id="chatHistory"></div>
			
			<div class="spacer"></div>
			<div style="text-align: left"><span id="sysMessage"></span></div>
			
			<div id="reply" style="text-align: left;">
				<input id="username" hidden="hidden" value='${chatName}' type="text"/>
				<span class="sernTo"></span><select id="toUser"></select><div></div>
				<textarea class="text" id="sendMessage" name="content" rows="2" cols="120" style="width: 580px;resize: none;" maxlength="250"></textarea>
				<!-- <input type="text" class="text" id="sendMessage" name="content" /> -->
				<input type="button" id="sendMsg" value="送出文字"  onclick="sendMsg();"/><br>
				<label id="imgLabel">傳送圖片:</label> <input id="uploadedImg" type="file" name="uploadedImg" accept="image/*"> 
				<input id="cancelImg" type="button" value="取消" onclick="$('#uploadedImg').val('');">
				<input id="sendImg" type="button" value="傳圖" onclick="sendImg();"><br>
				<div style="margin-top: 5px;"><p id="notes">圖片大小限5MB，圖片會自動壓縮至最大邊長200px</p></div>
				<div><p id="imgError">&nbsp;</p></div>
			</div>
		</div>
	
	</div>
	<!--footer-->

	<footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

	<script type="text/javascript">
		var winFoucs = 1;
		window.onfocus = function() {
			winFoucs = 1;
		};

		window.onblur = function() {
			winFoucs = 0;
		};
	
		var notifyConfig = {
			//body: '\\ ^o^ /', // 設定內容
			//icon: '/images/favicon.ico', // 設定 icon
		};

		if (Notification.permission === 'default' || Notification.permission === 'undefined') {
			Notification.requestPermission(function(permission) {
				if (permission === 'granted') {
					// 使用者同意授權
					var notification = new Notification('關閉視窗的話會中斷連線，不過視窗在背景或其他分頁的話仍會收到通知!', notifyConfig); // 建立通知
			    }
			});
		}
		if (('Notification' in window)) {
			var notification = new Notification('關閉視窗的話會中斷連線，不過視窗在背景或其他分頁的話仍會收到通知!', notifyConfig); 
		}
		

		var ip;
		$.getJSON("https://api.ipify.org?format=json", 
                function(data) { 
				ip = data.ip;
		}) 
				
	
		 
		var websocket = null;
		var userName = $("#username").val();
		var preventTimeOut = checkSetInterval(userName);

		// Send empty string to wake server. ngrok timeout 5 min.
		function checkSetInterval(userName){
				setInterval(function() {
					websocket.send("");		
				}, 250000);	
		}	
		
	    // Check Browser WebSocket Support
		if ('WebSocket' in window) {
			if(location.protocol !== 'https:'){
				websocket = new WebSocket("ws://" + window.location.host + '${pageContext.request.contextPath}' + "/websocket?username=" + userName);
			}else{
				websocket = new WebSocket("wss://" + window.location.host + '${pageContext.request.contextPath}' + "/websocket?username=" + userName);
			}
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
				// If message is JSON, update user list
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
					$(".sernTo").html("<span style='color: white'>傳送給: </span>");
				}else {
					$("#toUser").html("<option value='0'>所有人</option>").attr("hidden", "hidden")
				}
			} catch (e) {
				// If message is not JSON, it means pure message for user
				var time = new Date();
				var timeStamp = (time.getMonth()+1) + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
				document.getElementById('chatHistory').innerHTML+= "<table class='otherSpeaks'><tr>" + event.data + "<td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>";
				updateScroll();
				if(winFoucs == 0){
					var dataP = event.data.replace(/<br>/g, "\n").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
					if(dataP.indexOf("</p>") - (dataP.indexOf("otherSpeaksMsg")+16) > 10){
						if(dataP.includes("img src")){
							var notification = new Notification(dataP.substring(19, (dataP.substring(19).indexOf("<")+18)) + " [圖片訊息] ", notifyConfig);
						}else {
							var notification = new Notification(dataP.substring(19, (dataP.substring(19).indexOf("<")+18)) + dataP.substring( dataP.indexOf("otherSpeaksMsg")+16,dataP.indexOf("otherSpeaksMsg")+25)  + '...', notifyConfig);
						}
					}else {
						var notification = new Notification(dataP.substring(19, (dataP.substring(19).indexOf("<")+18)) + dataP.substring( dataP.indexOf("otherSpeaksMsg")+16,dataP.indexOf("</p>")), notifyConfig); 
					}
				}
			} 
		}

		// WebSocket lost
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
				var messageToSend = "[ip::"+ip+"]";
				var myMessage = "";
				if($("#toUser").val() != 0){
					messageToSend += "[ToUser::" + $("#toUser").val() + "]";
				}
				myMessage += $("#sendMessage").val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>");
				messageToSend += $("#sendMessage").val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>");
				$("#sendMessage").val("");
				websocket.send(messageToSend);
				var time = new Date();
				var timeStamp = (time.getMonth()+1) + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
				if($("#toUser").val() != 0){
					$("#chatHistory").append("<table class='mySpeaks'><tr><td class='tdNamePriv'>(私訊給 " + $("#toUser").val() + " )</td><td><p class='mySpeaksMsg'>"+ myMessage + "</p></td><td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>");
				}else {
					$("#chatHistory").append("<table class='mySpeaks'><tr><td><p class='mySpeaksMsg'>"+ myMessage + "</p></td><td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>");
				}
			}else if($("#sendMessage").val().includes("[ToUser::")) {
				$("#chatHistory").append("<p class='errorSpeaks'>無效的輸入指令</p></br>");
				$("#sendMessage").val("");
			}
			updateScroll();
		};

		function changeTarget(user) {
			$("#toUser").val(user);
		}
		
		// Enter key to send text
// 因為注音選字會直接送出所以移除		
//		document.getElementById("sendMessage").addEventListener("keyup", function(event) {
//			if (event.keyCode === 13) {
//				event.preventDefault();
//				document.getElementById("sendMsg").click();
//			}
//		}); 

		function sendImg() {
			if($('#uploadedImg')[0].files[0].size < 524288000 && $('#uploadedImg')[0].files[0].type.includes("image")) {
				$("#imgError").html("&nbsp;");
				var formData = new FormData();
				formData.append('uploadedImg', $('#uploadedImg')[0].files[0]);
				$('#sendImg').val("傳送中").attr("disabled","disabled").css("background-color", "lightgreen");
				$.ajax({
					url: "ChatImgProcess",
					enctype: "multipart/form-data",
					type: "post",
					contentType: false, //required
			    	processData: false, // required
			    	mimeType: 'multipart/form-data',
			    	data: formData,
			    	timeout: 20000, //設定傳輸的timeout,時間內沒完成則中斷, ngrok慢到靠杯所以設定20秒
			    	success: function(data) {
			    		$('#uploadedImg').val("");
			    		var messageToSend = "[ip::"+ip+"]";
						var myMessage = "";
			    		if($("#toUser").val() != 0){
							messageToSend += "[ToUser::" + $("#toUser").val() + "]";
						}
			    		messageToSend += data;
			    		myMessage += data;
			    		websocket.send(messageToSend);
			    		$('#uploadedImg').val("");
			    		var time = new Date();
						var timeStamp = (time.getMonth()+1) + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
						if($("#toUser").val() != 0){
							$("#chatHistory").append("<table class='mySpeaks'><tr><td class='tdNamePriv'>(私訊給 " + $("#toUser").val() + " )</td><td><p class='mySpeaksMsg'>"+ myMessage + "</p></td><td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>");
						}else {
							$("#chatHistory").append("<table class='mySpeaks'><tr><td><p class='mySpeaksMsg'>"+ myMessage + "</p></td><td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>");
						}
						$('#sendImg').val("傳圖").removeAttr("disabled").css("background-color", "darkgreen");
						updateScroll();
			    	},
					error: function (e) {
						$('#sendImg').val("傳圖").removeAttr("disabled").css("background-color", "darkgreen");
						console.log("ERROR : ", e);
						$("#imgError").html("網路塞車，傳送失敗...");
					}
				})
			}else{
				$("#imgError").html("檔案太大或檔案類型錯誤");
				$('#uploadedImg').val("");
			}
		}

		function updateScroll() {	
			$("#chatHistory").scrollTop($("#chatHistory")[0].scrollHeight);					
		}
		
	</script>
</body>
</html>