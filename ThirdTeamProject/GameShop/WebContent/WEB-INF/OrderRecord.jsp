<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GameGuild~Enjoy your gameLife here~</title>
<link rel="stylesheet" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>

<title>購買紀錄</title>
<style>
body{
	font-family:微軟正黑體;
	background:url(img/skytower.jpg) no-repeat;
	background-size: cover;
}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<table id="t1"></table>
<script type="text/javascript">
window.onload = function(){
	$.ajax({
		url:"getOrderRecord",
		type:"get",
		dataType:"json",
		success:function(data){
			console.log(data);
			var record;
			var payStatus;
			for (var i=0;i<data.length;i++){
				var date = new Date(data[i][0].buyDate).toLocaleDateString();
				var table="";
				var d1 = "<td>"+date+"</td>"
				var totalPrice=0;
				var thead = "<tr><td>";
				for(var j=0;j<data[i].length;j++){
				var trName = "<p>"+data[i][j].productName+" "+data[i][j].price;
				var br = "<br>";
				table +=trName+br;
				console.log(table);
				var p = data[i][j].price;
				totalPrice += p; 
				}
				var ttail = "</td>";
				var total = "<td>"+totalPrice+"</td>";
				if(data[i][0].payResult=='Y'){
					payStatus="<td><input type='button' id='payY' value='已結帳'></td></tr>";
					}else{
						payStatus="<td><input type='button' id='payN' value='去結帳' onclick='goPay("+data[i][0].orderId+")'></td></tr>";
						}
				record = thead+table+ttail+total+d1+payStatus;
				console.log(record);
			$("#t1").append(record);
				}
			}
		})
};

function goPay(orderId){
	window.location.href="PayOrder?orderId="+orderId;
}
</script>
</body>
</html>