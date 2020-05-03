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
<title>創造の壁</title>
<style type="text/css">

body{
	font-family:Microsoft JhengHei;
	background:url(img/blogbg.jpg) no-repeat;
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
    
<!-- top -->
		<a href="#"><input type="button" class="topbutton"></a>    
 
<!-- Main -->
<div class="bgblog">

	<div class="titledec">
        <div class="titletext">創造の壁</div>
	</div>

	<div id="select">
	</div>
	
<!-- Show Article -->
	<form id="demo1" class="blogArea" action=""></form>

</div>

<!--footer-->
    <footer style="margin-top: 300px">
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

<script src="https://cdn.ckeditor.com/ckeditor5/18.0.0/classic/ckeditor.js"></script>
<script>

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function () {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				var txt = "";
//把標題移到html	var txt = "<span>創造の壁</span>";
				var books = ${ aJson };
				var a = 1;

// 				txt += "<select style='float:right;' onChange='location = this.options[this.selectedIndex].value;'>";
// 				txt += "<option value='#'>會員空間</option>";
// 				txt += "<option value='/GameShop/myArticle'>我的創作</option>";
// 				txt += "<option value='/GameShop/postArticle'>發表文章</option>";
// 				txt += "</select>";

				var select = "<select class='movePage' onChange='location = this.options[this.selectedIndex].value;'>"
				select += "<option value='#'>移動至...</option>";
				select += "<option value='/GameShop/processArticle'>創造の壁</option>";
				select += "<option value='/GameShop/myArticle'>我的創作</option>";
				select += "<option value='/GameShop/postArticle'>發表文章</option>";
				select += "</select>";
				document.getElementById("select").innerHTML = select;

					
				for (let i = 0; i < books.length; i++) {
					txt += "<div class='articleList'>";
//把block去掉			txt += "<div class = 'imageblock'><img class = 'articleImg' alt='圖片失效' src='https://i.imgur.com/pLPub4P.jpg'></div>";
					txt += "<div><img class = 'articleImg' id='articleImg_"+i+"' alt='圖片失效'>";
					txt += "<div class = 'article'>";
					txt += "<a href='/GameShop/processReadArticle?articleID="+ books[i].articleID +"'><div class='title'>" + books[i].articleTitle+ "</div></a>";
					txt += "<div class='authoranddate'> 作者: " + books[i].nickname + " | 發表日期: " + books[i].postDatetime + "</div>";
					txt += "<div class='abstract'>"+books[i].articleAbstract + "....(<a href='/GameShop/processReadArticle?articleID="+ books[i].articleID +"' >繼續閱讀</a>)</div>";
					txt += "</div></div>";
					a++;
				}
				txt += "</br>"
				document.getElementById("demo1").innerHTML = txt;

				for (let i = 0; i < books.length; i++) {

					var imgstr = 0;
					imgstr = books[i].articleThumbnail;
					console.log("imgstr: "+imgstr);
					
					if(imgstr != undefined || imgstr != null){
						var b = "articleImg_"+i;
						document.getElementById(b).src = books[i].articleThumbnail;
					}else{
						var b = "articleImg_"+i;
						document.getElementById(b).src = 'https://orangemushroom.files.wordpress.com/2017/09/maplestory-256x256.png';
					}
				}
			}
		}
		xhttp.open("GET", "processArticle", true);
		xhttp.send();
	</script>

</body>

</html>