//serverUrl = '//120.27.110.143:3000/'
// serverUrl = '//120.27.110.143:3000/'
serverUrl = '//172.16.71.76:3000/';;
//serverUrl = '//127.0.0.1:8080/'
serverUrl_carrier = serverUrl + 'carrier/';;
serverUrl_fence = serverUrl + 'fence/';;
serverUrl_weburl = serverUrl + 'upload/tender_manage/';;
// serverUrl_weburl = serverUrl
//	弹窗消失
function hide_popover(name,get_text) {
	$(name).parent().find("label").text(get_text);;
	$(name).removeAttr('disabled')
}

//屏蔽点击事件
function disabled_click(name){
	$(name).attr({'disabled':'disabled'})
}

function login_cookies_set(get_data){
	var token=get_data.data.token;;
	var email=get_data.data.email;;
	var user_id=get_data.data.id;;
	var role_type=get_data.data.role_type;;
	var username=get_data.data.username;;
	var user_department=get_data.data.user_department;;
	var user_no=get_data.data.user_no;;
	expire_time={expires:1};;
	$.cookie('token', token,expire_time);
	$.cookie('email', email,expire_time);
	$.cookie('user_id', user_id,expire_time);
	$.cookie('role_type',role_type,expire_time);
	$.cookie('username', username,expire_time);
	$.cookie('user_department', user_department,expire_time);
	$.cookie('user_no', user_no,expire_time);
}

function cookies_remove(){
	 $.cookie('token', null);  
	 $.cookie('email', null);  
	 $.cookie('user_id', null);  
	 $.cookie('role_type', null);  
	 $.cookie('username', null);  
	 $.cookie('user_department', null);  
	 $.cookie('user_no', null);  
}
//api接口出错事件
//function api_error(name){
//	disabled_click()
//	
//}