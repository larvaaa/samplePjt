<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>
<head>
<style>
  .input_tab {margin-bottom:10px;width:553px}
  .div_login {position: absolute;top: 50%;left: 50%;transform: translate(-50%,-50%);box-sizing: border-box;width: 553px;margin: 0 auto;}
  .div_login input {height:50px;}
  .div_login button {height:50px;font-size:24px;color:#fff;font-weight:bold}
  .div_login h1 {text-align:center}
  .btn_login {width:100%;background:#03c75a;border: solid 1px rgba(0,0,0,.15);border-radius: 6px;}
  .div_login input.login_ckbox {height:20px;position:relative;top:15px;}
  
</style>

</head>
<body>

<script>
$(document).ready(function() {
	
	//로그인 버튼 클릭
	$(".btn_login").click(function() {
		
		doLogin();//로그인
		
	})
	
});

//엔터 입력시 로그인 처리
function loginKeyUp() {
	if(window.event.keyCode == 13) {
		doLogin();
	}
}

//로그인
function doLogin() {
	
	var login_id = $("#input_id").val();
	var login_pw = $("#input_pw").val();
    
	if(login_id == '' || login_pw == '') {
		alert("아이디 또는 패스워드를 입력하세요.");
		return false;
	}
	
	
	var param = {
		"login_id" : login_id
		, "login_pw" : login_pw
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/login/doLogin",
		type: "post",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(param),
		success: function(data){
			if(data.result_cd == "S") {
				goMain();
			} else if(data.result_cd == "N"){
				alert("아이디, 비밀번호를 확인해주세요");
			} else {
				alert("일시적인 오류 입니다.");
			}
			
		}
	});

}

//메인화면 이동
function goMain() {
	
	var f = document.loginForm;
	f.action = "${pageContext.request.contextPath}/goMain";
	f.method = "post";
	f.submit();
	
}
</script>


<div class="div_login">

  <h1>정호 프로젝트</h1>
  
  <form id="form1" name="loginForm">
    <input type="text" placeholder="아이디" class="input_tab" id="input_id" name="login_id" autocomplete="off"></input><br>

    <input type="password" placeholder="비밀번호" class="input_tab" id="input_pw" name="login_pw" onkeyup="loginKeyUp()"></input><br>

    <button type="button" class="btn_login" id="btn_login" id="btn_login">로그인</button><br>
    <div>
      <input type="checkbox" class="login_ckbox" id="login_ckbox" name="autoLogin" value="">
      <label for="login_ckbox" style="top: 12px;position: relative;">로그인 상태 유지</label>
    </div>
    <div style="text-align:right;text-align: right;position: relative;bottom: -17px;">
      <a href="${pageContext.request.contextPath}/login/signUp">회원가입</a><br>
      <a href="${pageContext.request.contextPath}/login/adminLogin">관리자</a>
    </div>
  </form>
  
</div>

</body>
</html>