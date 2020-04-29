<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <link rel="stylesheet" type="text/css" href="css/Bms.css"> -->
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<!-- <title>Insert title here</title> -->
<!-- </head> -->
<!-- <body> -->
	<form id="uplform" action="productBean" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" value="${product.productId}">
	<table>
	<!-- 	test id -->
		<tr><td>Id<td>${product.productId}
		<tr>
			<td>Name
			<td><input id="pName" type="text" name="pName" value="${product.productName}">
		<tr>
			<td>Price
			<td><input id="price" type="text" name="price" value="${product.price}">
		<tr>
			<td>tag
			<td><input id="tag" type="text" name="tag" value="${product.tag}">
		<tr>
			<td>intro
			<td>
				<textarea id="intro" name="intro" cols="50" rows="5">${product.intro}</textarea>
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
			<td><input id="uplTime"  type="text" name="uplTime" value="${product.uploadTime}">
		<tr>
			<td>dwlTime
			<td><input id="dwlTime"  type="text" name="dwlTime" value="${product.downloadTime}">
		<tr>
		    <td colspan="2"><input id="upl_btn" type="submit" value="Upload"> Press here to upload the file!	
	</table> 

	</form>
	
	<button id="goTestFormdata">Try Form data</button>
	<button id="getValue">Click get Value</button>
<!-- </section> -->
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
	
	$("#getValue").on("click", function(){
		$("#pName").val("testName")
		$("#price").val(888)
		$("#tag").val("TestTag")
		$("#intro").val("testIntro")
		$("#uplTime").val("2020-04-01")
		$("#dwlTime").val("2020-07-05")
	})

	$("#goTestFormdata").on("click", function(){
// 		var formdata = new FormData($("#uplform")[0]);
		var formdata = new FormData();
		formdata.append("k", "v")
		formdata.append("test-k", "test-v")
		formdata.append("fd", $("#file").get(0).files[0])
		var data = {
				kkk: "vvv",
				testK: "testV",
				file: $('#file')[0].files[0]
			}
		console.log(data)
		$.ajax({/// -------------------------  success upload file use ajax
			url: "bmstestimageupload",
			type: "POST",
			data: formdata,
		    async: false,
		    cache: false,
		    contentType: false,
		    processData: false,
		    success: function(data){
				alert("success.")
			},
			error: function(data){
				alert("error")
			}
		})
	})
	
		
	
</script>
<!-- </body> -->
<!-- </html> -->