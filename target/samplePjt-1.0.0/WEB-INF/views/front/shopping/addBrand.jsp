<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>

<head>

<style>

.btn {margin:10px;}
</style>
<title>네비게이션</title>

</head>

<body>
<script>
var sel_file = [];

$(document).ready(function() {
	
	//------------- 이미지 미리보기 시작 ------------------
    $("#brandImg").on("change", handleImgFileSelect);
	
});

//Upload 버튼 클릭 시 수행
function upload() {
    //FormData : 가상의 <form> 태그
    //Ajax를 이용하는 파일 업로드는 FormData를 이용
    var formData = new FormData();
    //<input type="file" 요소
    var inputFile = $("input[name='brandImages']");
    //<input type="file" 요소 내의 이미지들
    
    console.log("inputFile[0]:::::::::::::" );
    var files = inputFile[0].files;
    
    formData.append("brandName",$("input[name='brandName']").val());
    console.log("files : " + files);
    
    for(var i=0;i<files.length;i++){
        console.log(files[i]);
        //확장자, 크기 체크
        //function checkExtension(fileName, fileSize){
        if(!checkExtension(files[i].name, files[i].size)){//!true라면 실패
            return false;
        }
        
        formData.append("uploadFile",files[i]);
    }
    
    
    //processData,contentType은 반드시 false여야 전송됨
    $.ajax({
        url:'${pageContext.request.contextPath}/shopping/addBrand',
        processData:false,
        contentType:false,
        data:formData,
        type:'POST',
        success:function(data){
        	if(data.result_cd == 'S') {
        		console.log("result : " + JSON.stringify(data));
        		
        		location.href = "${pageContext.request.contextPath}/shopping/goBrand";
        	}
        }
    });
};

//e : change 이벤트 객체
// change 이벤트 설정하면  e는 이벤트가 된다. handleImgFileSelect에 파라미터 주면 e가 이벤트가 아니라 그냥 파라미터가 됨.
function handleImgFileSelect(e){
    
    console.log("여길봐라: "+ JSON.stringify(e));
    //e.target : 파일객체
    //e.target.files : 파일객체 안의 파일들
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
    
    //f : 파일 객체
    filesArr.forEach(function(f){
        //미리보기는 이미지만 가능함
        if(!f.type.match("image.*")){
            alert("이미지만 가능합니다");
            return;
        }
        
        // 파일객체 복사
         sel_file.push(f);
        
        //파일을 읽어주는 객체 생성
        var reader = new FileReader();
        reader.onload = function(e){
            //forEach 반복 하면서 img 객체 생성
            var img_html = "<img src=\"" + e.target.result + "\" />";
            $(".img_wrap").append(img_html);
        }
        reader.readAsDataURL(f);
    });
}

//------------- 이미지 미리보기 끝 ------------------

//첨부파일의 확장자가 exe, sh, zip, alz 경우 업로드를 제한
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
//최대 5MB까지만 업로드 가능
var maxSize = 5242880; //5MB
//확장자, 크기 체크
function checkExtension(fileName, fileSize){
    if(fileSize >= maxSize){
        alert("파일 사이즈 초과");
        return false;
    }
    
    if(regex.test(fileName)){
        alert("해당 종류의 파일은 업로드할 수 없습니다.");
        return false;
    }
    //체크 통과
    return true;
}

</script>

<form method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="brandName">브랜드 명</label>
    <input type="text" class="form-control" id="brandName" name="brandName" placeholder="브랜드 명을 입력해주세요.">
  </div>
  <div class="form-group">
    <label for="brandImg">파일 업로드</label>
    <input type="file" id="brandImg" name="brandImages" multiple>
  </div>
  <button type="button" class="btn btn-default" onclick="upload();">등록</button>
  <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/shopping/goBrand';">취소</button>
</form>

<div class="img_wrap">
</div>

</body>
</html>