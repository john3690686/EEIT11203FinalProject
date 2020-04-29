<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav>
        <ul class="ul1">
            <li><a href="index.html">HOME</a>
            <li><a href="#">News</a>
            <li><a href="Shop">SHOP</a>
            <li><a href="#" style="padding-right: 20px; padding-left: 25px;">COMMENT</a>
            <li><a href="Chatroom">CHAT</a>
            <li id="hello"> <a href="myProfile"> hi,${userName}</a>
        </ul>
        <a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>
    </nav>
</body>
</html>