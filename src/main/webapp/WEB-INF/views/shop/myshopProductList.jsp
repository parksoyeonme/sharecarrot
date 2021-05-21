<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<script>
$(document).ready(function() {
	console.log('shopId ', tempParam.shopId);
       $.ajax({
              url:"${pageContext.request.contextPath}/shop/myshopProductList.do?shopId=" + tempParam.shopId,
              type: "GET",
              contentType : "application/json; charset:UTF-8",
			dataType : "json",
		
			error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           },
              success: function(data){
// 	              	console.log(data);
console.log(data);
   //찍어주는 법
// 	console.log(data.productlist[0].product);
// 	console.log(data.productlist[0].productImage);

// 	              	console.log(data.productlistsize);
// 	              	console.log(data[1]);
 					$('#totalDiv').html(data.productListSize + "개");
					displayList(data);
               }
       });
});

function displayList(data){
//   	$.each(data, function(index, elem) { 
//      if (key == "productlist") {
//         for (var i = 0; i < value.length; i++) {
//            console.log(value[i]);
//         }
//      }
		var html = "";
// 		console.log(elem);
		console.log(data);
// 		for(var i = 0; i < data.productListSize; i++){
		for(var i = 0; i < 5; i++){
			if(i == 0){
				html += "<table>";
				html += "<tr>";
			}

			html += "<td><div class='box box1 boxC'>"+ data.productImageList[i].productImgRenamed +"</div>";
			html += "<div class='pro-title'>"+ data.productList[i].productName +"</div>";
			html += "<div class='pro-price'>"+ data.productList[i].productPrice +"</div>";
			html += "</td>";
			
			if(i == (data.productListSize-1)){
				html += "</tr>";
				html += "</table>";
			}
		}
		
		$('#product-list').append(html);
		console.log(html);
		
// 		for(var i = 0; i < elem; i++){
// 			console.log(data.productlist[i].product);
// 			console.log(data.productlist[i].productImage);
// 		}
// 		console.log("key" + key);
// 		console.log("data" + data);
// 		console.log("value" + value);
//      console.log(key);
// 	    console.log(value[0].product);
// 	    console.log(value[0]);
// 	    console.log(value[0]);
//      console.log(value.product);
//      console.log(value.productimage);
//      else if (key == "command") {
//         $('#doc_nm').append(value.doc_nm);
//         $('#contract_id').append(
//               value.contract_id);
//      }
//   });
	
}

</script>
<div class="div-division">
	<div class="left">전체</div>
	<div class="right" id="totalDiv">00개</div>
</div>
<div id = "product-list">
<!-- 	 <div class="wrap-pro"> -->
<!--          <div class="box box1 boxC">사진</div> -->
<!--          <div class="pro-title">제목</div> -->
<!--          <div class="pro-price">가격</div> -->
<!--      </div> -->
<!--      <div class="wrap-pro"> -->
<!--          <div class="box box1 boxC">사진</div> -->
<!--          <div class="pro-title">제목</div> -->
<!--          <div class="pro-price">가격</div> -->
<!--      </div> -->
<!--      <div class="wrap-pro"> -->
<!--          <div class="box box1 boxC">사진</div> -->
<!--          <div class="pro-title">제목</div> -->
<!--          <div class="pro-price">가격</div> -->
<!--      </div> -->
<!--      <div class="wrap-pro"> -->
<!--          <div class="box box1 boxC">사진</div> -->
<!--          <div class="pro-title">제목</div> -->
<!--          <div class="pro-price">가격</div> -->
<!--      </div> -->
<!--      <div class="wrap-pro"> -->
<!--          <div class="box box1 boxC">사진</div> -->
<!--          <div class="pro-title">제목</div> -->
<!--          <div class="pro-price">가격</div> -->
<!--      </div> -->
                            
</div>