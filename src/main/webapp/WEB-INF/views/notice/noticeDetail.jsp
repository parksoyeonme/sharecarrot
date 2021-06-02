<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항 상세보기" name="title"/>
</jsp:include>
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<div id="board-container" class="mx-auto text-center">
	<input type="text" class="form-control" placeholder="제목" name="noticeTitle" id="noticeTitle" value="${notice.boardTitle}" required>
	<input type="text" class="form-control" name="memberId" value="${notice.memberId}" readonly required>
    <textarea class="form-control" name="Content" placeholder="내용" required>${notice.boardContent}</textarea>
</div>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<input type="button" class="btn btn-primary form-control" value="수정" onclick="noticeUpdateForm(${notice.boardNo});"/>
<input type="button" class="btn btn-primary form-control" value="삭제" onclick="deleteForm(${notice.boardNo});"/>
</sec:authorize>
<form:form
			id="deleteFrm"
			method="post"
			action="${pageContext.request.contextPath}/notice/deleteForm.do?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name="no" value="${notice.boardNo}">
</form:form>
<script>
function deleteForm(no){
	if(confirm(`\${no}번 내용을 삭제하시겠습니까?`)){
		$(deleteFrm).submit();
	}
}
function noticeUpdateForm(no){
	location.href = `${pageContext.request.contextPath}/notice/noticeUpdateForm.do?no=\${no}`;
	console.log(no);
}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
