<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="비밀번호변경" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<style>
	.info-container{
		width: 100%;
		height: calc(100vh - 100px);
		display: flex;
		justify-content: center;
		align-items: center;

	}
	.info-wrapper{
		/* background-color: aqua; */
		width: 400px;
		height: 400px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.info-title{
		font-size: 24px;
		font-weight: bold;
		width: 100%;
		text-align: center;
	}
	.info-input{
		width: 100%;
		height: 50%;
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		align-items: center;
	}

	input {
		width: 300px;
		height: 50px;
		border: none;
		border-bottom: 2px solid #f7863b;
	}
	.btn-search {
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
.btn-search:hover {
  background-color: #3186c4;
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
	method="POST"
	onsubmit="return validation()">
	<div class="info-wrapper">
		<div class="info-title">
			<p>비밀번호 변경</p>
		</div>
		<div class="info-input">
			<div class="old-password-space">
				<!-- <label for="name">🤦‍♂️</label> -->
				<input type="password" name="oldPassword" id="old-password" placeholder="현재 비밀번호">
			</div>
			<div class="new-password-space">
				<!-- <label for="password">📩</label> -->
				<input type="password" name="newPassword" id="new-password"placeholder="변경할 비밀번호">
			</div>
			<div class="new-password-confirm-space">
				<!-- <label for="password">📩</label> -->
				<input type="password" name="new-password-chk" id="new-password-chk" placeholder="변경할 비밀번호 확인">
			</div>
            <div>
                <input type="hidden" name="memberId" id="memberId" value="<sec:authentication property='principal.username'/>" /> 
            </div>
		</div>
		<div class="button-space">
			<input type="submit" class="btn-search btn-large" value="비밀번호 변경">
		</div>
	</form:form>
</div>
</div>
<script>
	const inputOldPassword = document.querySelector("#old-password");
	const inputPassword = document.querySelector("#new-password");
	const inputPasswordChk = document.querySelector("#new-password-chk");

	const oldPassword = inputOldPassword.value;
	const newPassword = inputPassword.value;
	const memberId = document.querySelector("#memberId").value;
	
	function validation(){
		console.log(oldPassword, newPassword, memberId);
		if(inputOldPassword.value == "") {
			alert("현재 비밀번호를 입력하세요");
			return false;
		}
		else if(inputPassword.value ==""){
			alert("변경할 비밀번호를 입력하세요");
			return false;
		}
		else if(inputPasswordChk.value== ""){
			alert("변경할 비밀번호와 같은 비밀번호를 입력하세요");
			return false;
		}
		else if(inputPassword.value!= inputPasswordChk.value){
			alert("변경을 위해 입력한 두 비밀번호가 다릅니다.");
			return false;
		}
		else if(inputOldPassword.value == inputPassword.value){
			alert("기존에 사용하신 비밀번호로 변경할 수 없습니다.");
			return false;
		}

		return true;
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>