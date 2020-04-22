<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Comment</title>
</head>
<body>
<!-- Edit Area -->
<table id="editCom" hidden>
	<tr>
		<td colspan="4">
<!--	<form class="form_reply" action="updateComment" method="post">-->
		<form class="form_reply" id="idForm" method="POST">
			<H3>編輯評論</H3>
              <textarea name="comments" id="editword" cols="50" rows="5"></textarea>
              <input type="text" name="showComId" hidden>
              <input type="submit" id="submit_reply" value="送出">
              <input type="button" id="submit_cancel" value="取消">
        </form>	
		</td>
	</tr>
</table>

<!-- Show All Comment -->
<table id="t5">
</table>
</body>
</html>