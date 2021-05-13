<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
</style>
<section id="board-container" class="container">
<br />
	<ul class="nav nav-tabs nav-fill" id="navBars">
    <li class="nav-item">
      <a class="nav-link active" aria-current="page" href="#">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C1">여행/음식</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C2">취미생활</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C3">헬스/다이어트</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C4">반려동물</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C5">회사생활</a>
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

	<c:forEach items="${boardList}" var="board">
		<table id="tbl-board" class="table table-striped table-hover">
			<tr>
				<td>${board.memberId}</td>
				<th colspan="2">${board.boardTitle}</th>
				<td><fmt:formatDate value="${board.boardEnrollDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr id="boardImage-tr">
			<td colspan="4">
				<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
					<div class="carousel-inner">
					<div class="carousel-item active" style="height:500px;"></div>
					<c:forEach items="${board.boardImageList}" var="boardImg">
					  <div class="carousel-item">
					    <img src="${pageContext.request.contextPath}/resources/upload/board/${boardImg.boardImgRenamed}" class="d-block w-100" alt="...">
					  </div>
					  </c:forEach>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-bs-slide="prev">
					  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					  <span class="visually-hidden">Previous</span>
					</a>
					<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-bs-slide="next">
					  <span class="carousel-control-next-icon" aria-hidden="true"></span>
					  <span class="visually-hidden">Next</span>
					</a>
				</div>
			</td>
				<%-- <td><img src="${pageContext.request.contextPath}/resources/upload/board/${boardImg.boardImgRenamed}" /></td> --%>
			</tr>
			<tr>
				<td colspan="4">${board.boardContent}</td>
			</tr>
			<tr>
				<td>좋아요버튼</td>
			</tr>
			<tr>
				<td colspan="4">댓글창</td>
			<tr>
			<tr>
				<td colspan="4">
					<textarea id="boardCommentText" style="width:80%;"></textarea>
					<input type="button" class="btn btn-primary" value="댓글 등록" style="margin-top: -50px;"/>
				</td>
			</tr>
		</table>
	</c:forEach>
	${pageBar}
</section>
<script>
	function goBoardForm(){
		console.log('test');
		location.href="${pageContext.request.contextPath}/board/boardEnroll.do";
	}
</script> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
