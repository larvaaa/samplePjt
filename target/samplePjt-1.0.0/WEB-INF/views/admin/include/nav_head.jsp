<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.sidebar {background: black;}
</style>

<script>

//로그아웃
function doLogout() {
	let f = document.createElement('form');
    f.setAttribute('method', 'post');
    f.setAttribute('action', '/login/doLogout');
    document.body.appendChild(f);
    f.submit();
}

</script>

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">첫출발 프로젝트</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Dashboard</a></li>
        <li><a href="#">Settings</a></li>
        <li><a href="#">Profile</a></li>
        <li><a href="javascript:doLogout()">로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <div class="row" >
    <div class="col-sm-3 col-md-2 sidebar main">
      <ul class="nav nav-sidebar">
        <li class="active"><a href="${pageContext.request.contextPath}/login/adminLogin?side_idx=0">메인<span class="sr-only">(current)</span></a></li>
        <li><a href="${pageContext.request.contextPath}/admin/itemAdd">상품등록</a></li>
        <li><a href="#">상품목록</a></li>
        <li><a href="#">Export</a></li>
      </ul>
      <ul class="nav nav-sidebar">
        <li><a href="">Nav item</a></li>
        <li><a href="">Nav item again</a></li>
        <li><a href="">One more nav</a></li>
        <li><a href="">Another nav item</a></li>
        <li><a href="">More navigation</a></li>
      </ul>
      <ul class="nav nav-sidebar">
        <li><a href="">Nav item again</a></li>
        <li><a href="">One more nav</a></li>
        <li><a href="">Another nav item</a></li>
      </ul>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">