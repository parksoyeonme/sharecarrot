<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/history.jsp" />

<!--css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/headerSearch.css" type="text/css" />
<!--jquery-->
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
<!--icon-->
 <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script>
   console.log('test');
</script>

<script>
function productDetail(productId){
   location.href = "${pageContext.request.contextPath}/product/productDetail.do?productId="+productId;
}

</script>


<section id="search-container" class="ms_container">
	<div class="container">
	     <div class="row">
	         
	     </div>

    <div class="col-lg-9" style="margin-left: 55px;">
        <div class="content-product">
            <div class="div-division" style="font-size: 20px;">검색결과 (${productListSize}개)
			</div>
			<div class="item-wrapper">
				<div id = "product-list" class="product-list">
					<c:forEach items="${productList}" var="product" varStatus="status">
						<div class='item'>
							<div class='item-photo' onclick='productDetail(${product.productId})'>
								<img id='productImg' src='${pageContext.request.contextPath}/resources/upload/product/${productImageList[status.index].productImgRenamed}'>
							</div>
							<div class='item-detail'>
								<div class='pro-title'>${product.productName}</div>
								<div class='pro-price'>${product.productPrice}</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div id="pagebar">${pageBar}</div>
        </div>
    </div>
		</div>    
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>