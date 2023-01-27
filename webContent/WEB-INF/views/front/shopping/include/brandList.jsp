<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<head>

</head>
<body>

<script>

$(document).ready(function() {
	
	setPagingBtn("${pageNum}", "${endPage}");
	
	//페이지 버튼 클릭
    $(".paging_btn").click(function() {
        
        var page_num = $(this).text();
        page = page_num;
        selectBrandList(page_num);
        $(".paging_btn").removeClass("active");
        $(this).addClass("active");
    });
	
});

//페이징 버튼 세팅
function setPagingBtn(pageNum, endPage) {
    
    //전체 페이지 버튼 개수
    let totalPageBtn = 10;
    
    let start = totalPageBtn * Math.floor((pageNum - 1) / totalPageBtn) + 1;
    let end = start + totalPageBtn;
    
    for(let i = start; i < end; i++) {
        if(i <= endPage) {
            $(".paging_btn").eq(i - 1).show();
            $(".paging_btn > a").eq(i - 1).show().text(i);
        }
    }
    
    $(".paging_btn").eq(pageNum - 1).addClass("active");
}

//브랜드 수정 페이지 이동
function moveBrandUpd(brand_id) {
	
	var f = $('<form></form>');
    //set attribute (form) 
    f.attr("name","form");
    f.attr("method","get");
    f.attr("action","/shopping/moveBrandUpd");

    // create element & set attribute (input) 
    f.append($('<input/>', {type: 'hidden', name: 'brand_id', value:brand_id }));

    // append form (to body) 
    f.appendTo('body');

    // submit form
    f.submit();
}

//브랜드 삭제
function deleteBrand(id) {
	
	
	
	
}

</script>

<table class="table" style="margin-left: auto; margin-right: auto;">
  <tr class="active">
    <th>번호</th>
    <th>브랜드 명</th>
    <th>작성일</th>
  </tr>
  <c:forEach var="item" items="${brand_list}">
	  <tr>
	    <th>${item.id}</th>
	    <th>${item.name}</th>
	    <th>${item.mod_date}</th>
	    <th><button type="button" class="btn btn-success" onclick="moveBrandUpd(${item.id})">수정</button></th>
	    <th><button type="button" class="btn btn-danger" onclick="deleteBrand(${item.id})">삭제</button></th>
	  </tr>
  </c:forEach>
</table>
<nav style="text-align:center;">
  <ul class="pagination">
    <li>
      <a href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>1</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>2</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>3</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>4</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>5</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>6</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>7</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>8</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>9</a></li>
    <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>10</a></li>
    <li>
      <a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>


</body>
</html>