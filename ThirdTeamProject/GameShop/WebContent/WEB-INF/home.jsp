<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <!-- css for phone -->
    <link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
    <!-- favicon -->
    <link rel="shortcut icon" href="img/favicon.ico"/>
	<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/gameshop.js"></script>
	<title>GameGuild~Enjoy your gameLife here~</title>
	
<style>
 
body{
	font-family: Microsoft JhengHei;
	/* background:url(img/SkyTower2.jpg) no-repeat; */
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
<div>

<!--Trailer & Title-->
<div class="video">
     <p class="subtitle">
        Enjoy<br>Your<br>GameLife<br>
     </p>
</div>

<!--Login & Register#1-->
     <div class="loginArea">
        <input type="button" class="loginbutton" value="Login">
        <button class="registerbutton" id="registerbutton">Register</button>
     </div>

<!--Background Effect-->
<div class="bg">
    <div><img src="img/SkyTower2.jpg" style="width: 100%; height:2500px">
       <video class="bg-video" loop muted autoplay>
	   <source src="https://cxc421.github.io/draw-lots/static/media/smoke.9c21ff18.mp4" type="video/mp4">
	   </video>
     </div>
         <canvas class="bg-canvas"></canvas>
</div>

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
<!-- register form -->
        <div class="registerDiv">
            <div class="registerForm">
                <fieldset>
                    <legend>申請新帳號</legend>
                    <form action="register" method="POST" enctype="multipart/form-data">

                        <div class="warning"><img class="imgUserPhoto" src="img/defaultUserImg.jpg" alt="">
                      	<span>點擊左方圖片可更換大頭貼</span></div>
                        <input class="inputUserPhoto" type="file" name="userImg" hidden="hidden"><br />
						<label for="userAccount">帳號:</label><input type="text" id="userAccount" name="userAccount" placeholder="請輸入6~18英數字元">
                        <div class="check" id="checkAccount"><img src=""><span></span></div><br />	
                        
                        <label for="userName">姓名:</label><input type="text" id="userName" name="userName">
                        <div class="check" id=""><img src=""><span></span></div><br />
                        	
                        <label for="nickName">暱稱:</label><input type="text" id="nickName" name="nickName" placeholder="評論區顯示名稱">
                        <div class="check" id="checkNickName"><img src=""><span></span></div><br />
                        <label for="userPwd">密碼:</label><input type="password" id="userPwd" name="userPwd" placeholder="包含大小寫及數字的6~12位密碼">
                        <div class="check" id="checkPwd"><img src=""></div><br />
                        <label for="recheckPwd">確認密碼:</label><input type="password" id="recheckPwd" name="recheckPwd" placeholder="再次輸入密碼">
                        <div class="check" id="recheckPwd"><img src=""></div><br />	
                        <label for="mail">E-mail:</label><input type="text" id="mail" name="mail">
                        <div class="check" id="checkMail"><img src=""><span></span></div><br />

                        <hr>
                    <!--<label style="padding:0;text-align:center;font-size:20px;text-shadow:2px 2px 2px gray;">詳細資訊</label><br /> -->    
                        <label style="width:65px;padding:0;padding-left:10px;">性別:</label>
                        <input type="radio" class="gender" name="gender" value="m" checked="checked"><label class="gender">男</label>
                        <input type="radio" class="gender" name="gender" value="f"><label class="gender">女</label>
                        <input type="radio" class="gender" name="gender" value="o"><label style="width:50px">其他</label><br />
                        <label for="birthday">生日:</label><input type="text" id="birthday" name="birthday" placeholder="ex:2020/04/29"><br />
                        <label for="address">地址:</label><input type="text" id="address" name="address"><br />
                        <label for="phone">聯絡電話:</label><input type="text" id="phone" name="phone"><br />

                    </form>
                    <button class="registerconfirm">確認</button>
                    <input class="cancel_btn" type="button" value="取消">
                    <div id="registerMsg"></div>
                    <button class="fill">快速填入</button>

                </fieldset>
            </div>
        </div>

<!--Top Event Area-->
        <div class="titledec" style="margin-top:900px;">
        	<div class="titletext">最新消息</div>
        </div>
 
            <div class="event">
                <table>
                    <tr>
                        <td>2020.04.17</td>
                        <td><a href="searchEvent?eventId=1">《魔物獵人》更新擊殺排行榜</a></td>
                    </tr>
                    <tr>
                        <td>2020.04.03</td>
                        <td><a href="searchEvent?eventId=2">《惡靈古堡 3重製版》上市頭 5天全球出貨突破 200萬套</a></td>
                    </tr>
                    <tr>
                        <td>2020.03.30</td>
                        <td><a href="searchEvent?eventId=3">戰略 RPG《為了國王 For The King》PS4、Switch中文版即將發售</a></td>
                    </tr>
                    <tr>
                        <td>2020.03.30</td>
                        <td><a href="searchEvent?eventId=4">戰爭策略名作《騎馬與砍殺2：霸主》2020年3月登上Steam</a></td>
                    </tr>
                    <tr>
                        <td>2020.01.01</td>
                        <td><a href="searchEvent?eventId=5">2019 Steam大獎揭曉《隻狼》獲年度遊戲獎</a></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <a href="Event"><input type="submit" value="更多消息" name="more" class="morebutton" /></a></td>
                    </tr>
                </table>
            </div>

<!--Top Sale Area-->       
        <div class="titledec">
        	<div class="titletext">熱門遊戲</div>
        </div>

		<fieldset>
			<figure>
				<!--輪播已修改完畢(接商品頁面)-->
				<a id="mainUrl" href="https://store.steampowered.com/">
				<canvas id="myCanvas" width="460" height="215">
                <img id="mainImg1" src="img/sale1.jpg" style="display: none" alt=""/>
                <img id="mainImg2" src="img/sale2.jpg" style="display: none" alt=""/>
                <img id="mainImg3" src="img/sale3.jpg" style="display: none" alt=""/>
                <img id="mainImg4" src="img/sale4.jpg" style="display: none" alt=""/>
                <img id="mainImg5" src="img/sale5.jpg" style="display: none" alt=""/>
                </canvas>
				</a>
				<div id="chimg"></div><br>
			</figure>
		</fieldset>
            <a href="Shop"><input type="submit" value="更多遊戲" name="more" class="morebutton" /></a>

<!--Top Blog Article-->
        <div class="titledec">
        	<div class="titletext">熱門文章</div>
        </div>
        
            <div class="event">
                <table>
                    <tr>
                        <td colspan="2"><a href="processReadArticle?articleID=5">《最後生還者》表示不歡迎仇恨同性戀之玩家</a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><a href="processReadArticle?articleID=4">微軟首度揭露新一代 Xbox Series X</a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><a href="processReadArticle?articleID=3">在家裡自導自演一場 B 級恐怖片吧</a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><a href="processReadArticle?articleID=2">《Apex 英雄》賽季 5「時來運轉」</a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><a href="processReadArticle?articleID=1">夏季遊戲節 SGF</a></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <a href="processArticle"><input type="submit" value="更多文章" name="more" class="morebutton" /></a></td>
                    </tr>
                </table>

            </div>
</div>          

<!--footer-->
    <footer style="margin-top:50px;">
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>

// 背景圖片效果
(function () {
    const canvas2 = document.querySelector('.bg-canvas');
    const ctx2 = canvas2.getContext('2d');
    const video = document.querySelector('.bg-video');

    video.addEventListener('play', draw);

    function draw() {
        canvas2.width = canvas2.clientWidth;
        canvas2.height = canvas2.clientHeight;
        if (video.paused || video.ended) return false;
        ctx2.drawImage(video, 0, 0, canvas2.width, canvas2.height);

        requestAnimationFrame(draw);
    }
})();
    
//  商品輪播圖片
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
                document.getElementById("ad" + i).addEventListener("click", changebtn);
                document.getElementById("myCanvas").addEventListener("mouseover", pause);
                document.getElementById("myCanvas").addEventListener("mouseout", keepgo);
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
                timeouts.push(setTimeout(function () {
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
</script>

</body>

</html>