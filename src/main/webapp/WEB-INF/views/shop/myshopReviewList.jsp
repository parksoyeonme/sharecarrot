<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(function () {
	
    $.ajax({
        url: "${pageContext.request.contextPath}/shop/myshopReviewList.do?shopId=" + tempParam.shopId,
        type: "GET",
        contentType: "application/json; charset:UTF-8",
        dataType: "json",
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        },
        success: function (data) {
            $('#reviewCount').html(data.storeReviewListSize + "개");
            console.log(data.buyerList);
            displayList(data);
            $('[name=star]').css({"color": "#FFEB34"});
        }
    });
    function displayList(data) {
        var html = "";
        // console.log("dataSize"+data.reviewListSize);
        if (data.storeReviewList.length == 0) {
            html += "<table>";
            html += "<tr>";
            html += "<td>";
            html += "<div style='margin-left: 132px'>등록된 상점후기가 존재하지 않습니다.</div>";
            html += "</td>";
            html += "</tr>";
            html += "</table>";
        } else {
            for (var i = 0; i < data.storeReviewList.length; i++) {
                var buttonCount = 0;
                var l = 0;
                if (i == 0) {
                    html += "<div class='see-review'>";
                }
                html += "<table id='tbl" + i + "' class='table table-hover'>";
                html += "<thead><tr><th scope='col'>프로필</th><th style= 'width:8%'>아이디</th><th style= 'width:20%'>상품타이틀</th><th style= 'width:7%'>별점</th><th style= 'width:15%'>리뷰용사진</th><th style= 'width:35%'>리뷰내용</th></tr></thead>";
                html += "<input type='hidden' value='" + data.storeReviewList[i].reviewNo + "'  id='reviewNo' >";
                html += "<tbody><tr>"
                html += "<td><img id='profileImg' style= 'width:74px' src='${pageContext.request.contextPath}/resources/upload/member/" + data.buyerList[0].profileRenamed + "'></td>";
                html += "<td>" + data.buyerList[0].memberId + "</td>";
                html += "<td>" + data.storeReviewList[i].reviewTitle + "</td>";
                html += "<td><svg xmlns='http://www.w3.org/2000/svg' width='23' height='23' fill='currentColor' class='bi bi-star-fill' viewBox='0 0 16 16'><path name='star' d='M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z'/></svg>" + data.storeReviewList[i].reviewScore + "</td>";
                if (data.reviewImageList[i] != null) {
                    html += "<td><img id='reviewImg' style='height: 120px' src='${pageContext.request.contextPath}/resources/upload/product/" + data.reviewImageList[i].reviewImgRenamed + "'></td>";
                } else {
                    html += "<td>X</td>";
                } html += "<td>" + data.storeReviewList[i].reviewContent + "</td></tr>";
                
                // 댓글이 없을 때
                if (data.shopMemberId == data.loginMemberId) {
                    if (data.reviewCommentlist[i] == "") {
                        html += "<tr>";
                        // 댓글쓰기버튼
                        html += "<td><button type='button'  onclick='reply_review(commentText" + i + "," + data.storeReviewList[i].reviewNo + ")' class='btn btn-warning'>댓글쓰기</button></td></tr>";
                        // 댓글쓰는부분 + 등록버튼
                        html += "<tr><td style='display:none' id='commentText" + i + "' colspan='4'><input type='text' id='updateContent" + i + "' class='updateContent' style= 'width:72%'><button type='button' style='margin-left: 11px' id='BtnGoUpdate' onclick='update_review(" + data.storeReviewList[i].reviewNo + "," + i + ")' class='btn btn-warning'>댓글등록</button></td></tr>";
                    }
                    
                }
                for (var j = 0; j < data.reviewCommentlist.length; j++) {
                    if (data.storeReviewList[i].reviewNo == data.reviewCommentlist[j].reviewNo) {
                        buttonCount = 1;
                        break;
                    }
                    l = l + 1;
                }
               // console.log("l = " + l)
               
                if (buttonCount == 1) {
                    html += "<input type='hidden' value='" + data.reviewCommentlist[l].reviewCommentNo + "'  id='reviewCommentNo' >";
                    // 댓글보여주기
                    html += "<tr><td colspan='5'><div id='commentList" + i + "'>";
                    html += "<svg xmlns='http://www.w3.org/2000/svg' width='23' height='23' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z'/></svg> 댓글 : " + data.reviewCommentlist[l].reviewContent + "</div>"
                    if (data.shopMemberId == data.loginMemberId) {
                        // 댓글수정
                        // html += "<button type='button' id='BtnGore' onclick='reply_review(commentText"+i+"," + data.reviewCommentlist[l].reviewCommentNo +","+i+ "," + data.storeReviewList[i].reviewNo +")' class='btn btn-warning'>댓글수정</button>";
                        // 댓글삭제
                        html += "<button type='button' style='margin-left: 15px' value='123' id='BtnGoDelete' onclick='delete_review(" + data.reviewCommentlist[l].reviewCommentNo + "," + i + "," + data.storeReviewList[i].reviewNo + ")'class='btn btn-warning'>댓글삭제</button>";
                    }
                    html += "</td></tr>";
                   // console.log("댓글 있음", buttonCount);
                }
             
                if (data.shopMemberId == data.loginMemberId) {
                    if (buttonCount == 0) {
                    	// 댓글쓰는 부분나오고 등록
                        html += "<tr>";
                        // 댓글쓰기버튼
                        html += "<td><button type='button' id='BtnGoWrite" + i + "' onclick='reply_review(commentText" + i + "," + data.storeReviewList[i].reviewNo + "," + "BtnGoWrite" + i + ")' class='btn btn-warning'>댓글쓰기</button></td></tr>";
                        // 댓글쓰는부분 + 등록버튼
                        html += "<tr><td style='display:none' id='commentText" + i + "' colspan='4'><input type='text' id='updateContent" + i + "' class='updateContent' style= 'width:72%'><button type='button' style='margin-left: 11px' id='BtnGoUpdate' onclick='update_review(" + data.storeReviewList[i].reviewNo + "," + i + ")' class='btn btn-warning'>댓글등록</button></td></tr>";
                        html += "<tr>";
                        console.log("댓글 없음", buttonCount);
                    }
                }
                html += "</tbody>";
                html += "</table>";
               
                if (i == (data.storeReviewList.length - 1)) {
                    html += "</div>";
                }
            
            }
         
            
        }
        $('#review-list').append(html);
    }
});

	// 댓글쓰기 클릭시 버튼 사라지고 댓글쓰는창 생기기
	function reply_review(commentText, reviewNo, BtnGoWrite) {
	   // alert(reviewNo);
	    $(commentText).show();
	    $(BtnGoWrite).hide();
	}
	// 댓글등록
	function update_review(reviewNo, i) {
	    var reviewNo = reviewNo;
	    var updateContent = $("#updateContent" + i).val();
	    var shopId = tempParam.shopId;
	    //alert("후기번호 : " + reviewNo);
	   // alert("댓글 : " + updateContent);
	    //alert(tempParam.shopId);
	    
	    if ($("#updateContent" + i).val() == '' || $("#updateContent" + i).val() == null) {
	        alert('댓글 내용을 입력해주세요');
	        return;
	    }
	    $.ajax({
	        type: 'POST',
	        url: '${pageContext.request.contextPath}/shop/reviewComment.do?${_csrf.parameterName}=${_csrf.token}',
	        dataType: 'text',
	        data: {
	            "reviewNo": reviewNo,
	            "reviewContent": updateContent,
	            "shopId": shopId
	        },
	        success: function (data) {
	            if (data > 0) {
	                alert('댓들 등록 완료되었습니다.');
	            }
	            $("tr").remove("#commentText" + i);
	            window.self.location = "${pageContext.request.contextPath}/shop/myshop.do?shopId=" + tempParam.shopId
	        },
	        error: function (request, status, error) {
	            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	        }
	    });
	}
	
	
	
	// 댓글삭제
	function delete_review(reviewCommentNo, i, reviewNo) {
	    var reviewCommentNo = reviewCommentNo;
	    var reviewNo = reviewNo;
	   // alert("대댓글번호 : " + reviewCommentNo);
	    
	   
	   // 상품 삭제 버튼
	    $.ajax({
	        type: 'POST',
	        url: '${pageContext.request.contextPath}/shop/deleteReviewComment.do?${_csrf.parameterName}=${_csrf.token}',
	        dataType: 'json',
	        data: {
	            "reviewCommentNo": reviewCommentNo,
	            "reviewNo": reviewNo
	        },
	        success: function (data) {
	            if (data > 0) {
	                alert('리뷰 삭제 완료되었습니다.');
	            }
	            // 리로드
	            window.self.location = "${pageContext.request.contextPath}/shop/myshop.do?shopId=" + tempParam.shopId
	        },
	        error: function (request, status, error) {
	            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	        }
	    });
}
	
</script>

<div class="div-division2">
    <div class="left2">상점후기</div>
    <div id="reviewCount" class="right2"><div style="margin-left:197px;">로그인 후 이용하실 수 있습니다</div></div>
</div>
<div id="review-list">
</div>