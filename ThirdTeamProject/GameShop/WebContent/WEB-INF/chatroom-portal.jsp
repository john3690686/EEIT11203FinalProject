<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室 portal</title>
<link rel="stylesheet" href="css/style.css">

<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/chatroom.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/gameshop.js"></script>
<style type="text/css">
	#room {width: 800px; margin-top: 200px;}
	
	#legalNotice {width 800px; text-align:center;}
	#legalNotice h1 { color: white; margin: 10px;}
	#legalNotice p { color: white; text-align: left; height: 30px;}
	#agree { color: white; text-align: center;}
	#chat-portal {color: white; margin-top: 50px; text-align:  center;}
	#chatRoomErrorMsg {color: red;font-weight: bold;margin-bottom: 150px;}
	
	
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
 }
</style>
</head>
<body>

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

        <a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>
    </nav>
    <div id ='room'>
    	<div id='legalNotice' style="border: 2px solid yellow;">
   			<h1>聊天室規則</h1>
    		<p>1. 聊天室為屬於公共場合，請尊重其他使用者並謹慎發言</p>
    		<p>2. 請勿傳播不實訊息，包括但不限於武漢肺炎防疫資訊</p>
    		<p>3. 言論、圖片觸犯中華民國法律仍需自負法律責任</p>
    		<p>4. 本聊天室部分內容包括但不限於內文、IP可能會記錄於伺服器</p>
    	</div>
    	<div id='agree'>
    		<input type="checkbox" id='checkAgree'>
    		<label for="checkAgree">我已閱讀並同意遵守聊天室規則</label> 
    	</div>
    <div id="chat-portal">
	<form id="myform" action="Chatroom" method="post">
		請輸入暱稱： <input id="chatName" name="chatName" type="text"  onblur="checkUserNameDuplication();"/><input type="submit" value="進入聊天室" />
		<input type="text" id="guest" name="guest" hidden="hidden" value="(訪客)"><input type="text" id="check" name="check" hidden="hidden" value="false">
		<h3 id="chatRoomErrorMsg">&nbsp;</h3>
	</form>
	</div>
	</div>
	 <!--footer-->
    <footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>
	<script>
		function checkUserNameDuplication() {
			var chatName = $("#chatName").val()+$("#guest").val();
			if($("#chatName").val().trim()!=""){
				$.ajax({			
					url: "CheckRoomUser",
					data: {userNameToCheck: chatName},
					success: function(data) {
						var result = eval(data);
						if(result){
							$("#check").val("true");
							$("#chatRoomErrorMsg").html("暱稱可用").css("color", "green");
						}else {
							$("#check").val("false");
							
							$("#chatRoomErrorMsg").html("暱稱重複，請再換一個").css("color", "red");
						}
					}
				})
			}
		}
		
		document.getElementById('myform').onsubmit=function(){
			checkUserNameDuplication();
			if($("#chatName").val().trim()=="" || $("#check").val()=="false" || $("#checkAgree").is(":not(:checked)") )
	    		return false;
	    	return true;
	    }
	</script>
</body>
</html>
