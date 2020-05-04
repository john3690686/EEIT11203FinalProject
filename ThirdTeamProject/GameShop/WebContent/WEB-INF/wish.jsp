<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
<title>願望清單</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
body{
	font-family: Microsoft JhengHei;
	background:url(img/skytower.jpg) no-repeat;
	background-size: cover;
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
        <a href="showWish.controller"><input type="button" class="wishlist" title="願望清單"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart" title="購物車"></a>
		<a href="#"><input type="button" class="topbutton"></a>

<!--Main-->
<div class="bgwish">

	<br/><br/>
	<table class="wishList">
	<tr><td colspan="4"><H1><span style="color:rgb(106, 241, 241)">${nickName}</span> 的願望清單</H1></td></tr>
		
		<c:forEach var="wish" items="${wish}" varStatus="pk">
		<tr>
		<td>${pk.count}</td>
		<td><img src="productImage?gamename=${wish.productName}" width="230px"></td>
		<td class="deleteWish" id="${wish.productId}">${wish.productName}</td>
		<td >
		<!--遊戲資訊按鈕-->  
		<a href="searchGame?productName=${wish.productName}"><input class="infobutton" type="button" value="遊戲資訊"></a>
		<!--加入購物車按鈕(未完成)-->  
		<input class="cartbutton" type="button" value="加入購物車">
		<input class="deletebutton" type="button" value="刪除">
		</td>
		</tr>
		</c:forEach>
	</table>

</div>

<!--footer-->
	<footer>
		<div class="foot">
			<H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
			<H6>All copyrights and trademarks are the property of their
				respective owners.</H6>
		</div>
	</footer>
	
<script type="text/javascript">
$(".deletebutton").click(function(){
	var id = $(this).parent().siblings("td.deleteWish").attr("id");
	console.log("id="+id);
	var yes = confirm("是否將此遊戲從願望清單中刪除?");
	if(yes){
	
	$(this).parent().parent().remove();
	$.get({
		url:"deleteWish.controller?id=" + id,
		success:function(data){
			console.log("delete wish: "+data);
			alert("此遊戲已刪除!");
			location.reload();
			}
		})
	}else{
		location.href="";
		}
})
			       //加入商品到購物車，並檢查是否重複
				   $(".cartbutton").click(function(){
					var id1 = $(this).parent().siblings("td.deleteWish").attr("id");
					var name = $(this).parent().siblings("td.deleteWish").html();
					console.log("add product");
					$.ajax({
						url:"add.controller?id=" + id1,
						type:"get",
						success:function(data){
							console.log("add product: "+data);
							if(data=="ok"){
					            window.alert(name+"加入購物車");
								}else{
					            window.alert(name+"已加入購物車");
									}
						       }
						})
					})
</script>
</body>
</html>