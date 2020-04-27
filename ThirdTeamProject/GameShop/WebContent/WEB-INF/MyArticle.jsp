<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Article Page</title>

<style type="text/css">

.article {
	margin-top: 15px;
	width: 80%; border-style : solid;
	border-width: 1px;
	border-style: solid;
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
</style>

</head>
<body>
	<div id="select"></div>
	<div class="page">
		<form action="<c:url value='/postArticle'></c:url>">
			<input type="submit" value="發表">
		</form>

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

// 				txt += "<span style='float:right;'><a href='...'>我的空間</a></span>";
// 				txt += "<select style='float:right;' onChange='location = this.options[this.selectedIndex].value;'>";
// 				txt += "<option value='#'>會員空間</option>";
// 				txt += "<option value='/GameShop/myArticle'>我的創作</option>";
// 				txt += "<option value='/GameShop/postArticle'>發表文章</option>";
// 				txt += "</select>";

				var select = "<select style='float:right;' onChange='location = this.options[this.selectedIndex].value;'>"
				select += "<option value='#'>想去哪裡</option>";
				select += "<option value='/GameShop/processArticle'>創造の壁</option>";
				select += "<option value='/GameShop/myArticle'>我的創作</option>";
				select += "<option value='/GameShop/postArticle'>發表文章</option>";
				select += "</select>";
				document.getElementById("select").innerHTML = select;

					
				for (let i = 0; i < books.length; i++) {
					txt += "<div class = 'article'>";
					txt += "<a href='/GameShop/processReadArticle?articleID="+ books[i].articleID +"'><div class='title'>This is Title: " + books[i].articleTitle+ "</div></a>";
					txt += "<div class='authoranddate'> 作者: " + books[i].userId + " | " + books[i].postDatetime + "</div>";
// 					txt += "articleNum: " + a + "</br>";

// 					txt += "userId: "+ books[i].userId + "</br>";

					txt += "<div class='abstract'>"+books[i].articleAbstract + "....(<a href='/GameShop/processReadArticle?articleID="+ books[i].articleID +"' >繼續閱讀</a>)</div>";
// 					txt += "articleTitle: "+ books[i].articleContent + "</br>";
// 					txt += "postDatetime: "+ books[i].postDatetime + "</br>";
					txt += "</div>";
					a++;
				}
				txt += "</br>"
				document.getElementById("demo1").innerHTML = txt;
				
			}
		}
		xhttp.open("GET", "processArticle", true);
		xhttp.send();
	</script>

</body>
</html>