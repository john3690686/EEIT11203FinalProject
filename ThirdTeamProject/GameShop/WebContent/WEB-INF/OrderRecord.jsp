<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<script type="text/javascript">
window.onload = function(){
	console.log("onload");
	$.ajax({
		url:"record.do",
		type:"Post",
		dataType:"json",
		success:function(data){
			console.log(data);
			}
		})

	};
</script>
</body>
</html>