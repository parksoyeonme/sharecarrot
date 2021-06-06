<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	#EnrollFrm{
		width: 70%;
		margin: 0 auto;
		border: 1px solid green;
		padding: 20px 20px;
	}
	
	#imgContainer{
		width: 70%;
		margin: 0 auto;
	}
</style>
  <form:form 
  		class="mt-3"
  		id="EnrollFrm"
  		method="post" 
  		action="${pageContext.request.contextPath}/board/boardEnroll.do?${_csrf.parameterName}=${_csrf.token}" 
  		enctype="multipart/form-data">
    <select id="boardCategory" name="boardCategory" required>
      <option selected disabled value="">카테고리</option>
      <option value="C1">여행/음식</option>
      <option value="C2">취미생활</option>
      <option value="C3">헬스/다이어트</option>
      <option value="C4">반려동물</option>
      <option value="C5">회사생활</option>
    </select>
    <select class="col-md-2" name="locCode" required>
	  <option selected disabled value="">지역선택</option>
	  <c:forEach items="${locationList}" var="location">
	  	<option value="${location.locCode}">${location.locName}</option>
	  </c:forEach>
	</select>
    <input type="text" name="memberId" id="memberId" value="<sec:authentication property="principal.username"/>" readonly>
    <hr/>
    <div class="mb-3">
      <input type="text" class="form-control" name="boardTitle" id="boardTitle" placeholder="제목을 입력해주세요">
    </div>
    <div class="form-floating mb-3">
      <textarea class="form-control" id="boardContent" name="boardContent" rows="5" style="height: 300px;"></textarea>
      <label for="boardContent" style="color: orange; resize: none;">회원들과 소중한 추억을 공유해보세요!</label>
    </div>
    <div class="" id="imgContainer">
      <input type="file" class="form-control" id="upfile0" name="upfile">
    </div>
    <br/>
    <div style="text-align: right;">
    	<input type="button" class="btn btn-success btn-sm mb-5" id="addImgBtn" value="이미지 추가 등록"/>
    </div>
    
    <hr/>
    <div style="text-align: center;">
    	<button class="btn btn-success" style="width:300px;">등록</button>
    </div>
  </form:form>
  <script>
    var i = 1;
    $("#addImgBtn").click(function(){
      i++;
      
      if(i > 10) {
        alert("이미지 파일은 최대 10개까지만 등록이 가능합니다.");
        return;
      }
      $("#imgContainer").append("<input type='file' class='form-control' id='upfile"+i+"' name='upfile'>");
    });
  </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
