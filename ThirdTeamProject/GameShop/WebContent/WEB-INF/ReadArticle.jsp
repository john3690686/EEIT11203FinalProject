<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/gameshop.js"></script>
<title>閱讀文章</title>

<style type="text/css">

body{
	font-family:Microsoft JhengHei;
	background:url(img/blogbg.jpg) no-repeat;
	background-attachment: fixed;
}
p{
	padding:20px;
}
.title{
	text-align:left;
	font-size: 24px;
	font-weight:bold;
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
<!-- top -->
		<a href="#"><input type="button" class="topbutton"></a>    

<!-- Read Article -->
<div class="bgblog">

	<div class="titledec">
        <div class="titletext">創作內容</div>
	</div>

	<div id="select" style="width:50%;border-radius:5px"></div>
	
		<div id="demo1" class="articleRegion"></div>

<!-- Response Area -->
	<div id="messageRegion" class="responseMessage"></div>

		<form action="<c:url value='/processAddMessage'/>" method="post">
			<div class="reply">我要回應:<br/><br/>
			<textarea id='textareaMEG' cols="50" rows="5" name="message"></textarea>
			<input type="submit" value="送出" style="margin-left:90%; font-size:18px">
			<input type="button" value="一鍵填入" onclick="fillInQuicklyMeg()">
			<input type="hidden" id="requestArticleId" name="requestArticleId">		
			</div>
		</form>
		
		<p><a href="processArticle"><input type="button" class="morebutton" value="回到創造の壁"></a></p>
		
</div>
	
<!--footer-->
    <footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

<script src="https://cdn.ckeditor.com/ckeditor5/18.0.0/classic/ckeditor.js"></script>
<script>

		function addtext(i , mid, arid){
			var a ="textarea_"+i
			var messageTextaera = "<form action='<c:url value='/addReplyMessage'/>' method='POST'>" ;
				messageTextaera += "<textarea id='textareaRM' name='mContent'></textarea>";
				messageTextaera += "<input type='submit' value='送出' style='right'>";
				messageTextaera += "<input type='button' value='一鍵填入' onclick='fillInQuicklyRM()'>";
				messageTextaera += "<input type='hidden' name='mID' value='" + mid + "'>";
				messageTextaera += "<input type='hidden' name='aID' value='" + arid + "'>";
				messageTextaera += "</form>";
			document.getElementById(a).innerHTML = messageTextaera;


		}

		function fillInQuicklyRM() {
			var txt = "感謝你的支持~我會再接再厲的";
			document.getElementById("textareaRM").innerHTML = txt
		}

		function fillInQuicklyMeg(){
			var txt = "這一篇寫得真好~希望作者還可以再接再厲~期待你的下一篇作品~~";
			document.getElementById("textareaMEG").innerHTML = txt
		}

	
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function () {
			var txt = " ";
			var books = ${ readByArticleId };
			var a = 1;

			var select = "<select class='movePage' onChange='location = this.options[this.selectedIndex].value;'>"
			select += "<option value='#'>移動至...</option>";
			select += "<option value='/GameShop/processArticle'>創造の壁</option>";
			select += "<option value='/GameShop/myArticle'>我的創作</option>";
			select += "<option value='/GameShop/postArticle'>發表文章</option>";
			select += "</select>";
			document.getElementById("select").innerHTML = select;
			
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				
// 				txt += "<select style='float:right;' onChange='location = this.options[this.selectedIndex].value;'>";
// 				txt += "<option value='#'>會員空間</option>";
// 				txt += "<option value='/GameShop/myArticle'>我的創作</option>";
// 				txt += "<option value='/GameShop/postArticle'>發表文章</option>";
				
				txt += "</select>";

				for (let i = 0; i < books.length; i++) {
					txt += "<div class = 'readArticle'>";
					txt += "<div class='title'>"+books[i].articleTitle;
					txt += "</div>";
					txt += "<div class='authoranddate'> 作者: "+ books[i].nickname +" | 發表時間: " + books[i].postDatetime;
					txt += "<form id='deleteArticle' action='deleteArticle' method='POST' style='float:right;'></form>";				
					txt += "<form id='editorArticle' action='gotoUpdataPage' method='POST' style='float:right;'></form></div>";	
					txt += "<hr/>";  // 加一條裝飾分隔線
					txt += "<div class='articleContent'>"+books[i].articleContent+"</div>";
					txt += "</div>";
					a++;
				}
				txt += "</br>"
				document.getElementById("requestArticleId").setAttribute("value", books[0].articleID);
				document.getElementById("demo1").innerHTML = txt;

				var id = books[0].nickname;
				var loginid = "${sessionScope.nickname}";
				var inputeditor = "<input type='submit' value='編輯文章' style='right'>";
				inputeditor += "<input type='hidden' name='aID' value='" + books[0].articleID + "'>";

				var deleteArticle = "<input type='submit' value='刪除文章' style='right'>";
				deleteArticle += "<input type='hidden' name='aID' value='" + books[0].articleID + "'>";
				
				if(id == loginid){				
					document.getElementById("editorArticle").innerHTML = inputeditor;
					document.getElementById("deleteArticle").innerHTML = deleteArticle;
				}
			}

			var txt1 = "所有回應";
			var books1 = ${ message };
			var messageID;
			if(books1[0] === undefined){
				document.getElementById("messageRegion").innerHTML = txt1;
			}else{
				var a = 0;
	 			for (let i = 0; i < books1.length; i++) {		 			
	 				messageID = books1[i].messageID
	 				a++;
					txt1 += "<div class = 'article' style='color:black'>";
					txt1 += "<div class='title'>"+books1[i].nickname+":</div>";
					txt1 += "<div>" + books1[i].messageContent + "</div></div>";
// 					txt1 += "<div style='float:right;'>"+ books1[i].postDatetime +"</div>"
					txt1 += "<div class = 'timeremess'>" + "#" +a + ", " + books1[i].postDatetime + "</div>"
// 					txt1 += "<div class = 'remess' id='replymessage_"+books1[i].messageID+"'>"

					
					var remess = ${remess};
					for(let j = 0; j < remess.length; j++){
						if(remess[j].messageID == books1[i].messageID){
							books[0].userId
							txt1 += "<div class='remess'>${sessionScope.nickname}:</br>" + remess[j].messageContent+"</div></div>"
						}		
					}

						if(id == loginid){
							txt1 += "<div class='messageResponse'><a href='javascript:void(0)' onclick='addtext("+ i +","+ messageID +", "+ books[0].articleID +")'><span class='replyTitle'>回應</span></a>";
							txt1 += "</div>";
						}
					

					txt1 += "<div id='textarea_"+i+"'></div><hr>";
					
				}
				document.getElementById("messageRegion").innerHTML = txt1;
			};

		}

		xhttp.open("GET", "processArticle", true);
		xhttp.send();
		
</script>
</body>
</html>