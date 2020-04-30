<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>發表文章</title>

<style type="text/css">

body{
	font-family:Microsoft JhengHei;
	background:url(img/blogbg.jpg) no-repeat;
	background-size:cover;
}

</style>

</head>

<body>
	
<!-- Post Article -->
<div class="bgblog">

	<div class="titledec">
        <div class="titletext">發表文章</div>
	</div>

	<div id="select" style="width:50%;border-radius:5px">
		<select class='movePage' onChange='location = this.options[this.selectedIndex].value;'>
			<option value='#'>移動至...</option>
			<option value='/GameShop/processArticle'>創造の壁</option>
			<option value='/GameShop/myArticle'>我的創作</option>
			<option value='/GameShop/postArticle'>發表文章</option>
		</select>	
	</div>

		<form class="postArea" action="<c:url value='/processAction'></c:url>" id="form" method="post">
		
		<div class="postArticleTitle">文章標題:  <input type="text" id="title" name="articleTitle" ></div><br />
			<textarea class="textarea" name="articleContent" id="editor"></textarea>
			<input type="hidden" id="artid" name="articleID">
			<input type="submit" class="postSubmit" value="送出">
		<!-- 加入取消回前頁 -->
			<input type="button" class="postCancel" value="取消">
		</form>
		<br/>
		<a href="processArticle"><input type="button" class="morebutton" value="回到創造の壁"></a>

</div>

<!--footer-->
    <footer style="margin-top:200px">
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
	
		CKEDITOR.replace('articleContent', {});
			
		var checkout = ${checkout_1}+0;
		checkout += ${checkout_2}+0;
// 		console.log("checkout: "+checkout);
		if(checkout === 19487){
// 			console.log("可以編輯");
			var book = ${readByArticleId};
// 			console.log(book);
			document.getElementById("title").value = book[0].articleTitle;
			document.getElementById("editor").innerHTML = book[0].articleContent;
			document.getElementById("artid").value = book[0].articleID;
			document.getElementById("form").action = "<c:url value='/updataArticle'/>";
		}

		// 取消按鈕回前頁
		$(".postCancel").click(function(){
			var yes= confirm("確認取消?");

			if(yes){
				window.history.back();
			}else{
				local.href="";
				 }
			})
	
	</script>

</body>

</html>