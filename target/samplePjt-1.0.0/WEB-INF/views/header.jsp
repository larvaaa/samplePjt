<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>

<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon/favicon.ico" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
<%String side_idx = request.getParameter("side_idx");%>
var side_idx = "<%=side_idx%>";

$(document).ready(function() {
	
	//사이드바 활성화
	$(".main > .nav.nav-sidebar li").removeClass("active").eq(side_idx).addClass("active");
})
</script>
