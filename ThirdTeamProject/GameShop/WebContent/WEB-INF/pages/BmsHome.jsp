<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/Bms.css">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<title>Home Page</title>
<script type="text/javascript">
	$(function() {
		$("a.BmsMenuOption").click(function(){
			$("#section").load($(this).attr("id"))
			//$(this).css("background-color","yellow")
		})
	})
</script>
</head>
<body>
<%-- 	<jsp:include page="BmsMenuPage.jsp"></jsp:include> --%>
	<aside id="aside">
		<h1>ASIDE 側邊</h1>
		<h2>
			<a id="productlist" class="BmsMenuOption">Click this load update Page</a>
		</h2>
		<br />
		<h2>
			<a id="product.newPage" class="BmsMenuOption">Click this load insert page</a>
		</h2> 
	</aside>
	<section id="section">
		<h1>Main.jsp</h1>
		<div>Please Select Menu Option</div>
	</section>
	<div class="infoView">
		<div id="infoContxt">
		</div>
	</div>
</body>
</html>