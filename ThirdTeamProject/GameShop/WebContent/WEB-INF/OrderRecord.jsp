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
		url:"joinTest2",
		type:"get",
		dataType:"json",
		success:function(data){
			console.log("success");
			console.log(data);
			console.log(data[0][0].buyDate);
			console.log(data.length);
			var tableFull;
			for (var i=0;i<data.length;i++){
				var d1 = data[i][0].buyDate;
				var d2 = new Date(d1);
				var d3 = d2.pattern("yyyy-MM-dd"); 
				var t = "<h2>"+d2+"</h2>";
				var t1 = "<table>";
				var table="";
				for(var j=0;j<data[i].length;j++){
				var tr = "<tr><td>"+(j+1)+"</td><td>"+data[i][j].productName+"</td><td>"+data[i][j].price+"</td></tr>";
				table +=tr;
				}
				var t2 = "</table>";
				tableFull =t+t1+table+t2; 
			$("body").append(tableFull);
				}
			console.log(d3); 
			}
		})
};
</script>
</body>
</html>