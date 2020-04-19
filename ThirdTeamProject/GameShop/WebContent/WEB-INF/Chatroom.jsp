<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室</title>
<link rel="stylesheet" href="css/style.css">

<link href="css/bootstrap.min.css" rel="stylesheet">
 
<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">

<link rel="stylesheet" href="css/chatroom.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

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
 }
 
 .tdName {vertical-align: top; color: white;}
.tdNamePriv  {vertical-align: top; color: yellow;}
</style>
</head>
<body>
	<!--Navigator-->
     <nav>
        <ul class="ul1">
        <li><a href="index.html">HOME</a>
        <li><a href="#">NEWS</a>
        <li><a href="#">SHOP</a>
        <li><a href="#" style="padding-right: 20px; padding-left: 25px;">COMMENT</a>
        <li><a href="Chatroom">CHAT</a>
        <a href="#"><input type="button" class="loginz" value="LOGIN"></a>
        </ul>
    </nav>

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
				<input id="username" hidden="hidden" value='${chatName}' type="text"/>
				<span class="sernTo"></span><select id="toUser"></select><div></div>
				<input type="text" class="text" id="sendMessage" name="content" />
				<input type="button" id="sendMsg" value="送出文字"  onclick="sendMsg();"/><br>
				<label id="imgLabel">傳送圖片:</label> <input id="uploadedImg" type="file" name="uploadedImg" accept="image/*"> 
				<input id="cancelImg" type="button" value="取消" onclick="$('#uploadedImg').val('');">
				<input id="sendImg" type="button" value="傳圖" onclick="sendImg();"><br>
				<div><p id="notes">圖片大小限5MB，圖片會自動壓縮至最大邊長200px</p></div>
				<div><p id="imgError">&nbsp;</p></div>
			</div>
		</div>
	
	</div>

	<!--footer-->

	<footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

	<script type="text/javascript">
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
				var timeStamp = time.getMonth() + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
				document.getElementById('chatHistory').innerHTML+= "<table class='otherSpeaks'><tr>" + event.data + "<td class='timeStamp'><p>" + timeStamp + "</p></td></tr><table>";
				updateScroll();
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
				var messageToSend = "";
				var myMessage = "";
				if($("#toUser").val() != 0){
					messageToSend += "[ToUser::" + $("#toUser").val() + "]";
				}
				myMessage += $("#sendMessage").val().replace("<", "&lt;").replace(">", "&gt;");
				messageToSend += $("#sendMessage").val().replace("<", "&lt;").replace(">", "&gt;");
				$("#sendMessage").val("");
				websocket.send(messageToSend);
				var time = new Date();
				var timeStamp = time.getMonth() + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
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
			    		var messageToSend = "";
						var myMessage = "";
			    		if($("#toUser").val() != 0){
							messageToSend += "[ToUser::" + $("#toUser").val() + "]";
						}
			    		messageToSend += data;
			    		myMessage += data;
			    		websocket.send(messageToSend);
			    		$('#uploadedImg').val("");
			    		var time = new Date();
						var timeStamp = time.getMonth() + "/" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes();
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