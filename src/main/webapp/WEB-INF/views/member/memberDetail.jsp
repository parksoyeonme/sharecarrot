<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kh.sharecarrot.member.model.vo.Member, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script>
	console.log()
</script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="회원정보" name="title"/>
</jsp:include>
<style>
    div#update-container {
        width: 800px;
        text-align: center;
        margin-top: 40px;
        margin-bottom: 50px;
    }
    /* 부트스트랩 : 파일라벨명 정렬*/
    div#update-container label.custom-file-label {
        text-align: left;
    }
</style>
<div id="update-container" class="row mx-3 mx-auto text-center">
    <span class="fs-4 fw-bold">회원정보</span>
    <hr/>
    <div style="margin-left: -10px;" class="col-12">
		<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do?${_csrf.parameterName}=${_csrf.token}" 
   			method="post" enctype="multipart/form-data">     
            <!-- 테이블 -->
            <div class="mb-3 row">
                <label class="col-2 col-form-label fw-bold">프로필</label>
                <div class="col-2">
                    <img id="profileImg" src='${pageContext.request.contextPath}/resources/upload/member/<sec:authentication property="principal.profileRenamed"/>' style="max-width:80px; max-height:80px;">
                </div>
                <div class="col-6" id="upfiletr" style="margin-top: 41px;">
                    <div class="input-group" id="imgContainer">
                        <input type="file" class="form-control" id="upfile1" name="upfile">
                    </div>
                </div>
            </div>     
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">아이디</label>
	           <div class="col-8">
	               <input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="id" id="id" value='<sec:authentication property="principal.memberId"/>' readonly required/>
	           </div>
	       	</div>           
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">이름</label>
	           <div class="col-8">
	               <input type="text" class="form-control" placeholder="이름" name="name" id="name" value='<sec:authentication property="principal.memberName"/>' required/>
	           </div>
	       	</div>
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">생년월일</label>
	           <div class="col-8">
	               <input type="date" class="form-control" placeholder="생일" name="birthday" id="birthday" value='<sec:authentication property="principal.birthday"/>'/>
	           </div>
	       	</div>
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">이메일</label>
	           <div class="col-8">
	               <input type="email" class="form-control" placeholder="이메일" name="email" id="email" value='<sec:authentication property="principal.email"/>' required/>
	           </div>
	       	</div>
           	<hr/>
 	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">전화번호</label>
	           <div class="col-8">
	               <input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" value='<sec:authentication property="principal.phone"/>' required/>
	           </div>
	       	</div>
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">주소</label>
	           <div class="col-8">
	               <input type="text" class="form-control" name="address" id="address" value='<sec:authentication property="principal.memberAddr"/>' required/>
	           </div>
	       	</div>               
           	<hr/>
			<div class="row justify-content-end">
				<div class="col-2">
					<input type="button" class="btn btn-warning" id="changePwd" value="비밀번호변경" style="margin-left: -170px;" >
					<input type="submit" class="btn btn-warning" value="수정">
					<input type="reset" class="btn btn-warning" value="취소">
				</div>
			</div>
        </form:form>
     </div>
</div>

<script>
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

$('#changePwd').click(() =>{
	location.href="${pageContext.request.contextPath}/member/changePassword.do";
})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>