<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<h3>願望清單</h3>
<table>
<c:forEach var="wish" items="${wish}" varStatus="st"> 
<tr>
<td>${st.count}</td>
<td id="${wish.productId}" class="productNameForDelete">${wish.productName}</td>
<td>
<input class="delete" type="button" value="delete">
</td>
</tr>
</c:forEach>
</table>
<script type="text/javascript">
$(".delete").click(function(){
	var id = $(this).parent().siblings("td.productNameForDelete").attr("id");
	console.log("id="+id);
	$(this).parent().parent().remove();
	$.get({
		url:"deleteWish.controller?id=" + id,
		success:function(data){
			console.log("delete wish: "+data);
			}
		})
})
</script>
</body>
</html>