<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>信箱認證成功，3秒回到首頁</h1>
<h1><a href="index.html">回到首頁</a></h1>
</body>
<script>
     setTimeout(() => { location.replace("index.html"); }, 3000);
    
</script>
</html>