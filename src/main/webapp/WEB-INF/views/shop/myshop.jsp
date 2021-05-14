<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script type="text/javascript">
$(document).ready(function(){
	var initTab = '${tab}';
	
	if(initTab){
		$('.nav-link').removeClass('active');
		$('#'+ initTab +'Nav').addClass('active');
		$('.tab-pane').removeClass('show active');
		$('#'+ initTab).addClass('show active');
	}	
	
	
});
</script>


<div class="container-fluid">
	<div class="row my-3">
		<div class="col-md-12">
			<ul class="nav nav-pills">
				<li class="nav-item">
					<button class="nav-link" id="productRegNav" data-bs-toggle="tab" data-bs-target="#productReg" type="button" role="tab" aria-controls="productReg" aria-selected="true">
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
				<div class="tab-pane fade" id="productReg" role="tabpanel">
					<jsp:include page="myshop_reg.jsp"></jsp:include>
				</div>
				<div class="tab-pane fade" id="productManage" role="tabpanel">
					<jsp:include page="myshop_manage.jsp"></jsp:include>
				</div>
				<div class="tab-pane fade" id="transactionHistory" role="tabpanel">
					<span>구매/판매 내역 페이지</span>
				</div>
			</div>
		</div>
	</div>
	
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
