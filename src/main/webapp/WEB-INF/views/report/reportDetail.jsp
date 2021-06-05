<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<style>
div#board-container{width:800px; text-align:center; margin-top:40px; margin-bottom:50px;}
</style>
<div id="board-container" class="mx-auto text-center">
<span class="fs-3 fw-bold">신고합니다&nbsp;</span>
<!-- 테이블 -->
		<table  id="report_table" class="table table-bordered" style="vertical-align:middle">
		<!-- 한 행 -->
			<tr>
				<td colspan="2"><input type="text" class="form-control" placeholder="제목" name="boardTitle" id="title" value="${report.reportTitle}" readonly required></td>
			</tr>
			<tr>
			<!-- 한 열 -->
				<td colspan="2"><input type="button" class="btn btn-primary" id="addImgBtn" value="이미지 등록"/></td>
			</tr>
			<tr id="upfiletr">
				<td colspan="2">
					<c:forEach items="${reportImage}" var="reportImage">
					<button type="button" class="btn btn-outline-success btn-block" onclick="fileDownload(${reportImage.reportImgId});">
						첨부파일 - ${reportImage.reportImgOrigin}
					</button>
					</c:forEach>
			    </td>
			</tr>
			<tr>
				<td>신고자</td>
				<td><input type="text" class="form-control" name="memberId" value="${report.memberId}" readonly required></td>
			</tr>
			<tr>
				<td>신고할 상점</td>
				<td><input type="text" class="form-control" name="shopId" value="${report.shopId}" readonly required></td>
			</tr>
			<tr>                                                                         
				<td colspan="2"><textarea class="form-control" name="content" placeholder="내용" readonly required>${report.reportContent}</textarea></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="button" class="btn btn-danger" style="width:150px;" value="정지" onclick="goReprtList(${report.reportNo});" />
				</td>
			</tr>
		</table>   
</div>

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
