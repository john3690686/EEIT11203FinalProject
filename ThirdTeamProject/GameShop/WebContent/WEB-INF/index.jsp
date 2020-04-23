<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
</head>
<body>
<h1>TEST</h1>

<form action="http://localhost:8080/GameShop/processProfile" method="POST" enctype="multipart/form-data">
	<label>User ID:</label><input type="text" id="userId" name="userId"><br/>
	<label>User Name:</label><input type="text" id="userName" name="userName"><br/>
	<label>User Password:</label><input type="password" id="userPwd" name="userPwd"><br/>
	<label>Nickname:</label><input type="text" id="nickname" name="nickname"><br/>
	<label>E-mail:</label><input type="text" id="mail" name="mail"><br/>
	<label>Profile Image:</label><input type="file" id="userImg" name="userImg"><br/>
	<input type="submit" value="Send">
</form>

<button id="quickfill">Quick Fill</button>
<script type="text/javascript">
	$("#quickfill").click(function(){
		$("#userId").val("uid2");
		$("#userName").val("unm2");
		$("#userPwd").val("upd2");
		$("#nickname").val("nick2");
		$("#mail").val("mail2@");
	})
</script>
</body>
</html>