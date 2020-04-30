<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GameShop~Enjoy your gameLife here~</title>
    <link rel="stylesheet" href="css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">

<style>
 
body{
	font-family: Microsoft JhengHei;
	/* background:url(img/SkyTower2.jpg) no-repeat; */
} 

.loginDiv {
	display: none;
}
.registerDiv {
	display: none;
}

</style>

</head>

<body>

<!--Navigator-->

    <c:if test="${titleMessage.length()>0}">
        <div id="titleMessage">${titleMessage}</div>
    </c:if>

    <nav>
        <ul class="ul1">
            <li><a href="index.html">HOME</a>
            <li><a href="#">NEWS</a>
            <li><a href="Shop">SHOP</a>
            <li><a href="processArticle">BLOG</a>
            <li><a href="Chatroom">CHAT</a>
                <a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>	
            <li id="hello"> <a href="myProfile"> hi,${userName}</a>

        </ul>
    </nav>

<!--Wishlist & Shopping cart &top-->
        <a href="showWish.controller"><input type="button" class="wishlist"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart"></a>
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
        <button class="loginbutton">Login</button>
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

                        <label for="userAccount">帳號:</label><input type="text" name="userAccount"><br/>
                        <label for="userPwd">密碼:</label><input type="password" name="userPwd"><br/>
                        <input type="checkbox" name="autoLogin" id="autoLogin" ${autoLogin}><span>記住我</span><br/>
						
						<br/>
                        <button class="loginconfirm">登入</button>
                        <input type="button" class="cancel_btn" value="取消"><br/>
                       <!-- 登入頁加入新申請帳號 -->
                        <input type="button" class="registerbutton" id="register2" value="申請新帳號">

                    </form>
                        <button class="loginconfirm">Confirm</button><input type="reset" class="cancel_btn" value="Cancel">
                        <div><span id="loginMsg"></span></div>
                </fieldset>
            </div>
            
        </div>
<!-- register form -->
        <div class="registerDiv">
            <div class="registerForm">
                <fieldset>
                    <legend>申請新帳號</legend>
                    <form action="processProfile" method="POST" enctype="multipart/form-data">
                        <img style="cursor: pointer;" class="imgUserPhoto" src="img/coda.jpg" alt="" width="200px" height="200px"><input
                            class="inputUserPhoto" type="file" name="userImg" hidden="hidden"><br />
						 <label for="userAccount">帳號:</label><input type="text" id="userAccount" name="userAccount">
                        <div class="check" id="checkAccount"><img src=""></div><br />
                        <span class="note">(請輸入6~18英數字元)</span><br />		
                        <label for="userName">姓名:</label><input type="text" id="userName" name="userName"><br />
                        <label for="nickName">暱稱:</label><input type="text" id="nickName" name="nickName" placeholder="評論區顯示名稱"><br />
                        <label for="userPwd">密碼:</label><input type="password" id="userPwd" name="userPwd">
                        <div class="check" id="checkPwd"><img src=""></div><br />
                        <span class="note">(請輸入一組包含大小寫及數字的6~12位密碼)</span><br />
                        <label for="recheckPwd">密碼:</label><input type="password" id="recheckPwd" name="recheckPwd"
                            placeholder="再次輸入密碼">
                        <div class="check" id="recheckPwd"><img src=""></div><br />
						
                        <label for="mail">E-mail:</label><input type="text" id="mail" name="mail">
                        <div class="check" id="checkMail"><img src=""></div><br />

                    <legend>Register Form</legend>
                    <form action="register" method="POST" enctype="multipart/form-data">
                        <img style="cursor: pointer;" class="imgUserPhoto" src="img/coda.jpg" alt="" width="200px"
                            height="200px"><input class="inputUserPhoto" type="file" name="userImg"
                            hidden="hidden"><br />	
                        <hr>
                        <label style="padding:0;text-align:center;font-size:20px;text-shadow:2px 2px 2px gray;">詳細資訊</label><br />
                        <label style="width:90px;padding:0;">性別:</label>
                        <input type="radio" class="gender" name="gender" value="m" checked="checked"><label
                            class="gender">男</label>
                        <input type="radio" class="gender" name="gender" value="f"><label class="gender">女</label>
                        <input type="radio" class="gender" name="gender" value="o"><label class="gender">其他</label><br />
                        <label for="birthday">生日:</label><input type="text" id="birthday" name="birthday" placeholder="ex:2020/04/29"><br />
                        <label for="address">地址:</label><input type="text" id="address" name="address"><br />
                        <label for="phone">聯絡電話:</label><input type="text" id="phone" name="phone"><br />
                        <button class="registerconfirm">確認</button>
                        <input class="cancel_btn" type="button" value="取消">
                    </form>
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
                        <td>2020.04.01</td>
                        <td>New Release Avaliable!</td>
                    </tr>
                    <tr>
                        <td>2020.04.01</td>
                        <td>New Release Avaliable!</td>
                    </tr>
                    <tr>
                        <td>2020.04.01</td>
                        <td>New Release Avaliable!</td>
                    </tr>
                    <tr>
                        <td>2020.04.01</td>
                        <td>New Release Avaliable!</td>
                    </tr>
                    <tr>
                        <td>2020.04.01</td>
                        <td>New Release Avaliable!</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <a href="#"><input type="submit" value="更多消息" name="more" class="morebutton" /></a></td>
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
                        <td>GameName</td>
                        <td>GameTitle1</td>
                    </tr>
                    <tr>
                        <td>GameName</td>
                        <td>GameTitle2</td>
                    </tr>
                    <tr>
                        <td>GameName</td>
                        <td>GameTitle3</td>
                    </tr>
                    <tr>
                        <td>GameName</td>
                        <td>GameTitle4</td>
                    </tr>
                    <tr>
                        <td>GameName</td>
                        <td>GameTitle5</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <a href="#"><input type="submit" value="更多文章" name="more" class="morebutton" /></a></td>
                    </tr>
                </table>

            </div>
</div>          

<!--footer-->
    <footer style="margin-top:150px;">
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
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

//Login & Register Form
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $(".imgUserPhoto").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        $(".inputUserPhoto").change(function () {
            readURL(this);
        });
        $(".imgUserPhoto").click(function(){
            $(".inputUserPhoto").click();
        });

        $(".loginbutton").click(function () {
            $(".loginDiv").css({
                "position": "absolute",
                "display": "flex",
                "z-index": "99999",
                "top": $(document).scrollTop() + "px",
                "height": "100vh",
                "width": "100vw",
                "align-items": "center"
            });
            $("html").css("overflow", "hidden");
        })

        $(".registerbutton").click(function () {
            $(".registerDiv").css({
                "position": "absolute",
                "display": "flex",
                "z-index": "99999",
                "top": $(document).scrollTop() + "px",
                "height": "100vh",
                "width": "100vw",
                "align-items": "center"
            });
            $("html").css("overflow", "hidden");
        })

        var cancelbtn = function () {
            $(".loginDiv").css("display", "none");
            $(".registerDiv").css("display", "none");
            $("html").css("overflow", "initial");
        }
        $(".cancel_btn").click(cancelbtn);
        $(".loginDiv").click(function (e) {
            console.log($(".loginForm").is(e.target));
            if (!$(".loginForm").is(e.target)) {
                $(".loginDiv").css("display", "hidden");
            }
        })

        $(".fill").click(function () {
            $("#userId").val("uid");
            $("#userAccount").val("account");
            $("#userName").val("unm");
            $("#nickName").val("nnm");
            $("#userPwd").val("pwd");
            $("#checkPwd").val("pwd");
            $("#mail").val("uid@mail");
            $("#birthday").val("2020/03/03");
            $("#address").val("addr");
            $("#phone").val("0987141242");

        })

        $(document).ready(function () {

            if ($(".loginz").val() == "Logout") {
                $(".loginz").parent().attr("href", "http://localhost:8080/GameShop/logout/");
            } else {
                $(".loginz").parent().attr("href", "#");
                $(".loginz").click(function () {
                    $(".loginDiv").css({
                        "position": "absolute",
                        "display": "flex",
                        "z-index": "99999",
                        "top": $(document).scrollTop() + "px",
                        "height": "100vh",
                        "width": "100vw",
                        "align-items": "center"
                    })
                    $("html").css("overflow", "hidden");
                })
            }
        })
         
</script>

</body>

</html>