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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/gameshop.js"></script>
<title>最新消息</title>

<style type="text/css">

body{
	font-family:Microsoft JhengHei;
	background:url(img/eventbg.jpg) no-repeat;
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
<div class="bgevent">
	<div class="titledec">
        <div class="titletext">最新消息</div>
    </div>

		<fieldset>
			<figure>
				<!--輪播接活動頁面-->
				<img id="defaultmainImg" src="https://i.pinimg.com/originals/09/4a/6e/094a6ec8f9f452846d4c0c6e845c5b10.gif" style="margin-left:450px" width="460px" height="215px"/>
				<a id="mainUrl" href="">
				<canvas id="myCanvas" width="460" height="215">  
                <img id="mainImg1" src="img/05.jpg" style="display: none" alt=""/>
                <img id="mainImg2" src="img/03.jpg" style="display: none" alt=""/>
                <img id="mainImg3" src="img/07.jpg" style="display: none" alt=""/>
                <img id="mainImg4" src="img/08.jpg" style="display: none" alt=""/>
                <img id="mainImg5" src="img/06.jpg" style="display: none" alt=""/>
                </canvas>
				</a>
				<div id="chimg"></div>
			</figure>
		</fieldset>

		<hr>
		
		<!--Show Event & Page-->
		<table class="productTable">
			<tr class="eventHead">
			<td colspan="4"></td>
			</tr>
		</table>
		
		<table id="eventContent" class="eventTable"></table><br><br>
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

	window.setTimeout(defaultImg,2500);	
	function defaultImg(){
	document.getElementById("defaultmainImg").style.display="none";
	}

		//Sales輪播圖片

		var nowAD = 0;
		var maxAD = 5;
		var intervalAD;
		var adStatus = true;
	    var intervalTime = 2500;
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
		
			var db = [1,2,3,4,5];
		 	document.getElementById("mainUrl").href = "searchEvent?eventId="+ db[(nowAD-1)];

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
	                    '</td><td>' + data[i].eventName + "</td><td style='color:rgb(231, 225, 136)'>" + data[i].startDate +  
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