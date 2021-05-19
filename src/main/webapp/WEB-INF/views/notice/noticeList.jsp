<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/history.jsp" />

<div class="sub_title">
	<h1>공지사항</h1>
	
    <div class="search-form">
    	<input type="text"  placeholder="검색어 입력">
    </div>
	<hr />
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</script>

<!-- <section id="board-container" class="container"> -->
<!--    <input type="search" placeholder="제목 검색..." id="searchTitle" class="form-control col-sm-3 d-inline"/> -->
<!--    <input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goBoardForm();"/> -->
<!--    <table id="tbl-board" class="table table-striped table-hover"> -->
<!--       <tr> -->
<!--          <th>번호</th> -->
<!--          <th>제목</th> -->
<!--          <th>작성자</th> -->
<!--          <th>작성일</th> -->
<!--          <th>첨부파일</th> 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px -->
<!--          <th>조회수</th> -->
<!--       </tr> -->
<%--       <c:forEach items="${list}" var="board"> --%>
<%--       <tr data-no="${board.no}"> --%>
<%--          <td>${board.no}</td> --%>
<%--          <td>${board.title}</td> --%>
<%--          <td>${board.memberId}</td> --%>
<%--          <td><fmt:formatDate value="${board.regDate}" pattern="yy/MM/dd"/></td> --%>
<!--          <td> -->
<%--             <c:if test="${board.attachCount gt 0}"> --%>
<%--             <img alt="file" src="${pageContext.request.contextPath}/resources/images/file.png" width="16px"> --%>
<%--             </c:if> --%>
<!--          </td> -->
<%--          <td>${board.readCount}</td> --%>
<!--       </tr> -->
<%--       </c:forEach> --%>
      
<!--    </table> -->
<%--    ${pageBar} --%>
<!-- </section>  -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
