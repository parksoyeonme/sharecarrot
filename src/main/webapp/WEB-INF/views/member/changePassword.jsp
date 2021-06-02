<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
	action="${pageContext.request.contextPath}/member/changePassword.do"
	method="POST">
	<div class="info-wrapper">
		<div class="info-title">
			<p>아이디 찾기</p>
		</div>
		<div class="info-input">
			<div class="old-password-space">
				<label for="name">🤦‍♂️</label>
				<input type="text" name="oldPassword" placeholder="현재 비밀번호">
			</div>
			<div class="new-password-space">
				<label for="password">📩</label>
				<input type="password" name="newPassword"  placeholder="변경할 비밀번호">
			</div>
			<div class="new-password-confirm-space">
				<label for="password">📩</label>
				<input type="password" name="newPasswordChk" placeholder="변경할 비밀번호 확인">
			</div>
            <div>
                <input type="hidden" name="memberId" value="<sec:authentication property='principal.username'/>" /> 
            </div>
		</div>
		<div class="button-space">
			<input type="submit" value="비밀번호 변경">
		</div>
	</form:form>
</div>
</div>
<script>
	const inputName = document.querySelector("#oldPassword");
	const intputpassword = document.querySelector("#password");
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>