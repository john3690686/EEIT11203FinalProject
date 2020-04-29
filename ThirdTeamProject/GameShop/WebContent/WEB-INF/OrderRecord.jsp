<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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