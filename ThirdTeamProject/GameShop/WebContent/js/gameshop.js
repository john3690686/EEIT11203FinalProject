$(document).ready(function () {
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
        $("#checkAccount img").css("visibility", "visible");
        if (regUserAccount.test($(this).val())) {
            $("#checkAccount img").attr("src", "img/Right.png");
            errorAcc = 0;
        } else {
            $("#checkAccount img").attr("src", "img/Wrong.png");
            errorAcc = 1;
        }
    });
    $("#nickName").blur(function () {
        $("#checkNickName img").css("visibility", "visible");
        if ($(this).val().trim().length > 0) {
            $("#checkNickName img").attr("src", "img/Right.png");
            errorNickName = 0;
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
    $(".registerconfirm").click(function () {
        if (errorAcc == 0 && errorNickName == 0 && errorPwd == 0 && errorMail == 0) {
            $(".registerForm form").submit();
        } else {
            alert("資料格式不對唷!請再確認一次!");
        }
    })

    $(".loginconfirm").click(function () {
        console.log("userAccount:" + $("#loginAccount").val());
        console.log("userPwd:" + $("#loginPwd").val());
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
                    $("#loginMsg").text("登入失敗，請檢查帳號密碼!")
                }
            }, error: function () {
                $("#loginMsg").text("登入失敗，請檢查帳號密碼!")
            }
        })
    })

    //Rightup Login Button
    $(document).ready(function () {
        $("#titleMessage").animate({ opacity: "0" }, 4000, function () { $("#titleMessage").hide() });
        //if login
        if ($(".loginz").val() == "Logout") {
            $(".loginz").parent().attr("href", "http://localhost:8080/GameShop/logout/");
            $(".login").css("visibility", "hidden");
            $("#hello").show();
        } else {     //if guest
            $("#hello").hide();
            $(".login").css("visibility", "visible")
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

