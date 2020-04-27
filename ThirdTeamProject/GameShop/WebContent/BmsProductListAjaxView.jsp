<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<title>Insert title here</title>
	<script type="text/javascript">
		var productbean;
		$(function(){
			function getProductList(){
				console.log("")
				$.getJSON("productJsonView", function( jdata ){
					productbean = jdata;
					showProductList();
					console.log(productbean)
				})
			}
			getProductList();
		})
		
		function showProductList() {
			let txt = "<table>"
			for(let i=productbean.length-1;i>=0;i--){
				if(i==productbean.length){
					txt += "<tr>"
					$.each(productbean[i], function(key, val){
						txt += "<td>" + key + "</td>"
					})
					txt += "</tr>"
				}
				let now = Date.parse(new Date()).valueOf()
				let uplt = Date.parse(productbean[i].uploadTime).valueOf()
				let dwlt = Date.parse(productbean[i].downloadTime).valueOf()
				txt += "<tr class='" + (Compare(now, dwlt)?"expired'":Compare(now, uplt)?"valid":"notyet") + "'>"
				$.each(productbean[i], function(key, val){
					if(key=="productImage"){
						txt += "<td><img src='data:image/jpeg;base64," + val + "'></td>"
					} else {
						txt += "<td>" + val + "</td>"
					}
				})
				txt += "</tr>"
			}
			txt += "</table>"
			$("#productlist").html(txt)
		}

		function Compare(x, y) {
			if( x > y ) {
				return true
			} else {
				return false
			}
		}
	</script>
	<style type="text/css">
		.expired {
			background-color: red;
		}
		.valid {
			background-color: yellow;
		}
		.notyet {
			background-color: blue;
		}
	</style>
</head>
<body>
	<div id="productlist">

	</div>
</body>
</html>