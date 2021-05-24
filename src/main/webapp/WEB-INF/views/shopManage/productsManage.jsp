<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	selectProductList();
	
	//탭 초기화
	$('#productManageNav').on('shown.bs.tab',function(){
		selectProductList();
	});
	
	//판매상태 변경
	$(document).on('change', '.product-ynh', function(){
		var productId = $(this).parent().nextAll('.product-id').val();
		var productYnh = $(this).val();
		
		if(!confirm('상태를 변경하시겠습니까?')){
			return;
		}
		
		$.ajax({
			url : 'updateProductYnh.do'
			, type : "POST"
			, data : {"productId" : productId, "productYnh" : productYnh}
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				if(result > 0){
					alert('상태 변경 완료');
					return;
				}else{
					alert('상태 변경 실패');
					return;
				}
			}
			, error : function(jqXHR){
				alert('상태 변경 실패');
				return;
			}
		});
	});
	
	//상품 검색 버튼
	$('#searchBtn').on('click', function(){
		var search = {"productName" : $('#searchKeyword').val()
					 , "productYnh" : $('#productYnhSelect').val()
					 , "categoryCode" : $('#categoryCode2').val()};
		selectProductList(search);
	});
	
	//상품 수정 버튼
	
	//상품 삭제 버튼
	$(document).on('click','.deleteBtn',function(){
		var productId = $(this).parent().nextAll('.product-id').val();
		
		if(!confirm('상품을 삭제하시겠습니까?')){
			return;
		}
		
		$.ajax({
			url : 'deleteProduct.do'
			, type : "POST"
			, data : {"productId" : productId}
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				if(result > 0){
					alert('상품 삭제 완료');
					selectProductList();
					return;
				}else{
					alert('상품 삭제 실패');
					return;
				}
			}
			, error : function(jqXHR){
				alert('상품 삭제 실패');
				return;
			}
		});
	});
	
	function selectProductList(search){
		$.ajax({
			url : "selectProductList.do"
			, type : "POST"
			, data : search
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				console.log(result);
				
				var tbody = $('#productListTbody');
				tbody.empty();
				
				var tbodyHtml = '';
				$.each(result,function(index,item){
					tbodyHtml += '<tr>';
					if(item.productImageList[0]){
						tbodyHtml += '<td class="align-middle" style="width:10%;"><img class="img-thumbnail" style="object-fit:cover;" height="250" src="/sharecarrot/resources/upload/product/' + item.productImageList[0].productImgRenamed + '""></td>';
					}else{
						tbodyHtml += '<td class="align-middle" style="width:10%;"></td>';
					}
					tbodyHtml += '<td class="align-middle" style="width:10%;"><select class="form-select product-ynh">';
					if(item.productYnh == 'N'){
						tbodyHtml += '<option value="N" selected>판매중</option>';
						tbodyHtml += '<option value="H">예약중</option>';
						tbodyHtml += '<option value="Y">판매완료</option>';
					}else if(item.productYnh == 'H'){
						tbodyHtml += '<option value="N">판매중</option>';
						tbodyHtml += '<option value="H" selected>예약중</option>';
						tbodyHtml += '<option value="Y">판매완료</option>';
					}else if(item.productYnh == 'Y'){
						tbodyHtml += '<option value="N">판매중</option>';
						tbodyHtml += '<option value="H">예약중</option>';
						tbodyHtml += '<option value="Y" selected>판매완료</option>';
					}
					tbodyHtml += '</select></td>';
					tbodyHtml += '<td class="align-middle" style="width:20%;">' + item.productName + '</td>';
					tbodyHtml += '<td class="align-middle" style="width:10%;">' + item.productPrice + '</td>';
					tbodyHtml += '<td class="align-middle" style="width:10%;">찜/댓글</td>';
					tbodyHtml += '<td class="align-middle" style="width:10%;">' + getDateFormat(new Date(item.productRegDate)) + '</td>';
					tbodyHtml += '<td class="align-middle" style="width:10%;">';
					tbodyHtml += '<button class="btn btn-primary modifyBtn">수정</button>';
					tbodyHtml += '<button class="btn btn-danger deleteBtn">삭제</button>';
					tbodyHtml += '</td>';
					tbodyHtml += '<input type="hidden" class="product-id" value="' + item.productId + '"/>';
					tbodyHtml += '</tr>';
				});
				tbody.append(tbodyHtml);
				
			}
			, error : function(jqXHR){
				alert('로딩 실패');
				location.href="/sharecarrot";
				return;
			}
		});
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

<div class="row mx-3">
	<div class="col-md-4">
		<div class="input-group">
			<input type="text" class="form-control" id="searchKeyword" placeholder="상품명을 입력해주세요.">
			<button type="button" class="btn btn-outline-primary" id="searchBtn">검색</button>
		</div>
	</div>
	<div class="col-md-2">
		<select class="form-select" id="productYnhSelect">
			<option value="">전체</option>
			<option value="N">판매중</option>
			<option value="H">예약중</option>
			<option value="Y">판매완료</option>
		</select>
	</div>
	<div class="col-md-2">
		<select class="form-select" id="categoryCode2">
		</select>
	</div>
	<div class="col-md-1">
	</div>
</div>
<div class="row mx-3 mt-5">
	<div class="col-md-12">
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">사진</th>		
					<th scope="col">판매상태</th>		
					<th scope="col">상품명</th>		
					<th scope="col">가격</th>		
					<th scope="col">찜/댓글</th>		
					<th scope="col">등록일</th>		
					<th scope="col">수정/삭제</th>		
				</tr>
			</thead>
			<tbody id="productListTbody" style="table-layout: fixed;">
			
			
			</tbody>
		</table>
	</div>
</div>

<div class="row mx-3 mt-5">
	<div class="col-md-12">
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="#">&lt;&lt;</a></li>
			<li class="page-item"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">4</a></li>
			<li class="page-item"><a class="page-link" href="#">5</a></li>
			<li class="page-item"><a class="page-link" href="#">&gt;&gt;</a></li>
		</ul>
	</div>
</div>
