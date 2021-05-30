<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<script>
$(document).ready(function() {
   console.log('shopId ', tempParam.shopId);
   productListFn();
  
   $(document).on("click",".btngropu4",function (){ 
      var btnValue = $(this).val();
      productListFn(btnValue);
     // alert($(this).val());
   });
   
   function productListFn(btnValue){
      $.ajax({
	         url:"${pageContext.request.contextPath}/shop/myshopProductList.do?shopId=" + tempParam.shopId,
	         type: "GET",
	         contentType : "application/json; charset:UTF-8",
	         dataType : "json",
	         data: {
	               "btnValue" : btnValue
	            },
	         error:function(request,status,error){
	               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	          },
	          success: function(data){

              $('#totalDiv').html(data.productListSize + "개");
              displayList(data);
            }
      });
   };
});

function productDetail(productId){
   location.href = "${pageContext.request.contextPath}/product/productDetail.do?productId="+productId;
}

function displayList(data){
   $('#product-list *').remove();
   $('#pagebar *').remove();

      var html = "";

      console.log(data);

      //나중에 페이징 처리 후에 5에서 data.productListSize로 바꾸기
      for(var i = 0; i < 5; i++){
         if(i == 0){
            html += "<table>";
            html += "<tr>";
         }
	         html += "<td><div class='box box1 boxC ' onclick='productDetail(" + data.productList[i].productId + ")'>"
	         + "<img id='productImg' src='${pageContext.request.contextPath}/resources/upload/product/" + data.productImageList[i].productImgRenamed + "'>"
	           + "</div>";
	         html += "<div class='pro-title'>"+ data.productList[i].productName +"</div>";
	         html += "<div class='pro-price'>"+ data.productList[i].productPrice +"</div>";
	         html += "</td>";
         //나중에 페이징 처리 후에 data.productListSize-1로 바꿔주기
         if(i == (4)){
            html += "</tr>";
            html += "</table>";
            
         }
      }
      
      
      $('#product-list').append(html);
      //console.log(html);
 
      console.log("@@pagebar : " + data.pageBar);
      $('#pagebar').append(data.pageBar);
}
  
   
</script>

<div class="div-division">
   <div class="left">전체</div>
   <div class="right" id="totalDiv">00개</div>
   <div id='btn_group'>
      <button id='btncurrent' value='cu' onclick='btn_group()' class='btngropu4'>최신 |</button>
      <button id='btnrowprice' value='row' onclick='btn_group()' class='btngropu4'>저가 |</button>
      <button id='btnhighprice' value='hig' onclick='btn_group()' class='btngropu4'>고가 |</button>
   </div>
</div>
<div id = "product-list"></div>
<div id="pagebar"></div>

