<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Back-Manager-System_HomePage</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link rel="stylesheet" href="css/BmsHomePage.css">
<style type="text/css">

	table tr {
		line-height: 70px;
		height: 70px;
	}

	input[type=submit], input[type=reset], input[type=button] {
		margin:0 0.325em;
	}
	
	input[type=text], input[type=password] {
		margin: 0;
		margin-bottom: 15px;
		height: 33px;
		width: 240px;
	}
	
	.login {
		font-size: 20pt;
	    background-color: rgb(172, 214, 255, 0.4);
		width: 400px;
		margin: 0 auto;
	}
	.response {
		height: 52px;
		max-height: 30px; 
	}

	.errMsg {
		text-align: center;
		height: 52px;
		font-style: italic;	
		color: red;
		font-size: 16px;
	}
	
	.login tr:nth-child(1) td:nth-child(1), .login tr:nth-child(2) td:nth-child(1){
		text-align:justify;
		text-justify:distribute-all-lines;
		text-align-last:justify;
		width: 150px;	
	}
	
	.login td:nth-child(2) {
		text-align: center;
		width: 320px;	
	}
	
	.loginBtn {
		text-align: center !important;
	}
	
	.button {
		background-color: rgb(70, 163, 255, 0.4);
		font-size: 16pt;
		width: 120px;
		margin: 0;
		padding: 0;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("input[type=button]#quick").on("click", function() {
			$("#bmsAcc").val("mGgM2e1E1i2t")
			$("#bmsPwd").val("P@ssW0rd")
		})
	})
</script>
</head>
<body>
	 <div class="bms">
	 
        <div class="header">
            <h1>GameGuild's 後臺管理系統</h1>
        </div>
        
		<div class="login">
			<form action="bmsLoginPage" method="post">
			<fieldset >
				<legend>GameGuild's 後台登入系統</legend>
				<table>
					<tr>
						<td>
							<label for="bmsAcc">帳號</label>
						</td>
						<td>
							<input type="text" id="bmsAcc" name="bmsAcc" placeholder="請輸入帳號">
						</td>
					</tr>
					<tr>
						<td>
							<label for="bmsPwd">密碼</label>
						</td>
						<td>
							<input type="password" id="bmsPwd" name="bmsPwd" placeholder="請輸入密碼">
						</td>
					</tr><tr class="response">
						<td class="errMsg" colspan="2">
							${errMsg.errMsg}
						</td>
					</tr><tr>
						<td colspan="2" class="loginBtn">
							<input type="submit" class="button" value="登入">
							<input type="reset" class="button" value="重新輸入">
						</td>
					</tr><tr>
						<td colspan="2" class="loginBtn">
							<input type="button" class="button" value="一鍵輸入" id="quick">
							<input type="button" class="button" value="客戶端" onClick="javascript:location.href='index.html'">
						</td>	
					</tr>
				</table>
			</fieldset>
			</form>
			
		</div>
	</div>
	
</body>
</html>