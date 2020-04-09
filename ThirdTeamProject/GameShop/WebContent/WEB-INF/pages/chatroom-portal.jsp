<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室 portal</title>
<script src="scripts/jquery-3.3.1.min.js" type="text/javascript"></script>
<style type="text/css">
	#chatRoomErrorMsg {
		color: red;
		font-weight: bold;
	}
</style>
</head>
<body>

	訪客，請輸入暱稱
	<form id="myform" action="Chatroom" method="post">
		暱稱： <input id="chatName" name="chatName" type="text"  onblur="checkUserNameDuplication();"/><input type="submit" value="進入聊天室" />
		<input type="text" id="guest" name="guest" hidden="hidden" value="(訪客)"><input type="text" id="check" name="check" hidden="hidden" value="false">
		<h3 id="chatRoomErrorMsg"></h3>
	</form>
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
