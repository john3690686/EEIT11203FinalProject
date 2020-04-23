<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室 portal</title>
<link rel="stylesheet" href="css/style.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/chatroom.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<style type="text/css">
	#chat-portal {color: white; margin-top: 150px;}
	#chatRoomErrorMsg {
		color: red;
		font-weight: bold;
	}
	
	footer{
     border-radius: 2px 2px 2px 2px;
     background: -webkit-linear-gradient( #3C3C3C, rgb(19, 18, 18));
     background-repeat: no-repeat;
     position: relative;
     width: 100%;
     height: 180px;
     top: 150vh;
     left: 0;
     right: 0;
     bottom: 0;
     text-align: center;
     z-index: 6666;
 }
</style>
</head>
<body>
<!--Navigator-->
     <nav>
        <ul class="ul1">
        <li><a href="#">HOME</a>
        <li><a href="#">NEWS</a>
        <li><a href="#">SHOP</a>
        <li><a href="#" style="padding-right: 20px; padding-left: 25px;">COMMENT</a>
        <li><a href="Chatroom">CHAT</a>
        <a href="#"><input type="button" class="loginz" value="LOGIN"></a>
        </ul>
    </nav>
    <div id="chat-portal">
	訪客，請輸入暱稱
	<form id="myform" action="Chatroom" method="post">
		暱稱： <input id="chatName" name="chatName" type="text"  onblur="checkUserNameDuplication();"/><input type="submit" value="進入聊天室" />
		<input type="text" id="guest" name="guest" hidden="hidden" value="(訪客)"><input type="text" id="check" name="check" hidden="hidden" value="false">
		<h3 id="chatRoomErrorMsg"></h3>
	</form>
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
							$("#chatRoomErrorMsg").html("暱稱可用")
						}else {
							$("#check").val("false");
							$("#chatRoomErrorMsg").html("暱稱重複，請再換一個")
						}
					}
				})
			}
		}
		
		document.getElementById('myform').onsubmit=function(){
			checkUserNameDuplication();
			if($("#chatName").val().trim()=="" || $("#check").val()=="false")
	    		return false;
	    	return true;
	    }
	</script>
</body>
</html>
