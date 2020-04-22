<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Read Article Page</title>

<style type="text/css">
	.title{
		font-size: 20px;
		font-family: 微軟正黑體;
	}
	
	.article{
		margin-top: 15px;
		margin-left:20px;
		width: 80%; 
		border-width: 1px;
		border-style: solid;
		border-color: #ADADAD;
	}
	
	.authoranddate{
		font-size: 10px;
		color: #ADADAD;
	}
	
	.articlePage{ 
		margin: auto;
		width: 80%; 
		border-style : solid;
		border-width: 1px;
		border-style: solid;
		border-color: #ADADAD;
	
	}
	
	textarea{
		margin-left:20px;
		width: 80%; 
	}
	
	.message{
		margin-left: 20px;
		border-top-style: solid; 
		width: 80%;
		border-width: 1px;
		border-color: #ADADAD;
		padding-top: 10px;
	}
	
	.messageResponse{
		font-size:13px;
		margin-top:10px;
		margin-left:20px;
	}
	
	.remess{
		font-size:13px;
 		margin-top:10px; 
		margin-left:20px;
		padding:5px;
		border-style: solid;
		border-color: #ADADAD;
		
	}
	
	.timeremess{
		margin-left:20px;
		padding-bottom:0px;
		text-align: right;
	}
	
	</style>

</head>
<body>
	<div class="articlePage">
		<div id="demo1" class="articleRegion"></div>

		<div id="messageRegion" class="message" style="padding-bottom: 10px"></div>

		<form action="<c:url value='/processAddMessage'/>" method="post">
			<div class="message">我要回應:</div>
			<textarea name="message"></textarea>
			
			<div style="margin-left: 20px;margin-bottom: 20px; text-align: right; width: 80%">
				<input type="submit" value="送出" style="right">
				<input type="hidden" id="requestArticleId" name="requestArticleId">
			</div>
			
		</form>
	
	</div>
	
	<script
		src="https://cdn.ckeditor.com/ckeditor5/18.0.0/classic/ckeditor.js"></script>

	<script>

		function addtext(i , mid, arid){
			var a ="textarea_"+i
			var messageTextaera = "<form action='<c:url value='/addReplyMessage'/>' method='POST'>" ;
				messageTextaera += "<textarea name='mContent'></textarea>";

				messageTextaera += "<input type='submit' value='送出' style='right'>";
				messageTextaera += "<input type='hidden' name='mID' value='" + mid + "'>";
				messageTextaera += "<input type='hidden' name='aID' value='" + arid + "'>";
				messageTextaera += "</form>";
			document.getElementById(a).innerHTML = messageTextaera;
		}
	
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function () {
			var txt = " ";
			var books = ${ readByArticleId };
			var a = 1;
			
			if (xhttp.readyState == 4 && xhttp.status == 200) {

				for (let i = 0; i < books.length; i++) {
					txt += "<div class = 'article'>";
					txt += "<div class='title'>"+books[i].articleTitle+"</div>";
					txt += "<div class='authoranddate'> 作者: " + books[i].userId + " | " + books[i].postDatetime + "</div>";
					txt += "<div class='articleContent'>"+books[i].articleContent+"</div>";
					txt += "</div>";
					a++;
				}
				txt += "</br>"
				document.getElementById("requestArticleId").setAttribute("value", books[0].articleID);
				document.getElementById("demo1").innerHTML = txt;
			}

			var txt1 = "回應";
			var books1 = ${ message };
			var messageID;
			if(books1[0] === undefined){
				document.getElementById("messageRegion").innerHTML = txt1;
			}else{
				
	 			for (let i = 0; i < books1.length; i++) {		 			
	 				messageID = books1[i].messageID
					txt1 += "<div class = 'article'>";
					txt1 += "<div class='title'>"+books1[i].respUserId+"</div>";
					txt1 += "<div>" + books1[i].messageContent + "</div></div>";
// 					txt1 += "<div style='float:right;'>"+ books1[i].postDatetime +"</div>"
					txt1 += "<div class = 'timeremess'>"+ books1[i].postDatetime +"</div>"
// 					txt1 += "<div class = 'remess' id='replymessage_"+books1[i].messageID+"'>"

					
					var remess = ${remess};
					for(let j = 0; j < remess.length; j++){
						if(remess[j].messageID == books1[i].messageID){
							txt1 += "<div class='remess'>" + remess[j].messageContent+"</div></div>"
						}else{
							console.log("沒有回應")
						}			
					}

					txt1 += "<div class='messageResponse'><a href='javascript:void(0)' onclick='addtext("+ i +","+ messageID +", "+ books[0].articleID +")'>回應</a>";

					txt1 += "</div>";
					txt1 += "<div id='textarea_"+i+"'></div>";
					
				}

				txt1 += "</br>"

				document.getElementById("messageRegion").innerHTML = txt1;
			};

		}

		
		xhttp.open("GET", "processArticle", true);
		xhttp.send();
	</script>
</body>
</html>