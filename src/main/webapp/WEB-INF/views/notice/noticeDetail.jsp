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
div#board-container{width:800px; height:300px; text-align:center; margin-top:40px; margin-bottom:50px;}
/* div#board-container h1 { margin-top:30px; } */
</style>



<form:form
			id="deleteFrm"
			method="post"
			action="${pageContext.request.contextPath}/notice/deleteForm.do?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name="no" value="${notice.boardNo}">
</form:form>



<div id="board-container" class="mx-auto text-center" >
<h1>공지사항</h1>
<hr/>

	<table class="table table-bordered" style="vertical-align:middle">
		<tr >
			<td colspan="2" >
				<input type="text" class="form-control" placeholder="제목" 
				name="noticeTitle" id="noticeTitle" value="${notice.boardTitle}" required>
			</td>
		</tr>
		<tr >
			<td colspan="2">
				<input type="text" class="form-control" name="memberId" value="${notice.memberId}" readonly required>
			</td>
		</tr>
		<tr >
			<td colspan="2">
			    <textarea class="form-control" name="Content" placeholder="내용" required>${notice.boardContent}</textarea>
			</td>
		</tr>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		<tr>
			<td>			
				<input type="button" class="btn btn-outline-secondary" style="width:150px;" value="수정" onclick="noticeUpdateForm(${notice.boardNo});"/>
			</td>
			<td>
				<input type="button" class="btn btn-outline-secondary" style="width:150px;" value="삭제" onclick="deleteForm(${notice.boardNo});"/>			
			</td>
		</tr>
		</sec:authorize>
	</table>
</div>

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
