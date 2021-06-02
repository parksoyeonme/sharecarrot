<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<div id="board-container" class="mx-auto text-center">
	<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="title" value="${report.reportTitle}" required>
	<c:forEach items="${reportImage}" var="reportImage">
	<button type="button" class="btn btn-outline-success btn-block" onclick="fileDownload(${reportImage.reportImgId});">
		첨부파일 - ${reportImage.reportImgOrigin}
	</button>
	</c:forEach>
	<input type="text" class="form-control" name="memberId" value="${report.memberId}" readonly required>
	<input type="text" class="form-control" name="shopId" value="${report.shopId}" readonly required>
    <textarea class="form-control" name="content" placeholder="내용" required>${report.reportContent}</textarea>
</div>
<input type="button" class="btn btn-primary form-control" value="정지" onclick="goReprtList(${report.reportNo});" />
<script>
function goReprtList(no){
	if(confirm("해당 내용을 처리하시겠습니까?")){
		location.href = "${pageContext.request.contextPath}/report/reportListGo.do?no=" + no;
	}
	
}
function fileDownload(no){
	location.href = "${pageContext.request.contextPath}/report/fileDownload.do?no=" + no;
}
</script>	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
