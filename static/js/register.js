$(function() {
	$('[data-toggle="popover"]').popover();;
	$("#register_form").validate({
		rules: {
			email: {
				required: true
			},
			regPass: {
				required: true
			},
			confirmPass: {
				required: true,
				equalTo: "#regPass"
			}
		},
		messages: {
			email: {
				required: "请输入邮箱"
			},
			regPass: {
				required: "请输入密码"
			},
			confirmPass: {
				required: "请再次输入密码",
				equalTo: "两次密码输入不一致"
			}
		},
		submitHandler: function() {
			disabled_click(this);
			var email = $("#regEmail").val().toLowerCase(); //邮箱
			var password = $.md5($("#regPass").val()); //密码
			var username = $("#username").val(); //用户姓名
			var role_type = parseInt($("input[name='role_type']:checked").val());; //权限
			//注册接口
			$.ajax({
				url: serverUrl_carrier + "users",
				type: 'post',
				dataType: "json",
				data: {
					email: email,
					password: password,
					username: username,
					role_type: role_type
				},
				success: function(data) {
					if(data.code == 1800) {
						hide_popover('#createAccount', '注册成功');;
						//跳转到登录界面start
						$.ajax({
							url: serverUrl_carrier + "login",
							type: 'post',
							dataType: "json",
							data: {
								email: email,
								password: password
							},
							success: function(data) {
								if(data.code == 1800) {
									login_cookies_set(data);;
                                    window.location.href = serverUrl_weburl+"main.html";
								}
							},
							error: function(jqXHR,textStatus,errorThrown) {
								console.log(textStatus);;
								hide_popover('#createAccount', '程序错误,请联系管理员')
							}
						});
						//跳转到登录界面end
						
					} else if(data.code == 1805) {
						hide_popover('#createAccount', '邮箱已被注册,请重新输入邮箱')
					} else if(data.code == 1820) {
						hide_popover('#createAccount', '百度添加围栏失败，请联系管理员')
					} else {
						hide_popover('#createAccount', '程序错误,请联系管理员')
					}
				},
				error: function(msg) {
					hide_popover('#createAccount', '程序错误,请联系管理员')
				}
			});
		}
	});

	$(document).ready(function() {
		$("#register_form").validate({

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
		$("#createAccount").click(function() {
			$("#createAccount").submit();
			
		});
	});

});