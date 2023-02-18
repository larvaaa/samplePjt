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
<title>네비게이션</title>

</head>

<body>
<script>
var sel_file = [];
let file_idx = 0;
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
//     var inputFile = $("input[name='brandImages']");
    //<input type="file" 요소 내의 이미지들
    
    //console.log("inputFile[0]:::::::::::::" );
    
    formData.append("brandName",$("input[name='brandName']").val());
    //console.log("files : " + files);
    
    for(var i=0;i<sel_file.length;i++){
        //console.log(files[i]);
        //확장자, 크기 체크
        //function checkExtension(fileName, fileSize){
        var file = sel_file[i];
        if(!checkExtension(file.name, file.size)){//!true라면 실패
            return false;
        }
        
        formData.append("uploadFile",file);
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
    
    //console.log("여길봐라: "+ JSON.stringify(e));
    //e.target : 파일객체
    //e.target.files : 파일객체 안의 파일들
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
    
    //f : 파일 객체
    filesArr.forEach(function(f){
    	//console.log(f);
    	//미리보기는 이미지만 가능함
        if(!f.type.match("image.*")){
            alert("이미지만 가능합니다");
            return;
        }
        
        // 파일객체 복사
        sel_file.push(f);
        changeInputFile();
        //파일을 읽어주는 객체 생성
        var reader = new FileReader();
        reader.onload = function(e){
            //forEach 반복 하면서 img 객체 생성
            var img_html = "<div>" +
            "<img src=\"" + e.target.result + "\" />" +
            "<button onclick='deleteFile(this)' data-file-name='"+ f.name +"'>X</button>" +
            "</div>";
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

//파일 삭제
function deleteFile(obj) {
    
	let fileName = $(obj).data("file-name");
    
    sel_file.forEach((file,idx) => {
    	if(file.name == fileName) {
    		sel_file.splice(idx,1);
    	}
    });
    
    $(obj).parent().remove();
    changeInputFile();
    
}

//input[type="file"] 상태 변경
function changeInputFile() {
    
    const dataTransfer = new DataTransfer();
    
    //let files = $('#brandImg')[0].files;    //사용자가 입력한 파일을 변수에 할당
    
    let fileArray = sel_file;  //변수에 할당된 파일을 배열로 변환(FileList -> Array)
    
    //fileArray.splice(fileNum, 1);   //해당하는 index의 파일을 배열에서 제거
    
    fileArray.forEach(file => {
        dataTransfer.items.add(file); 
    });
    //남은 배열을 dataTransfer로 처리(Array -> FileList)
    
    $('#brandImg')[0].files = dataTransfer.files;   //제거 처리된 FileList를 돌려줌
}
</script>

<form method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="brandName">상품 명</label>
    <input type="text" class="form-control" id="brandName" name="brandName" placeholder="브랜드 명을 입력해주세요.">
  </div>
  <div class="form-group">
    <label for="brandName">재고 수량</label>
    <input type="text" class="form-control" id="brandName" name="brandName" placeholder="브랜드 명을 입력해주세요.">
  </div>
  
  
  
  <div class="form-group">
    <label>파일 업로드</label><br/>
    <label for="brandImg"><div class="btn_file">파일찾기</div></label>
    <input type="file" id="brandImg" name="brandImages" multiple>
  </div>
  <button type="button" class="btn btn-default" onclick="upload();">등록</button>
  <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/shopping/goBrand'">취소</button>
</form>

<div class="img_wrap">
</div>

</body>
</html>