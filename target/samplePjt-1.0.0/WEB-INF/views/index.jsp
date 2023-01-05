<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>

<body>


<script>

//로그인 화면 이동
function goLogin() {
	
	var loginForm = $('<form></form>');  
	
	loginForm.attr("name","loginForm"); 
	loginForm.attr("method","post"); 
	loginForm.attr("action","${pageContext.request.contextPath}/login/goLogin"); 
	
	loginForm.appendTo('body'); 
	loginForm.submit();

}


</script>

<h1>안녕하세요!</h1>

<button onclick="goLogin()">로그인 하기</button>



</body>
</html>