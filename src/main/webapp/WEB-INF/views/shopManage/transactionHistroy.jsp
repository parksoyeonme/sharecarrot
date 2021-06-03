<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
.star, .star2{
	color: #FFEB34;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	var tab = 'buy';
	
	//후기모달
	var reviewModal = new bootstrap.Modal($('#reviewModal'), {keyboard: false, backdrop: 'static'});
	var reviewViewModal = new bootstrap.Modal($('#reviewViewModal'), {keyboard: false});
	//별점점수
	var reviewScore = 1;
	
	//최초실행
	buyTabActive();
	
	//상단탭클릭
	$('#transactionHistoryNav').on('show.bs.tab',function(){
		buyTabActive();
	});
	
	//탭클릭
	$('#buyTab').on('click', function(){
		buyTabActive();
	});
	//탭클릭
	$('#sellTab').on('click', function(){
		sellTabActive();
	});
	
	//후기작성버튼
	$(document).on('click', '.btn-review', function(){
		if(!confirm('후기를 작성하시겠습니까?')){
			return;
		}
		
		var productId = $(this).parent().nextAll('.product-id').val();
		$('#reviewProductId').val(productId);
		
		reviewModal.show();
	});
	
	//후기조회버튼
	$(document).on('click', '.btn-reviewView', function(){
		var productId = $(this).parent().nextAll('.product-id').val();
		
		$.ajax({
			url : 'selectStoreReview.do'
			, type : 'POST'
			, data : {"productId" : productId}
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        }
			, success : function(result){
				if(result){
					$('#reviewViewTitle').val(result.reviewTitle);
					$('#reviewViewContent').val(result.reviewContent);
					$.each($('.star2').children(), function(index, item){
						if(result.reviewScore >= item.dataset.score){
							item.classList.remove('far');
							item.classList.add('fas');
						}else{
							item.classList.remove('fas');
							item.classList.add('far');
						}
					});
					reviewViewModal.show();
				}else{
					alert('후기가 작성되지 않았습니다.');
					return;
				}
			}
		});
		
		
	});
	//상태변경
	$('.btn-status').on('click', function(){
		$('.btn-status').removeClass('btn-danger').removeClass('btn-active');
		$('.btn-status').addClass('btn-outline-secondary');
		$(this).removeClass('btn-outline-secondary');
		$(this).addClass('btn-danger').addClass('btn-active');
		dataInit();
	});
	//페이징
	$(document).on('click','.page-transaction',function(){
		dataInit($(this).data('page'));
	});
	
	//별점
	$('.star').on('click', function(){
		var score = $(this).children().data('score')
		reviewScore = score;
		$('#reviewScoreLength').text(score);
	});
	
	//별점 마우스오버
	$('.star').on('mouseover', function(){
		var i = $(this).children().data('index');
		$.each($('.fa-star'),function(index,item){
			if(i >= index){
				item.classList.remove('far');
				item.classList.add('fas');
			}else if(i < index){
				item.classList.remove('fas');
				item.classList.add('far');
			}
		});
	}).on('mouseleave', function(){
		$.each($('.fa-star'), function(index,item){
			if(reviewScore >= item.dataset.score){
				item.classList.remove('far');
				item.classList.add('fas');
			}else if(reviewScore < item.dataset.score){
				item.classList.remove('fas');
				item.classList.add('far');
			}
		});
	});

	$('#reviewTitle').on('keyup',function(){
		var length = $(this).val().length;
		$('#reviewTitleLength').text(length);
		if(length > 40){
			$(this).val($(this).val().substring(0,40));
			$('#reviewTitleLength').text('40');
		}
	});
	
	$('#reviewContent').on('keyup',function(){
		var length = $(this).val().length;
		$('#reviewContentLength').text(length);
		if(length > 200){
			$(this).val($(this).val().substring(0,200));
			$('#reviewContentLength').text('200');
		}
	});
	
	$('#insertReviewBtn').on('click', function(){
		var reviewTitle = $('#reviewTitle').val();
		var reviewContent = $('#reviewContent').val();
		
		if(!confirm('작성하시겠습니까?')){
			return false;
		}
		
		
		if(reviewTitle == '' || reviewTitle == null){
			alert('제목을 입력하세요.');
			return;
		}else if(reviewContent == '' || reviewContent == null){
			alert('내용을 입력하세요.');
			return;
		}
		
		$.ajax({
			url : 'insertStoreReview.do'
			, type : "POST"
			, data : {"reviewTitle" : reviewTitle
					, "reviewContent" : reviewContent
					, "reviewScore" : reviewScore
					, "productId" : $('#reviewProductId').val()}
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        }
			, success : function(result){
				if(result > 0){
					alert('작성 완료.');
					dataInit();
					reviewModal.hide();
					return;
				}
			}
		});
	});
	
	$('#reviewModal').on('hidden.bs.modal', function(){
		$('#reviewTitleLength').text('0');
		$('#reviewTitle').val('');
		$('#reviewContentLength').text('0');
		$('#reviewContent').val('');
		$('#reviewScoreLength').text('0');
		reviewScore = 0;
		
	});
	
	
	function dataInit(pageNum){
		if(!pageNum){
			pageNum = 1;
		}
		
		var status = $('.btn-active').data('status');
		$.ajax({
			url : 'selectTransactionList.do'
			, type : "POST"
			, data : {"transactionType" : tab, "productYnh" : status, "pageNum" : pageNum}
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				var transactionList = result.transactionList;
				var paging = result.paging;
				var html = '';
				if(transactionList.length != 0){
					$.each(transactionList, function(index, item){
						html += '<tr>';
						if(item.productImageList[0]){
							html += '<td class="align-middle" style="width:20%;">';
							html += '<img class="img-thumbnail" style="object-fit:cover;" height="250" src="/sharecarrot/resources/upload/product/' + item.productImageList[0].productImgRenamed + '"">';
							html += '</td>';
						}else{
							html += '<td class="align-middle" style="width:10%;"></td>';
						}
						html += '<td class="align-middle" style="width:60%;">' + item.productName + '</td>';
						html += '<td class="align-middle" style="width:10%;">' + getDateFormat(new Date(item.productRegDate)) + '</td>';
						if(tab == 'buy'){
							if(item.reviewYn == 'Y'){
								html += '<td class="align-middle" style="width:20%;"><button class="btn btn-success btn-reviewView">후기조회</button></td>';
							}else{
								html += '<td class="align-middle" style="width:20%;"><button class="btn btn-success btn-review">후기작성</button></td>';
							}
						}else if(tab == 'sell'){
							html += '<td class="align-middle" style="width:20%;"><button class="btn btn-success btn-reviewView">후기조회</button></td>';
						}
						
						html += '<input type="hidden" class="product-id" value="' + item.productId + '"/>';
						html += '</tr>';
					});
				}else{
					html += '<tr><td><p class="h2">거래 내역이 없습니다.<p></td></tr>';
				}
				$('#transactionList').empty();
				$('#transactionList').append(html);
				
				//페이징
				var pagingHtml = '';
				
				if(paging.minNum == 1){
					pagingHtml += '<li class="page-item disabled"><a class="page-link page-transaction" href="#">&lt;&lt;</a></li>';
				}else{
					pagingHtml += '<li class="page-item"><a class="page-link page-transaction" href="#" data-page="' + (paging.minNum - 1) + '">&lt;&lt;</a></li>';
				}
				
				for(var i = paging.minNum; i <= paging.maxNum; i++){
					if(i > paging.maxPageNum){
						break;
					}
					if(i == paging.pageNum){
						pagingHtml += '<li class="page-item active"><a class="page-link page-transaction">' + i + '</a></li>';
					}else{
						pagingHtml += '<li class="page-item"><a class="page-link page-transaction" href="javascript:void(0);" data-page="' + i + '">' + i + '</a></li>';
					}
				}
				if(paging.maxNum >= paging.maxPageNum){
					pagingHtml += '<li class="page-item disabled"><a class="page-link page-transaction" href="#">&gt;&gt;</a></li>';
				}else{
					pagingHtml += '<li class="page-item"><a class="page-link page-transaction" href="#" data-page="' + (paging.maxNum + 1) + '">&gt;&gt;</a></li>';
				}
				
				$('#transactionPaging').empty();
				$('#transactionPaging').append(pagingHtml);
				
			}
			, error : function(jqXHR){
				alert('조회 실패');
				return;
			}
		});
	
	
	}
	
	function statusInit(){
		$('.btn-status').removeClass('btn-danger').removeClass('btn-active');
		$('.btn-status').addClass('btn-outline-secondary');
		$('#allTab').removeClass('btn-outline-secondary');
		$('#allTab').addClass('btn-danger').addClass('btn-active');
		dataInit();
	}
	
	function buyTabActive(){
		tab = 'buy';
		$('#buyTab').addClass('active');
		$('#sellTab').removeClass('active');
		statusInit();
	}
	
	function sellTabActive(){
		tab = 'sell';
		$('#sellTab').addClass('active');
		$('#buyTab').removeClass('active');
		statusInit();
	}
	
	function getDateFormat(date){
		var year = date.getFullYear();
		var month = (1 + date.getMonth());
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		return year + '-' + month + '-' + day;
	}
});
</script>


<div class="row d-flex justify-content-center">
	<div class="col-md-12">
		<!-- 타이틀 -->
		<p class="fs-3 fw-bold text-center">거래 내역</p>
		
		<!-- 판매구매탭 -->
		<ul class="nav nav-pills nav-justified">
			<li class="nav-item">
				<a class="nav-link nav-status active" data-tab="buy" aria-target="page" href="#" id="sellTab">판매</a>
			</li>
			<li class="nav-item">
				<a class="nav-link nav-status" data-tab="sell" href="#" id="buyTab">구매</a>
			</li>
		</ul>
		
		<!-- 상태메뉴 -->
		<!-- 
		<div class="row my-2 d-flex justify-content-between">
			<div class="col-6">
				<button type="button" class="btn btn-sm btn-status" data-status="" id="allTab">전체</button>
				<button type="button" class="btn btn-sm btn-status" data-status="N" id="preTab">판매중</button>
				<button type="button" class="btn btn-sm btn-status" data-status="H" id="progressTab">진행중</button>
				<button type="button" class="btn btn-sm btn-status" data-status="Y" id="finishTab">완료</button>
			</div>
			<div class="col-1">
				<i class="fas fa-list"></i>
			</div>
		</div>
		 -->
		<!-- 거래내역 목록 -->
		<div class="col-12">
			<table>
				<tbody id="transactionList"></tbody>
			</table>
		</div>
	</div>
</div>

<div class="row mx-3">
	<div class="col-md-12">
		<ul class="pagination justify-content-center" id="transactionPaging">
		</ul>
	</div>
</div>

<div class="modal fade" id="reviewModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">후기 작성</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="col-12 row my-3">
					<div class="col-3">
						<span class="align-middle">제목</span>
					</div>
					<div class="col-8">
						<input type="text" class="form-control" id="reviewTitle"/>
					</div>
					<div class="col-1">
						<span class=""><span id="reviewTitleLength">0</span>/40</span>
					</div>
				</div>
				
				<div class="col-12 row my-3">
					<div class="col-3">
						<span class="align-middle">내용</span>
					</div>
					<div class="col-8">
						<textarea class="form-control" rows="3" id="reviewContent"></textarea>
					</div>
					<div class="col-1">
						<span class=""><span id="reviewContentLength">0</span>/200</span>
					</div>
				</div>
			
				<div class="col-12 row my-3">
					<div class="col-3">
						<span class="align-middle">점수</span>
					</div>
				    <div class="col-1 star" role="button"><i class="fas fa-star" data-index="0" data-score="1"></i></div>
				    <div class="col-1 star" role="button"><i class="far fa-star" data-index="1" data-score="2"></i></div>
				    <div class="col-1 star" role="button"><i class="far fa-star" data-index="2" data-score="3"></i></div>
				    <div class="col-1 star" role="button"><i class="far fa-star" data-index="3" data-score="4"></i></div>
				    <div class="col-1 star" role="button"><i class="far fa-star" data-index="4" data-score="5"></i></div>
					<div class="col-1 offset-3">
						<span class=""><span id="reviewScoreLength">1</span>/5</span>
					</div>
				</div>
				<input type="hidden" id="reviewProductId">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="insertReviewBtn">작성완료</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="reviewViewModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">후기 조회</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="col-12 row my-3">
					<div class="col-3">
						<span class="align-middle">제목</span>
					</div>
					<div class="col-8">
						<input type="text" class="form-control" id="reviewViewTitle" readonly/>
					</div>
				</div>
				
				<div class="col-12 row my-3">
					<div class="col-3">
						<span class="align-middle">내용</span>
					</div>
					<div class="col-8">
						<textarea class="form-control" rows="3" id="reviewViewContent" readonly></textarea>
					</div>
				</div>
			
				<div class="col-12 row my-3">
					<div class="col-3">
						<span class="align-middle">점수</span>
					</div>
				    <div class="col-1 star2"><i class="fas fa-star" data-index="0" data-score="1"></i></div>
				    <div class="col-1 star2"><i class="far fa-star" data-index="1" data-score="2"></i></div>
				    <div class="col-1 star2"><i class="far fa-star" data-index="2" data-score="3"></i></div>
				    <div class="col-1 star2"><i class="far fa-star" data-index="3" data-score="4"></i></div>
				    <div class="col-1 star2"><i class="far fa-star" data-index="4" data-score="5"></i></div>
				</div>
				<input type="hidden" id="reviewProductId">
			</div>
		</div>
	</div>
</div>