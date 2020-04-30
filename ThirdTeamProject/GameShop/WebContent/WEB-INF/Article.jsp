<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>創造の壁</title>
<style type="text/css">

.article {
 	margin-top: 15px; 
 	margin-left: 90px; 
	border-width: 1px;
	border-style: solid;
	height: 80px;
	width: 1000px;
/*  	float:left;  */
}

.page{
	margin: auto;
	width: 90%;
}

.title{
	font-size: 20px;
	font-family: 微軟正黑體;
}

.authoranddate{
	font-size: 10px;
	color: #ADADAD;
}

.abstract{
	margin-top: 20px;
}

.imageblock{ 
/*  	margin-top: ; */
	float:left;
	border: 1px #ADADAD solid;
	height: 80px;
	width: 80px;
 }
 
.articleImg{
	height: 80px;
	width: 80px;
}

</style>

</head>

<body>
	<div id="select"></div>
	<div class="page">


	<form id="demo1" action=""></form>

	</div>

	<script
		src="https://cdn.ckeditor.com/ckeditor5/18.0.0/classic/ckeditor.js"></script>

	<script>

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function () {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				var txt = "<span>創造の壁</span>";
				var books = ${ aJson };
				var a = 1;

				var select = "<select style='float:right;' onChange='location = this.options[this.selectedIndex].value;'>"
				select += "<option value='#'>想去哪裡</option>";
				select += "<option value='/GameShop/processArticle'>創造の壁</option>";
				select += "<option value='/GameShop/myArticle'>我的創作</option>";
				select += "<option value='/GameShop/postArticle'>發表文章</option>";
				select += "</select>";
				document.getElementById("select").innerHTML = select;

				var a
				for (let i = 0; i < books.length; i++) {
					txt += "<div>";
					txt += "<div class = 'imageblock'><img class='articleImg' id='articleImg_"+i+"' alt='圖片失效'></div>";
					txt += "<div class = 'article'>";
					txt += "<a href='/GameShop/processReadArticle?articleID="+ books[i].articleID +"'><div class='title'>This is Title: " + books[i].articleTitle+ "</div></a>";
					txt += "<div class='authoranddate'> 作者: " + books[i].userId + " | " + books[i].postDatetime + "</div>";
					txt += "<div class='abstract'>"+books[i].articleAbstract + "....(<a href='/GameShop/processReadArticle?articleID="+ books[i].articleID +"' >繼續閱讀</a>)</div>";
					txt += "</div></div>";
					a++;
				}
				txt += "</br>"
				document.getElementById("demo1").innerHTML = txt;


				
				for (let i = 0; i < books.length; i++) {

					var imgstr = 0;
					imgstr = books[i].articleThumbnail;
					
					if(imgstr != undefined){
						var b = "articleImg_"+i;
						document.getElementById(b).src = books[i].articleThumbnail;
					}else{
						var b = "articleImg_"+i;
						document.getElementById(b).src = 'https://i.imgur.com/4ZuUoI1.png';
					}
				}
				
			}
		}
		xhttp.open("GET", "processArticle", true);
		xhttp.send();
	</script>

</body>

</html>