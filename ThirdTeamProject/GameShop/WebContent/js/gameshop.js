$(document).ready(function () {
    //nav
    $("#navShop").click(function(){
        if($(".loginz").val() == "Login"){
            alert("請先登入");
        }
    });

    //Login & Register Form

    //User Photo
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

    //login form
    $(".loginbutton").click(function () {
        $(".loginDiv").css({
            "position": "absolute",
            "display": "flex",
            "z-index": "99999",
            "top": $(document).scrollTop() + "px",
            "height": "100vh",
            "width": "100vw",
            "align-items": "center"
        });
        $("html").css("overflow", "hidden");
    })

    //register form
    $(".registerbutton").click(function () {
        $(".registerDiv").css({
            "position": "absolute",
            "display": "flex",
            "z-index": "99999",
            "top": $(document).scrollTop() + "px",
            "height": "100vh",
            "width": "100vw",
            "align-items": "center"
        });
        $("html").css("overflow", "hidden");
    })

    //auto filled
    $(".fill").click(function () {
        $("#userAccount").val("account");
        $("#userName").val("Jimmy");
        $("#nickName").val("jim");
        $("#userPwd").val("Passw0rd");
        $("#recheckPwd").val("Passw0rd");
        $("#mail").val("j.t.hung1988@gmail.com");
        $("#birthday").val("2020/03/03");
        $("#address").val("addr");
        $("#phone").val("0987141242");
        errorAcc = 0; errorNickName = 0; errorPwd = 0; errorMail = 0;
    })

    //check data right
    var regUserAccount = new RegExp(/^[a-zA-Z0-9]{6,18}$/);
    var regUserPwd = new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z\d].{6,12}$/);
    var regMail = new RegExp(/\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+/);
    var errorAcc = 1, errorNickName = 1, errorPwd = 1, errorMail = 1;


    $("#userAccount").blur(function () {
        let ajaxFlag = true;
        $("#checkAccount img").css("visibility", "visible");
        if (regUserAccount.test($(this).val()) && ajaxFlag) {
            ajaxFlag = false;
            console.log("thisvalue = " + $(this).val());
            $.ajax({
                url: "http://localhost:8080/GameShop/isAccountExist",
                type: "GET",
                data : {"userAccount":$(this).val()},
                dataType:"json",
                success: function(data){
                    console.log(data);
                    if(data){
                        alert("此帳號已存在");
                        $("#checkAccount img").attr("src", "img/Wrong.png");
                        errorAcc = 1;
                    }else{
                        $("#checkAccount img").attr("src", "img/Right.png");
                        errorAcc = 0;
                    }
                },error: function(){
                    console.log("連線失敗");
                }
            }).done(ajaxFlag = true);
            
        } else {
            $("#checkAccount img").attr("src", "img/Wrong.png");
            errorAcc = 1;
        }
    });
    $("#nickName").blur(function () {
        let ajaxFlag = true;
        $("#checkNickName img").css("visibility", "visible");
        if (ajaxFlag && $(this).val().length>0) {
            ajaxFlag = false;
            console.log("thisvalue = " + $(this).val());
            $.ajax({
                url: "http://localhost:8080/GameShop/isNickNameExist",
                type: "GET",
                data : {"nickName":$(this).val()},
                dataType:"json",
                success: function(data){
                    console.log(data);
                    if(data){
                        alert("此暱稱已存在");
                        $("#checkNickName img").attr("src", "img/Wrong.png");
                        errorAcc = 1;
                    }else{
                        $("#checkNickName img").attr("src", "img/Right.png");
                        errorAcc = 0;
                    }
                },error: function(){
                    console.log("連線失敗");
                }
            }).done(ajaxFlag = true);
        } else {
            $("#checkNickName img").attr("src", "img/Wrong.png");
            errorNickName = 1;
        }
    });
    $("#userPwd").blur(function () {
        $("#checkPwd img").css("visibility", "visible");
        if (regUserPwd.test($(this).val())) {
            $("#checkPwd img").attr("src", "img/Right.png");
            errorPwd = 0;
        } else {
            $("#checkPwd img").attr("src", "img/Wrong.png");
            errorPwd = 1;
        }
    });
    $("#recheckPwd").blur(function () {
        $("#recheckPwd img").css("visibility", "visible");
        if ($(this).val().length > 0 && $(this).val() == $("#userPwd").val()) {
            $("#recheckPwd img").attr("src", "img/Right.png");
        } else {
            $("#recheckPwd img").attr("src", "img/Wrong.png");
        }
    });
    $("#mail").blur(function () {
        let ajaxFlag = true;
        $("#checkMail img").css("visibility", "visible");
        if (regMail.test($(this).val())) {
            ajaxFlag = false;
            console.log("thisvalue = " + $(this).val());
            $.ajax({
                url: "http://localhost:8080/GameShop/isMailExist",
                type: "GET",
                data : {"mail":$(this).val()},
                dataType:"json",
                success: function(data){
                    console.log(data);
                    if(data){
                        alert("此信箱已存在");
                        $("#checkMail img").attr("src", "img/Wrong.png");
                        errorAcc = 1;
                    }else{
                        $("#checkMail img").attr("src", "img/Right.png");
                        errorAcc = 0;
                    }
                },error: function(){
                    console.log("連線失敗");
                }
            }).done(ajaxFlag = true);
        } else {
            $("#checkMail img").attr("src", "img/Wrong.png");
            errorMail = 1;
        }
    });

    //confirm
    $(".registerconfirm").click(function (e) {
        e.preventDefault();
        if (errorAcc == 0 && errorNickName == 0 && errorPwd == 0 && errorMail == 0) {
            var form = $(".registerForm form")[0];
            var formdata = new FormData(form);
            for(var pair of formdata.entries()) {
                console.log(pair[0]+ ', '+ pair[1]); 
             }
            $.ajax({
                url: "http://localhost:8080/GameShop/register",
                type: "POST",
                data : formdata,
				dataType : "json",
				contentType: false,
				processData : false,
				cache : false,
				async : false,
                success: function (data) {
                    console.log("DATA : "+data);
                    if (data) {
                        alert("註冊成功，請到信箱收取確認信!");
                        location="http://localhost:8080/GameShop/index.html"
                    } else {
                        alert("註冊失敗，請檢查資料是否正確");
                    }
                }, error: function () {
                    alert("註冊失敗，請檢查資料是否正確");
                }
            })
        } else {
            alert("資料格式不對唷!請再確認一次!");
        }
    })

    $(".loginconfirm").click(function () {
        console.log("Account = " + $("#loginAccount").val());
        $.ajax({
            url: "http://localhost:8080/GameShop/checkProfile",
            type: "POST",
            data: {
                userAccount: $("#loginAccount").val(),
                userPwd: $("#loginPwd").val(),
            },
            dataType: "json",
            cache: false,
            success: function (data) {
                console.log(data);
                if (data) {
                    $(".loginForm form").submit();
                    alert("登入成功");
                } else {
                    alert("登入失敗，請檢查帳號密碼!")
                }
            }, error: function () {
                alert("登入失敗，請檢查帳號密碼!")
            }
        })
    })

    //Rightup Login Button
    $(document).ready(function () {
        $("#titleMessage").animate({ opacity: "0" }, 4000, function () { $("#titleMessage").hide() });
        //if login
        if ($(".loginz").val() == "Logout") {
            $(".loginz").parent().attr("href", "http://localhost:8080/GameShop/logout/");
            $(".loginArea").css("visibility", "hidden");
            $("#hello").show();
        } else {     //if guest
            $("#hello").hide();
            $(".loginArea").css("visibility", "visible")
            $(".loginz").parent().removeAttr("href");
            $(".loginz").click(function () {
                $(".loginDiv").css({
                    "position": "absolute",
                    "display": "flex",
                    "z-index": "99999",
                    "top": $(document).scrollTop() + "px",
                    "height": "100vh",
                    "width": "100vw",
                    "align-items": "center"
                })
                $("html").css("overflow", "hidden");
            })
        }
    })


    //cancel form
    var cancelbtn = function () {
        $(".loginDiv").css("display", "none");
        $(".registerDiv").css("display", "none");
        $("html").css("overflow", "initial");
    }
    $(".cancel_btn").click(cancelbtn);

    var loginMousePosition = false;
    $(".loginDiv, .registerDiv").mouseover(function (e) {
        loginMousePosition = $(".loginDiv, .registerDiv").is(e.target);
    })
    $(".loginDiv, .registerDiv").click(function (e) {
        if (loginMousePosition) {
            cancelbtn();
        }
    })
})

