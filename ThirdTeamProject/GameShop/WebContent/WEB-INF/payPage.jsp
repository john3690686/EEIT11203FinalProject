<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<!-- css for phone -->
	<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
	<!-- favicon -->
	<link rel="shortcut icon" href="img/favicon.ico" />
	<title>購物車內容</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="js/gameshop.js"></script>
	<style type="text/css">
		body {
			font-family: Microsoft JhengHei;
			background: url(img/wishbg.jpg) no-repeat;
			background-attachment: fixed;
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
	<!-- login form -->
	<div class="loginDiv">
		<div class="loginForm">
			<fieldset>
				<legend>登入帳號 </legend>
				<div class="warning"><img src="img/Info_icon.png" title="需擁有帳號，方能使用願望清單與評論功能" style="vertical-align:middle">公用電腦請記得登出，或開啟無痕模式</div><br/>
				<form action="processLogin" method="POST">

					<label for="userAccount">帳號:</label><input type="text" id="loginAccount" name="userAccount" value="${userAccount}"><br/>
					<label for="userPwd">密碼:</label><input type="password" id="loginPwd" name="userPwd" value="${userPwd}"><br/>
					<input type="checkbox" name="autoLogin" id="autoLogin" ${autoLogin}><span>記住我</span><br/>
					
					<br/>
				</form>
				<button class="loginconfirm">登入</button>
					<input type="button" class="cancel_btn" value="取消"><br/>
				   <!-- 登入頁加入新申請帳號 -->
					<input type="button" class="registerbutton" id="register2" value="申請新帳號">
					<p><a href="forget_password">忘記密碼?</a></p>
			</fieldset>
		</div>
		
	</div>

	<!--Wishlist & Shopping cart &top-->
	<a href="showWish.controller"><input type="button" class="wishlist" title="願望清單"></a>
	<a href="prePay.controller"><input type="button" class="shoppingcart" title="購物車"></a>
	<a href="#"><input type="button" class="topbutton"></a>

	<!--Main-->
	<div class="bgcart">

		<br /><br />
		<table class="cartList">
			<tr>
				<td colspan="2">
					<H1><span style="color:rgb(106, 241, 241)">${nickName}</span> 的購物車
						<img src="img/Info_icon.png" title="結帳後會取得遊戲數位版序號，請您務必妥善保存"></H1>
				</td>
				<td colspan="2" style="text-align:right"><a href="toOrderRecord"><input type="button" class="morebutton"
							value="查詢歷史訂單"></a></td>
			</tr>

			<c:forEach var="p" items="${cart}">
				<tr>
					<td><img src="productImage?gamename=${p.productName}" width="230px"></td>
					<td id="${p.productId}" class="pName">${p.productName}</td>
					<td class="pprice">$${p.price}</td>
					<td>
						<!--遊戲資訊按鈕-->
						<a href="searchGame?productName=${p.productName}"><input class="infobutton" type="button"
								value="遊戲資訊"></a>
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

		<a href="Shop"><input type="button" class="morebutton" value="回到商店"></a>

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
		window.onload = function () {
			console.log("onload");
			$.post({
				url: "show.controller",
				type: "post",
				success: function (data) {
					var totalPrice = 0;
					for (var i = 0; i < data.length; i++) {
						var tempPrice = data[i].price;
						totalPrice += tempPrice;
					}
					console.log(totalPrice);
					$("#total").html(totalPrice);
				}
			})

		};
		$(function () {
			$(".delete").click(function () {

				var yes = confirm("是否將此遊戲從購物車中刪除?");

				if (!yes) {
					location.href = "";

				} else {

					var id = $(this).parent().siblings("td.pName").attr("id");
					console.log("id" + id);

					$(this).parent().parent().remove();

					var nextPrice = $(this).parent().siblings("td.pprice").html();
					var price2 = nextPrice.slice(1, nextPrice.length);
					var updatePrice = $("#total").html();
					console.log(price2);
					console.log(nextPrice);
					console.log(updatePrice);

					$("#total").html(updatePrice - price2);

					/*location.reload();*/

					$.ajax({
						url: "delete.controller",
						type: "get",
						data: { id: id },
						success: function (data) {
							console.log("delete ok");
						}
					})
				}

			});

			$("#pay").click(function () {
				
				if ($(".loginz").val() == "Login") {
					alert("請先登入");
				} else {
					var yes = confirm("確認購買以上遊戲?");
					if (yes) {
						var tp = $("#total").html();
						window.location.href = "pay.controller?price=" + tp;

					} else {
						alert("已取消!");
						location.href = "";
					}
				}
			});
		});
		//topButton & wish
		var needLogin = function () {
			if ($(".loginz").val() == "Login") {
				alert("請先登入");
			}
		}
		$(".wishlist").click(needLogin);

		$(".topbutton").hide();
		var winHeight = $(window).height();
		$(window).scroll(function () {
			if ($(window).scrollTop() >= winHeight) {
				$(".topbutton").show();
			} else {
				$(".topbutton").hide();
			}
		})
	</script>
</body>

</html>