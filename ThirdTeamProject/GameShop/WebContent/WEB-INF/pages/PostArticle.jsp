<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Post Article</title>
<style type="text/css">


.page{
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

		帳號:<input type="text" name="userID"><br/> 
		標題:<input type="text" name="articleTitle"><br/> 
		文章:
		<textarea class="textarea" name="articleContent" id="editor" ></textarea>
		<input type="submit" value="送出">
	</form>

	</div>

	<script src="https://cdn.ckeditor.com/ckeditor5/18.0.0/classic/ckeditor.js"></script>
	<script>
		ClassicEditor
			.create(document.querySelector(
				'#editor'), {
				toolbar: ['bold', 'italic', 'link',
					'bulletedList',
					'numberedList',
					'|', 'outdent', 'indent']
			})
			.then(editor => {
				console.log(editor);
			})
			.catch(error => {
				console.error(error);
			});

		
	</script>

</body>

</html>