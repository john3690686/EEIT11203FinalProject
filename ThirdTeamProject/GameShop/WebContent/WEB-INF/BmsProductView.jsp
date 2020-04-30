<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
why not view page?
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



