<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</head>
<body>
<h1>Account:${session.userAccount}</h1>
<h1>User Name:${session.userName}</h1>
<h1>Nickname:${session.nickName}</h1>
<div class="getsession">
<h1>Ajax get session:</h1>
</div>

</body>
</html>