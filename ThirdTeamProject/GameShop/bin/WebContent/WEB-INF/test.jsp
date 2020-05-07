<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <style>
        table{
            border: 2px solid;
        }

    </style>

</head>
<body>
    <table id="table">
        <tr><td>遊戲名稱</td><td>評論</td><td>日期</td><td>回覆</td><td>回覆日期</td></tr>
    </table>
    <div class="msg"></div>
    <script>
        var totalList = 0;
        $(document).ready(function(){
            $.ajax({
                url: "http://localhost:8080/GameShop/bmscomment",
                type: "GET",
                dataType:"json",
                success: function(data){
                    totalList = data.length;
                    for(let i=0; i<data.length; i++){
                        $("#table").append('<tr><td>' + data[i].productId + '</td><td>'+ data[i].comment +'</td><td>' + data[i].postDatetime +'</td><td>' + data[i].reply + '<input id="reply' + i + '" type="text" name="reply"></input><input id="comId' + i +'" type="text" name="comId" hidden="hidden" value="'+ data[i].comId +'"></input><button id="btn'+ i +'">回覆</button></td><td>'+ data[i].replyDatetime +'</td></tr>');
                    }
                },error: function(){
                	console.log("連線失敗");
                }
            }).done(function(){
                for(let i=0; i<totalList; i++){
                    $("#btn"+i).click(function(){
                        console.log("comId:"+$("#comId"+i).val());
                        $.ajax({
                            url: "http://localhost:8080/GameShop/reply",
                            type: "GET",
                            dataType:"json",
                            data:{comId : $("#comId"+i).val(),
                                    reply : $("#reply"+i).val()},
                            success: function(data){
                                if(data){
                                    alert("success");
                                }else{
                                    alert("fail");
                                }
                            },error: function(){
                	            console.log("連線失敗");
                            }
                        })
                    })
                }
            })
        })

    </script>
</body>
</html>