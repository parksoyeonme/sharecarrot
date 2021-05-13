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
                <input type="text" class="form-control" placeholder="지역 혹은 물품을 검색해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
                <button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
            </div>
        </li>
        <li class="nav-item">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <button type="button" class="btn btn-primary">로그인</button>
                <button type="button" class="btn btn-primary">회원가입</button>
                <button type="button" class="btn btn-primary">판매하기</button>
                <button type="button" class="btn btn-primary">내상점</button>
                <div class="btn-group" role="group">
                  <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    카테고리
                  </button>
                  <ul class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                    <li><a class="dropdown-item" href="#">상품카테고리</a></li>
                    <li><a class="dropdown-item" href="#">동네생활게시판</a></li>
                    <li><a class="dropdown-item" href="#">신고게시판</a></li>
                    <li><a class="dropdown-item" href="#">공지사항</a></li>
                    <li><a class="dropdown-item" href="#">계정설정</a></li>
                  </ul>
                </div>
              </div>
        </li>
      </ul>
    </header>
<section>