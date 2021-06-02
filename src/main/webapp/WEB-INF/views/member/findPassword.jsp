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

<div>
<form:form
	action="${pageContext.request.contextPath}/member/searchPassword.do"
	method="post">
	    <label for="name">ID : </label>
	    <input type="text" name="memberId" id="memberId">
	    <label for="email">이메일 : </label>
	    <input type="email" name="email" id="email">
    	<input type="submit" value="비밀번호 찾기?">
</form:form>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>