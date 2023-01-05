<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>

<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon/favicon.ico" />

<script src="${pageContext.request.contextPath}/resources/js/jquery.js" type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.min.js'></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script> -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script> --%>

<link href='${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css' rel='stylesheet' />
<%-- <link href='${pageContext.request.contextPath}/resources/css/main.css' rel='stylesheet' /> --%>
<%-- <link href='${pageContext.request.contextPath}/resources/css/board.css' rel='stylesheet' /> --%>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/board.css"/>

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
