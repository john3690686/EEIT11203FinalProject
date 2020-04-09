<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[DEBUG用] Session Attribute Changer</title>
</head>
<body>
<form action="createSession" method="get">
<input type="text" name="debugName" required="required" default="Cat">
<input type="submit" value="Create Session!!">
</form>
<input type="button" value="Destroy Session!!" onclick="destroySession();">

<script type="text/javascript">
	function destroySession() {
		window.location.href= "destroySession";
	}
</script>
</body>
</html>