<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/style.css">
<title>GameShop</title>

<style type="text/css">

*{
font-family:微軟正黑體;
}
</style>
</head>

<body>

 <!--Navigator-->
     <nav>
        <ul class="ul1">
        <li><a href="index.html">HOME</a>
        <li><a href="#">NEWS</a>
        <li><a href="Shop">SHOP</a>
        <li><a href="#">BLOG</a>
        <li><a href="#">CHAT</a>
        <a href="#"><input type="button" class="loginz" value="LOGIN"></a>
        </ul>
    </nav>
    
 <!--Wishlist & Shopping cart-->
        <a href="showWish.controller"><input type="button" class="wishlist"></a>
        <a href="prePay.controller"><input type="button" class="shoppingcart"></a>

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
    	<td><input type="button" class="buythis" value="BUY"></td>
    	<td><input type="button" class="wishthis" value="WISH"></td>
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

</table>

</div>

 <!--footer-->
    <footer>
        <div class="foot">
            <H2>©COPYRIGHT 2020 EEIT112 Team3</H2>
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
				var row = "<tr><td>"+data[i].nickName+"</td><td class='com' id='newcom'>"+data[i].comment+"</td><td>"
				+data[i].postDatetime+"</td><td class='comId' hidden>" + data[i].comId +"</td>";
				if(data[i].userId==${userId}){
					edit = "<td><input type='button' id='updateCom' value='編輯'><input type='button' id='deleteCom' value='刪除'></td>";
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
			window.alert(name+"加入購物車");
			$.ajax({
				url:"add.controller?id=" + id,
				type:"get",
				success:function(data){
					console.log("add product: "+data);
					}
				})
			
		})
		//wish button 接起來
		$(".wishthis").click(function(){
					console.log("add wish");
					var id1 = ${productId};
					var name1 = "${productName}";
					console.log("id1="+id1);
					window.alert(name1+"加入願望清單");
					$.ajax({
						url:"addWish.controller?id=" + id1,
						type:"get",
						success:function(data){
							console.log("add wish: "+data);
							}
						})
					})
</script>
</body>
</html>