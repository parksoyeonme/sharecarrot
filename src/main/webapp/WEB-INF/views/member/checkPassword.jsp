<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="비밀번호확인" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<style>
	.result-container{
	width: 100%;
	height: calc(100vh - 100px);
	/* background-color: hotpink; */
	display: flex;
	justify-content: center;
	align-items: center;

}
.result-wrapper{
	justify-content: center;
}
.password-search-result{
	/* background-color: aqua; */
	width: 400px;
	height: 400px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
.content-container{
	text-align: center;
	width: 100%;
	height: 80%;
	/* justify-content: center; */
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.content-container b{
	font-size: 32px;
	border-bottom: 3px solid #f7863b;
}
.content-info{
	font-size: 18px;
	font-weight: 600;
	margin-top: 10px;
}
.btn-password {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0 8px;
  border: none;
  border-radius: 4px;
  font-weight: 700;

  color: #fff;
  background-color: #3da5f5;
  transition: background-color 200ms ease-in-out;
}
.btn-large {
	width: 200px;
	height: 40px;
  font-size: 18px;
  line-height: 24px;
  letter-spacing: -0.01em;
}
.btn-password:hover {
  background-color: #3186c4;
}

</style>
<div class="result-container">
	<c:choose>
		<c:when test="${not empty email}">
			<div class="result-wrapper">
				<div class="password-search-result">
					<div class="content-container">
						<div class="content-email">
							<b>${email}</b>
						</div>
						<div class="content-info">
							으로
							임시 비밀번호를 발송했습니다.
						</div>
					</div>
						<div class="btn-container">
						<!-- 로그인으로 이동 -->
						<div class="buttons">
							<input type="button" class="button btn-password btn-large" id="login-btn" value="로그인">
						</div>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="result-wrapper">
				<div class="password-search-result">
					<div class="password-search-result">
						<div class="content-container">
						<b>조회된 회원이 없습니다.</b>
						<!-- 비밀번호 찾기로 이동 -->
						</div>
					</div>
						<div class="btn-container">
							<div class="buttons">
								<input type="button" class="button btn-password btn-large" id="find-password-btn" value="비밀번호 찾기">
							</div>
						</div>
					</div>
				</div>
		</c:otherwise>
	</c:choose>
</div>
<script>
	const loginBtn = document.getElementById("login-btn");
	const findPasswordBtn = document.getElementById("find-password-btn");
	const btn = document.querySelector(".button")
	
	btn.addEventListener('click', ()=>{
		if(loginBtn == null){
			history.back();
		}
		else if(findPasswordBtn == null) {
			location.href='${pageContext.request.contextPath}/member/memberLogin.do';
		}
	})
	</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>