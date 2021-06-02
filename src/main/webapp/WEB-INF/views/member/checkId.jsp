<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원등록" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<c:choose>
	<c:when test="${not empty memberId}">
		<div>
			회원님의 아이디는 <b>${memberId}</b> 입니다.
			<!-- 로그인으로 이동 -->
		</div>
	</c:when>
	<c:otherwise>
		<div>
			조회된 아이디가 없습니다.
			<!-- 다시 아이디 조회 -->
		</div>
	</c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>