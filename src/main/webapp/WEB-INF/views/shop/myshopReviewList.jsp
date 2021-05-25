<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
			
			html += "<div style='float: left; margin-left: -13px'>";
			html += "<table id='tbl"+ i + "' class='tg'>";
			html += "<thead> <tr> <th class='tg-0lax' colspan='2' rowspan='5' style= width='132px' text-align='center'><img id='profileImg' style= width= '100px' height= '100px' src='${pageContext.request.contextPath}/resources/upload/member/" + data.buyerList[i].profileRenamed + "'></th></tr>";
			html += "<tr><th class='tg-0lax' colspan='4'>아이디 : " + data.buyerList[i].memberId +"</th> </tr>";
			html += "<input type='hidden' value='" + data.reviewList[i].reviewNo +"'  id='reviewNo' >";
			html += "<tr> <td class='tg-0lax' colspan='4'>별점 : " + data.reviewList[i].reviewScore + "</td> </tr>";
			
			html += "<tr> <td class='tg-0lax' colspan='4'>" + data.reviewList[i].reviewTitle + "</td> </tr>"	
// 			+ "<img id='profileImg' src='${pageContext.request.contextPath}/resources/upload/product/" + data.reviewImageList[i].reviewImgRenamed + "'>"	
			
			html += "<tr> <td class='tg-0lax' colspan='4' style= 'width= 463px height: 213px'><img id='profileImg' src='${pageContext.request.contextPath}/resources/upload/product/" + data.reviewImageList[i].reviewImgRenamed + "'></td></tr>";																												
			html += "<tr> <td class='tg-0lax' colspan='4'style='height= 100px'>댓글내용 : " + data.reviewList[i].reviewContent +"<button type='button' id='BtnGoWrite' onclick='reply_review(commentText"+i+","+ data.reviewList[i].reviewNo +")' class='btn btn-primary'>댓글쓰기</button></td></tr>";
			html += "<tr><td class='tg-0lax' colspan='4'><div id='commentList"+i+"'>답글 : "+ data.reviewList[i].reviewCommentText +"</div></td></tr>"
			html += "<tr style='display:none' id='commentText"+i+"'><td class='tg-0lax' colspan='4'> <input type='text' id='updateContent"+i+"' class='updateContent'><button type='button' id='BtnGoUpdate' onclick='update_review("+ data.reviewList[i].reviewNo +","+i+")' class='btn btn-primary'>댓글등록</button></td></tr>";
			html += "</thead></table></div>";
				
				
			
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
/*
 * 댓글 등록하기(Ajax)
 */
 
function reply_review(commentText,reviewNo){
	alert(reviewNo);
//     alert('@@@@comment : ' + id);
	    $(commentText).show();
	    //console.log(comment_id);
	    
    
//     var chk = document.getElementById('BtnGoUpdate');
//     var boxs = document.getElementById('box');
//     if (boxs.style.display == 'none') {
//         boxs.style.display = 'block';
//         return false;
// 	}
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
                if(data=="success")
                {
                    getCommentList();
                    $("#updateContent").val("");
                }
            },
            error:function(request,status,error){
            	alert(data);
                //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
            
        });
    }
   
	
	
</script>

<div class="div-division2">
	<div class="left2">상점후기</div>
	<div id = "reviewCount" class="right2">00개</div>
</div>
           <div id="review-list" class="see-review">
                          <!-- <div style="float: left; margin-left: 5px;">
								<<table class="tg">
                                <thead>
                                  <tr>
                                    <th class="tg-0lax" colspan="2" rowspan="5" style="width: 132px; text-align: center;">
                                        <img src="./resources/images/slide1.jpg" alt="" style="width: 100px; height: 100px; ">
                                    </th>
                                    <th class="tg-0lax" colspan="4">아이디</th>
                                  </tr>
                                  <tr>
                                    <td class="tg-0lax" colspan="4">별점</td>
                                  </tr>
                                  <tr>
                                    <td class="tg-0lax" colspan="4">상품명</td>
                                  </tr>
                                  <tr>
                                    <td class="tg-0lax" colspan="4" style="width: 463px; height: 213px;">
                                    <img src="./resources/images/slide2.jpg" alt=""style="width: 180px; height: 180px; ">
                                    <img src="./resources/images/slide3.jpg" alt=""style="width: 180px; height: 180px; ">
                                    </td>
                                  </tr>
                                  <tr>
                                    <td class="tg-0lax" colspan="4" style="height: 100px;">댓글</td>
                                  </tr>
                                </thead>
                                </table>
                             </div>  -->

                        </div>
                        
                        <div class="container" id="box" style="display:none">
    <form id="commentForm" name="commentForm" method="post">
    <br><br>
        <div>
            <div>
                <span><strong>Comments</strong></span> <span id="cCnt"></span>
            </div>
            <div>
                <table class="table">                    
                    <tr>
                        <td>
                            <textarea style="width: 1100px" rows="3" cols="30" id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div>
                                <a href='#' onClick="fn_comment('$')" class="btn pull-right btn-success">등록</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <input type="hidden" id="b_code" name="b_code" value="" />        
    </form>
</div>
<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
        </div>
    </form>
</div>
<div id="pagebar2" style="margin-top: 550px;"></div>