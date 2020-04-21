<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:if test="${message.length()>0}">
	<script type="text/javascript">alert("Message:" + message)</script>
</c:if>
<meta charset="UTF-8">
<c:if test="${product==null}">
	<link rel="stylesheet" type="text/css" href="css/Bms.css">
</c:if>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<c:if test="${product==null}">
	<jsp:include page="BmsMenuPage.jsp"></jsp:include>
</c:if>
	<c:choose>
		<c:when test="${product!=null}">
			<section>
		</c:when>
		<c:otherwise>
			<section id="section">
		</c:otherwise>
	</c:choose>
	<form action="productBean" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" value="${product.productId}">
	<table>
	<!-- 	test id -->
		<tr><td>Id<td>${product.productId}
		<tr>
			<td>Name
			<td><input type="text" name="pName" value="${product.productName}">
		<tr>
			<td>Price
			<td><input type="text" name="price" value="${product.price}">
		<tr>
			<td>tag
			<td><input type="text" name="tag" value="${product.tag}">
		<tr>
			<td>intro
			<td>
				<textarea name="intro" cols="50" rows="5">${product.intro}</textarea>
		<tr>
			<td>file
			<td>
				<c:choose>
					<c:when test="${product!=null}"><img id="Preview" src="productImageView/${product.productId}"></c:when>
					<c:otherwise><img id="Preview" src="img/defaultImg.jpg"></c:otherwise>
				</c:choose>
	<!-- 			<img id="Preview"> -->
			    <input id="file" type="file" name="file" hidden="true">
		<tr>
			<td>uplTime
			<td><input type="text" name="uplTime" value="${product.uploadTime}">
		<tr>
			<td>dwlTime
			<td><input type="text" name="dwlTime" value="${product.downloadTime}">
		<tr>
		    <td colspan="2"><input id="upl_btn" type="submit" value="Upload"> Press here to upload the file!	
	</table> 
	</form>
</section>
<script type="text/javascript">
	$('#file').change(function() {
		var file = $('#file')[0].files[0];
		var reader = new FileReader;
		reader.onload = function(e) {
			$('#Preview').attr('src', e.target.result);
		};
		reader.readAsDataURL(file);
	});
	$("#Preview").click(function(){
		$("#file").click();
	});
</script>
</body>
</html>