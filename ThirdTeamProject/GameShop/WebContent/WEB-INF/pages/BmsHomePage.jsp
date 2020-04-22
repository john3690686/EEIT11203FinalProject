<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<title>BmsHomePage.jsp</title>
<style type="text/css">
     
     #header{
	     background-color: #425660;
	     padding: 20px;
     }

     #nav{
	     background-color: #20292F;
	     padding: 5px;
     }

     #aside{
	     width: 30%;
 	     height: 700px; 
	     text-align: center;
	     background-color: #63808F;
	     padding:20px 10px;
	     float: left;
     }

     #section{
	     width: 66%; 
	     height: 700px; 
	     background-color: #849DAA;
	     line-height: 1.5em;
	     padding: 20px;
 	     float: right; 
     }

     #footer{
	     padding:20px;
	     background-color: #425660;
	     clear: both;
     }
  
     h1{
	     font-family: sans-serif, "微軟正黑體";
	     font-size: 18px;
	     color: #FFF;
	     text-align: center;
     }
</style>
</head>
<body id="BmsHomePage">
	
<!-- 	<header id="header"> -->
<!-- 		<h1>HEADER 標題</h1> -->
<!-- 	</header> -->

<!-- 	<nav id="nav"> -->
<!-- 		<h1>NAV 導覽列</h1> -->
<!-- 	</nav> -->

	<aside id="aside">
		<h1>ASIDE 側邊</h1>
		<h2><a href="#" onclick=loadPage()>Click this load update Page</a></h2>
		<br />
		<h2><a href="#" onclick=loadInserPage()>Click this load insert page</a></h2>
	</aside>

	<section id="section">
		<h1>Section</h1>
	</section>

<!-- 	<footer id="footer"> -->
<!-- 		<h1>FOOTER 頁尾</h1> -->
<!-- 	</footer> -->
<!-- 	<div id="main"></div> -->
<script type="text/javascript">
	function loadPage() {
		console.log("click hyperlick");
		$("#section").load("product.all");
	};

	function loadInserPage() {
		console.log("click insert hyperlink");
		$("#section").load("product.newPage");
	};

	
</script>
</body>
</html>