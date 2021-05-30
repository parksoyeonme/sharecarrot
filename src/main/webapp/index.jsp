<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/history.jsp" />
<!-- 메인 페이지 작업영역 -->
<link rel="stylesheet" href="./resources/css/index.css" />


<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<div class="container">
      <div class="wrapper">
        <!-- 배너 시작 -->
        <!-- 이미지 슬라이더(carousel) 구현하기 -->
        <div class="banner">
          <div class="slides">
            <div class="slide">
              <img src="./resources/images/sample_banner1.jpg" alt="배너1">
            </div>
            <div class="slide">
              <img src="./resources/images/sample_banner2.jpg" alt="배너2">
            </div>
            <div class="slide">
              <img src="./resources/images/sample_banner3.jpg" alt="배너3">
            </div>
          </div>
          <div class="slide-controls">
            <button id="prev-btn">
              <
            </button>
            <button id="next-btn">
              >
            </button>
         </div>
        </div>
        <!-- 배너 끝 -->
        <!-- 검색 시작 -->
        <form:form>
          <div class="search">
            <div style="display: flex">
              <div class="location-nav">
                <select id="select-location" onchange="changeOption()">
                  <!-- 지역명 불러오기 , 로그인 시 회원 지역정보 우선 -->
                  <option value="" disabled selected>지역명</option>
                  <c:forEach items="${locationList}" var="location">
                    <option value="${location.locCode}" ${loginMember.locCode eq location.locCode ? 'selected' : ''} >${location.locName}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="category-nav">
                <select id="select-category" onchange="changeOption()">
                  <!-- 카테고리명 불러오기 -->
                  <option value="" disabled selected>카테고리</option>
                  <c:forEach items="${categoryList}" end="4" var="category">
                    <option value="${category.categoryCode}">${category.categoryName}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
          </div>
        </form:form>
        <!-- 검색 끝 -->
        <!-- 상품 리스트 시작 -->
        <!-- 조건에 맞는 상품 정보 불러오기 -->
        
			
        <div class="item-wrapper">
          <div class="items">
  		<c:forEach items="${productList}" var="product">
            <div class="item" onclick="location.href='${pageContext.request.contextPath}/product/productDetail.do?productId=${product.productId}'">
              <div class="item-photo">
                <img src="./resources/upload/product/${product.productImgRenamed}" alt="상품이미지">
              </div>
              <div class="item-detail">
                <div class="item-name">${product.productName}</div>
                <div class="item-price">
                  <strong class="amount">${product.productPrice}</strong>
                  <span class="currency">원</span>
                </div>
              </div>
            </div>
		</c:forEach>
            
		</div>
          <!-- 상품 끝 -->
          <!-- 버튼 시작-->
          <!-- 버튼 클릭 시 상품 목록 불러오기 (10개씩)-->
            
          <div class="button-more">
            <button type="button" class="btn-more btn-large">더보기</button>
          </div>
          <!-- 버튼 끝 -->
        </div>
      </div>
    </div>
    <script src="./resources/js/index.js"></script>



<!--메인 페이지 작업영역 끝 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>