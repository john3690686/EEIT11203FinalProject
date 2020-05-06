<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/gameshop.js"></script>
<title>活動頁面</title>
<title>${eventName}</title>

<style type="text/css">
body{
	font-family:Microsoft JhengHei;
	background:url(img/eventbg.jpg) no-repeat;
	background-attachment: fixed;
}
.showProduct td{
	padding:20px;
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
        <a href="showWish.controller"><input type="button" class="wishlist"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart"></a>
		<a href="#"><input type="button" class="topbutton"></a>

 <!--Main-->
	<div class="bgevent">
	
	<table class="showProduct">
    <tr>
        <td colspan="2">
            <H1>${eventName}</H1>
        </td>
    </tr>
    <!--Event Introduction-->
	<tr>
		<td><img src="${pageContext.servletContext.contextPath}/eventImage?eventId=${eventId}" width="460px"/></td>
    	<td class="showProductIntro">${eventContent}<br/></td>
		
    </tr>
    <!--event start & end time-->
    <tr>
    	<td><span style="color:bisque; font-size:18px">活動開始時間：${sDate}</span></td>
		<td><span style="color:bisque; font-size:18px">活動結束時間：${eDate}</span></td>
    </tr>
    <!--product&wish button-->
    <tr>
    	<td><a href="searchGame?productName=${productName2}"><input type="button" class="shopthis" value="前往遊戲主頁"></a></td>
    	<td><input type="button" class="wishthis" value="加入願望清單"></td>
    </tr>
    
    <tr>
    	<td colspan="2"><a href="Event"><input type="button" class="morebutton" value="回到最新消息"></a></td>
    </tr>

</table>

</div>

 <!--footer-->
    <footer style="margin-top:200px">
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
//topButton & wish
var needLogin = function(){
    if($(".loginz").val() == "Login"){
        alert("請先登入");
    }
}
$(".wishlist").click(needLogin);

$(".topbutton").hide();
var winHeight = $(window).height();
$(window).scroll(function(){
    if($(window).scrollTop() >= winHeight){
        $(".topbutton").show();
    }else{
        $(".topbutton").hide();
    }
})
//wish button 接起來
$(".wishthis").click(function(){
			console.log("add wish");
			var id1 = ${productId};
			var name1 = "${productName}";
			console.log("id1="+id1);
			$.ajax({
				url:"addWish.controller?id=" + id1,
				type:"get",
				success:function(data){
					if(data=="ok"){
		                window.alert(name1+"加入願望清單");
						}else if(data=="a"){
						window.alert(name1+"此遊戲已購買");
						}else{
	                    window.alert(name1+"已加入願望清單");
					         }
		              }
				})
			})
			
</script>
</body>
</html>