<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title"/>
</jsp:include>
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}

</style>
<script>
function noticeValidate(){
	var $boardTitle = $("[name=boardTitle]");
	var $boardContent = $("[name=boardContent]");

	if(/^(.|\n)+$/.test($boardTitle.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	
	if(/^(.|\n)+$/.test($boardContent.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

function cancel(){
	location.href=	"${pageContext.request.contextPath}/notice/noticeList.do";
}

</script>
<div id="board-container">
	<form 
		name="noticeFrm" 
		action="${pageContext.request.contextPath}/notice/noticeEnroll.do?${_csrf.parameterName}=${_csrf.token}"
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return noticeValidate();">
		<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" required>
		<input type="text" class="form-control" name="memberId" id="memberId" value="<sec:authentication property="principal.username"/>" readonly required>
		
		
		
		
	    <textarea class="form-control" name="boardContent" placeholder="내용" required></textarea>
		<br />
		<input type="submit" class="btn btn-primary form-control"value="글등록" >
		<input type="button" onclick="cancel();" class="btn btn-primary form-control" value="취소" >
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
