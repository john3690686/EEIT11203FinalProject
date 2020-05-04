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
			var record;
			var payStatus;
			for (var i=0;i<data.length;i++){
				var date = new Date(data[i][0].buyDate).toLocaleDateString();
				var table="";
				var d1 = "<td>"+date+"</td>"
				var totalPrice=0;
				var thead = "<tr><td>";
				for(var j=0;j<data[i].length;j++){
				var trName = "<p>"+data[i][j].productName+" "+data[i][j].price;
				var br = "<br>";
				table +=trName+br;
				console.log(table);
				var p = data[i][j].price;
				totalPrice += p; 
				}
				var ttail = "</td>";
				var total = "<td>"+totalPrice+"</td>";
				if(data[i][0].payResult=='Y'){
					payStatus="<td><input type='button' id='payY' value='已結帳'></td></tr>";
					}else{
						payStatus="<td><input type='button' id='payN' value='去結帳' onclick='goPay("+data[i][0].orderId+")'></td></tr>";
						}
				record = thead+table+ttail+total+d1+payStatus;
				console.log(record);
			$("#showOrderDetail").append(record);

				}
			}
		})
};

function goPay(orderId){
	window.location.href="PayOrder?orderId="+orderId;
}
</script>
</body>
</html>