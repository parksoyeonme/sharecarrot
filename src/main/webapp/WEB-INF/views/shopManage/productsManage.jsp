<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	
	//탭 초기화
	$('#productManageNav').on('shown.bs.tab',function(){
		selectProductList();
	});
	
	function selectProductList(search){
		$.ajax({
			url : "selectPoductList.do"
			, type : "POST"
			, data : search
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				var tbody = $('#productListTbody');
				var tbodyHtml = '';
				$.each(result,function(index,item){
					tbodyHtml += '<tr>';
					tbodyHtml += '<td><img class="img-thumbnail" style="object-fit:cover;" width="250" height="250" src="/sharecarrot/resources/upload/product/' + item.productImageList[0].productImgRenamed + '"">';
					tbodyHtml += '<td><select class="form-select">';
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
					tbodyHtml += '<td>' + item.productName + '</td>';
					tbodyHtml += '<td>' + item.productPrice + '</td>';
					tbodyHtml += '<td>찜/댓글</td>';
					tbodyHtml += '<td>' + item.productRegDate + '</td>';
					tbodyHtml += '<td>';
					tbodyHtml += '<button class="btn btn-primary modifyBtn">수정</button>';
					tbodyHtml += '<button class="btn btn-danger deleteBtn">삭제</button>';
					tbodyHtml += '</td>';
					tbodyHtml += '</tr>';
				});
				tbody.append(tbodyHtml);
				
			}
			, error : function(jqXHR){
				alert('로딩 실패');
				return;
			}
		});
	}
	
});
</script>

<div class="row mx-3">
	<div class="col-md-4">
		<div class="input-group">
			<input type="text" class="form-control">
			<button type="button" class="btn btn-outline-primary">검색</button>
		</div>
	</div>
	<div class="col-md-2">
		<select class="form-select" id="productYnhSelect">
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
		<button type="button" class="btn btn"></button>
		<img style="obhce" alt="" src="">
	</div>
</div>
<div class="row mx-3 mt-5">
	<div class="col-md-12">
		<table class="table">
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
