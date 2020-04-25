<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>購物車內容</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">
body{
	font-family:微軟正黑體;
	background:url(img/skytower.jpg) no-repeat;
	background-size:cover;
}

.bgcart{
	position: relative;
	width:100%;
	height:200%;
    left:0;
    right:0;
    background-size:cover;
}
.cartList{
	position:relative;
	text-align:center;
	top:200px;
	width:70%;
	border-collapse:collapse;
	border-radius:2px 2px 2px 2px;
	border:2px solid rgb(189, 192, 196);
	margin-left:0;
	margin-right:0;
	margin:auto;
	margin-bottom:500px;
}
.cartList h1{
	color:white;
	font-weight:bold;
	text-shadow:2px 2px 2px black;
	text-align:left;
}

.cartList tr:nth-child(1){
	border:none;
	background-color:rgba(21, 65, 78, 0.8);
}
.cartList td:nth-child(1){
	padding:0;
	padding-left:20px;
	padding-right:20px;
}

.cartList tr:nth-child(2n){
	font-size:20px;
	border:none;
	background-color:rgb(201, 214, 198, 0.8);

}
.cartList tr:nth-child(2n+3){
	font-size:20px;
	border:none;
	background-color:rgb(83, 134, 150, 0.8);
}
.cartList td{
	color:white;
	font-weight:bold;
	text-shadow:2px 2px 2px black;
	padding:30px;
}
.cartList tr:last-child{
	font-size:20px;
	border:none;
	background-color:rgb(0, 0, 0, 0.8);
}

#total{
	color:bisque;
	font-size:25px;
}

#pay{
  width:100px;
  font-family: 微軟正黑體;
  font-weight: bold;
  color: black;
  font-size: 16px;
  text-shadow: 1px 1px 0px rgb(222, 170, 127);
  box-shadow: 1px 1px 1px #293136;
  padding: 10px 15px;
  border-radius: 10px;
  border: 2px inset #A33B37;
  background: -webkit-linear-gradient( rgb(248, 205, 141), rgb(223, 131, 70));
}
#pay:hover {
  width:100px;
  background: -webkit-linear-gradient( rgb(252, 156, 78),rgb(221, 193, 152));
}

</style>

</head>

<body>

<!--Navigator-->
	<nav>
		<ul class="ul1">
			<li><a href="index.html">HOME</a>
			<li><a href="#">NEWS</a>
			<li><a href="Shop">SHOP</a>
			<li><a href="#">BLOG</a>
			<li><a href="#">CHAT</a> 
			<a href="#"><input type="button" class="loginz" value="LOGIN"></a>
		</ul>
	</nav>

	<!--Wishlist & Shopping cart-->
	<a href="showWish.controller"><input type="button" class="wishlist"></a>
	<a href="prePay.controller"><input type="button"
		class="shoppingcart"></a>

<!--Main-->
<div class="bgcart">

<br/><br/>
	<table class="cartList">
	  <tr>
		<td colspan="4">
		<H1><span style="color:rgb(106, 241, 241)">${nickName}</span> 的購物車
		<img src="img/Info_icon.png" title="結帳後會取得遊戲數位版序號，請您務必妥善保存"></H1>
		</td>
	  </tr>
	  
	  <c:forEach var="p" items="${cart}">
	  <tr>
	    <td><img src="productImage?gamename=${p.productName}" width="230px"></td>
	    <td id="${p.productId}" class="pName">${p.productName}</td>
	    <td class="pprice">$${p.price}</td>
	    <td>
	    <!--遊戲資訊按鈕-->  
		<a href="searchGame?productName=${p.productName}"><input class="infobutton" type="button" value="遊戲資訊"></a>
	    <input class="delete cartbutton" type="button" value="刪除">
	    </td>
	  </tr>
	  </c:forEach>
	  <tr>
	    <td>總計</td>
	    <td></td>
	    <td>$<span id="total"></span></td>
	    <td><input id="pay" type="button" value="結帳"></td>
	  </tr>  
	</table>

</div>

	<!--footer-->
	<footer>
		<div class="foot">
			<H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
			<H6>All copyrights and trademarks are the property of their
				respective owners.</H6>
		</div>
	</footer>

<script type="text/javascript">
	window.onload = function(){
		console.log("onload");
		$.post({
			url:"show.controller",
			type:"post",
			success:function(data){
				var totalPrice = 0;
				for(var i=0;i<data.length;i++){
					var tempPrice = data[i].price;
					totalPrice += tempPrice;
					}
				console.log(totalPrice);
				$("#total").html(totalPrice);
				}
			})

		};
$(function(){
	$(".delete").click(function(){

	var yes = confirm("是否將此遊戲從購物車中刪除?");

	if(!yes){
		location.href="";
		
	}else{
			
	var id = $(this).parent().siblings("td.pName").attr("id");
	console.log("id" + id);

		$(this).parent().parent().remove();
	
		var nextPrice = $(this).parent().siblings("td.pprice").html();
		var price2 = nextPrice.slice(1,nextPrice.length);
		var updatePrice = $("#total").html();
		console.log(price2);
		console.log(nextPrice);
		console.log(updatePrice);

	$("#total").html(updatePrice-price2);

	/*location.reload();*/

	$.ajax({
		url:"delete.controller",
		type:"get",
		data:{id:id},
		success:function(data){
			console.log("delete ok");
			}
		})
	}	

});

	$("#pay").click(function(){

		var yes = confirm("確認購買以上遊戲?");

		if(yes){
		
		var tp = $("#total").html();	
		window.location.href="pay.controller?price="+tp;
		
	}else{
		alert("已取消!");
		location.href="";
		}
	});
});
</script>
</body>
</html>