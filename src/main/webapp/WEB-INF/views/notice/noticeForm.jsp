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
		<input type="text" class="form-control" name="memberId" id="memberId" value="<sec:authentication property="principal.username"/>" readonly required>
		<input type="text" class="form-control" name="shopId" id="shopId" value="t8" readonly required>
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input 
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1">
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일2</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile2" >
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
		  </div>
		</div>
		-->
		
		
		
	    <textarea class="form-control" name="reportContent" placeholder="내용" required></textarea>
		<br />
		<input type="submit" value="글등록" >
		<input type="button" class="btn btn-outline-success" value="취소" >
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
