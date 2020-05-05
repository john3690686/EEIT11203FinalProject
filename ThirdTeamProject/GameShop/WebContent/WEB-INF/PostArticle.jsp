<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
<title>發表文章</title>

<style type="text/css">

body{
	font-family:Microsoft JhengHei;
	background:url(img/blogbg.jpg) no-repeat;
	background-attachment: fixed;
}

img{
	width: 20%;
	height: 20%;
}

</style>

</head>

<body>

<!--Navigator-->
    <nav>
        <ul class="ul1">
            <li><a href="index.html">HOME</a>
            <li><a href="Event">NEWS</a>
            <li><a id="navShop" href="Shop">SHOP</a>
            <li><a href="processArticle">BLOG</a>
            <li><a href="Chatroom">CHAT</a>
            <li id="hello"><a href="myProfile">會員中心</a>
        </ul>
        <a href="#"><input type="button" class="loginz" value="${login_btn}" /></a>	
    </nav>

<!-- Post Article -->
<div class="bgblog">

	<div class="titledec">
        <div class="titletext">發表文章</div>
	</div>

	<div id="select" style="width:50%;border-radius:5px">
		<select class='movePage' onChange='location = this.options[this.selectedIndex].value;'>
			<option value='#'>移動至...</option>
			<option value='/GameShop/processArticle'>創造の壁</option>
			<option value='/GameShop/myArticle'>我的創作</option>
			<option value='/GameShop/postArticle'>發表文章</option>
		</select>	
	</div>

<!-- ===================================================================================================================== -->
			<form id="myform" class="uploadImg" onsubmit="submitFile(event)" method="POST"
				enctype=multipart/form-data>
				<h3 style="margin:0">文章縮圖:</h3>
				
				<div class="articleThumbnail" id="articleThumbnail">
						<div id="image">No image available</div>
				</div>
				
				<div class="uppic">
					<p><input type="file" name="myfile" onchange="onChange(event)" class="uppic"/></p>
					<p style="margin:0;"><input type="submit" value="圖片上傳" /><span id = "success"></span>
					   <input type="reset" onclick="resetImg()"></p>
				</div>
				
			</form>		
<!-- ===================================================================================================================== -->

		<form class="postArea" action="<c:url value='/processAction'></c:url>" id="form" method="post">
		
		<div class="postArticleTitle">
		文章標題:  <input type="text" id="title" name="articleTitle" >${errormeg}</div><br />
				<textarea class="textarea" name="articleContent" id="editor"></textarea>
				<input type="hidden" id="artid" name="articleID">
				<input type="hidden" id="imgLink" name="imgLink">
				<input type="submit" class="postSubmit" value="送出">
		<!-- 加入取消回前頁 -->
			<input type="button" class="postCancel" value="取消">
		</form>
		<br/>
		<a href="processArticle"><input type="button" class="morebutton" value="回到創造の壁"></a>

</div>

<!--footer-->
    <footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>

<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
	
		CKEDITOR.replace('articleContent', {});
			
		var checkout = ${checkout};	
 		console.log("checkout: "+checkout);

		if(checkout == 19487){
 			console.log("可以編輯");
			var book = ${readByArticleId};
// 			console.log(book);
			document.getElementById("title").value = book[0].articleTitle;
			document.getElementById("editor").innerHTML = book[0].articleContent;
			document.getElementById("artid").value = book[0].articleID;
			document.getElementById("form").action = "<c:url value='/updataArticle'/>";
			var imgset = "<img class='setImg' src='"+book[0].articleThumbnail+"'>";
			document.getElementById("articleThumbnail").innerHTML = imgset;
			document.getElementById("imgLink").value = book[0].articleThumbnail;
			
		}else if(checkout == 99847){
			var errorReturnTitle = ${errorReturnTitle};
			console.log("var errorReturnTitle = "+errorReturnTitle);			
			document.getElementById("title").value = errorReturnTitle[0].articleTitle;
			document.getElementById("editor").innerHTML = errorReturnTitle[0].articleContent;
			var imgset = "<img class='setImg' src='"+errorReturnTitle[0].articleThumbnail+"'>";
			document.getElementById("articleThumbnail").innerHTML = imgset;
			document.getElementById("imgLink").value = errorReturnTitle[0].articleThumbnail;
		}

		// 取消按鈕回前頁
		$(".postCancel").click(function(){
			var yes= confirm("確認取消?");

			if(yes){
				window.history.back();
			}else{
				local.href="";
				 }
			})
			
		function resetImg(){
			var txt = "<div id='image'>No image<br/>available</div>";
			document.getElementById("articleThumbnail").innerHTML = txt;
			 document.getElementById("success").innerHTML = " ";
		}

	
	</script>
	
	<script type="text/javascript">
	const readImage = (file) =>{
		  const img = document.createElement("img");
		  const reader = new FileReader();
		  reader.onloadend = function() {
		          img.src = reader.result;
		  }
		  reader.readAsDataURL(file);
		  return img;
		}

		const onChange = (event) => {

		    const file = event.srcElement.files[0];
		    const img = readImage(file);
		    const image = document.getElementById("image");
		    image.parentNode.replaceChild(img,image);
		}

		const submitFile = async (event) => {
		    event.preventDefault();
		    const file = event.target.elements.myfile.files[0];
		    console.log(file);
		    const response = await fetch('https://api.imgur.com/3/image',{
		      method:'post',
		      headers:{
		        'Authorization':'Client-ID a5f4685fccae07b'
		      },
		      body:file
		    });
		    const json = await response.json();
		    const id = json.data.id;
		    const responseimg = await fetch('https://api.imgur.com/3/image/'+id,{
		      headers:{
		        'Authorization':'Client-ID a5f4685fccae07b'
		      }
		    });
		    const responseimgjson = await responseimg.json()
		    console.log(responseimgjson.data.link);
		    
		    var imgLink = responseimgjson.data.link;
		    if(imgLink != null){
			    document.getElementById("imgLink").value = imgLink;
			    document.getElementById("success").innerHTML = " 上傳成功";

			}

		}

	</script>

</body>

</html>