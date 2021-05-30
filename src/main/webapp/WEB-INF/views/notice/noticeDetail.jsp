<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항 상세보기" name="title"/>
</jsp:include>
<style>
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button { overflow: hidden; }
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<div id="board-container" class="mx-auto text-center">
	<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="title" value="${notice.boardTitle}" required>
	<input type="text" class="form-control" name="memberId" value="${notice.memberId}" readonly required>
    <textarea class="form-control" name="content" placeholder="내용" required>${notice.boardContent}</textarea>
	<input type="datetime-local" class="form-control" name="regDate" value='<fmt:formatDate value="${notice.boardEnrollDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>'>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
