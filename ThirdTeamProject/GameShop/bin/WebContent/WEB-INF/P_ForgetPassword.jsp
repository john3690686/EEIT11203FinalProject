<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget Password</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<style>
    *{
        margin: 0;
        padding: 0;
    }
    body{
        background-image: url("img/skytower.jpg");
        background-repeat:no-repeat;
        background-size:cover;
        text-align: center;
    }
    #mailForm{
        width: 800px;
        margin: auto;
        margin-top: 30px;
        background-color: rgba(79, 221, 240, 0.651);
        border-radius: 10px;
        text-align: center;
        font-size: 30px;
    }
    label{
        display: inline-block;
        line-height: 40px;
        width: 90px;
        text-align: right;
    }
    input{
        font-size: 30px;
    }
    button{
        font-size: 30px;
    }
</style>

</head>
<body>
<h1>忘記密碼</h1>
<h3>請填入註冊E-mail，密碼將以信件方式寄送到信箱中</h3>
<form id="mailForm" action="forget_password/sendMail" method="get">
<label>E-mail:</label><input type="text" id="mail" name="mail">
</form>
<button id="send">送出</button>
<script type="text/javascript">
$("#send").click(function(){
    $.ajax({
        url:"http://localhost:8080/GameShop/isMailExist",
        data:{mail:$("#mail").val()},
        dataType: "json",
        success:function(data){
            if(data){
                $("#mailForm").submit();
                alert("信件已寄出");
                location = "http://localhost:8080/GameShop/index.html";
            }else{
                alert("查無此信箱");
            }
        }
    })
})
</script>
</body>
</html>