<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	 $.ajax({
         url:"${pageContext.request.contextPath}/shop/myshopReviewList.do?shopId=" + tempParam.shopId,
         type: "GET",
         contentType : "application/json; charset:UTF-8",
			dataType : "json",
		
			error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      },
       success: function(data){
//	              	console.log(data);
//					console.log(data);
//찍어주는 법
//	console.log(data.productlist[0].product);
//	console.log(data.productlist[0].productImage);

	              	console.log(data.reviewList);
	              	console.log(data.reviewImageList);
					$('#reviewCount').html(data.reviewListSize + "개");
					console.log(data.buyerList);
					displayList(data);
          }
  	});
	 
	 
	 function displayList(data){
			
			var html = "";
			console.log(data);
			//나중에 페이징 처리 후에 2에서 data.reviewListSize로 바꾸기
			for(var i = 0; i < data.reviewListSize; i++){
				if(i == 0){
					html += "<div class='see-review'>";
				}
				
				html += "<div style='float: left; margin-left: -13px;'>"
				html += "<table class='review-table'>";
				html += "<thead> <tr> <th class='rt-tbl' colspan='2' rowspan='2'><img id='profileImg' style='width: 139px;' src='${pageContext.request.contextPath}/resources/upload/member/" + data.buyerList[i].profileRenamed + "'></th>";
				html += "<th class='rt-tbl' colspan='2'>아이디 : " + data.buyerList[i].memberId +"</th> </tr>";
				html += "<tr> <td class='rt-tbl' colspan='2'>별점 : " + data.reviewList[i].reviewScore + "</td> </tr> </thead>"
				
				html += "<tbody> <tr> <td class='rt-tbl' colspan='4'>상품제목</td> </tr>"	
	// 			+ "<img id='profileImg' src='${pageContext.request.contextPath}/resources/upload/product/" + data.productImageList[i].productImgRenamed + "'>"
				html += "<tr> <td class='rt-tbl' colspan='4' rowspan='2'>사진들</td> </tr>"
				html += "<tr></tr>"
				html += "<tr> <td class='rt-tbl' colspan='4'>댓글내용 : " + data.reviewList[i].reviewContent +"</td> </tr>"
				html += "</tbody></table></div>";

				
				
				
				//나중에 페이징 처리 후에 data.reviewListSize-1로 바꿔주기
				if(i == (data.reviewListSize-1)){
					html += "</div>";
				}
			}
			$('#review-list').append(html);
			console.log(html);
			
			console.log("@@pagebar2 : " + data.pageBar2);
			$('#pagebar2').append(data.pageBar2);
	}
	 
	
	
});




</script>

<div class="div-division2">
	<div class="left2">상점후기</div>
	<div id = "reviewCount" class="right2">00개</div>
</div>
           <div id="review-list" class="see-review">
<!--                             <div style="float: left; margin-left: 5px;"> -->
<!--                                 <table class="review-table"> -->
<!--                                     <thead> -->
<!--                                         <tr> -->
<!--                                             <th class="rt-tbl" colspan="2" rowspan="2">프로필</th> -->
<!--                                             <th class="rt-tbl" colspan="2">아이디</th> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="2">별점</td> -->
<!--                                         </tr> -->
<!--                                     </thead> -->
<!--                                     <tbody> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="4">상품제목</td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="4" rowspan="2">사진들</td> -->
<!--                                         </tr> -->
<!--                                         <tr></tr> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="4">댓글내용</td> -->
<!--                                         </tr> -->
<!--                                     </tbody> -->
<!--                                 </table> -->
<!--                             </div> -->
<!--                             <div style="float: left; margin-left: 61px;"> -->
<!--                                 <table class="review-table"> -->
<!--                                     <thead> -->
<!--                                         <tr> -->
<!--                                             <th class="rt-tbl" colspan="2" rowspan="2">프로필</th> -->
<!--                                             <th class="rt-tbl" colspan="2">아이디</th> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="2">별점</td> -->
<!--                                         </tr> -->
<!--                                     </thead> -->
<!--                                     <tbody> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="4">상품제목</td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="4" rowspan="2">사진들</td> -->
<!--                                         </tr> -->
<!--                                         <tr></tr> -->
<!--                                         <tr> -->
<!--                                             <td class="rt-tbl" colspan="4">댓글내용</td> -->
<!--                                         </tr> -->
<!--                                     </tbody> -->
<!--                                 </table> -->
<!--                             </div> -->

                        </div>
                        
<div id="pagebar2" style="margin-top: 275px;"></div>
