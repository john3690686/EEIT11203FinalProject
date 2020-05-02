<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CommentList</title>
</head>
<body>

<div class="createCommentArea">

<!-- <form:form action="commentgo?id=${productId}" method="post" modelAttribute="comments">
	<span class="useridtag">UserID:${UserId}</span><br><br>
	<form:textarea cols="50" rows="5" path="Comment"/>
	<form:button value="Send" >Submit</form:button>
	</form:form>
 -->	
	<span class="useridtag">暱稱: ${nickName}</span><br><br>
	<textarea cols="50" rows="5" id="commentHere" required="required"></textarea>
	<input type="button" value="發表評論" id="sendComment">
</div>
	
<script src="js/jquery-3.5.0.min.js"></script>
<script>
$(function(){
	$("#sendComment").click(function(){
		var yes = confirm("確認發表評論?");
	
		if(yes){	
		var productid = ${productId};
		var com = $("#commentHere").val();
		
		$.ajax({
			url:"/GameShop/commentgo?id="+productid+"&comments="+com,
			type:"Post",
			success:function(jdata){
				
				alert("已發表");
				location.reload();
			}
	})
		}else{
			alert("取消");
	     	location.href="";
			}
	})
});

</script>
</body>
</html>