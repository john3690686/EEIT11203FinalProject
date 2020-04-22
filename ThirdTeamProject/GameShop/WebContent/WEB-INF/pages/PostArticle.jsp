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
	<div class="page">

		<form action="<c:url value='/processAction'></c:url>" method="post">

			標題:<input type="text" name="articleTitle"><br />
			文章:
<!-- 			<textarea class="textarea" name="articleContent" id="editor"></textarea> -->
			<textarea class="textarea" name="articleContent" id="editor"></textarea>
			<input type="submit" value="送出">
		</form>

	</div>

<!-- 	123 -->
<!-- 	<form name='form' action='#' method='post'> -->
<!-- 		<textarea name="content"  id="content" rows="10" cols="80"></textarea> -->
<!-- 		<input type='button' value='送出' onclick='processData()'> -->

<!-- 	</form> -->

	<!-- 	<script src="https://cdn.ckeditor.com/ckeditor5/18.0.0/classic/ckeditor.js"></script> -->
	<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
	<script>
		// 		ClassicEditor.create(document.querySelector(
		// 				'#editor'), {
		// 				toolbar: ['bold', 'italic', 'link',
		// 					'bulletedList',
		// 					'numberedList',
		// 					'|', 'outdent', 'indent']
		// 			})
		// 			.then(editor => {
		// 				console.log(editor);
		// 			})
		// 			.catch(error => {
		// 				console.error(error);
		// 			});

		CKEDITOR.replace('articleContent', {});
// 		CKEDITOR.replace('content', {});



	</script>

</body>

</html>