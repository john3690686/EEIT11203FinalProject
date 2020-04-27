<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>index.html</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Bootstrap CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Sen&display=swap" rel="stylesheet">
    <style>
        footer {
            border-radius: 2px 2px 2px 2px;
            background: -webkit-linear-gradient(#3C3C3C, rgb(19, 18, 18));
            background-repeat: no-repeat;
            position: relative;
            width: 100%;
            height: 180px;
            top: 150vh;
            left: 0;
            right: 0;
            bottom: 0;
            text-align: center;
            z-index: 6666;
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
    <c:if test="${titleMessage.length()>0}">
        <div id="titleMessage">${titleMessage}</div>
    </c:if>
    <!--Navigator-->
    <nav>
        <ul class="ul1">
            <li><a href="index.html">HOME</a>
            <li><a href="myProfile">TEST</a>
            <li><a href="#">SHOP</a>
            <li><a href="#" style="padding-right: 20px; padding-left: 25px;">COMMENT</a>
            <li><a href="Chatroom">CHAT</a>
            <li id="hello"> <a href="myProfile"> hi,${userName}</a>
        </ul>

        <a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>
    </nav>

    <!--Wishlist & Shopping cart-->
    <a href="wishlist.jsp"><input type="button" class="wishlist"></a>
    <a href="shoppingcart.jsp"><input type="button" class="shoppingcart"></a>

    <!--Main-->
    <div class="container-fluid">

        <!--Login System #1-->
        <div class="login">
            <button class="loginbutton">Login</button>
            <button class="registerbutton">Register</button>
        </div>

        <!-- login form -->
        <div class="loginDiv">
            <div class="loginForm">
                <fieldset>
                    <legend>Login Form</legend>
                    <form action="processLogin" method="POST">
                        <label for="userAccount">User Account:</label><input type="text" name="userAccount" value="${userAccount}"><br />
                        <label for="userPwd">Password:</label><input type="password" name="userPwd" value="${userPwd}"><br />
                        <input type="checkbox" name="autoLogin" id="autoLogin" ${autoLogin}><span>記住我</span><br/>
                        <button class="loginconfirm">Confirm</button><input type="reset" class="cancel_btn" value="Cancel">
                    </form>
                    
                </fieldset>
            </div>
        </div>
        <!-- register form -->
        <div class="registerDiv">
            <div class="registerForm">
                <fieldset>
                    <legend>Register Form</legend>
                    <form action="register" method="POST" enctype="multipart/form-data">
                        <img style="cursor: pointer;" class="imgUserPhoto" src="img/coda.jpg" alt="" width="200px"
                            height="200px"><input class="inputUserPhoto" type="file" name="userImg"
                            hidden="hidden"><br />

                        <label>Required</label><br />
                        <label for="userAccount">Account:</label><input type="text" id="userAccount" name="userAccount">
                        <div class="check" id="checkAccount"><img src=""></div><br />
                        <span class="note">(請輸入6~18英數字元)</span><br />

                        <label for="userName">Name:</label><input type="text" id="userName" name="userName">
                        <div class="check"><img src=""></div><br />

                        <label for="nickName">Nick Name:</label><input type="text" id="nickName" name="nickName">
                        <div class="check" id="checkNickName"><img src=""></div><br />

                        <label for="userPwd">Password:</label><input type="password" id="userPwd" name="userPwd">
                        <div class="check" id="checkPwd"><img src=""></div><br />
                        <span class="note">(請輸入一組包含大小寫及數字的6~12位密碼)</span><br />

                        <label for="recheckPwd">Password:</label><input type="password" id="recheckPwd" name="recheckPwd"
                            placeholder="Re-Enter Password">
                        <div class="check" id="recheckPwd"><img src=""></div><br />

                        <label for="mail">E-mail:</label><input type="text" id="mail" name="mail">
                        <div class="check" id="checkMail"><img src=""></div><br />
                        <hr>
                        <label>Detail</label><br />
                        <label>Gender:</label>
                        <input type="radio" class="gender" name="gender" value="m" checked="checked"><label
                            class="gender">male</label>
                        <input type="radio" class="gender" name="gender" value="f"><label class="gender">female</label>
                        <input type="radio" class="gender" name="gender" value="o"><label
                            class="gender">other</label><br />

                        <label for="birthday">Birthday:</label><input type="text" id="birthday" name="birthday"><br />

                        <label for="address">Address:</label><input type="text" id="address" name="address"><br />

                        <label for="phone">Phone:</label><input type="text" id="phone" name="phone"><br />
                    </form>
                    <button class="registerconfirm">Confirm</button><input class="cancel_btn" type="button"
                            value="Cancel">
                    <button class="fill">fill</button>
                </fieldset>
            </div>
        </div>

        <!--Trailer & Title-->
        <div class="video">
            <p class="subtitle">
                Enjoy<br>Your<br>GameLife<br>
            </p>
        </div>

        <!--Backgroundimage-->
        <div class="bg">
            <div><img src="img/SkyTower2.jpg" style="width: 100%">
                <video class="bg-video" src="https://cxc421.github.io/draw-lots/static/media/smoke.9c21ff18.mp4"
                    autoplay="autoplay" muted="true" loop="true"></video>
            </div>
            <canvas class="bg-canvas"></canvas>
        </div>

        <!--Top Event Area-->
        <div class="eventarea">
            <div class="horizon">
                <img src="img/hr.png">
                <H1>NEWS & EVENTS</H1>
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
                            <a href="#"><input type="submit" value="MORE" name="more" class="morebutton" /></a></td>
                    </tr>
                </table>
            </div>
        </div>

        <!--Top Sale Area-->
        <div class="salearea">
            <div class="horizon">
                <img src="img/hr.png">
                <H1>TOP SALES</H1>
            </div>

            <fieldset>
                <figure>
                    <!--è¼ªæ­æ«ææ¥Steamç¶²å, ä¹å¾é ä¿®æ¹æååé ç·¨ç¢¼-->
                    <a id="mainUrl" href="https://store.steampowered.com/">
                        <canvas id="myCanvas" width="460" height="215">
                            <img id="mainImg1" src="img/sale1.jpg" style="display: none">
                            <img id="mainImg2" src="img/sale2.jpg" style="display: none">
                            <img id="mainImg3" src="img/sale3.jpg" style="display: none">
                            <img id="mainImg4" src="img/sale4.jpg" style="display: none">
                            <img id="mainImg5" src="img/sale5.jpg" style="display: none">
                        </canvas>
                    </a>
                    <div id="chimg"></div><br>
                </figure>
            </fieldset>
            <a href="#"><input type="submit" value="MORE" name="more" class="morebutton" /></a>
        </div>

        <!--Top Comment-->
        <div class="commentarea">
            <div class="horizon">
                <img src="img/hr.png">
                <H1>HOT COMMENTS</H1>
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
                            <a href="#"><input type="submit" value="MORE" name="more" class="morebutton" /></a></td>
                    </tr>
                </table>

            </div>
        </div>

        <!--background image & footer-->
        <!-- <div class="bg">
        <div><img src="img/SkyTower2.jpg" style="width: 100%">
            <video class="bg-video" src="https://cxc421.github.io/draw-lots/static/media/smoke.9c21ff18.mp4" autoplay="autoplay" muted="true" loop="true"></video>
        </div>
            <canvas class="bg-canvas"></canvas> -->

    </div>

    <!--footer-->
    <footer>
        <div class="foot">
            <H2>Â©COPYRIGHT 2020 EEIT112 Team3</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>
        // èæ¯åççé§ææ
        (function () {
            const canvas = document.querySelector('.bg-canvas');
            const ctx = canvas.getContext('2d');
            const video = document.querySelector('.bg-video');

            video.addEventListener('play', draw);

            function draw() {
                canvas.width = canvas.clientWidth;
                canvas.height = canvas.clientHeight;
                if (video.paused || video.ended) return false;
                ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

                requestAnimationFrame(draw);
            }
        })();

        //  Salesè¼ªæ­åç
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
            // å¯å°åç¶²é çåçé£çµ(ä¹å¾åæ¥ç¶²é å§çåå)
            // document.getElementById("mainUrl").href = "https://store.steampowered.com";
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
        
        //User Photo
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
        $(".imgUserPhoto").click(function () {
            $(".inputUserPhoto").click();
        });

        //login form
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

        //register form
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

        //auto filled
        $(".fill").click(function () {
            $("#userAccount").val("account");
            $("#userName").val("Jimmy");
            $("#nickName").val("jim");
            $("#userPwd").val("Passw0rd");
            $("#recheckPwd").val("Passw0rd");
            $("#mail").val("j.t.hung1988@gmail.com");
            $("#birthday").val("2020/03/03");
            $("#address").val("addr");
            $("#phone").val("0987141242");
            errorAcc = 0; errorNickName =0; errorPwd = 0; errorMail = 0;
        })

        //check data right
        var regUserAccount = new RegExp(/^[a-zA-Z0-9]{6,18}$/);
        var regUserPwd = new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z\d].{6,12}$/);
        var regMail = new RegExp(/\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+/);
        var errorAcc = 1, errorNickName =1, errorPwd = 1, errorMail = 1;


        $("#userAccount").blur(function(){
            $("#checkAccount img").css("visibility","visible");
            if(regUserAccount.test($(this).val())){
                $("#checkAccount img").attr("src","img/Right.png");
                errorAcc = 0;
            }else{
                $("#checkAccount img").attr("src","img/Wrong.png");
                errorAcc = 1;
            }
        });
        $("#nickName").blur(function(){
            $("#checkNickName img").css("visibility","visible");
            if($(this).val().trim().length>0){
                $("#checkNickName img").attr("src","img/Right.png");
                errorNickName = 0;
            }else{
                $("#checkNickName img").attr("src","img/Wrong.png");
                errorNickName = 1;
            }
        });
        $("#userPwd").blur(function(){
            $("#checkPwd img").css("visibility","visible");
            if(regUserPwd.test($(this).val())){
                $("#checkPwd img").attr("src","img/Right.png");
                errorPwd = 0;
            }else{
                $("#checkPwd img").attr("src","img/Wrong.png");
                errorPwd = 1;
            }
        });
        $("#recheckPwd").blur(function(){
            $("#recheckPwd img").css("visibility","visible");
            if($(this).val().length>0 && $(this).val() == $("#userPwd").val()){
                $("#recheckPwd img").attr("src","img/Right.png");
            }else{
                $("#recheckPwd img").attr("src","img/Wrong.png");
            }
        });
        $("#mail").blur(function(){
            $("#checkMail img").css("visibility","visible");
            if(regMail.test($(this).val())){
                $("#checkMail img").attr("src","img/Right.png");
                errorMail = 0;
            }else{
                $("#checkMail img").attr("src","img/Wrong.png");
                errorMail = 1;
            }
        });

        //confirm
        $(".registerconfirm").click(function(){
            if(errorAcc == 0&& errorNickName ==0&& errorPwd == 0&& errorMail == 0){
                $(".registerForm form").submit();
            }else{
                alert("資料不對唷!");
            }
        })

        //Rightup Login Button
        $(document).ready(function () {
            $("#titleMessage").animate({ opacity: "0" }, 4000, function () { $("#titleMessage").hide() });
            //if login
            if ($(".loginz").val() == "Logout") {
                $(".loginz").parent().attr("href", "http://localhost:8080/GameShop/logout/");
                $(".login").css("visibility", "hidden");
                $("#hello").show();
                //if guest
            } else {
                $("#hello").hide();
                $(".login").css("visibility", "visible")
                $(".loginz").parent().removeAttr("href");
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


        //cancel form
        var cancelbtn = function () {
            $(".loginDiv").css("display", "none");
            $(".registerDiv").css("display", "none");
            $("html").css("overflow", "initial");
        }
        $(".cancel_btn").click(cancelbtn);

        var loginMousePosition = false;
        $(".loginDiv, .registerDiv").mouseover(function (e) {
            loginMousePosition = $(".loginDiv, .registerDiv").is(e.target);
        })
        $(".loginDiv, .registerDiv").click(function (e) {
            if (loginMousePosition) {
                cancelbtn();
            }
        })

    </script>

</body>

</html>