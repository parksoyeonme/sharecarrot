<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	
});
</script>


<div class="row d-flex justify-content-center">
	<div class="col-md-9">
		<!-- 타이틀 -->
		<p class="fs-3 fw-bold text-center">거래 내역</p>
		
		<!-- 판매구매탭 -->
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item">
				<a class="nav-link" aria-target="page" href="#">판매</a>
			</li>
			<li class="nav-item">
				<a class="nav-link"  href="#">구매</a>
			</li>
		</ul>
		
		<!-- 상태메뉴 -->
		<div class="row my-2 d-flex justify-content-between">
			<div class="col-6">
				<button type="button" class="btn btn-sm btn-outline-secondary">전체</button>
				<button type="button" class="btn btn-sm btn-outline-secondary">진행중</button>
				<button type="button" class="btn btn-sm btn-outline-secondary">완료</button>
				<button type="button" class="btn btn-sm btn-outline-secondary">취소/환불</button>
				<button type="button" class="btn btn-sm btn-outline-secondary">진행중</button>
			</div>
			<div class="col-1">
				<i class="fas fa-list"></i>
			</div>
		</div>
		<!-- 거래내역 목록 -->
		<div class="row">
		
			<!-- 한단위 -->
			<div class="col-12">
				<div class="card mb-3">
					<div class="col-md-4">
						<img>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="card-title">상품1</div>
							<div class="card-text">
								상품설명~~~~
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 한단위 -->
			<div class="col-12">
				<div class="card mb-3">
					<div class="col-md-4">
						<img>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="card-title">상품2</div>
							<div class="card-text">
								상품설명~~~~
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 한단위 -->
			<div class="col-12">
				<div class="card mb-3">
					<div class="col-md-4">
						<img>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="card-title">상품3</div>
							<div class="card-text">
								상품설명~~~~
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 한단위 -->
			<div class="col-12">
				<div class="card mb-3">
					<div class="col-md-4">
						<img>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="card-title">상품4</div>
							<div class="card-text">
								상품설명~~~~
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 한단위 -->
			<div class="col-12">
				<div class="card mb-3">
					<div class="col-md-4">
						<img>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="card-title">상품5</div>
							<div class="card-text">
								상품설명~~~~
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
