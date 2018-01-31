$(function() {
	function forget_api() {
		disabled_click(this);
		var email = $("#forget_form_email").val().toLowerCase(); //邮箱
		//登录接口
		$.ajax({
			url: serverUrl_carrier + "password",
			type: 'post',
			dataType: "json",
			data: {
				email: email
			},
			success: function(data) {
				if(data.code == 1800) {
					$('#progress_bar_find_pass').css({
						'width': '100%'
					});;
					hide_popover('#find_paswod_button', '成功找回密码')
				} else if(data.code == 1806) {
					hide_popover('#find_paswod_button', '用户不存在,请检查邮箱是否正确')
				} else {
					hide_popover('#find_paswod_button', '程序错误,请联系管理员')
				}
			},
			error: function(msg) {
				hide_popover('#find_paswod_button', '程序错误,请联系管理员')
			}
		});
	}

	$(document).ready(function() {
		$("#find_paswod_button").click(function() {
			if(check_eamil_reg($('#forget_form_email').val()) == true) {
				$('#progress_bar_find_pass').css({
					'width': '5%'
				});
				forget_api();
			}else{
				hide_popover('#find_paswod_button', '请输入邮箱地址')
			}

		});
		$("#forget_form_email").blur(function() {
			result=check_eamil_reg($(this).val());;
			if(result != true) {
				$(this).parent().parent().parent().find('label').text('邮箱格式错误')
			} else {
				$(this).parent().parent().parent().find('label').text('')
			}
		});
	});

	function check_eamil_reg(val) {
		return /^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,50}$/.test(val)
	}

});