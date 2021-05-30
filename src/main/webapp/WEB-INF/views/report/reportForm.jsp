<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title"/>
</jsp:include>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}

</style>
<script>

var i = 1;

$(() => {
	$("#addImgBtn").click(function(){
		i++;
		if(i > 10) {
			alert("이미지 파일은 최대 10개까지만 등록이 가능합니다.");
			return;
		}
		$("#imgContainer").append("<input type='file' class='form-control' id='upfile"+i+"' name='upfile'>");
	});
	
});

function reportValidate(){
	var $reportTitle = $("[name=reportTitle]");
	var $reportContent = $("[name=reportContent]");

	if(/^(.|\n)+$/.test($reportTitle.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	
	if(/^(.|\n)+$/.test($reportContent.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>
<div id="board-container">
	<form 
		name="reportFrm" 
		action="${pageContext.request.contextPath}/report/reportEnroll.do?${_csrf.parameterName}=${_csrf.token}"
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return reportValidate();">
		<input type="text" class="form-control" placeholder="제목" name="reportTitle" id="reportTitle" required>
		<input type="button" class="btn btn-primary" id="addImgBtn" value="이미지 등록"/>
	    <div class="input-group" id="imgContainer">
	      <input type="file" class="form-control" id="upfile1" name="upfile">
	    </div>
		<input type="text" class="form-control" name="memberId" id="memberId" value="<sec:authentication property="principal.username"/>" readonly required>
		<input type="text" class="form-control" name="shopId" id="shopId" value="t8" readonly required>
	    <textarea class="form-control" name="reportContent" placeholder="내용" required></textarea>
		<br />
		<input type="submit" value="글등록" >
		<input type="button" class="btn btn-outline-success" value="취소" >
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
