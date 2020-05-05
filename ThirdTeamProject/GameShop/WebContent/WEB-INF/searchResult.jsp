<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/style.css">
<link href="https://fonts.googleapis.com/css2?family=Sen&display=swap"
	rel="stylesheet">
<!-- css for phone -->
<link rel="stylesheet" media="screen and  (max-width: 700px)" href="css/style700.css" />
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.ico"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/gameshop.js"></script>
<title>GameShop</title>
<title>瀏覽 ${productName}主頁面</title>

<style type="text/css">
body{
	font-family:Microsoft JhengHei;
	background:url(img/shopbg.jpg) no-repeat;
	background-attachment: fixed;
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
    <!-- login form -->
	<div class="loginDiv">
		<div class="loginForm">
			<fieldset>
				<legend>登入帳號 </legend>
				<div class="warning"><img src="img/Info_icon.png" title="需擁有帳號，方能使用願望清單與評論功能" style="vertical-align:middle">公用電腦請記得登出，或開啟無痕模式</div><br/>
				<form action="processLogin" method="POST">

					<label for="userAccount">帳號:</label><input type="text" id="loginAccount" name="userAccount" value="${userAccount}"><br/>
					<label for="userPwd">密碼:</label><input type="password" id="loginPwd" name="userPwd" value="${userPwd}"><br/>
					<input type="checkbox" name="autoLogin" id="autoLogin" ${autoLogin}><span>記住我</span><br/>
					
					<br/>
				</form>
				<button class="loginconfirm">登入</button>
					<input type="button" class="cancel_btn" value="取消"><br/>
				   <!-- 登入頁加入新申請帳號 -->
					<input type="button" class="registerbutton" id="register2" value="申請新帳號">
					<p><a href="forget_password">忘記密碼?</a></p>
			</fieldset>
		</div>
		
	</div>
<!--Wishlist & Shopping cart &top-->
        <a href="showWish.controller"><input type="button" class="wishlist" title="願望清單"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart" title="購物車"></a>
		<a href="#"><input type="button" class="topbutton"></a>

 <!--Main-->
	<div class="bgshop" style="height:200%">
	
	<table class="showProduct">
    <tr>
        <td colspan="2">
            <H1>${productName}</H1>
        </td>
    </tr>
    <!--#2 Product Introduction-->
	<tr>
		<td><img src="${pageContext.servletContext.contextPath}/productImage?gamename=${productName}" width="460px"/></td>
    	<td class="showProductIntro">遊戲簡介:<br/>
        ${intro}<br/><br/>
		<span style="color:bisque">價錢：$${price}</span><br/><br/>
		分類：${tag}<br/></td>
    </tr>
    <!--#3 BUY & WISH button-->
    <tr>
    	<td><input type="button" class="buythis" value="加入購物車"></td>
    	<td><input type="button" class="wishthis" value="加入願望清單"></td>
    </tr>

    <!--#4 Create Comment-->
    <tr>
    	<td><H1>建立遊戲評論</H1>
    	<p class="commentRule">
    	請描述這款遊戲您喜歡或不喜歡的地方，<br/>
    	以及您是否會將該款遊戲推薦給其他人。<br/>
		※請保持禮貌並尊重他人言論<br/>
		</p>
    	</td>
    	<td>
    	<%@include file="commentList.jsp" %>
    	</td>
    </tr>
    <!--#5&6 Show All Comment-->
    <tr>
    	<td colspan="2"><H1>所有評論</H1>
    </tr>
    <tr>
    	<td colspan="2">
    	<%@include file="showComment.jsp" %>
   		</td>
    </tr>
    
    <tr>
    	<td colspan="2">
    	<p><a href="Shop"><input type="button" class="morebutton" value="回到商店"></a></p>
	</tr>
	
</table>

</div>

 <!--footer-->
    <footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 GameGuild Production</H2>
            <H6>All copyrights and trademarks are the property of their respective owners.</H6>
        </div>
    </footer>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
//新增評論

window.onload = function(){

	var productid = ${productId};
	var comId = "";
	
	$.ajax({
		url:"searchCom2?id="+productid,
		type:"Post",
		dataType:"json",
		success:function(data){
			
			var empty ="";
			var i;
			var edit = "";
			var t1 = "</tr>";

			if (data.length!=0){
				for(i=0; i<data.length; i++){

				var neoTime = data[i].postDatetime.slice(0,-2);

				var row = "<tr><td class='useridtag'>"+data[i].nickName+"</td><td class='com' id='newcom'>"+data[i].comment+"</td><td>"
				+neoTime+"</td><td class='comId' hidden>" + data[i].comId +"</td>";

				if(data[i].userId==${userId}){
					edit = "<td><input type='button' id='updateCom' value='編輯'>  <input type='button' id='deleteCom' value='刪除'></td>";
					row += edit;
				}else{
					edit = "<td></td>"; 
					row += edit;
					}
				empty+=row+t1;
			}
				$("#t5").html(empty);

			// 更新評論按鈕

				$("input#updateCom").click(function(){
					var preCom = $(this).parent().siblings("td.com").html();
					var comId = $(this).parent().siblings("td.comId").html();
					
					$("#editCom").show();	
					$("#editword").html(preCom);
					$("input[name='showComId']").val(comId);

					$('html,body').animate({scrollTop:$('.useridtag').offset().top}, 200);
				})

				$("#submit_reply").click(function(){
					var yes = confirm("確認編輯評論?");
						
					if (yes){
			    	$("#editCom").hide();
			    	alert("已修改評論");
			    	
				}else{
					alert("已取消");
			     	location.href="";
					}
				})
				
				$("#submit_cancel").click(function(){
					location.href="";
				})

			// 修改評論
			
				$("#idForm").submit(function() {

				var form = $(this);

    				$.ajax({
           				type: "post",
           				url: "updateComment",
           				data: form.serialize(), 
           				success: function(data){      				
           				location.reload();	
			           }
			         });
			});

		   // 刪除評論

				 $("input#deleteCom").click(function(){

					var yes= confirm("確認刪除該評論？");
					var comId = $(this).parent().siblings("td.comId").html();

					console.log(comId);
					
					if (yes){
						$.ajax({
							type: "get",
							url: "deleteCom?id="+comId,
							success: function(data){  
								alert("評論已刪除！");    				
	           					location.reload();	
				        }
			})
				}else{
			     	location.href="";
				}
		})
				   
		}else{
			$("#t5").html("");
			}
		}
	})
}
	//buy button 接起來
	$(".buythis").click(function(){
		console.log("buy");
			var id = ${productId};
			var name = "${productName}";
			console.log("add product");
			$.ajax({
				url:"add.controller?id=" + id,
				type:"get",
				success:function(data){
					console.log("add product: "+data);
					if(data=="ok"){
			            window.alert(name+"加入購物車");
						}else{
			            window.alert(name+"已加入購物車");
							}
				}
				})
			
		})
		//wish button 接起來
		$(".wishthis").click(function(){
					console.log("add wish");
					var id1 = ${productId};
					var name1 = "${productName}";
					console.log("id1="+id1);
					$.ajax({
						url:"addWish.controller?id=" + id1,
						type:"get",
						success:function(data){
							if(data=="ok"){
				                window.alert(name1+"加入願望清單");
								}else if(data=="a"){
								window.alert(name1+"此遊戲已購買");
								}else{
			                    window.alert(name1+"已加入願望清單");
							         }
				              }
						})
					})
</script>
</body>
</html>