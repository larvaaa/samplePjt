<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
  .input_tab {margin-bottom:10px;width:553px}
  .div_login {position: absolute;top: 50%;left: 50%;transform: translate(-50%,-50%);box-sizing: border-box;width: 553px;margin: 0 auto;}
  .div_login input {height:50px;}
  .div_login button {height:50px;font-size:24px;color:#fff;font-weight:bold}
  .div_login h1 {text-align:center}
  .btn_login {width:100%;background:#03c75a;border: solid 1px rgba(0,0,0,.15);border-radius: 6px;}
  .div_login input.login_ckbox {height:20px;position:relative;top:15px;}
  .address_btn {color:#000000;border-color:#000000;position:relative;left:170px;}
  .id_chk_btn {color:#000000;border-color:#000000;position:relative;left:83px;}
  .birth > .form-control {display:inline;width:30%;margin-right: 16px;}
</style>

</head>
<body>

<script>
$(document).ready(function() {
	
	//회원가입 취소
	$(".btn.btn-success.cancel").click(function() {
		if(confirm("회원가입을 취소하시겠습니까?")) {
			history.back();
		}
	});
	
	//로그인 버튼 클릭
	$(".btn_login").click(function() {
		
		doLogin();//로그인
		
	})
	
	//핸드폰 번호 '-' 자동 입력
	$('#phone').keydown(function(event) {
      var key = event.charCode || event.keyCode || 0;
      $text = $(this);
      if (key !== 8 && key !== 9) {
          if ($text.val().length === 3) {
              $text.val($text.val() + '-');
          }
          if ($text.val().length === 8) {
              $text.val($text.val() + '-');
          }
      }

//       return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105)); 
    });
	
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

function popOnAddressApi() {
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
//                 document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
//                 document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
//             document.getElementById('sample6_postcode').value = data.zonecode;
            $("#postcode").val(data.zonecode);
//             document.getElementById("sample6_address").value = addr;
            $("#address").val(addr);
            // 커서를 상세주소 필드로 이동한다.
            $("#detailAddress").focus();
        }
    }).open();
}
    
</script>

<div class="container" style="width:40%;">
    <h3>회원가입</h3>
    <form action="/ajax/signup" method="post" id="myForm">
        <div class="form-group has-feedback">
            <label class="control-label" for="id">아이디</label><br>
            <input class="form-control" type="text" name="id" id="id" style="width:70%;display:inline;"/>
            <input type="button" class="btn id_chk_btn" onclick="popOnAddressApi()" value="중복확인">
            <span id="overlapErr" class="help-block">사용할 수 없는 아이디 입니다.</span>
        </div>
        <div class="form-group has-feedback">
            <label class="control-label" for="pwd">비밀번호</label>
            <input class="form-control" type="password" name="pwd" id="pwd"/>
            <span id="pwdRegErr" class="help-block">8글자 이상 입력하세요.</span>
        </div>
        <div class="form-group has-feedback">
            <label class="control-label" for="rePwd">비밀번호 재확인</label>
            <input class="form-control" type="password" name="rePwd" id="rePwd"/>
            <span id="rePwdErr" class="help-block">비밀번호와 일치하지 않습니다. 다시 입력해 주세요.</span>
        </div>
        <div>
        <div class="form-group has-feedback birth">
          <label class="control-label" for="birth">생년월일</label><br>
          <input type="text" id="yy" class="form-control" maxlength="4" placeholder="년(4자)">
            <select id="mm" class="form-control">
                <option>월</option>
                <option value="01">1</option>
                <option value="02">2</option>
                <option value="03">3</option>
                <option value="04">4</option>
                <option value="05">5</option>
                <option value="06">6</option>
                <option value="07">7</option>
                <option value="08">8</option>
                <option value="09">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
            </select>
            <input type="text" id="dd" class="form-control" maxlength="2" placeholder="일">
          </div>
          <span class="error_next_box"></span>
        </div>
        <div class="form-group has-feedback">
          <label class="control-label" for="gender">성별</label><br>
          <select id="mm" class="form-control">
              <option>성별</option>
              <option value="01">남자</option>
              <option value="02">여자</option>
          </select>
        </div>
        <div class="form-group has-feedback">
            <label class="control-label" for="phone">핸드폰</label>
            <input class="form-control" type="text" name="phone" id="phone" maxlength="13" />
            <span id="rePwdErr" class="help-block">- 없이 입력해주세요.</span>
        </div>
        <div class="form-group has-feedback">
            <label class="control-label" for="email">이메일</label>
            <input class="form-control" type="text" name="email" id="email"/>
            <span id="emailErr" class="help-block">올바른 이메일 형식이 아닙니다. 다시 입력해 주세요.</span>
        </div>
        <div class="form-group has-feedback">
            <label class="control-label" for="nickname">닉네임</label>
            <input class="form-control" type="text" name="nickname" id="nickname"/>
            <span id="overlapErr" class="help-block">사용할 수 없는 닉네임 입니다.</span>
        </div>
        <div class="form-group has-feedback">
          <label class="control-label" for="zipCode">주소</label><br>
          <input type="text" class="form-control" id="postcode" placeholder="우편번호" style="width:50%;display:inline;">
          <input type="button" class="btn address_btn" onclick="popOnAddressApi()" value="우편번호 찾기"><br><br>
          <input type="text" class="form-control" id="address" placeholder="주소"><br>
          <input type="text" class="form-control" id="detailAddress" placeholder="상세주소">
        </div>
        <button class="btn btn-success" type="submit">가입</button>
        <button class="btn btn-success cancel" type="button">취소</button>
    </form>
</div>

</body>
</html>