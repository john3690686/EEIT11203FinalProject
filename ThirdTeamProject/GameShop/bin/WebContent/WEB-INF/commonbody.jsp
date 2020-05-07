<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>

	<h1>TEST</h1>
	<!-- login form -->
	<div class="loginDiv">
		<div class="loginForm">
			<fieldset>
				<legend>Login Form</legend>
				<form action="processLogin" method="POST">
					<label for="userAccount">User Account:</label><input
						id="loginAccount" type="text" name="userAccount"
						value="${userAccount}"><br /> <label for="userPwd">Password:</label><input
						id="loginPwd" type="password" name="userPwd" value="${userPwd}"><br />
					<input type="checkbox" name="autoLogin" id="autoLogin" ${autoLogin}><span>記住我</span><br />
				</form>
				<button class="loginconfirm">Confirm</button>
				<input type="reset" class="cancel_btn" value="Cancel">
				<div>
					<span id="loginMsg"></span>
				</div>
			</fieldset>
		</div>

	</div>
	<!-- register form -->
	<div class="registerDiv">
		<div class="registerForm">
			<fieldset>
				<legend>Register Form</legend>
				<form action="register" method="POST" enctype="multipart/form-data">
					<img style="cursor: pointer;" class="imgUserPhoto"
						src="img/coda.jpg" alt="" width="200px" height="200px"><input
						class="inputUserPhoto" type="file" name="userImg" hidden="hidden"><br />

					<label>Required</label><br /> <label for="userAccount">Account:</label><input
						type="text" id="userAccount" name="userAccount">
					<div class="check" id="checkAccount">
						<img src="">
					</div>
					<br /> <span class="note">(請輸入6~18英數字元)</span><br /> <label
						for="userName">Name:</label><input type="text" id="userName"
						name="userName">
					<div class="check">
						<img src="">
					</div>
					<br /> <label for="nickName">Nick Name:</label><input type="text"
						id="nickName" name="nickName">
					<div class="check" id="checkNickName">
						<img src="">
					</div>
					<br /> <label for="userPwd">Password:</label><input
						type="password" id="userPwd" name="userPwd">
					<div class="check" id="checkPwd">
						<img src="">
					</div>
					<br /> <span class="note">(請輸入一組包含大小寫及數字的6~12位密碼)</span><br /> <label
						for="recheckPwd">Password:</label><input type="password"
						id="recheckPwd" name="recheckPwd" placeholder="Re-Enter Password">
					<div class="check" id="recheckPwd">
						<img src="">
					</div>
					<br /> <label for="mail">E-mail:</label><input type="text"
						id="mail" name="mail">
					<div class="check" id="checkMail">
						<img src="">
					</div>
					<br />
					<hr>
					<label>Detail</label><br /> <label>Gender:</label> <input
						type="radio" class="gender" name="gender" value="m"
						checked="checked"><label class="gender">male</label> <input
						type="radio" class="gender" name="gender" value="f"><label
						class="gender">female</label> <input type="radio" class="gender"
						name="gender" value="o"><label class="gender">other</label><br />

					<label for="birthday">Birthday:</label><input type="text"
						id="birthday" name="birthday"><br /> <label for="address">Address:</label><input
						type="text" id="address" name="address"><br /> <label
						for="phone">Phone:</label><input type="text" id="phone"
						name="phone"><br />
				</form>
				<button class="registerconfirm">Confirm</button>
				<input class="cancel_btn" type="button" value="Cancel">
				<button class="fill">fill</button>
			</fieldset>
		</div>
	</div>
	<script>
		//Login & Register Form

		//User Photo
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$(".imgUserPhoto").attr("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$(".inputUserPhoto").change(function() {
			readURL(this);
		});
		$(".imgUserPhoto").click(function() {
			$(".inputUserPhoto").click();
		});

		//login form
		$(".loginbutton").click(function() {
			$(".loginDiv").css({
				"position" : "absolute",
				"display" : "flex",
				"z-index" : "99999",
				"top" : $(document).scrollTop() + "px",
				"height" : "100vh",
				"width" : "100vw",
				"align-items" : "center"
			});
			$("html").css("overflow", "hidden");
		})

		//register form
		$(".registerbutton").click(function() {
			$(".registerDiv").css({
				"position" : "absolute",
				"display" : "flex",
				"z-index" : "99999",
				"top" : $(document).scrollTop() + "px",
				"height" : "100vh",
				"width" : "100vw",
				"align-items" : "center"
			});
			$("html").css("overflow", "hidden");
		})

		//auto filled
		$(".fill").click(function() {
			$("#userAccount").val("account");
			$("#userName").val("Jimmy");
			$("#nickName").val("jim");
			$("#userPwd").val("Passw0rd");
			$("#recheckPwd").val("Passw0rd");
			$("#mail").val("j.t.hung1988@gmail.com");
			$("#birthday").val("2020/03/03");
			$("#address").val("addr");
			$("#phone").val("0987141242");
			errorAcc = 0;
			errorNickName = 0;
			errorPwd = 0;
			errorMail = 0;
		})

		//check data right
		var regUserAccount = new RegExp(/^[a-zA-Z0-9]{6,18}$/);
		var regUserPwd = new RegExp(
				/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z\d].{6,12}$/);
		var regMail = new RegExp(
				/\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+/);
		var errorAcc = 1, errorNickName = 1, errorPwd = 1, errorMail = 1;

		$("#userAccount").blur(function() {
			$("#checkAccount img").css("visibility", "visible");
			if (regUserAccount.test($(this).val())) {
				$("#checkAccount img").attr("src", "img/Right.png");
				errorAcc = 0;
			} else {
				$("#checkAccount img").attr("src", "img/Wrong.png");
				errorAcc = 1;
			}
		});
		$("#nickName").blur(function() {
			$("#checkNickName img").css("visibility", "visible");
			if ($(this).val().trim().length > 0) {
				$("#checkNickName img").attr("src", "img/Right.png");
				errorNickName = 0;
			} else {
				$("#checkNickName img").attr("src", "img/Wrong.png");
				errorNickName = 1;
			}
		});
		$("#userPwd").blur(function() {
			$("#checkPwd img").css("visibility", "visible");
			if (regUserPwd.test($(this).val())) {
				$("#checkPwd img").attr("src", "img/Right.png");
				errorPwd = 0;
			} else {
				$("#checkPwd img").attr("src", "img/Wrong.png");
				errorPwd = 1;
			}
		});
		$("#recheckPwd").blur(
				function() {
					$("#recheckPwd img").css("visibility", "visible");
					if ($(this).val().length > 0
							&& $(this).val() == $("#userPwd").val()) {
						$("#recheckPwd img").attr("src", "img/Right.png");
					} else {
						$("#recheckPwd img").attr("src", "img/Wrong.png");
					}
				});
		$("#mail").blur(function() {
			$("#checkMail img").css("visibility", "visible");
			if (regMail.test($(this).val())) {
				$("#checkMail img").attr("src", "img/Right.png");
				errorMail = 0;
			} else {
				$("#checkMail img").attr("src", "img/Wrong.png");
				errorMail = 1;
			}
		});

		//confirm
		$(".registerconfirm").click(
				function() {
					if (errorAcc == 0 && errorNickName == 0 && errorPwd == 0
							&& errorMail == 0) {
						$(".registerForm form").submit();
					} else {
						alert("資料格式不對唷!請再確認一次!");
					}
				})

		$(".loginconfirm").click(function() {
			console.log("userAccount:" + $("#loginAccount").val());
			console.log("userPwd:" + $("#loginPwd").val());
			$.ajax({
				url : "http://localhost:8080/GameShop/checkProfile",
				type : "POST",
				data : {
					userAccount : $("#loginAccount").val(),
					userPwd : $("#loginPwd").val(),
				},
				dataType : "json",
				cache : false,
				success : function(data) {
					console.log(data);
					if (data) {
						$(".loginForm form").submit();
					} else {
						$("#loginMsg").text("登入失敗，請檢查帳號密碼!")
					}
				},
				error : function() {
					$("#loginMsg").text("登入失敗，請檢查帳號密碼!")
				}
			})
		})

		//Rightup Login Button
		$(document).ready(
				function() {
					$("#titleMessage").animate({
						opacity : "0"
					}, 4000, function() {
						$("#titleMessage").hide()
					});
					//if login
					if ($(".loginz").val() == "Logout") {
						$(".loginz").parent().attr("href",
								"http://localhost:8080/GameShop/logout/");
						$(".login").css("visibility", "hidden");
						$("#hello").show();
					} else { //if guest
						$("#hello").hide();
						$(".login").css("visibility", "visible")
						$(".loginz").parent().removeAttr("href");
						$(".loginz").click(function() {
							$(".loginDiv").css({
								"position" : "absolute",
								"display" : "flex",
								"z-index" : "99999",
								"top" : $(document).scrollTop() + "px",
								"height" : "100vh",
								"width" : "100vw",
								"align-items" : "center"
							})
							$("html").css("overflow", "hidden");
						})
					}
				})

		//cancel form
		var cancelbtn = function() {
			$(".loginDiv").css("display", "none");
			$(".registerDiv").css("display", "none");
			$("html").css("overflow", "initial");
		}
		$(".cancel_btn").click(cancelbtn);

		var loginMousePosition = false;
		$(".loginDiv, .registerDiv").mouseover(function(e) {
			loginMousePosition = $(".loginDiv, .registerDiv").is(e.target);
		})
		$(".loginDiv, .registerDiv").click(function(e) {
			if (loginMousePosition) {
				cancelbtn();
			}
		})
	</script>
