<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
#table1{
float:left;
}
</style>
</head>
<body>
<table id="table1">
  <tr>
    <th>名稱</th>
    <th>價錢</th>
    <th>分類</th>
    <th>圖片</th>
    <th>選項</th>
  </tr>
  <c:forEach var="product" items="${products}">
  <tr>
    <td id="${product.productId}" class="pName">${product.productName}</td>
    <td>${product.price}</td>
    <td>${product.tag}</td>
    <td><img alt="picture" src="${pageContext.servletContext.contextPath}/productImage.do?Id=${product.productId}" width="112" ></td>
    <td>
    <input name="wish" type="button" value="許願">
    <input type="button" value="評價">
    <input name="cart" type="button" value="加入購物車">
    </td>
  </tr>
  </c:forEach>
</table>
 
  <input id="cart"type="button" value="顯示購物車內容">
  <div id="div1"></div>
  <input id="wish" type="button" value="顯示願望內容">
  <div id="div2"></div>
  <a href="showWish.controller">顯示願望內容</a>
  <input id="pay" type="button" value="結帳">
<script type="text/javascript">
$(function(){
	//OK
$("input[name='cart']").click(function(){
	var id = $(this).parent().siblings("td.pName").attr("id");
	var name = $(this).parent().siblings("td.pName").html();
	console.log("add product");
	window.alert(name+"加入購物車");
	$.get({
		url:"add.controller?id=" + id,
		success:function(data){
			console.log("add product: "+data);
			}
		})
})

$("#cart").mouseenter(function(){
	$.post({
		url:"show.controller",
		type:"post",
		dataType:"json",
		success:function(data){
			var t1 = "<table><tr><th>name</th><th>price</th></tr>";
			var i;
			var t2 = "";
			for(i=0;i<data.length;i++){
				var t3 = "<tr><td>"+data[i].productName+"</td><td>"+data[i].price+"</td></tr>";
				t2 = t2+t3;
				console.log(t2);
				}
			var t4 = "</table>";
			$("#div1").append(t1,t2,t4).css("color","blue");
			}
		})
	}).mouseleave(function(){
		$("#div1").empty();
		});

	//OK
$("#pay").click(function(){
	window.location.href="prePay.controller";
})
//OK
$("input[name='wish']").click(function(){
	var id1 = $(this).parent().siblings("td.pName").attr("id");
	var name1 = $(this).parent().siblings("td.pName").html();
	console.log("add wish");
	window.alert(name1+"加入願望清單");
	$.get({
		url:"addWish.controller?id=" + id1,
		success:function(data){
			console.log("add wish: "+data);
			}
		})
})
	
});
</script>
</body>
</html>