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
	<c:when test="${not empty email}">
		<div>
			회원님의 이메일(<b>${email}</b>)로 임시 비밀번호를 전송했습니다.
			<!-- 로그인으로 이동 -->
		</div>
	</c:when>
	<c:otherwise>
		<div>
			없어요 그런사람
			<!-- 다시 아이디 조회 -->
		</div>
	</c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>