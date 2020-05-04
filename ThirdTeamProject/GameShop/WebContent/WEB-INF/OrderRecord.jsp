<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GameGuild~Enjoy your gameLife here~</title>
<link rel="stylesheet" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>

<title>購買紀錄</title>

<style>
	body{
	font-family: Microsoft JhengHei;
	background:url(img/skytower.jpg) no-repeat;
	background-size: cover;
	
	
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
		
		
<table id="showOrderDetail" class="wishList">
<tr><td colspan="4"><H1>訂單紀錄</H1></td></tr>

</table>


<!--footer-->
	<footer>
		<div class="foot">
			<H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
			<H6>All copyrights and trademarks are the property of their
				respective owners.</H6>
		</div>
	</footer>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	$.ajax({
		url:"getOrderRecord",
		type:"get",
		dataType:"json",
		success:function(data){
			console.log(data);
			console.log(data[0][0].payResult);
			var record;
			var payStatus;
			for (var i=0;i<data.length;i++){
				var d = new Date(data[i][0].buyDate).toLocaleDateString();
				var date = "<h2>"+d+"</h2>";
				var thead = "<table>";
				var table="";
				var totalPrice=0;
				for(var j=0;j<data[i].length;j++){
				var tr = "<tr><td>"+(j+1)+"</td><td>"+data[i][j].productName+"</td><td>"+data[i][j].price+"</td></tr>";
				table +=tr;
				var p = data[i][j].price;
				totalPrice += p; 
				}
				var total = "<tr><td></td><td>總計</td><td>"+totalPrice+"</td>";
				if(data[i][0].payResult=='Y'){
					payStatus="<td><input type='button' id='payY' value='已結帳'></td></tr>";
					}else{
						payStatus="<td><input type='button' id='payN' value='去結帳'></td></tr>";
						}
				var ttail = "</table>";
				record =date+thead+table+total+payStatus+ttail; 
			$("#showOrderDetail").append(record);
				}
			}
		})
};
</script>
</body>
</html>