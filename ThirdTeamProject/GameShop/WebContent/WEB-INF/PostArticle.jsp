<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Post Article</title>
<style type="text/css">
.page {
	margin: auto;
	width: 90%;
}

.ck-editor__editable {
	min-height: 400px;
}

.articleThumbnail{
	width:100px;
	height: 100px;
	border:solid;
	border-color: #ADADAD;
	border-width: 2px;
}


.articleThumbnail img{
	width:100px;
	height: 100px;

}

.uploadImg{
	width:500px;
}


</style>

</head>

<body>
	<div>
		<select style='float: right;'
			onChange='location = this.options[this.selectedIndex].value;'>
			<option value='#'>想去哪裡</option>
			<option value='/GameShop/processArticle'>創造の壁</option>
			<option value='/GameShop/myArticle'>我的創作</option>
			<option value='/GameShop/postArticle'>發表文章</option>
		</select>
	</div>

	<div class="page">
		<div class="uploadImg">
			<form id="myform" onsubmit="submitFile(event)" method="POST"
				enctype=multipart/form-data>
				文章縮圖<br/>
				<input type="file" name="myfile" onchange="onChange(event)" />
				<input type="submit" value="圖片上傳" /><span id = "success"></span><br/>
				<input type="reset" onclick="resetImg()">
					<div class="articleThumbnail" id="articleThumbnail">
						<div id="image">No image<br/>available</div>
					</div>
				
			</form>

		</div>

		<form action="<c:url value='/processAction'></c:url>" id="form"
			method="post">

			標題:<input type="text" id="title" name="articleTitle"><br />
			文章:
			<textarea class="textarea" name="articleContent" id="editor"></textarea>
			<input type="hidden" id="artid" name="articleID"> 
			<input type="hidden" id="imgLink" name="imgLink">
			<input type="submit" value="送出">
		</form>

	</div>

	<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
	<script>
		CKEDITOR.replace('articleContent', {});

		var checkout = ${checkout_1}+0;
		checkout += ${checkout_2}+0;
		// 		console.log("checkout: "+checkout);
		if(checkout === 19487){
			// 			console.log("可以編輯");
			var book = ${readByArticleId};
			// 			console.log(book);
			document.getElementById("title").value = book[0].articleTitle;
			document.getElementById("editor").innerHTML = book[0].articleContent;
			document.getElementById("artid").value = book[0].articleID;
			document.getElementById("form").action = "<c:url value='/updataArticle'/>";
		}

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


