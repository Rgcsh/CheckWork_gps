$(function() {
	//注册特效
	function login_form_hide() {
		$("#login_form").animate({
			opacity: 0.5,
			right: '+=750px',
			backgroundColor: "gray"
		}, {
			step: function(now) {
				$("#login_form").css({
					"transform": "rotate(" + now + "deg)",
				})
			},
			duration: 500,
			easing: 'linear',
			complete: function() {
				login_form_hide1()
			}
		});
    }
    function login_form_hide1() {
		$("#login_form").hide();
		$("#sign_form").css({
			"opcity": 0,
			'background-color': 'gray',
			'right': '750px',
			'display': 'block'
		});
		$("#sign_form").animate({
			opacity: 1,
			right: '-=750px',
			backgroundColor: "write"
		}, {
			step: function(now) {
				$("#sign_form").css({
					"transform": "rotate(" + now + "deg)",
				})
			},
			duration: 500,
			easing: 'linear'
		});
    }
    $("#sign_link").on("click", function() {
		login_form_hide();
	});

	//忘记密码特效
	$("#forget_link").on("click", function() {
		login_form_hide3();
	});

	function login_form_hide3() {
		$("#login_form").animate({
			opacity: 0.5,
			right: '-=750px',
			backgroundColor: "gray"
		}, {
			step: function(now) {
				$("#login_form").css({
					"transform": "rotate(" + now + "deg)",
				})
			},
			duration: 500,
			easing: 'linear',
			complete: function() {
				login_form_hide2()
			}
		});
    }
    function login_form_hide2() {
		$("#login_form").hide();
		$("#forget_form").css({
			"opcity": 0,
			'background-color': 'gray',
			'right': '-750px',
			'display': 'block'
		});
		$("#forget_form").animate({
			opacity: 1,
			right: '+=750px',
			backgroundColor: "write"
		}, {
			step: function(now) {
				$("#forget_form").css({
					"transform": "rotate(" + now + "deg)",
				})
			},
			duration: 500,
			easing: 'linear'
		});
    }
    //	返回到登录界面
	$(".hold_back_login").on("click", function() {
		var target=$(this).parent().parent().parent();
		target.fadeOut(500,function(){
			$('#login_form').css({'background-color':'white','transform': 'rotate(0deg)','opacity':'1','right':'0px'});
			$('#login_form').fadeIn(500);
		})
	});

});