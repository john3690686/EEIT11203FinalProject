<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/Bms.css">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<meta charset="UTF-8">
<title>Product List</title>
</head>
<body id="BmsProductListPage">
<jsp:include page="BmsMenuPage.jsp"></jsp:include>
<section id="section">
<table>
	<c:forEach var="product" items="${productlist}" varStatus="varStatus">
		<c:if test="${varStatus.first}">
			<tr>
				<td>Id
				<td>Name
				<td>Price
				<td>intro
				<td>Image
				<td>uplTime
				<td>dwlTime
		</c:if>
			<tr>
				<td>${product.productId}
				<td><h2>${product.productName}</h2>
					<c:forTokens var="item" items="${product.tag}" delims=",">
						<label>${item}</label>
					</c:forTokens>
				<td>${product.price}
				<td>${product.intro}
				<td><img class="pImg" alt="${product.productName}" src="productImageView/${product.productId}">
	<%-- 			<td><img class="pImg" alt="${product.productName}" src="data:image/jpeg;base64,${product.productImage}"> --%>
				<td>${product.uploadTime}
				<td>${product.downloadTime}
				<td><button onClick="uplClick('${product.productId}')">Upl</button>
				<td><button onClick="delClick('${product.productId}')">Del</button>
	</c:forEach>
	</table>
	<div id="uplDiv" hidden="true" style="background-color: white;">
		<div id="uplmain">
		</div>
	</div>
</section>
<script type="text/javascript">
	function uplClick(n){
		$("#uplDiv").toggle()
 		$("#uplmain").load("product.upl/" + n)
// 		location.href = "product.upl/" + n;
	}
	
	function delClick(n){
		if (confirm("Are you sure Delete pId=" + n + " data?")) {
			txt = "You pressed OK!";
 			document.location = 'product.del/' + n;
			$.ajax({
				method: "GET",
				url: 'product.del/' + n,
			})
			.done(function( data ) {
				if(data){
					alert( "Delete id=" + n + " is success." );
				}
			})
		} else {
			txt = "You pressed Cancel!";
		}
	}

</script>
</body>
</html>