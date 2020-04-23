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
<table>
  <c:forEach var="p" items="${cart}">
  <tr>
    <td id="${p.productId}" class="pName">${p.productName}</td>
    <td class="pprice">${p.price}</td>
    <td>
    <input class="delete" type="button" value="delete">
    </td>
  </tr>
  </c:forEach>
  <tr>
    <td >總計</td>
    <td id="total"></td>
  </tr>
</table>
<input id="pay" type="button" value="付款">


<script type="text/javascript">
	window.onload = function(){
		console.log("onload");
		$.post({
			url:"show.controller",
			type:"post",
			success:function(data){
				var totalPrice = 0;
				for(var i=0;i<data.length;i++){
					var tempPrice = data[i].price;
					totalPrice += tempPrice;
					}
				console.log(totalPrice);
				$("#total").html(totalPrice);
				}
			})

		};
$(function(){
	$(".delete").click(function(){
	var id = $(this).parent().siblings("td.pName").attr("id");
	console.log("id" + id);
	$(this).parent().parent().remove();
	var nextPrice = $(this).parent().siblings("td.pprice").html();
	var updatePrice = $("#total").html();
	console.log(nextPrice);
	console.log(updatePrice);
	$("#total").html(updatePrice-nextPrice);
	$.ajax({
		url:"delete.controller",
		type:"get",
		data:{id:id},
		success:function(data){
			console.log("delete ok");
			}
		})
		});
	$("#pay").click(function(){
		var tp = $("#total").html();
		window.location.href="pay.controller?price="+tp;
		});
	
});
</script>
</body>
</html>