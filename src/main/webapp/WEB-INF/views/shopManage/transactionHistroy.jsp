<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	
	var tab = 'buy';
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
	
	$(document).on('click', '.btn-review', function(){
		if(!confirm('후기를 작성하시겠습니까?')){
			return;
		}
		
		var productId = $(this).parent().nextAll('.product-id').val();
		
		alert('상품번호 : ' + productId);
	})
	
	$('.btn-status').on('click', function(){
		$('.btn-status').removeClass('btn-danger').removeClass('btn-active');
		$('.btn-status').addClass('btn-outline-secondary');
		$(this).removeClass('btn-outline-secondary');
		$(this).addClass('btn-danger').addClass('btn-active');
		dataInit();
	});
	
	$(document).on('click','.page-transaction',function(){
		dataInit($(this).data('page'));
	})
	
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
						html += '<td class="align-middle" style="width:20%;"><button class="btn btn-success btn-review">후기작성</button></td>';
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
