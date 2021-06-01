<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
<jsp:param value="공지사항" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
 .searchlist{
 	margin-left: 1000px;
 }
</style>
<script>
function goNoticeForm(){
	location.href = "${pageContext.request.contextPath}/notice/noticeForm.do";
}

$(() => {
	$("tr[data-no]").click(e => {
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		
		location.href = `${pageContext.request.contextPath}/notice/noticeDetail.do?no=\${no}`;
	});
	
	//검색버튼 클릭했을때
	$(searchNoitcButton).click(e =>{
		//검색창
		const searchNoticeTitle = $("#searchNoticeTitle");
		//사용자가 입력한값
		const searchKeyword = searchNoticeTitle.val();
		//검색내용이 비어있다면 취소
		if(!searchNoticeTitle){
			alert('검색어를 입력해주세요.');
			return;
		}
		else {
			location.href=`${pageContext.request.contextPath}/notice/noticeList.do?searchKeyword=\${searchKeyword}`;
		}	
	});
});
</script>
<section id="board-container" class="container">
	<h1>공지사항</h1>
	<div class="searchlist">
	<select id="clickesearch" required>
	  <option value="title">제목</option>
	</select>
	<input type="text" placeholder="검색.." id="searchNoticeTitle" />
	<input type="button" value="검색" id="searchNoitcButton" />
	</div>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			
		</tr>
		<c:forEach items="${noticeList}" var="notice">
		<tr data-no="${notice.boardNo}">
			<td>${notice.boardNo}</td>
			<td>${notice.boardTitle}</td>
			<td>${notice.memberId}</td>
			<td><fmt:formatDate value="${notice.boardEnrollDate}" pattern="yy/MM/dd"/></td>
		</tr>
		</c:forEach>
		
	</table>
	${pageBar}
	<sec:authorize access="hasRole('ADMIN')">
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goNoticeForm();"/>
	</sec:authorize>
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
