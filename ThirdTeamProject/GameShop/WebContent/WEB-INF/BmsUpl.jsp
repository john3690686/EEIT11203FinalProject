<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${product==null}">
	<jsp:include page="BmsMenuPage.jsp"></jsp:include>
</c:if>
	<c:choose>
		<c:when test="${product!=null}">
			<c:set var="controllerUrl" value="product.upldata"/>
			<div>
		</c:when>
		<c:otherwise>
			<c:set var="controllerUrl" value="product.new"/>
			<div id="section">
		</c:otherwise>
	</c:choose>
	<form action="${controllerUrl}" method="post" enctype="multipart/form-data">
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
					<c:otherwise><img id="Preview" src="defaultImg.jpg"></c:otherwise>
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
		    <td colspan="2"><input type="submit" value="Upload"> Press here to upload the file!	
	</table> 
	</form>
</div>
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
