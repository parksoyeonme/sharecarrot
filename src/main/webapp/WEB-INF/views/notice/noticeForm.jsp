﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title"/>
</jsp:include>
<style>
div#board-container{width:800px; height:300px; text-align:center; margin-top:40px; margin-bottom:50px;}
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

/* function cancel(){
	location.href=	"${pageContext.request.contextPath}/notice/noticeList.do";
} */
function cancel(){
	history.go(-1);
	
}

</script>

<div id="board-container" class="mx-auto text-center">
<h1>공지사항 등록</h1>
<hr/>
	<form 
		name="noticeFrm" 
		action="${pageContext.request.contextPath}/notice/noticeEnroll.do?${_csrf.parameterName}=${_csrf.token}"
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return noticeValidate();">		

		<table class="table table-bordered" style="vertical-align:middle">
			<tr>
				<td colspan="2">
					<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" required>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="text" class="form-control" name="memberId" id="memberId" value="<sec:authentication property="principal.username"/>" readonly required>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea class="form-control" name="boardContent" placeholder="내용" required></textarea></td>
			</tr>
			<tr>
				<td><input type="submit" class="btn btn-outline-secondary" style="width:150px;" value="글등록" ></td>
				<td><input type="button" onclick="cancel();" class="btn btn-outline-secondary" style="width:150px;" value="취소" ></td>
			</tr>			
		</table>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
