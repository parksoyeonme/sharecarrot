<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원등록" name="title"/>
</jsp:include>
<!-- 도로명주소 api를 위한 js -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/resources/js/addressapi.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />

<div id="enroll-container" class="mx-auto text-center" >
	
	
	<div class="sub_title" style="margin-top:50px;">
		<h1>회원가입</h1>
		<hr />
	</div>

	
	
	<form 
		name="memberEnrollFrm" 
		action="${pageContext.request.contextPath}/member/memberEnroll.do" 
		method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
						<input type="text" 
							   class="form-control" 
							   placeholder="4글자이상"
							   name="id" 
							   id="id"
							   required>
						<span class="guide result">사용여부</span>
						<input type="hidden" id="idValid" value="0"/>
					</div>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="password" id="password" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="passwordCheck" required>
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
					<input type="text" class="form-control" name="name" id="name" required>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>		
					<input type="date" class="form-control" name="birthday" id="birthday"/>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email">
				</td>
				<td>
					<input type="button" value="이메일 인증" class="btn btn-outline-secondary" style="margin-left:10px;">
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="address1" id="address1" readonly>
				</td>
				<td>
					<input type="button" value="주소 찾기" onclick="execPostCode();" class="btn btn-outline-secondary" style="margin-left:10px;">
				</td>
			</tr>
			<tr>
				<th>도로명 주소</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="address2" id="address2" readonly>
				</td>
			</tr>
			<tr>
				<th>상세 주소</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="address3" id="address3">
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form>
</div>
<script>

$(() => {
	$(".guide").hide();
});

// 도로명주소
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=address1]").val(data.zonecode);
           $("[name=address2]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}

// 중복검사
$('#id').keyup(e => {
	const id = $(e.target).val();
// 	console.log(id);
	const $idValid = $("#idValid");
	const $result = $(".guide.result");
	
	//아이디 처음 작성하거나, 다시 작성하는 경우
	if(id.length < 4){
		$(".guide").hide();
		$idValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		data: {id}, //변수 이름을 속성명으로 쓰고 싶을 때
		success: data => {
			$(".guide").show();
			console.log(data);
			if(data.usable){
				$result.show();
 			    $result.html("아이디가 사용 가능합니다.");

				$idValid.val(1);
			}else{
 			    $result.html("이미 존재하는 아이디입니다.");
				$idValid.val(0);				
			}
		},
		error: (xhr, status, err) =>{
			console.log(xhr, status, err);
		}
	});
});

$("#passwordCheck").blur(function(){
	var $password = $("#password"), $passwordCheck = $("#passwordCheck");
	if($password.val() != $passwordCheck.val()){
		alert("패스워드가 일치하지 않습니다.");
		$password.select();
	}
});
	
/**
 * 회원 등록 유효성검사
 */
$("[name=memberEnrollFrm]").submit(function(){

	var $id = $("#id");
	if(/^\w{4,}$/.test($id.val()) == false) {
		alert("아이디는 최소 4자리이상이어야 합니다.");
		$id.focus();
		return false;
	}
	
	//중복검사여부
	var $idValid = $("#idValid");
	if($idValid.val() == 0){
		alert("아이디 중복 검사해주세요.");
		return false;
	}
	return true;
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
