<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
     <meta charset="UTF-8">
     <title>Insert title here</title>
     <style>
          * {
               margin: 0;
               padding: 0;
          }

          body {
               background-image: url("img/skytower.jpg");
               background-repeat: no-repeat;
               background-size: cover;
               text-align: center;
          }
     </style>
</head>

<body>
     <h1>信箱認證成功，3秒回到首頁</h1>
     <h1><a href="index.html">回到首頁</a></h1>
</body>
<script>
     setTimeout(() => { location.replace("http://localhost:8080/GameShop/index.html"); }, 3000);
</script>

</html>