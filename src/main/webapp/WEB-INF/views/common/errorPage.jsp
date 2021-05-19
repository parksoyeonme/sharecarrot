<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<!--Custom CSS-->
<link  rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/error.css" type="text/css"/>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
     
</head>
<script>

//전페이지로 돌아가기
function backPage(){
	history.go(-1);
}
</script>
<body>
	<div class="errorlogo">
    <img src="${pageContext.request.contextPath}/resources/images/errorcarrot.gif" alt="에러쉐어캐롯">
    </div>
    <div class="sorry-text">
        죄송합니다. 현재 페이지는 존재하지 않거나 로그인 후에 이용하실 수 있습니다.
    </div>

    <div class="plznotice-text">
        존재하지 않는 주소를 입력하셨거나,<br /> 
        요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br />
        궁금한 점이 있으시면 언제든 고객센터를 통해 문의해 주시기 바랍니다.
        <br />감사합니다.
    </div>
    <div class="error-btn">
       <button type="button" class="btn btn-primary" onclick="backPage();">돌아가기</button>
    </div>
</body>
</html>