<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
<title>${eventName}</title>

<style type="text/css">
body{
	font-family:Microsoft JhengHei;
	background:url(img/eventbg.jpg) no-repeat;
	background-attachment: fixed;
}
.showProduct td{
	padding:20px;
}

</style>
</head>

<body>

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
    
<!--Wishlist & Shopping cart &top-->
        <a href="showWish.controller"><input type="button" class="wishlist"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart"></a>
		<a href="#"><input type="button" class="topbutton"></a>

 <!--Main-->
	<div class="bgevent">
	
	<table class="showProduct">
    <tr>
        <td colspan="2">
            <H1>${eventName}</H1>
        </td>
    </tr>
    <!--Event Introduction-->
	<tr>
		<td><img src="${pageContext.servletContext.contextPath}/eventImage?eventId=${eventId}" width="460px"/></td>
    	<td class="showProductIntro">${eventContent}<br/></td>
		
    </tr>
    <!--event start & end time-->
    <tr>
    	<td><span style="color:bisque; font-size:18px">活動開始時間：${sDate}</span></td>
		<td><span style="color:bisque; font-size:18px">活動結束時間：${eDate}</span></td>
    </tr>
    <!--product&wish button-->
    <tr>
    	<td><a href="searchGame?productName=${productName2}"><input type="button" class="shopthis" value="前往遊戲主頁"></a></td>
    	<td><input type="button" class="wishthis" value="加入願望清單"></td>
    </tr>
    
    <tr>
    	<td colspan="2"><a href="Event"><input type="button" class="morebutton" value="回到最新消息"></a></td>
    </tr>

</table>

</div>

 <!--footer-->
    <footer style="margin-top:200px">
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

//wish button 接起來
$(".wishthis").click(function(){
			console.log("add wish");
			var id1 = ${productId};
			var name1 = "${productName}";
			console.log("id1="+id1);
			$.ajax({
				url:"addWish.controller?id=" + id1,
				type:"get",
				success:function(data){
					if(data=="ok"){
		                window.alert(name1+"加入願望清單");
						}else if(data=="a"){
						window.alert(name1+"此遊戲已購買");
						}else{
	                    window.alert(name1+"已加入願望清單");
					         }
		              }
				})
			})
			
</script>
</body>
</html>