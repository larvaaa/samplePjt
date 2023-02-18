<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>

<head>

<style>

.btn {margin:10px;}

.btn_file {
  width: 150px;
  height: 30px;
  background: #fff;
  border: 1px solid rgb(77,77,77);
  border-radius: 10px;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.btn_file:hover {
  background: rgb(77,77,77);
  color: #fff;
}

#brandImg {display:none;}

</style>
<title>상품 등록</title>

</head>

<body>
<script>
$(document).ready(function() {
	
	$("#cate_lev").change(function() {
		let depth = $("#cate_lev").val();
		selectParent(--depth);
	});
		
	
});

//카테고리 등록
function insertCategory() {
    
	let param = $("form[name='cateForm']").serialize();
	
	$.ajax({
        url:'${pageContext.request.contextPath}/shopping/add/category',
//         contentType: "application/json",
        dataType: "json",
        data: param,
        type:'POST',
        success:function(data){
            if(data.result_cd == 'S') {
                
//                 location.href = "${pageContext.request.contextPath}/shopping/goBrand";
            }
        }
    });
}

//상위 카테고리 조회
function selectParent(depth) {
	
	if(depth == 0) {
		$("#p_cate").html("<option value='' selected disabled hidden>select parent</option>");
		return;
	}
	
	$.ajax({
        url:'${pageContext.request.contextPath}/shopping/category/depth/' + depth,
//         contentType: "application/json",
        dataType: "json",
        type:'get',
        success:function(data){
        	$("#p_cate").html("<option value='' selected disabled hidden>select parent</option>");
        	data.forEach(d => $("#p_cate").append("<option value=" + d.id + ">" + d.name +"</option>"));
        }
    });
}
</script>

<form name="cateForm" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="cateName">카테고리 명</label>
    <input type="text" class="form-control" id="cateName" name="name" placeholder="카테고리 명을 입력해주세요.">
  </div>
  레벨
  <select class="form-select" id="cate_lev" name="depth" aria-label="Default select example">
    <option selected disabled hidden>select level</option>
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
  </select><br><br>
  상위 카테고리
  <select class="form-select" id="p_cate" name="parentId" aria-label="Default select example">
    <option value="" selected disabled hidden>select parent</option>
  </select><br><br>
  <div class="form-group">
    <label for="seq">카테고리 순서</label>
    <input type="text" class="form-control" name="seq" id="seq" placeholder="카테고리 순서를 입력해주세요.">
  </div><br><br>
  사용여부
  <div class="form-check form-check-inline">
    <input class="form-check-input" type="radio" name="useYn" id="flexRadioDefault1" value="Y" checked>
    <label class="form-check-label" for="flexRadioDefault1">Y</label>
  </div>
  <div class="form-check form-check-inline">
    <input class="form-check-input" type="radio" name="useYn" id="flexRadioDefault2" value="N" >
    <label class="form-check-label" for="flexRadioDefault2">N</label>
  </div><br><br>
  
  <button type="button" class="btn btn-default" onclick="insertCategory();">등록</button>
  <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/shopping/category'">취소</button>
</form>

<div class="img_wrap">
</div>

</body>
</html>