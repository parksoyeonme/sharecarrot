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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>

    <!-- bootstrap js: jquery load 이후에 작성할것.-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <!-- bootstrap css -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
   
   <style>
        #header-nav {
            background-color: rgb(247, 247, 247);
            border-bottom: 1px solid rgb(209, 209, 209);
            padding-top: 10px;
        }
    </style>
<script>

function enterkey() {
    if (window.event.keyCode == 13) {
    	search_button_click();
    }
}

function search_button_click() {
    // 검색 버튼을 눌렀을때의 기능 구현
	var searchkeyword = $('#headersearch').val();
    location.href = "${pageContext.request.contextPath}/product/headerSearch.do?searchkeyword="+searchkeyword;
}

</script>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>
</head>
<body>
    <header>
    <ul class="nav nav-pills nav-fill" id="header-nav">
        <li class="nav-item" style="padding-top: 7px;">
	        <a href="${pageContext.request.contextPath}">
	            <img src="${pageContext.request.contextPath}/resources/images/mainlogo.png" style="max-height: 50px;">
	        </a>
        </li>
        <li class="nav-item">
            <div class="input-group mb-3">
                <input type="text" onkeyup="enterkey();" id="headersearch" name="headersearch" class="form-control" placeholder="지역 혹은 물품을 검색해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
                <button class="btn btn-outline-secondary" onclick="search_button_click();" id="searchbutton" name="searchbutton" type="button" id="button-addon2">검색</button>
            </div>
        </li>
        <li class="nav-item">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
   				<sec:authorize access="isAnonymous()">
	                <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do';">로그인</button>
	                <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do';">회원가입</button>
	                <button type="button" class="btn btn-primary" >판매하기</button>
	                <button type="button" class="btn btn-primary" >내상점</button>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
               		<form:form class="d-inline" action="${pageContext.request.contextPath}/member/memberLogout.do" method="POST">
					    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">로그아웃</button>
	                </form:form>
	                <button type="button" class="btn btn-primary">판매하기</button>
	                <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/shop/myshop.do';">내상점</button>
                </sec:authorize>
                <div class="btn-group" role="group">
                  <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    카테고리
                  </button>
                  <ul class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                    <li><a class="dropdown-item" href="#">상품카테고리</a></li>
                    <%--분기처리 --%>
                    <sec:authorize access="isAnonymous()">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardList.do">동네생활게시판</a></li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardList.do?memberId=<sec:authentication property='principal.username'/>">동네생활게시판</a></li>
                    </sec:authorize>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/report/reportList.do">신고게시판</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberDetail.do">계정설정</a></li>
                  </ul>
                </div>
              </div>
        </li>
      </ul>
    </header>
<section>