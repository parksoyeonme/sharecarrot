<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	selectProductList();
	
	//기존이미지
	var productImageList = new Array();
	//이미지파일리스트
	var imgFileList = new Array();
	
	//수정 모달
	var myModal = new bootstrap.Modal($('#productUpdateModal'), {
					  keyboard: false
					  , backdrop: 'static'
				});
	
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
		productPaging(1);
	});
	
	//상품 수정 버튼
	$(document).on('click', '.updateBtn', function(){
		var productId = $(this).parent().nextAll('.product-id').val();
		
		if(!confirm('상품정보를 수정하시겠습니까?')){
			return;
		}
		
		$.ajax({
			url : 'selectProductInfo.do'
			, type : 'POST'
			, data : {"productId" : productId}
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        }
			, success : function(result){
				var product = result.product;
				var image = result.image;
				
				productImageList = image;
				
				$('#productNameModal').val(product.productName);
				$('#productNameLengthModal').text($('#productNameModal').val().length);
				$('#categoryCodeModal').val(product.categoryCode);
				$('#productPriceModal').val(product.productPrice);
				$('#productContentModal').val(product.productContent);
				$('#productContentLengthModal').text($('#productContentModal').val().length);
				$('#productIdModal').val(product.productId);
				$('#imagePreviewModal').empty();
				var imgHtml = "";
				$.each(image, function(index,item){
					//이미지 url
					var imageUrl = '/sharecarrot/resources/upload/product/' + item.productImgRenamed;
					
					if((index%3) == 0){
						imgHtml += '<div class="row my-3">';
					}
					if(index == 0){
						imgHtml += '<div class="col-4" style="position: relative;">';
						imgHtml += '<p class="h4 fw-bold" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index=1;l">메인</p>';
						imgHtml += '<img class="img-thumbnail img-preview-modal" src="' + imageUrl + '" data-name="' + item.productImgOrigin + '" style="width:100%; height:100%; opacity: 0.8;">';
					}else{
						imgHtml += '<div class="col-4">';
						imgHtml += '<img class="img-thumbnail img-preview-modal" src="' + imageUrl + '" data-name="' + item.productImgOrigin + '" style="width:100%; height:100%;">';
					}
					imgHtml += '</div>';
					if((index%3) == 2){
						imgHtml += '</div>';
					}
				});
				
				if(imgFileList.length % 3 != 2){
					imgHtml += '</div>';
				}
				$('#imagePreviewModal').append(imgHtml);
				
				myModal.show();
			}
			, error : function(jqXHR){
				alert('상품 수정 실패');
				return;
			}
		});
	});
	
	//상품 수정모달 이미지 업로드
	$('#productImageUploadModal').on('click', function(){
		if(!confirm('이미지를 변경하시겠습니까?')){
			productImageList.length = 0;
			return false;
		}
	});
	
	//상품 삭제 버튼
	$(document).on('click', '.deleteBtn', function(){
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
	
	//상품명 글자수 제한
	$('#productNameModal').on('keyup',function(){
		var length = $(this).val().length;
		$('#productNameLengthModal').text(length);
		if(length > 40){
			$(this).val($(this).val().substring(0,40));
			$('#productNameLengthModal').text('40');
		}
	});
	
	//상품 설명 글자수 제한
	$('#productContentModal').on('keyup',function(){
		var length = $(this).val().length;
		$('#productContentLengthModal').text(length);
		if(length > 200){
			$(this).val($(this).val().substring(0,200));
			$('#productContentLengthModal').text('200');
		}
	});
	
	//이미지 미리보기
	$('#productImageUploadModal').on('change',function(){
		//기존이미지 삭제
		productImageList.length = 0;
		//확장자
		var ext = $(this).val().split('.').pop().toLowerCase();
		//업로드 가능 이미지 확장자
		var imageExt = ['jpg', 'jpeg', 'png'];

		if(ext){
			if($.inArray(ext,imageExt) == -1){
				$(this).val('');
				alert('이미지 파일이 아닙니다.');
			}else{
				var list = $('#productImageUploadModal').prop('files');
				drawPreviewModal(list);
			}
		}
	});
	
	//이미지 미리보기 삭제
	$('#imgRemoveBtnModal').on('click',function(){
		productImageList.length = 0;
		$('#productImageUploadModal').val('');
		$('#imagePreviewModal').empty();
	});
	
	//대표이미지 설정
	$(document).on('click', '.img-preview-modal', function(){
		if(!confirm('대표이미지를 변경하시겠습니까??')){
			return;
		}
		var input = $('#productImageUploadModal')
		var fileList = input[0].files;
		var selectedName = $(this).data('name');
		var tmpList = new Array();
		
		//업로드 없을때 - 최초실행
		if(fileList.length == 0){
			//대표이미지 선택
			$.each(productImageList, function(index, item){
				if(selectedName == item.productImgOrigin){
					tmpList.push(item);
					return;
				}
			});
			//이외파일
			$.each(productImageList, function(index, item){
				if(selectedName != item.productImgOrigin){
					tmpList.push(item);
				}
			});
			productImageList = tmpList;
			drawPreviewModalData();
		}else{
			//대표이미지 선택
			$.each(fileList, function(index, item){
				if(selectedName == item.name){
					tmpList.push(item);
					return;
				}
			});
			//이외파일
			$.each(fileList, function(index, item){
				if(selectedName != item.name){
					tmpList.push(item);
				}
			});
			drawPreviewModal(tmpList);
		}
	});
	
	//수정 버튼
	$('#productUpdateBtn').on('click', function(){
		if($('#productNameModal').val() == '' || $('#productNameModal').val() == null){
			alert('상품명을 입력해주세요.');
			return;
		}else if($('#productPriceModal').val() == '' || $('#productPriceModal').val() == null){
			alert('상품 가격을 입력해주세요.');
			return;
		}else if($('#productContentModal').val() == '' || $('#productContentModal').val() == null){
			alert('상품 설명을 입력해주세요.');
			return;
		}
		
		if(!confirm('상품을 수정 하시겠습니까?')){
			return;
		}
		 
		if(productImageList.length != 0){
			var ajaxJson = {"productId" : $('#productIdModal').val()
							, "productName" : $('#productNameModal').val()
							, "categoryCode" : $('#categoryCodeModal').val()
							, "productPrice" : $('#productPriceModal').val()
							, "productContent" : $('#productContentModal').val()
							, "productImageList": productImageList};
			$.ajax({
				url : "updateProduct.do"
				, type : "POST"
				, data : JSON.stringify(ajaxJson)
				, processData : false
				, contentType : 'application/json; charset=UTF-8'
				, beforeSend : function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            }
				, success : function(result){
					if(result > 0){
						alert('상품 수정에 성공하였습니다.');
						myModal.hide();
						selectProductList();
						return;
					}
				}
				, error : function(jqXHR){
					alert('상품 수정에 실패하였습니다.');
					return;
				}
			});
		}else{
			var formData = new FormData();
			var imgList = imgFileList;
			
			formData.append("productId", $('#productIdModal').val());
			formData.append("productName", $('#productNameModal').val());
			formData.append("categoryCode", $('#categoryCodeModal').val());
			formData.append("productPrice", $('#productPriceModal').val());
			formData.append("productContent", $('#productContentModal').val());
			
			if(productImageList.length == 0){
				for(var i = 0; i < imgList.length; i++){
					formData.append("productImage", imgList[i]);
				}
			}
			
			$.ajax({
				url : "updateProductNewImage.do"
				, type : "POST"
				, data : formData
				, processData : false
				, contentType : false
				, beforeSend : function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            }
				, success : function(result){
					if(result > 0){
						alert('상품 수정에 성공하였습니다.');
						myModal.hide();
						selectProductList();
						return;
					}
				}
				, error : function(jqXHR){
					alert('상품 수정에 실패하였습니다.');
					return;
				}
			});
		}
	});
	
	$(document).on('click', '.page-product', function(){
		productPaging($(this).data('page'));
	});
	
	$(document).on('click', '.img-manage', function(){
		var productId = $(this).parent().nextAll('.product-id').val();
		location.href='${pageContext.request.contextPath}/product/productDetail.do?productId=' + productId;
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
				var productList = result.productList;
				var paging = result.paging;
				
				var tbody = $('#productListTbody');
				tbody.empty();
				
				var tbodyHtml = '';
				$.each(productList,function(index,item){
					tbodyHtml += '<tr>';
					if(item.productImageList[0]){
						tbodyHtml += '<td class="align-middle" style="width:10%;">';
						tbodyHtml += '<img class="img-thumbnail img-manage" role="button" style="object-fit:cover;" height="250" src="/sharecarrot/resources/upload/product/' + item.productImageList[0].productImgRenamed + '"">';
						tbodyHtml += '</td>';
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
					tbodyHtml += '<td class="align-middle" style="width:10%;">' + item.jjimCnt + '</td>';
					tbodyHtml += '<td class="align-middle" style="width:10%;">' + getDateFormat(new Date(item.productRegDate)) + '</td>';
					tbodyHtml += '<td class="align-middle" style="width:10%;">';
					tbodyHtml += '<button class="btn btn-primary updateBtn">수정</button>';
					tbodyHtml += '<button class="btn btn-danger deleteBtn">삭제</button>';
					tbodyHtml += '</td>';
					tbodyHtml += '<input type="hidden" class="product-id" value="' + item.productId + '"/>';
					tbodyHtml += '</tr>';
				});
				tbody.append(tbodyHtml);
				
				//페이징
				var pagingHtml = '';
				
				if(paging.minNum == 1){
					pagingHtml += '<li class="page-item disabled"><a class="page-link page-product" href="#">&lt;&lt;</a></li>';
				}else{
					pagingHtml += '<li class="page-item"><a class="page-link page-product" href="#" data-page="' + (paging.minNum - 1) + '">&lt;&lt;</a></li>';
				}
				
				for(var i = paging.minNum; i <= paging.maxNum; i++){
					if(i > paging.maxPageNum){
						break;
					}
					if(i == paging.pageNum){
						pagingHtml += '<li class="page-item active"><a class="page-link page-product">' + i + '</a></li>';
					}else{
						pagingHtml += '<li class="page-item"><a class="page-link page-product" href="javascript:void(0);" data-page="' + i + '">' + i + '</a></li>';
					}
				}
				if(paging.maxNum >= paging.maxPageNum){
					pagingHtml += '<li class="page-item disabled"><a class="page-link page-product" href="#">&gt;&gt;</a></li>';
				}else{
					pagingHtml += '<li class="page-item"><a class="page-link page-product" href="#" data-page="' + (paging.maxNum + 1) + '">&gt;&gt;</a></li>';
				}
				
				$('#paging').empty();
				$('#paging').append(pagingHtml);
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
	
	function productPaging(pageNum){
		var search = {"productName" : $('#searchKeyword').val()
				 , "productYnh" : $('#productYnhSelect').val()
				 , "categoryCode" : $('#categoryCode2').val()
				 , "pageNum" : pageNum};
		selectProductList(search);
	}
	
	function drawPreviewModalData(){
		//초기화
		$('#imagePreviewModal').empty();
		var imgHtml = "";
		$.each(productImageList, function(index,item){
			//이미지 url
			var imageUrl = '/sharecarrot/resources/upload/product/' + item.productImgRenamed;
			
			if((index%3) == 0){
				imgHtml += '<div class="row my-3">';
			}
			if(index == 0){
				imgHtml += '<div class="col-4" style="position: relative;">';
				imgHtml += '<p class="h4 fw-bold" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index=1;l">메인</p>';
				imgHtml += '<img class="img-thumbnail img-preview-modal" src="' + imageUrl + '" data-name="' + item.productImgOrigin + '" style="width:100%; height:100%; opacity: 0.8;">';
			}else{
				imgHtml += '<div class="col-4">';
				imgHtml += '<img class="img-thumbnail img-preview-modal" src="' + imageUrl + '" data-name="' + item.productImgOrigin + '" style="width:100%; height:100%;">';
			}
			imgHtml += '</div>';
			if((index%3) == 2){
				imgHtml += '</div>';
			}
		});
		
		if(imgFileList.length % 3 != 2){
			imgHtml += '</div>';
		}
		$('#imagePreviewModal').append(imgHtml);
	}
	
	function drawPreviewModal(list){
		//업로드리스트 초기화
		imgFileList = list;
		//초기화
		$('#imagePreviewModal').empty();
		var imgHtml = "";
		$.each(imgFileList, function(index,file){
			//이미지 url
			var imageUrl = URL.createObjectURL(file);
			
			if((index%3) == 0){
				imgHtml += '<div class="row my-3">';
			}
			if(index == 0){
				imgHtml += '<div class="col-4" style="position: relative;">';
				imgHtml += '<p class="h4 fw-bold" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index=1;l">메인</p>';
				imgHtml += '<img class="img-thumbnail img-preview-modal" src="' + imageUrl + '" data-name="' + file.name + '" style="width:100%; height:100%; opacity: 0.8;">';
			}else{
				imgHtml += '<div class="col-4">';
				imgHtml += '<img class="img-thumbnail img-preview-modal" src="' + imageUrl + '" data-name="' + file.name + '" style="width:100%; height:100%;">';
			}
			imgHtml += '</div>';
			if((index%3) == 2){
				imgHtml += '</div>';
			}
		});
		
		if(imgFileList.length % 3 != 2){
			imgHtml += '</div>';
		}
		$('#imagePreviewModal').append(imgHtml);
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
					<th scope="col">찜</th>		
					<th scope="col">등록일</th>		
					<th scope="col">수정/삭제</th>		
				</tr>
			</thead>
			<tbody id="productListTbody" style="table-layout: fixed;">
			</tbody>
		</table>
	</div>
</div>

<div class="row mx-3">
	<div class="col-md-12">
		<ul class="pagination justify-content-center" id="paging">
		</ul>
	</div>
</div>

<!-- 수정 -->

<div class="modal fade" id="productUpdateModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalTitle">상품 정보 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
    			<form id="productUpdateModalForm">
    				<table class="table">
    					<tbody>
    						<tr>
    							<th width="20%">상품명</th>
    							<td width="80%">
    								<div class="row">
    									<div class="col-10">
		    								<input class="form-control" name="product_name" id="productNameModal">
    									</div>
    									<div class="col-2">
    										<span class=""><span id="productNameLengthModal">0</span>/40</span>
    									</div>
    								</div>
    							</td>
    						</tr>
    						<tr>
    							<th>상품이미지</th>
    							<td>
    								<div class="row">
    									<div class="col-10">
    										<input type="file" class="form-control" id="productImageUploadModal" multiple>
											<div id="imagePreviewMainModal"></div>
											<div id="imagePreviewModal"></div>
    									</div>
    									<div class="col-1">
    										<button type="button" class="btn-close" aria-label="Close" id="imgRemoveBtnModal"></button>
    									</div>
    									
    								</div>
    							
    							</td>
    						</tr>
    						<tr>
    							<th>카테고리</th>
    							<td>
    								<div class="row">
    									<div class="col-6">
			    							<select class="form-select" id="categoryCodeModal"></select>
    									</div>
    								</div>
    							</td>
    						</tr>
    						<tr>
    							<th>상품가격</th>
    							<td>
	    							<div class='row'>
	    								<div class="col-6">
	    									<input type="number" class="form-control" name="product_price" id="productPriceModal">
	    								</div>
	    								<div class="col-2">
	    									원
	    								</div>
	    							</div>
   								</td>
    						</tr>
							<tr>
    							<th>상품설명</th>
    							<td>
    								<div class="row">
    									<div class="col-10">
    										<textarea class="form-control" id="productContentModal" rows="3"></textarea>
    									</div>
    									<div class="col-2">
    										<span class=""><span id="productContentLengthModal">0</span>/200</span>
    									</div>
    								</div>
    							</td>
    						</tr>
    						<!-- <tr>
    							<th>거래 지역</th>
    							<td>
	    							<div class="row">
	  									<div class="col-6">
	  										<select class="form-select" id="locationCodeModal"></select>
	  									</div>
	  								</div>
    							</td>
    						</tr> -->
    					</tbody>
    				</table>
 					<input type="hidden" id="productIdModal">
    			</form>
 			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="productUpdateBtn">수정</button>
			</div>
		</div>
	</div>
</div>
