<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script type="text/javascript">
$(document).ready(function(){
	var initTab = '${tab}';
	
	getCode();
	
	if(initTab){
		$('.nav-link').removeClass('active');
		$('#'+ initTab +'Nav').addClass('active');
		$('.tab-pane').removeClass('show active');
		$('#'+ initTab).addClass('show active');
	}
	
	$('#productEnrollNav').on('show.bs.tab',function(){
		history.pushState(null,null,"enroll.do");
		$('#productRegForm')[0].reset();
		getCode();
	});
	
	$('#productManageNav').on('show.bs.tab',function(){
		history.pushState(null,null,"manage.do");
		getCode();
	});
	
	$('#transactionHistoryNav').on('show.bs.tab',function(){
		history.pushState(null,null,"transactionHistory.do");
	});
	
	//카테고리, 지역
	function getCode(){
		$('#categoryCode').empty();
		$('#categoryCode2').empty();
		$('#locationCode').empty();
		
		$.ajax({
			url : "getCode.do"
			, type : "POST"
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				var category = '';
				$.each(result.category,function(index, item){
					category += '<option value="' + item.categoryCode +'">'+ item.categoryName + '</option>';
				});
				$('#categoryCode').append(category);
				$('#categoryCodeModal').append(category);
				
				category = '<option value="">전체</option>' + category;
				$('#categoryCode2').append(category);
				
				var location = '';
				$.each(result.location,function(index, item){
					location += '<option value="' + item.locCode +'">'+ item.locName + '</option>';
				});
				$('#locationCode').append(location);
				$('#locationCodeModal').append(location);
			}
		});
	}
	
	
	
	
});
</script>


<div class="container-fluid" style="width: 1024px;">
	<div class="row my-3">
		<div class="col-md-12">
			<ul class="nav nav-pills">
				<li class="nav-item">
					<button class="nav-link" id="productEnrollNav" data-bs-toggle="tab" data-bs-target="#productEnroll" type="button" role="tab" aria-controls="productEnroll" aria-selected="true">
						상품등록
					</button>
				</li>
				<li class="nav-item">
					<button class="nav-link" id="productManageNav" data-bs-toggle="tab" data-bs-target="#productManage" type="button" role="tab" aria-controls="productManage" aria-selected="false">
						상품관리
					</button>
				</li>
				<li class="nav-item">
					<button class="nav-link" id="transactionHistoryNav" data-bs-toggle="tab" data-bs-target="#transactionHistory" type="button" role="tab" aria-controls="transactionHistory" aria-selected="false">
						구매/판매 내역
					</button>
				</li>
			</ul>
		</div>
	</div> 
	
	<div class="row">
		<div class="col-md-12">
			<div class="tab-content">
				<div class="tab-pane fade" id="productEnroll" role="tabpanel">
					<jsp:include page="productsEnroll.jsp"></jsp:include>
				</div>
				<div class="tab-pane fade" id="productManage" role="tabpanel">
					<jsp:include page="productsManage.jsp"></jsp:include>
				</div>
				<div class="tab-pane fade" id="transactionHistory" role="tabpanel">
					<jsp:include page="transactionHistroy.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
