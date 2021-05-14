<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	
});
</script>

<div class="row mx-3">
	<div class="col-md-10">
		<span class="fs-4 fw-bold">기본정보&nbsp;<span class="fs-6 text-danger">*필수입력</span></span>
		<hr/>
		<form action="" id="productRegForm" method="post">
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">상품명</label>
				<div class="col-md-6">
					<input class="form-control" name="product_name" id="productName">
				</div>
				<div class="col-md-1">
					<span class="">0/40</span>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">상품 이미지</label>
				<div class="col-md-10">
					<img src="#" class="img-fluid" id="productImage">
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">상품 구매일</label>
				<div class="col-md-10"> datepicker 반영 예정</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">카테고리</label>
				<div class="col-md-2"> 
					<select class="form-select" id="category1">
						<option>옵션1</option>
						<option>옵션2</option>
						<option>옵션3</option>
						<option>옵션4</option>
					</select>
				</div>
				<div class="col-md-2 offset-md-1"> 
					<select class="form-select" id="category2">
						<option>옵션1</option>
						<option>옵션2</option>
						<option>옵션3</option>
						<option>옵션4</option>
					</select>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">상품 상태</label>
				<div class="col-md-1 form-check">
					<input class="form-check-input" type="radio" name="product_status">
					<label class="form-check-label">새 상품</label>
				</div>
				<div class="col-md-1 form-check">
					<input class="form-check-input" type="radio" name="product_status">
					<label class="form-check-label">증고 상품</label>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">상품 가격</label>
				<div class="col-md-2">
					<input class="form-control" name="product_price" id="productPrice">
				</div>
				<div class="col-md-1">
					<span class="">원</span>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">상품 설명</label>
				<div class="col-md-5">
					<textarea class="form-control" id="productContent" rows="3"></textarea>
				</div>
				<div class="col-md-1">
					<span class="">0/200</span>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-md-1 col-form-label fw-bold">거래 지역</label>
				<div class="col-md-5">
					<input class="form-control" name="product_price" id="">
				</div>
				<div class="col-md-1">
					<button type="button" class="btn btn-success">지역 변경</button>
				</div>
			</div>
			<hr/>
			<div class="row justify-content-end">
				<div class="col-md-1">
					<button type="button" class="btn btn-warning">등록하기</button>
				</div>
			</div>
		</form>
	</div>
</div>