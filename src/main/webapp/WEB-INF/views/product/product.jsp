<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<link rel="stylesheet" href=" type="" />


	<div class="product-img" style="height:220px;">
		<div>상품이미지</div>
	</div>
	<div class="product-profile" style="height:220px;">
	
		<div class="jjim-btn" style="margin-top: 3px;">
			<a href="" class="">찜하기</a>
		</div>
               
	
	
	</div>
	
	<div class="information" style="height:500px;">
		<div class="product-information" style="height:50px;">
			<div class="product-title">
				상품정보
			</div>
			<div class="product-content" style="height:450px;">
			
			</div>	
		</div>
		
		<div class="store-information" style="height:50px;">
			<div class="store-profile" style="height:100px;">
				<div class="store-img">
				</div>
				<div class="store-name">
				</div>
				<div class="product-amount-title">
					상품
				</div>
				<div class="product-amount">
					00
				</div>
			</div>
			<div class="store-review">
				<div class="store-review-title" style="height:50px;">
				</div>
				<div class="store-review-amount">
					00
				</div>
				<talble class="review-table">
					<thead>
						<tr>
							<th class="rv-tb" colspan="1" rowspan="1">(profile)</th>
							<th class="rv-tb" colspan="1">(memberId)</th>
						</tr>
						<tr>
							<td class="rv-tb" colspan="1">(stars)</td>
						</tr>	
					</thead>
					<tbody>
						<tr>
							<td class="rv-tb" colspan="2">(productName)</td>
						</tr>
						<tr>
							<td class="rv-tb" colspan="2" rowspan="1">(reviewImg)</td>
						</tr>
						<tr>
							<td class="rv-tb" colspan="2">(reviewComment)</td>
						</tr>
					</tbody>				
				</table>

			</div>
		</div>
	</div>
		
		
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>



