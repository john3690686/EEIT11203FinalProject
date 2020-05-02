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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

<script type="text/javascript">
window.onload = function(){
	$.ajax({
		url:"getOrderRecord",
		type:"get",
		dataType:"json",
		success:function(data){
			console.log(data);
			var record;
			for (var i=0;i<data.length;i++){
				var d = new Date(data[i][0].buyDate).toLocaleDateString();
				var date = "<h2>"+d+"</h2>";
				var thead = "<table>";
				var table="";
				for(var j=0;j<data[i].length;j++){
				var tr = "<tr><td>"+(j+1)+"</td><td>"+data[i][j].productName+"</td><td>"+data[i][j].price+"</td></tr>";
				table +=tr;
				}
				var ttail = "</table>";
				record =date+thead+table+ttail; 
			$("body").append(record);
				}
			}
		})
};
</script>
</body>
</html>