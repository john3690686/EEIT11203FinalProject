<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap"
	rel="stylesheet">

<title>Shop</title>

<style type="text/css">

</style>

</head>
<body>
	<!--Navigator-->
	<nav>
		<ul class="ul1">
			<li><a href="index.html">HOME</a>
			<li><a href="#">NEWS</a>
			<li><a href="Shop">SHOP</a>
			<li><a href="#" style="padding-right: 20px; padding-left: 25px;">COMMENT</a>
			<li><a href="#">CHAT</a> <a href="#"><input type="button"
					class="loginz" value="LOGIN"></a>
		</ul>
	</nav>

	<!--Wishlist & Shopping cart-->
	<a href="showWish.controller"><input type="button" class="wishlist"></a>
	<a href="prePay.controller"><input type="button"
		class="shoppingcart"></a>

	<!--Main-->
	<div class="bgshop">

		<div class="horizon2">
			<H1>Shop</H1>
		</div>
		<br /> <br />

		<fieldset>
			<figure>
				<!--輪播已修改完畢(接商品頁面)-->
				<a id="mainUrl" href="">
					<canvas id="myCanvas" width="460" height="215">  
                <img id="mainImg1" src="img/sale1.jpg"
							style="display: none" />
                <img id="mainImg2" src="img/sale2.jpg"
							style="display: none" />
                <img id="mainImg3" src="img/sale3.jpg"
							style="display: none" />
                <img id="mainImg4" src="img/sale4.jpg"
							style="display: none" />
                <img id="mainImg5" src="img/sale5.jpg"
							style="display: none" />
                </canvas>
				</a>
				<div id="chimg"></div>
			</figure>
		</fieldset>

		<hr>

		<table class="productTable">
			<tr class=searchArea>

				<!--Search Game Area-->
				<td></td>
				<td></td>
				<td></td>
				<td></td>

				<form:form action="searchGame" method="get"
					modelAttribute="searchGo">
					<td><img src="img/searchicon2.png"
						style="filter: contrast(100%);"> <form:input
							path="productName" /> <form:button value="Send">Search Games</form:button>
					</td>
				</form:form>
			</tr>
		</table>
		
				<!--Show Products & Page-->
				<table id="content" class="productTable" ></table>
    			<div id="page" class="pageview"></div>
 
	</div>

	<!--footer-->
	<footer>
		<div class="foot">
			<H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
			<H6>All copyrights and trademarks are the property of their
				respective owners.</H6>
		</div>
	</footer>

	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		//Sales輪播圖片

		var nowAD = 0;
		var maxAD = 5;
		var intervalAD;
		var intervalTime = 3000;
		var myCanvas;
		var ctx;
		var preImg;
		var timeouts = [];
		var backFlag = false;
		var tempAD = maxAD;
		document.addEventListener("DOMContentLoaded", init);

		function init() {
			genereteChangeBtn();
			for (let i = 1; i <= maxAD; i++) {
				document.getElementById("ad" + i).addEventListener("click",
						changebtn);
				document.getElementById("myCanvas").addEventListener(
						"mouseover", pause);
				document.getElementById("myCanvas").addEventListener(
						"mouseout", keepgo);
			}

			myCanvas = document.getElementById("myCanvas");
			ctx = myCanvas.getContext("2d");
			preImg = document.getElementById("mainImg1");
			intervalAD = setInterval(cycleAD, intervalTime);
		}
		function genereteChangeBtn() {
			let html = "";
			for (let i = 1; i <= maxAD; i++) {
				html = html + "<img id='ad" + i + "'src='img/chimg.png'>";
			}
			document.getElementById("chimg").innerHTML = html;
		}
		function cycleAD() {
			while (timeouts.length != 0) {
				let i = timeouts.length - 1;
				clearTimeout(timeouts[i]);
				timeouts.pop();
			}
			preImg = document.getElementById("mainImg" + tempAD);
			nextAD();
			if (tempAD == 1 && nowAD == maxAD) {
				backFlag = true;
			} else if (tempAD == maxAD && nowAD == 1) {
				backFlag = false;
			} else if (tempAD > nowAD) {
				backFlag = true;
			}
		// 可導向網頁的圖片連結(之後再接網頁內的商品)
		
			var db = ['DARK SOULS: REMASTERED','Terraria','Resident Evil3','Age of Empires II: Definitive Edition','Monster Hunter'];
		 	document.getElementById("mainUrl").href = "http://localhost:8080/GameShop/searchGame?productName="+ db[(nowAD-1)];

			let nowImg = document.getElementById("mainImg" + nowAD);
			for (let x = 0; x <= 460; x++) {
				let x1;
				let x2;
				if (backFlag) {
					x1 = 0 + x;
					x2 = x - 460;
				} else {
					x1 = 0 - x;
					x2 = 460 - x;
				}
				timeouts.push(setTimeout(function() {
					ctx.drawImage(preImg, x1, 0, 460, 215);
					ctx.drawImage(nowImg, x2, 0, 460, 215);
				}, x));
			}
			backFlag = false;
			tempAD = nowAD;
		}
		function nextAD() {
			nowAD += 1;
			if (nowAD > maxAD) {
				nowAD = 1;
			}
			for (let i = 1; i <= maxAD; i++) {
				if (i == nowAD) {
					document.getElementById("ad" + i).style.filter = "none";
				} else {
					document.getElementById("ad" + i).style.filter = "grayscale(100)";
				}
			}
		}
		function pause() {
			clearInterval(intervalAD);
		}
		function keepgo() {
			intervalAD = setInterval(cycleAD, intervalTime);
		}

		function changebtn() {
			if (this.id.charAt(2) == 1) {
				nowAD = maxAD;
			} else {
				nowAD = this.id.charAt(2) - 1;
			}
			changeAD();
		}
		function changeAD() {
			cycleAD();
			if (adStatus) {
				clearInterval(intervalAD);
				intervalAD = setInterval(cycleAD, intervalTime);
			}
		}

		//鈞太哥的商品分頁
		$(document).ready(function () {
			
	        var itemPerPage = 5;		// 一頁幾個商品
	        var nowPage = 1;
	        var totalPage = 0;			// 全部頁數
	        
	        $.ajax({
	            url: "JsonProducts.controller",  //data path
	            type: "GET",
	            dataType: "json",
	            success: function (data) {
		            
	                //donload data to <table>
	                var txt = ' ';
	                
	                for (let i = 0; i < data.length; i++) {

		                txt += '<tr><td>' + "<img src='data:image/jpeg;base64," + data[i].productImage + "' width='230px'>" + 
	                    '</td><td class="pName" id="'+data[i].productId +'">' + data[i].productName + '</td><td>' + data[i].tag + '</td><td>' + data[i].price + 
	                    '</td><td>' + "<a href='searchGame?productName="+data[i].productName+"'><input type='button' value='遊戲資訊'></a>  <input class='wish' type='button' value='加入願望清單'>  <input class='cart' type='button' value='加入購物車'>" +
	                    '</td></tr>';
	                }
	                txt + ' ';
	                $("#content").append(txt);

	                //Calculate total page
	                totalPage = Math.ceil(data.length / itemPerPage);

	                //create page number link
	                $("#page").append('<a id="pre" href="#"> << </a>');
	                
	                for (let i = 0; i < totalPage; i++) {
	                    $("#page").append('<a href="#">' + (i + 1) + '</a>');	// 顯示總共幾頁 	   

	                    $("#page a").eq(i + 1).click(function () {
	                        $("#content tr").hide();
	                        for (let item = i * itemPerPage; item < (i + 1) * itemPerPage; item++) {
	                            $("#content tr").eq(item).show();
	                        }
	                        nowPage = i + 1;
	                        $("#nowPage").text(nowPage);
	                    })
	                }
	                $("#page").append('<a id="next" href="#">>></a>');

	                //pre link
	                $("#pre").click(function () {
	                    if (nowPage > 1) {
	                        nowPage = nowPage - 1;
	                        $("#page a").eq(nowPage).click();
	                        $("#nowPage").text(nowPage);
	                    }
	                })

	                //next link
	                $("#next").click(function () {
	                    if (nowPage < totalPage) {
	                        nowPage = nowPage + 1;
	                        $("#page a").eq(nowPage).click();
	                        $("#nowPage").text(nowPage);
	                    }
	                })

	                //first show
	                $("#page a").eq(1).click();
	                $(".wish").click(function(){
					console.log("add wish");
					var id1 = $(this).parent().siblings("td.pName").attr("id");
					var name1 = $(this).parent().siblings("td.pName").html();
					console.log("id1="+id1);
					window.alert(name1+"加入願望清單");
					$.ajax({
						url:"addWish.controller?id=" + id1,
						type:"get",
						success:function(data){
							console.log("add wish: "+data);
							}
						})
					})
				   $(".cart").click(function(){
					var id = $(this).parent().siblings("td.pName").attr("id");
					var name = $(this).parent().siblings("td.pName").html();
					console.log("add product");
					window.alert(name+"加入購物車");
					$.ajax({
						url:"add.controller?id=" + id,
						type:"get",
						success:function(data){
							console.log("add product: "+data);
							}
						})
					})
	                
	            }
	        })
	    })
	    


		
	</script>

</body>
</html>