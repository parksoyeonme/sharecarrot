<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kh.sharecarrot.member.model.vo.Member, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<% 
   /* List.contains메소드를 사용하기 위해 String[] => List로 형변환함.  */
   Member member = (Member)session.getAttribute("loginMember");
%>
<script>
	console.log()
</script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="회원정보" name="title"/>
</jsp:include>
<style>

div#update-container{width:600px; margin:0 auto; text-align:center;}
div#update-container input, div#update-container select {margin-bottom:10px;}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />


<div id="update-container" class="mx-auto text-center" >
	<div class="sub_title" style="margin-top:50px;">
		<h1>회원정보</h1>
		<hr />
	</div>


   <form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do" method="post"><%--       <input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="id" id="id" value="${loginMember.id}" readonly required/> --%>
      <table style="margin:0 auto">
      	<tr>
      		<th>프로필</th>
            <td><input type="file" name="upProfile" id="upProfile" ></td>
            <td><img id="profileImg" src="" style="max-width:80px; max-height:80px;"></td>
     	</tr>
      	<tr>
			<th>아이디</th>
			<td>
			    <input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="id" id="id" value='<sec:authentication property="principal.memberId"/>' readonly required/>
			</td>
			<td style="visibility:hidden">자리채우기용</td>
      	</tr>
      	<tr>
			<th>이름</th>
			<td>
	        	<input type="text" class="form-control" placeholder="이름" name="name" id="name" value='<sec:authentication property="principal.memberName"/>' required/>
			</td>
      	</tr>
      	<tr>
			<th>생년월일</th>
			<td>
	        	<input type="date" class="form-control" placeholder="생일" name="birthday" id="birthday" value='<sec:authentication property="principal.birthday"/>'/>
			</td>
      	</tr>
      	<tr>
			<th>이메일</th>
			<td>
	        	<input type="email" class="form-control" placeholder="이메일" name="email" id="email" value='<sec:authentication property="principal.email"/>' required/>
			</td>
      	</tr>
      	<tr>
			<th>전화번호</th>
			<td>
	      		<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" value='<sec:authentication property="principal.phone"/>' required/>
			</td>
      	</tr>
      	<tr>
			<th>주소</th>
			<td>
	      		<input type="text" class="form-control" name="address" id="address" value='<sec:authentication property="principal.memberAddr"/>' required/>
			</td>
      	</tr>
      </table>
      
      <input type="submit" class="btn btn-outline-success" value="수정" style="margin-top:10px;">&nbsp;
      <input type="reset" class="btn btn-outline-success" value="취소" style="margin-top:10px;">
   </form:form>
</div>

<script>
$('#upProfile').change(function(){
    setProfile(this, '#profileImg');
    if(!/([^\s]+(?=\.(jpg|gif|png))\.\2)/.test($("#upProfile").val())){
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