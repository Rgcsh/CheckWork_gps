$(function () {
    $('[data-toggle="popover"]').popover()
    $("#form_login").validate({
        rules: {
            email: {
                required: true
            },
            regPass: {
                required: true
            }
        },
        messages: {
            email: {
                required: "请输入邮箱"
            },
            regPass: {
                required: "请输入密码"
            }
        },
        submitHandler: function () {
            disabled_click(this);
            var email = $("#login_email").val().toLowerCase(); //邮箱
            var password = $("#login_password").val(); //密码
            //登录接口
            $.ajax({
                url: serverUrl_carrier + "login",
                type: 'post',
                dataType: "json",
                data: {
                    email: email,
                    password: $.md5(password)
                },
                success: function (data) {
                    if (data.code == 1800) {
                        window.location.href = serverUrl_weburl + "main.html";
                        login_cookies_set(data)
                    } else if (data.code == 1806) {
                        hide_popover('#login_button', '用户不存在,请检查邮箱是否正确或注册')
                    } else if (data.code == 1812) {
                        hide_popover('#login_button', '密码错误,请从新输入密码')
                    } else {
                        hide_popover('#login_button', '程序错误,请联系管理员')
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus)
                    hide_popover('#login_button', '程序错误,请联系管理员')
                }
            });
        }
    });

    $(document).ready(function () {
        $("#form_login").validate({
            rules: {
                confirmPass: {
                    required: true,
                    minlength: 6,
                    equalTo: "#regPass"
                }
            },
            messages: {
                confirmPass: {
                    required: "请输入密码",
                    minlength: "密码长度不能小于 6 个字母",
                    equalTo: "两次密码输入不一致"
                }
            }
        });
        $("#login_button").click(function () {
            $("#login_button").submit();

        });
        $(document).keyup(function (e) {
            if (e.keyCode == 13) {
                $("#login_button").submit();
            }
        });
    });

});