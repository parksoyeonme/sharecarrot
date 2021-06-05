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

<style>
    div#enroll-container {
        width: 800px;
        text-align: center;
        margin-top: 40px;
        margin-bottom: 50px;
    }
    /* 부트스트랩 : 파일라벨명 정렬*/
    div#enroll-container label.custom-file-label {
        text-align: left;
    }
</style>

<div id="enroll-container" class="row mx-3 mx-auto text-center">
    <span class="fs-4 fw-bold">회원가입</span>
    <hr/>
    <div style="margin-left: -34px;" class="col-12">
		<form 
		name="memberEnrollFrm" 
		action="${pageContext.request.contextPath}/member/memberEnroll.do?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data">
        	<!-- 테이블 -->
            <div class="mb-3 row">
                <label class="col-2 col-form-label fw-bold">프로필사진</label>
                <div class="col-6" id="upfiletr">
                    <div class="input-group" id="imgContainer">
                        <input type="file" name="upfile" id="upfile" >
                    </div>
                </div>
                <div class="col-1">
                    <img id="profileImg" src="" style="max-width:150px; max-height:80px;">
                </div>
            </div>            
    		<hr/>
          	<div class="mb-3 row">
            	<label class="col-2 col-form-label fw-bold">아이디</label>
              	<div class="col-8">
                	<input type="text" class="form-control" placeholder="4글자이상" name="id"	id="id"	required>
						<span class="guide result">사용여부</span>
						<input type="hidden" id="idValid" value="0"/>
               	</div>
            </div>
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">패스워드</label>
	           <div class="col-8">
	               <input type="password" class="form-control" name="password" id="password" required>
	           </div>
	       	</div>
	       	<hr/>           	
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">패스워드확인</label>
	           <div class="col-8">
	               <input type="password" class="form-control" id="passwordCheck" required>
	           </div>
	       	</div>
	       	<hr/>            	
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">이름</label>
	           <div class="col-8">
	               <input type="text" class="form-control" name="name" id="name" required>
	           </div>
	       	</div>
	       	<hr/>            	
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">연락처</label>
	           <div class="col-8">
	               <input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
	           </div>
	       	</div>
	       	<hr/>             	
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">생년월일</label>
	           <div class="col-8">
	               <input type="date" class="form-control" name="birthday" id="birthday"/>
	           </div>
	       	</div>
	       	<hr/>            	
            <div class="mb-3 row">
                <label class="col-2 col-form-label fw-bold">이메일</label>
                <div class="col-8">
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email">                   
                    </div>
                </div>
                <div class="col-1">
                    <input type="button" value="인증번호 전송" class="btn btn-warning" name="emailbutton" id="emailbutton">
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-10">
                    <div class="input-group">
                        <input	type="text" class="form-control" placeholder="인증번호 입력" name="emailconfirm" id="emailconfirm" style="margin-left:133px;" readonly>                   
                    </div>
                </div>
                <div class="col-1">
                    <input type="button" value="인증번호 확인"  class="btn btn-warning" name="emailconfirmbutton" id="emailconfirmbutton" style="margin-left:10px; visibility:hidden;">
					<input type="hidden" id="emailValid" value="0"/>
                </div>
            </div>
			<hr/> 
            <div class="mb-3 row">
                <label class="col-2 col-form-label fw-bold">우편번호</label>
                <div class="col-8">
                    <div class="input-group" id="imgContainer">
                        <input type="text" class="form-control" placeholder="" name="address1" id="address1" readonly>
                    </div>
                </div>
                <div class="col-1">
                    <input type="button" value="주소 찾기" onclick="execPostCode();" class="btn btn-warning">
                </div>
            </div>	       	
	       	<hr/>           	
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">도로명주소</label>
	           <div class="col-8">
	               <input type="text" class="form-control" placeholder="" name="address2" id="address2" readonly>
	           </div>
	       	</div>
	       	<hr/>           	
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">상세주소</label>
	           <div class="col-8">
	               <input type="text" class="form-control" placeholder="" name="address3" id="address3">
	           </div>
	       	</div>          	
           	<hr/>
           	<div class="row justify-content-end">
               <div class="col-2">
                   <input type="submit" class="btn btn-warning" style="margin-left: -76px;" value="가입">
                   <input type="reset" onclick="cancel();" class="btn btn-warning" value="취소">
               </div>
            </div>
        </form>
     </div>
</div>
    
<script>
function cancel(){
	location.href = location.href = "${pageContext.request.contextPath}";
}


// 이메일 인증용 코드
var code = "";  
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
//            console.log(data.zonecode);
//            console.log(fullRoadAddr);
           
           
           $("[name=address1]").val(data.zonecode);
           $("[name=address2]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}
$('[name=emailbutton]').click(function(){
	// 이메일 유효성 검사
	var email = $("#email").val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if( !email ){ 
	   alert("이메일주소를 입력 해 주세요"); 
	   $("#email").focus(); 
	   return false; 
	} else { 
	   if(!regExp.test(email)) { 
	      alert("이메일 주소가 유효하지 않습니다"); 
	      $("#email").focus(); 
	      return false; 
	   } 
	} 
	
	$('[name=emailconfirm]').attr("readonly",false);	
	$('[name=emailconfirmbutton]').attr("style","visivility:visible");	
	$('[name=emailconfirmbutton]').attr("style","margin-left:10px");	
	alert('인증번호가 전송되었습니다.');
    $.ajax({
        
        type:"GET",
        url:"${pageContext.request.contextPath}/member/emailCheck.do?email="+email,
        success:function(data){
//             console.log(data);
            code = data;
        }                
    });
	
});
$('[name=emailconfirmbutton]').click(function(){
	var emailconfirm = $("#emailconfirm").val();
	var $emailValid = $("#emailValid");
	if(code != emailconfirm){
		alert('인증번호가 일치하지 않습니다.');
		return false;
	}else{
		alert('이메일 인증에 성공하였습니다.');
		$emailValid.val(1);
		$('[name=emailconfirm]').attr("readonly",true);			
	}
});
	
	
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
// 			console.log(data);
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
	
	var $emailValid = $("#emailValid");
	if($emailValid.val() == 0){
		alert("이메일 중복 검사해주세요.");
		return false;
	}
	
	return true;
});
$('#upfile').change(function(){
    setProfile(this, '#profileImg');
    if(!/([^\s]+(?=\.(jpg|gif|png))\.\2)/.test($("#upfile").val())){
        alert('프로필사진은 jpg|png|gif 형식의 파일만 가능합니다.');
        return false;
    }
});
function setProfile(input, profileImg){
    if(input.files && input.files[0]){
        var reader = new FileReader();
        reader.onload = function(e){
            $(profileImg).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>