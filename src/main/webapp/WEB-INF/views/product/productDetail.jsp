<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
#imgSlider{
      width: 50%;
      margin: 0 auto;
   }
   #imgSlider img{
      height: 500px;
      margin: 0 auto;
   }
   #memberProfile{
      border-radius: 10% 30% 50% 70%;
   }
	#productList img{
		width: 100px !important;
		height: 100px !important;
	}
</style>

<script>
function chatting_popup(){
// 	var loginUser = <sec:authentication property="principal.memberId"/>;
// 	var shopId = ${product.shopId};
	var url = "${pageContext.request.contextPath}/chat/chattingRoom.do?roomBuyerId=<sec:authentication property='principal.memberId'/>&shopId=${product.shopId}";

	var popupWidth = 600;
	var popupHeight = 420;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (popupHeight / 2) - 50;
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	window.open(url, "chat", "width=" + popupWidth + ", height=" + popupHeight + ", left="+popupX+", top=" + popupY).focus();
}


</script>

<!-- Img Slider 영역 -->
<div id="imgSlider" class="carousel slide col" data-bs-ride="carousel">
  <div class="carousel-inner">
    <c:if test="${product.productImageList ne null}">
	    <div class="carousel-item">
	      <img src="${pageContext.request.contextPath}/resources/upload/product/${product.productImageList[0].productImgRenamed}" class="d-block w-100" alt="...">
	    </div>
	    <c:forEach items="${product.productImageList}" var="image">
		    <div class="carousel-item">
		      <img src="${pageContext.request.contextPath}/resources/upload/product/${image.productImgRenamed}" class="d-block w-100" alt="...">
		    </div>
	    </c:forEach>
       <div class="carousel-item active">
         <img src="${pageContext.request.contextPath}/resources/upload/product/${product.productImageList[0].productImgRenamed}" class="d-block w-100" alt="...">
       </div>
       <c:forEach items="${product.productImageList}" var="image">
          <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/resources/upload/product/${image.productImgRenamed}" class="d-block w-100" alt="...">
          </div>
       </c:forEach>
    </c:if>
      
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#imgSlider" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#imgSlider" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<div class="container">
   <div class="row">
   <h2 style="text-align:center;">${product.productName}</h2>
   <hr>
   <p style="text-align:right;">&nbsp;&nbsp;&nbsp;
      ${category}  |  ${product.productPrice}원
   </p>
   <div style="text-align:center; height:500px;">
      ${product.productContent}
   </div>
   </div>
   <!-- 찜하기 FORM -->
   <div style="text-align:right;">
      <form:form    class="d-inline"
                     id="jjimFrm"
                     method="POST"
                     action="${pageContext.request.contextPath}/product/insertJjim.do?${_csrf.parameterName}=${_csrf.token}">
         <a href="#" onclick="insertJjim();">
            <svg style="color:red;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
              <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
            </svg> 찜하기
         </a>
         <sec:authorize access="isAuthenticated()">
         <input type="hidden" name="memberId" value="<sec:authentication property='principal.username'/>" />
         </sec:authorize>
         <input type="hidden" name="productId" value="${product.productId}" />
      </form:form>
      <sub>${product.productRegDate} | 조회수 : ${product.shopVisitCount}회</sub>
   </div>
<hr/>
</div>

<!-- userProfile 영역 -->
<div class="container">
   <div class="row justify-content-between">
   
   <!-- 상점정보 -->
      <div class="col">
      <h5>상점정보</h5>
      <hr/>
         <div>
            <a href="${pageContext.request.contextPath}/shop/myshop.do">
               <img id='memberProfile' src="${pageContext.request.contextPath}/resources/upload/member/${product.profileRenamed}"/>
               <b>${product.memberId}</b>
               <sub>${product.locName}</sub>
            </a> &nbsp;
            <!-- 채팅기능 -->
            
<%--             <c:if test="'${memberId ne loginId}"> --%>
            <a onclick="chatting_popup();"><sub>
               <svg style="color:green;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-plus-fill" viewBox="0 0 16 16">
                 <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM12.5 1a.5.5 0 0 1 .5.5V3h1.5a.5.5 0 0 1 0 1H13v1.5a.5.5 0 0 1-1 0V4h-1.5a.5.5 0 0 1 0-1H12V1.5a.5.5 0 0 1 .5-.5z"/>
               </svg> 연락하기</sub>
            </a>
<%--             </c:if> --%>
            <p style="text-align:right;">
            <sub>상점 총 별점</sub>&nbsp;&nbsp;&nbsp;
               <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16" style='color:CCCC00;'>
                 <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
               </svg>
               ${product.shopTotalScore}
            </p>
             <p style="text-align:right;">
            <sub>상점 총 상품수</sub>&nbsp;
               <svg style='color:red;' xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-basket2-fill" viewBox="0 0 16 16">
				  <path d="M5.929 1.757a.5.5 0 1 0-.858-.514L2.217 6H.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h.623l1.844 6.456A.75.75 0 0 0 3.69 15h8.622a.75.75 0 0 0 .722-.544L14.877 8h.623a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1.717L10.93 1.243a.5.5 0 1 0-.858.514L12.617 6H3.383L5.93 1.757zM4 10a1 1 0 0 1 2 0v2a1 1 0 1 1-2 0v-2zm3 0a1 1 0 0 1 2 0v2a1 1 0 1 1-2 0v-2zm4-1a1 1 0 0 1 1 1v2a1 1 0 1 1-2 0v-2a1 1 0 0 1 1-1z"/>
				</svg>
               ${product.shopProductCount}
            </p>
         </div>
      </div> <!-- col -->
   
      
      <div class="col">
      <h5 class="d-inline">연관상품</h5><sub>${category}</sub>
      <hr/>
      <div id="productList" class='row' style="text-align:center;">
      <c:forEach items="${productList}" var="product" begin="1" end="3">
      	<c:if test="${product ne null}">
      		<div class='col'>
      			<a href="${pageContext.request.contextPath}/product/productDetail.do?productId=${product.productId}">
      			<img style="border:1px solid black" src="${pageContext.request.contextPath}/resources/upload/product/${product.productImageList[0].productImgRenamed}">
      			<p>${product.productName}</p>
      			</a>
      		</div>      	
      	</c:if>
      </c:forEach>
      </div>
      </div>
      
      
   </div> <!-- row -->
</div> <!-- container -->

<hr/>

<script>
   function insertJjim(){
      //로그인 한경우에만 폼제출
      <sec:authorize access="isAnonymous()">
         alert('로그인후 이용해주세요.');
         return;
      </sec:authorize>
      
      <sec:authorize access="isAuthenticated()">
      //본인 상품에 찜하려 한경우
      const loginMember = "<sec:authentication property='principal.username'/>";
      const enrollMember = '${product.memberId}';
      if(loginMember == enrollMember){
         alert('본인 상품은 찜을 할수 없습니다!');
         return
      }
      
      //찜목록에 이미 있는경우
      var bool = false;
      const productId = '${product.productId}';
      <c:forEach items="${jjimList}" var="jjim">
         if(productId == '${jjim.productId}'){
            var bool = true;
         }
      </c:forEach>
      
      if(bool){
         alert('이미 찜한 상품입니다.');
         return;
      }
      
      //폼제출
      $("#jjimFrm").submit();
      </sec:authorize>
   }
   
   
   const productId = '${product.productId}';
   const productName = '${product.productName}';
   const productImg = '${product.productImageList[0].productImgRenamed}'
   const productPrice = '${product.productPrice}'
</script>
<script src="../resources/js/productDetail.js"></script>
<jsp:include page="/WEB-INF/views/common/history.jsp" /> 


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>


