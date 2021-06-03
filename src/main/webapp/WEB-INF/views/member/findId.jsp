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
<style>
	.info-container{
		width: 100%;
		height: calc(100vh - 100px);
		background-color: hotpink;
		display: flex;
		justify-content: center;
		align-items: center;

	}
	.info-wrapper{
		background-color: aqua;
		width: 400px;
		height: 400px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.info-input{
		height: 50%;
	}

/* .info-input input{
    background: none;
   
    border: none;
    line-height: 45px;
    padding-left:10px;
    width:267px;
}
.info-input input:focus{
    outline: none;
} */
</style>
<div class="info-container">
<form:form
	action="${pageContext.request.contextPath}/member/findId.do"
	method="POST">
	<div class="info-wrapper">
		<div class="info-title">
			<p>아이디 찾기</p>
		</div>
		<div class="info-input">
			<div class="name-space">
				<label for="name">🤦‍♂️</label>
				<input type="text" name="memberName" id="memberName" placeholder="이름">
			</div>
			<div class="email space">
				<label for="email">📩</label>
				<input type="email" name="email" id="email" placeholder="이메일">
			</div>
		</div>
		<div class="button-space">
			<input type="submit" value="아이디 찾기">
		</div>
	</form:form>
</div>
</div>
<script>
	const inputName = document.querySelector("#memberName");
	const intputEmail = document.querySelector("#email");
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>