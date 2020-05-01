<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<style>
		*{
			margin: 0;
			padding: 0;
			font-size: 20px;
		}
		body{
			background-image: url("img/skytower.jpg");
			background-repeat:no-repeat;
			background-size:cover;
		}
		#profileForm{
			width: 800px;
			margin: auto;
			background-color: rgba(79, 221, 240, 0.651);
		}
		fieldset{
			border-radius: 10px;
			text-align: center;
			
		}
		.message{
			font-size: 20px;
			font-weight: bold;
			margin: auto;
			text-align: center;
		}
		label{
			display: inline-block;
			line-height: 20px;
			width: 90px;
			text-align: right;
		}
		.gender{
			width: auto;
		}
		.check{
			display: inline-block;
			visibility: hidden;
		}
		.check img{
			width: 20px;
		}
	</style>
</head>

<body>
	<div id="profileForm">
	<fieldset>
		<legend>會員資料</legend>
		<form action="#" method="POST" enctype="multipart/form-data">
			<img style="cursor: pointer;" class="imgUserPhoto" src="" alt="" width="200px" height="200px">
			<input class="inputUserPhoto" type="file" name="userImg" hidden="hidden"><br />
			<label>主要部分</label><br /> 
			<label for="userAccount">帳號:</label><input type="text" id="userAccount" name="userAccount" readonly="readonly"><br /> 
			<label for="userName">姓名:</label><input type="text" id="userName" name="userName">
            <div class="check"><img src=""></div><br />

            <label for="nickName">暱稱:</label><input type="text" id="nickName" name="nickName">
            <div class="check" id="checkNickName"><img src=""></div><br />
            <label for="oriPwd">原密碼:</label><input type="password" id="oriPwd" name="oriPwd">
            <div class="check" id="checkOriPwd"><img src=""></div><br />
			<span class="note">請輸入原密碼</span><br />
			
            <label for="userPwd">新密碼:</label><input type="password" id="userPwd" name="userPwd">
            <div class="check" id="checkPwd"><img src=""></div><br />
            <span class="note">(不改密碼可不填)</span><br />

            <label for="recheckPwd">新密碼:</label><input type="password" id="recheckPwd" name="recheckPwd"
                            placeholder="Re-Enter Password">
            <div class="check" id="recheckPwd"><img src=""></div><br />

            <label for="mail">E-mail:</label><input type="text" id="mail" name="mail">
            <div class="check" id="checkMail"><img src=""></div><br />
			<hr>
			<label>次要部分</label><br />
			<label>性別:</label>
			<input type="radio" class="gender" name="gender" value="m" checked="checked"><label
				class="gender">男生</label>
			<input type="radio" class="gender" name="gender" value="f"><label class="gender">女生</label>
			<input type="radio" class="gender" name="gender" value="o"><label
				class="gender">其他</label><br />

			<label for="birthday">生日:</label><input type="text" id="birthday" name="birthday"><br />

			<label for="address">地址:</label><input type="text" id="address" name="address"><br />

			<label for="phone">電話:</label><input type="text" id="phone" name="phone"><br />
			<button class="registerconfirm">確認</button><input class="cancel_btn" type="button" value="取消">
		</form>
	</fieldset>
</div>
	<div class="message"></div>
	<script>
		//user image <input>
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$(".imgUserPhoto").attr("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$(".inputUserPhoto").change(function () {
			readURL(this);
		});
		$(".imgUserPhoto").click(function () {
			$(".inputUserPhoto").click();
		});

		//get data
		function queryProfile(){
			$.ajax({
				url: "http://localhost:8080/GameShop/serchProfile",
				type: "POST",
				dataType: "json",
				success: function (data) {
					$("#userAccount").val(data.userAccount);
					$("#userName").val(data.userName);
					$("#nickName").val(data.nickName);
					$("#mail").val(data.mail);
					$("#birthday").val(data.birthday);
					$("#address").val(data.address);
					$("#phone").val(data.phone);
					if (data.userImg == null || data.userImg == 0) {  
						$(".imgUserPhoto").attr("src", "img/defaultUserImg.jpg");
					} else {
						$(".imgUserPhoto").attr("src", "data:image/jpeg;base64," + data.userImg);
					}

				}
			})
		}

		$(document).ready(function () {
			queryProfile();
		})

		//check data right
        var regUserAccount = new RegExp(/^[a-zA-Z0-9]{6,18}$/);
        var regUserPwd = new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z\d].{6,12}$/);
        var regMail = new RegExp(/\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+/);
        var errorOriPwd = 1, errorNickName =1, errorPwd = 0, errorMail = 1;


        $("#oriPwd").blur(function(){
            $("#checkOriPwd img").css("visibility","visible");
            if(regUserAccount.test($(this).val())){
                $("#checkOriPwd img").attr("src","img/Right.png");
                errorOriPwd = 0;
            }else{
                $("#checkOriPwd img").attr("src","img/Wrong.png");
                errorOriPwd = 1;
            }
        });
        $("#nickName").blur(function(){
            $("#checkNickName img").css("visibility","visible");
            if($(this).val().trim().length>0){
                $("#checkNickName img").attr("src","img/Right.png");
                errorNickName = 0;
            }else{
                $("#checkNickName img").attr("src","img/Wrong.png");
                errorNickName = 1;
            }
        });
        $("#userPwd").blur(function(){
            $("#checkPwd img").css("visibility","visible");
            if(regUserPwd.test($(this).val()) || $(this).val() == ""){
                $("#checkPwd img").attr("src","img/Right.png");
                errorPwd = 0;
            }else{
                $("#checkPwd img").attr("src","img/Wrong.png");
                errorPwd = 1;
            }
        });
        $("#recheckPwd").blur(function(){
            $("#recheckPwd img").css("visibility","visible");
            if($(this).val() == $("#userPwd").val()){
                $("#recheckPwd img").attr("src","img/Right.png");
            }else{
                $("#recheckPwd img").attr("src","img/Wrong.png");
            }
        });
        $("#mail").blur(function(){
            $("#checkMail img").css("visibility","visible");
            if(regMail.test($(this).val())){
                $("#checkMail img").attr("src","img/Right.png");
                errorMail = 0;
            }else{
                $("#checkMail img").attr("src","img/Wrong.png");
                errorMail = 1;
            }
        });


		$(".registerconfirm").click(function (e) {
				if (errorOriPwd == 0 && errorNickName == 0, errorPwd == 0 && errorMail == 0) {
					e.preventDefault();
					var form = $('form')[0];
					var formData = new FormData(form);
					$.ajax({
						url: "http://localhost:8080/GameShop/modifyProfile",
						type: "POST",
						data: formData,
						contentType: false,
						cache: false,
						processData: false,
						success: function (data) {
							if (data.length == 0 || data === "undefined" || data == null) {
								$(".message").text("資料不正確，修改失敗").css("color", "red");
							} else {
								console.log(data)
								$(".message").text("修改成功").css("color", "green");
							}
						}
						, done: function (data) {
							queryProfile();
						}
						, error: function (data) {
							$(".message").text("連線失敗，修改失敗").css("color", "red")
							console.log('無法送出');
						}

					})
				}

			})

			$(".cancel_btn").click(function () {
				location.replace("index.html")
			})

	</script>
</body>

</html>