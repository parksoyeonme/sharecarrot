<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<section id="board-container" class="container">
<br />
	<ul class="nav nav-tabs nav-fill" id="navBars">
    <li class="nav-item">
      <a class="nav-link active" aria-current="page" href="#">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">여행/음식</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">취미생활</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">헬스/다이어트</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">반려동물</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">회사생활</a>
    </li>
  </ul>

  <script>
    const navItem = $("ul .nav-item");
    navItem.click(function(e){
      navItem.removeClass('active');
      $.each(navItem, function(index, item){
        let tagA = $(item).find('a');
        tagA.removeClass('active');
      });
      $(e.target).addClass('active');
    });
  </script>

	<select class="col-md-2" id="validationCustom04" required>
	  <option selected disabled value="">지역선택</option>
	  <option value="L1">강서구</option>
	  <option value="L2">양천구</option>
	  <option value="L3">구로구</option>
	  <option value="L4">영등포구</option>
	  <option value="L5">금천구</option>
	  <option value="L6">동작구</option>
	  <option value="L7">관악구</option>
	  <option value="L8">서초구</option>
	  <option value="L9">강남구</option>
	  <option value="L10">송파구</option>
	  <option value="L11">강동구</option>
	</select>
	<select class="col-md-2" id="validationCustom04" required>
	  <option value="latest">최신순</option>
	  <option value="hottest">인기순</option>
	</select>
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success pull-right" onclick="goBoardForm();"/>

	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach items="${boardList}" var="board">
		<tr data-no="${board.boardNo}">
			<td>${board.boardNo}</td>
			<td>${board.boardTitle}</td>
			<td>${board.memberId}</td>
			<td><fmt:formatDate value="${board.boardEnrollDate}" pattern="yyyy-MM-dd"/></td>
		</tr>
		</c:forEach>
	</table>
	${pageBar}
</section>
<script>
	function goBoardForm(){
		console.log('test');
		location.href="${pageContext.request.contextPath}/board/boardEnroll.do";
	}
</script> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
