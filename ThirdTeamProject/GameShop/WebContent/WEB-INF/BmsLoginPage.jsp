<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<style type="text/css">
	input[type=submit], input[type=reset], input[type=button] {
		margin:0 0.325em;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("input[type=button]").on("click", function() {
			$("#bmsAcc").val("mGgM2e1E1i2t")
			$("#bmsPwd").val("P@ssW0rd")
		})
	})
</script>
</head>
<body>
	<div>
		<div>
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
					</tr><tr>
						<td colspan="2">
							${errMsg.errMsg}
						</td>
					</tr><tr>
						<td colspan="2">
							<input type="submit" value="登入">
							<input type="reset" value="重新輸入">
							<input type="button" value="一鍵輸入">
						</td>
					</tr>
				</table>
			</fieldset>
			</form>
			
		</div>
	</div>
	
	<script type="text/javascript">
		
	</script>
</body>
</html>