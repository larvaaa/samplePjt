<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>

</style>
</head>
<body>

<script>


$('#commentModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var recipient = button.data('cseq') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('New message to ' + recipient)
	  modal.find('.modal-body input').val(recipient)
	})

//댓글작성
function insertReComment() {
    
    let param = {
        "content" : $("#write_comment > textarea").val(),
        "bseq" : bseq,
        "cdepth" : "1"
        "cgrp" : 
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/board/insertComment",
        type: "post",
        contentType: "application/json",
        dataType: "json",
        data: JSON.stringify(param),
        success: function(data){
            if(data.result_cd == "S") {
                alert("댓글 작성 완료했습니다.");
                selectCommentList();
            } else {
                alert("오류가 발생했습니다.");
            }
        }
    });

}

</script>



<c:forEach var="comment" items="${commentList}">
  <c:choose>
    <c:when test="${comment.CDEPTH == 0}">
      <div>
        <span>${comment.WRITER}</span>
        <span>${comment.CONTENT}</span>
        <span>${comment.REG_DATE}</span>
        <button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#commentModal" data-cseq="${comment.CSEQ}">답글</button>
      </div>
    </c:when>
    <c:otherwise>
      <div style="padding-left:20px;">
        <span>${comment.WRITER}</span>
        <span>${comment.CONTENT}</span>
        <span>${comment.REG_DATE}</span>
      </div>
    </c:otherwise>
  </c:choose>
</c:forEach>


<!-- Modal -->
<div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
<!--         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="myModalLabel">댓글</h4>
      </div>
      <div class="modal-body">
	    <div class="write_comment">
	      <textarea class="form-control" rows="3"></textarea>
	    </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="insertReComment">등록</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>