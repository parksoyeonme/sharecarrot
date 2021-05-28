<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
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

					$('#reviewCount').html(data.reviewListSize + "개");
					console.log(data.buyerList);
					displayList(data);
					
					$('[name=star]').css({
				          "color": "CCCC00"
				    });

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
			
			html += "<div style='float: left; margin-left: 28px'>";
			html += "<table id='tbl"+ i + "' class='tg'>";
			html += "<thead> <tr> <th class='tg-0lax' colspan='2' rowspan='4' style= 'width: 132px' 'text-align:center'><img id='profileImg' style= 'width:187px' 'height: 100px' src='${pageContext.request.contextPath}/resources/upload/member/" + data.buyerList[i].profileRenamed + "'></th></tr>";
			html += "<tr><th class='tg-0lax' colspan='4'>아이디 : " + data.buyerList[i].memberId +"</th> </tr>";
			html += "<input type='hidden' value='" + data.reviewList[i].reviewNo +"'  id='reviewNo' >";
			html += "<tr> <td class='tg-0lax' colspan='4'><svg xmlns='http://www.w3.org/2000/svg' width='23' height='23' fill='currentColor' class='bi bi-star-fill' viewBox='0 0 16 16'><path name='star' d='M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z'/></svg>" + data.reviewList[i].reviewScore + "</td> </tr>";
			html += "<tr> <td class='tg-0lax' colspan='4'>" + data.reviewList[i].reviewTitle + "</td> </tr>";	
			html += "<tr> <td class='tg-0lax' colspan='4' style= 'width:463px' 'height: 213px'><img id='profileImg' data-toggle='lightbox' src='${pageContext.request.contextPath}/resources/upload/product/" + data.reviewImageList[i].reviewImgRenamed + "'></td></tr>";																												
			html += "<tr> <td class='tg-0lax' colspan='4'style='height: 64px'>리뷰내용 : " + data.reviewList[i].reviewContent+"</th> </tr>";
			console.log("@@@" + data.isExistArray[i]);
			
			//댓글이 있을 때
			if(data.isExistArray[i] == 1){
// 				댓글보여주는거
				html += "<tr><td class='tg-0lax' colspan='4'><div id='commentList"+i+"'>";
				html += "<svg xmlns='http://www.w3.org/2000/svg' width='23' height='23' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z'/></svg> 댓글 : "+data.reviewCommArray[i].reviewContent +"</div></td></tr>";
			}
			//댓글이 없을 때
			else if(data.isExistArray[i] == 0){
				console.log(data.shopMemberId);
				console.log(data.loginMemberId);
				if(data.shopMemberId == data.loginMemberId){					
					html +="<tr> <td class='tg-0lax' colspan='4'style='height: 63px'>";
					html += "<button type='button' id='BtnGoWrite' onclick='reply_review(commentText"+i+","+ data.reviewList[i].reviewNo +")' class='btn' style= 'background: #eba326' 'width:97px'>댓글쓰기</button>";
					html += "</td></tr>";				
				}
			}
			
			html += "<tr style='display:none' id='commentText"+i+"'><td class='tg-0lax' colspan='4'> <input type='text' id='updateContent"+i+"' class='updateContent' style='width: 392px' height:'100px'><button type='button' id='BtnGoUpdate' onclick='update_review("+ data.reviewList[i].reviewNo +","+i+")' class='btn btn-warning' style='margin-left: 29px'>댓글등록</button></td></tr>";
			html += "</thead></table></div>";
			
			//나중에 페이징 처리 후에 data.reviewListSize-1로 바꿔주기
			if(i == (data.reviewListSize-1)){
				html += "<br /></div>";
			}
		}
		$('#review-list').append(html);

		console.log("@@pagebar2 : " + data.pageBar2);
		$('#pagebar2').append(data.pageBar2);
		
			
 }
	
	 	
});
/*
 * 댓글 등록하기(Ajax)
 */
 
function reply_review(commentText,reviewNo){
	alert(reviewNo);

	    $(commentText).show();


}



	//댓글등록
    function update_review(reviewNo,i){
		var reviewNo = reviewNo;
		var updateContent =$("#updateContent"+i).val(); 
		var shopId = tempParam.shopId;
		
		alert("후기번호 : " + reviewNo);
		alert("댓글 : " + updateContent);
		alert(tempParam.shopId);
        
         $.ajax({
            type:'POST',
            url : '${pageContext.request.contextPath}/shop/reviewComment.do?${_csrf.parameterName}=${_csrf.token}',
            dataType : 'json',
            data: {
            	"reviewNo" : reviewNo,
            	"reviewContent" :updateContent,
            	"shopId" : shopId
            	
            	
            },
            success : function(data){
               
                $("tr").remove("#commentText"+i);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
            
        });
    }

</script>
<script>
$(document).on('click', '[data-toggle="lightbox"]', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
});
</script>

<div class="div-division2">
	<div class="left2">상점후기</div>
	<div id = "reviewCount" class="right2">00개</div>
</div>
<div id="review-list" class="see-review"></div>
                        

<div id="pagebar2" style="margin-top: 780px;"></div>