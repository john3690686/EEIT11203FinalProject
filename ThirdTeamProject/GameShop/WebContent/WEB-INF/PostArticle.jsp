<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Post Article</title>
	<style type="text/css">
		.page {
			margin: auto;
			width: 90%;
		}

		.ck-editor__editable {
			min-height: 400px;
		}
	</style>

</head>

<body>
	<div>
		<select style='float:right;' onChange='location = this.options[this.selectedIndex].value;'>
			<option value='#'>想去哪裡</option>
			<option value='/GameShop/processArticle'>創造の壁</option>
			<option value='/GameShop/myArticle'>我的創作</option>
			<option value='/GameShop/postArticle'>發表文章</option>
		</select>	
	</div>
	
	<div class="page">

		<form action="<c:url value='/processAction'></c:url>" id="form" method="post">

			標題:<input type="text" id="title" name="articleTitle" ><br />
			文章:
			<textarea class="textarea" name="articleContent" id="editor"></textarea>
			<input type="hidden" id="artid" name="articleID">
			<input type="submit" value="送出">
		</form>

	</div>

	<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
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

	</script>

</body>

</html>