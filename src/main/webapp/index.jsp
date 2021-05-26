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
                <select id="select-location">
                  <!-- 지역명 불러오기 , 로그인 시 회원 지역정보 우선 -->
                  <option value="" disabled selected>지역명</option>
                  <option value="">전체</option>
                  <c:forEach items="${locationList}" var="location">
                    <option value="${location.locCode}" ${loginMember.locCode eq location.locCode ? 'selected' : ''} >${location.locName}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="category-nav">
                <select id="select-category" >
                  <!-- 카테고리명 불러오기 -->
                  <option value="" disabled selected>카테고리</option>
                  <option value="">전체</option>
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
          <div class="items" id="item-list">
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
            <input type="hidden" id="btn-plus" value="2">
          </div>
          <!-- 버튼 끝 -->
        </div>
      </div>
    </div>
    <script src="./resources/js/index.js"></script>
<!-- jQuery ajax script-->
  <script>


    function makeItem({productId,productName,productPrice,productImgRenamed}) {          
        let item = document.createElement("div");
        item.className = "item";
        item.addEventListener("click", function(e) {
          location.href='${pageContext.request.contextPath}/product/productDetail.do?productId=' + productId;
        })
        
        let item_photo = document.createElement("div");
        item.appendChild(item_photo);
        item_photo.className ="item-photo"
        
        let item_photo_img = document.createElement("img");
        item_photo_img.src = "./resources/upload/product/" + productImgRenamed;
        item_photo.appendChild(item_photo_img);
        
        let item_detail = document.createElement("div");
        item.appendChild(item_detail);
        item_detail.className ="item-detail";
        let item_name = document.createElement("div");
        item_detail.appendChild(item_name);
        item_name.className ="item-name";
        item_name.innerText = productName;
        let item_price = document.createElement("div");
        item_detail.appendChild(item_price);
        item_price.className ="item-price"
        
        let amount = document.createElement("strong");
        amount.innerText = productPrice;
        amount.className ="amount";
        item_price.appendChild(amount);
        
        let currency = document.createElement("span");
        currency.innerText = "원";
        currency.className = "currency"
        item_price.appendChild(currency);
        
        return item;
    }


    const $locationOption = $("#select-location");
    const $categoryOption = $("#select-category");
    const button_more = document.querySelector(".btn-more");
    let btnPlus = document.querySelector("#btn-plus").value;

    const itemList = document.getElementById("item-list");

    $locationOption.on("change", function(){
      console.log($locationOption.val());
      // var locCode = this.value;
      // console.log(locCode);

      $.ajax({
        type:"POST",
        dataType:"JSON",
        data:{
          locCode : $locationOption.val()
        },
        url:"${pageContext.request.contextPath}/search/mainProductList.do?${_csrf.parameterName}=${_csrf.token}",
        success: data =>{
          console.log(data);
          let list_div = document.getElementById("item-list");

          while ( list_div.hasChildNodes() ) { 
            list_div.removeChild( list_div.firstChild ); 
          }

          for (let i = 0; i < data.length; i++) 
          {          
            let item = makeItem(data[i]);
            list_div.appendChild(item);
          }
        },
          
          
          
          /*
          <div class="item" onclick="location.href='/sharecarrot/product/productDetail.do?productId=20210522232524'">
            <div class="item-photo">
              <img src="./resources/upload/product/20210522232524_4b9c60bf-7644-4799-b710-5e17a9ee1b89jpg" alt="상품이미지">
            </div>
            <div class="item-detail">
              <div class="item-name">test</div>
              <div class="item-price">
                <strong class="amount">1231</strong>
                <span class="currency">원</span>
              </div>
            </div>
          </div>
*/

        
        error: (request, status, error) =>{
          console.log(request, status, error);
        },
      })
    })
    $categoryOption.on("change", function(){ 
      if($locationOption.val() == null){
        alert("지역을 먼저 선택해주세요");


          return false;
      }
        console.log($locationOption.val(), $categoryOption.val());

        $.ajax({
        type:"POST",
        dataType:"JSON",
        data:{
          locCode : $locationOption.val(),
          category: $categoryOption.val()
        },
        url:"${pageContext.request.contextPath}/search/mainProductList.do?${_csrf.parameterName}=${_csrf.token}",
        success: data =>{
          console.log(data);
          let list_div = document.getElementById("item-list");

          while ( list_div.hasChildNodes() ) { 
            list_div.removeChild( list_div.firstChild ); 
          }

          for (let i = 0; i < data.length; i++) 
          {          
            let item = makeItem(data[i]);
            list_div.appendChild(item);
          }

        },
        error: (request, status, error) =>{
          console.log(request, status, error);
        },
      })
    })

    button_more.addEventListener("click", e =>{
      // alert("눌림");
      $.ajax({
        type:"POST",
        dataType:"JSON",
        data:{
          locCode : $locationOption.val(),
          category: $categoryOption.val(),
          cPage : btnPlus,
        },
        url:"${pageContext.request.contextPath}/search/mainProductList.do?${_csrf.parameterName}=${_csrf.token}",
        success: data =>{
          console.log(data);
          let list_div = document.getElementById("item-list");

          // while ( list_div.hasChildNodes() ) { 
          //   list_div.removeChild( list_div.firstChild ); 
          // }

          for (let i = 0; i < data.length; i++) 
          {          
            let item = makeItem(data[i]);
            list_div.appendChild(item);
          }
          btnPlus++;

          if(data.length === 0){
            alert("등록된 상품이 없습니다.")
          }
        },
        error: (request, status, error) =>{
          console.log(request, status, error);
        },
      })
    })

  </script>
      
  <!-- jQuery ajax script 끝-->
<!--메인 페이지 작업영역 끝 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>