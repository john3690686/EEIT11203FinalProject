<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</head>

<body>
	<fieldset>
		<legend>Profile Detail</legend>
		<form action="processProfile" method="POST" enctype="multipart/form-data">
			<img style="cursor: pointer;" class="imgUserPhoto" src="img/coda.jpg" alt="" width="200px"
				height="200px"><input class="inputUserPhoto" type="file" name="userImg" hidden="hidden"><br />
			<label>Required</label><br /> <label for="userAccount">Account:</label><input type="text" id="userAccount"
				name="userAccount" readonly="readonly"><br /> <label for="userName">Name:</label><input type="text" id="userName"
				name="userName"><br /> <label for="nickName">Nick
				Name:</label><input type="text" id="nickName" name="nickName"><br />
			<label for="userPwd">Password:</label><input type="password" id="userPwd" name="userPwd"><br /> <label
				for="checkPwd">Password:</label><input type="password" id="checkPwd" name="checkPwd"
				placeholder="Re-enter Password"><br /> <label for="mail">E-mail:</label><input type="text" id="mail"
				name="mail"><br />
			<hr>
			<label>Detail</label><br /> <label>Gender:</label> <input type="radio" class="gender" name="gender"
				value="m" checked="checked"><label class="gender">male</label> <input type="radio" class="gender"
				name="gender" value="f"><label class="gender">female</label> <input type="radio" class="gender"
				name="gender" value="o"><label class="gender">other</label><br />
			<label for="birthday">Birthday:</label><input type="text" id="birthday" name="birthday"><br /> <label
				for="address">Address:</label><input type="text" id="address" name="address"><br /> <label
				for="phone">Phone:</label><input type="text" id="phone" name="phone"><br />
			<button class="registerconfirm">Confirm</button>
			<input class="cancel_btn" type="button" value="Cancel">
		</form>
		<button class="fill">fill</button>
	</fieldset>
	<button class="getdata">ajax</button>
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
		$(".getdata").click(function () {
			$.ajax({
				url: "http://localhost:8080/GameShop/modify",
				type: "GeT",
				dataType: "json",
				success: function (data) {
					$("#userId").val(data.userId);
					$("#userAccount").val(data.userAccount);
					$("#userName").val(data.userName);
					$("#nickName").val(data.nickName);
					$("#mail").val(data.mail);
					$(".imgUserPhoto").attr("src", "data:image/jpeg;base64," + data.userImg);
				}
			})
		})

		$(".cancel_btn").click(function(){
			location.replace("index.html")
		})

	</script>
</body>

</html>