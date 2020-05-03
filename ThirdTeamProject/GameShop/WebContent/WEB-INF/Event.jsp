<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>

<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css" /> 
<link rel="stylesheet" href="css/jquery-ui.theme.min.css" /> 
<title>EVENT</title>

<style type="text/css">

body{
	font-family:Microsoft JhengHei;
	background:url(img/shopbg.jpg) no-repeat;
	background-size:cover;
}

/*Event Page*/
.bgevent{
	position: relative;
	width:100%;
	height:200%;
	top:0;
    left:0;
    right:0;
}
.eventHead td{
	background:black;
	height:40px
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
			<li><a href="processArticle">BLOG</a>
			<li><a href="#">CHAT</a> 
			<a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>
		</ul>
	</nav>

<!--Wishlist & Shopping cart &top-->
        <a href="showWish.controller"><input type="button" class="wishlist"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart"></a>
		<a href="#"><input type="button" class="topbutton"></a>

<!--Main-->
<div class="bgevent">
	<div class="titledec">
        <div class="titletext">活動資訊</div>
    </div>

		<fieldset>
			<figure>
				<!--輪播待補(接活動頁面)-->
				<a id="mainUrl" href="">
				<canvas id="myCanvas" width="460" height="215">  
                <img id="mainImg1" src="img/sale1.jpg" style="display: none" alt=""/>
                <img id="mainImg2" src="img/sale2.jpg" style="display: none" alt=""/>
                <img id="mainImg3" src="img/sale3.jpg" style="display: none" alt=""/>
                <img id="mainImg4" src="img/sale4.jpg" style="display: none" alt=""/>
                <img id="mainImg5" src="img/sale5.jpg" style="display: none" alt=""/>
                </canvas>
				</a>
				<div id="chimg"></div>
			</figure>
		</fieldset>

		<hr>
		
		<!--Show Event & Page-->
		<table class="productTable">
			<tr class="eventHead">
			<td colspan="5"></td>
			</tr>
		</table>
		
		<table id="eventContent" class="productTable" style="text-align:left !important"></table><br><br>
    	<div id="page" class="pageview"></div>
 
	</div>

<!--footer-->
	<footer>
		<div class="foot">
			<H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
			<H6>All copyrights and trademarks are the property of their
				respective owners.</H6>
		</div>
	</footer>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
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

		//活動清單分頁
		$(document).ready(function () {
			
	        var itemPerPage = 5;		// 一頁幾個活動
	        var nowPage = 1;
	        var totalPage = 0;			// 全部頁數
	        
	        $.ajax({
	            url: "queryAllEvent",  //data path
	            type: "GET",
	            dataType: "json",
	            success: function (data) {   
	                var txt = ' ';
	             
	                for (let i = 0; i < data.length; i++) {

		                txt += '<tr><td>' + "<img src='data:image/jpeg;base64," + data[i].eventImage + "' width='230px'>" + 
	                    '</td><td>' + data[i].eventName + '</td><td>' + data[i].startDate + '</td><td>' + data[i].endDate + 
	                    '</td><td>' + "<a href='searchEvent?eventId="+data[i].eventId+"'><input class='infobutton' type='button' value='活動資訊'></a>" +
	                    '</td></tr>';
	                }
	                txt + ' ';
	                $("#eventContent").append(txt);

	                //Calculate total page
	                totalPage = Math.ceil(data.length / itemPerPage);

	                //create page number link
	                $("#page").append('<a id="pre" href="#"> << </a>');
	                
	                for (let i = 0; i < totalPage; i++) {
	                    $("#page").append('<a href="#">' + (i + 1) + '</a>');	// 顯示總共幾頁 	   

	                    $("#page a").eq(i + 1).click(function () {
	                        $("#eventContent tr").hide();
	                        for (let item = i * itemPerPage; item < (i + 1) * itemPerPage; item++) {
	                            $("#eventContent tr").eq(item).show();
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
	            }
	            })
	 	    })
	
</script>

</body>
</html>