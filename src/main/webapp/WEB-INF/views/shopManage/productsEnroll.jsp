<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<script type="text/javascript">
$(document).ready(function(){
	
	//이미지파일리스트
	var imgFileList = new Array();
	
	//상품명 글자수 제한
	$('#productName').on('keyup',function(){
		var length = $(this).val().length;
		$('#productNameLength').text(length);
		if(length > 40){
			$(this).val($(this).val().substring(0,40));
			$('#productNameLength').text('40');
		}
	});
	
	//상품 설명 글자수 제한
	$('#productContent').on('keyup',function(){
		var length = $(this).val().length;
		$('#productContentLength').text(length);
		if(length > 200){
			$(this).val($(this).val().substring(0,200));
			$('#productContentLength').text('200');
		}
	});
	
	//이미지 미리보기
	$('#productImageUpload').on('change',function(){
		//확장자
		var ext = $(this).val().split('.').pop().toLowerCase();
		//업로드 가능 이미지 확장자
		var imageExt = ['jpg', 'jpeg', 'png'];

		if(ext){
			if($.inArray(ext,imageExt) == -1){
				$(this).val('');
				alert('이미지 파일이 아닙니다.');
			}else{
				var list = $('#productImageUpload').prop('files');
				drawPreview(list);
			}
		}
	});
	
	//이미지 미리보기 삭제
	$('#imgRemoveBtn').on('click',function(){
		$('#productImageUpload').val('');
		$('#imagePreview').empty();
	});
	
	
	//대표이미지 설정
	$(document).on('click', '.img-preview', function(){
		if(!confirm('대표이미지를 변경하시겠습니까?')){
			return;
		}
		
		var input = $('#productImageUpload');
		var fileList = input[0].files;
		var selectedName = $(this).data('name');
		var tmpList = new Array();
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
		drawPreview(tmpList);
	});
	
	//상품등록
	$('#productEnrollBtn').on('click', function(){
		
		if($('#productName').val() == '' || $('#productName').val() == null){
			alert('상품명을 입력해주세요.');
			return;
		}else if($('#productPrice').val() == '' || $('#productPrice').val() == null){
			alert('상품 가격을 입력해주세요.');
			return;
		}else if($('#productContent').val() == '' || $('#productContent').val() == null){
			alert('상품 설명을 입력해주세요.');
			return;
		}
		
		if(!confirm('상품을 등록 하시겠습니까?')){
			return;
		}
		
		
		var formData = new FormData();
		//var imgList = $('#productImageUpload').prop('files');
		var imgList = imgFileList;
		
		formData.append("productName", $('#productName').val());
		
		for(var i = 0; i < imgList.length; i++){
			formData.append("productImage", imgList[i]);
		}
		
		formData.append("categoryCode", $('#categoryCode').val());
		formData.append("productStatus", $('input[name="product_status"]:checked').val());
		formData.append("productPrice", $('#productPrice').val());
		formData.append("productContent", $('#productContent').val());
		
		$.ajax({
			url : "productEnroll.do"
			, type : "POST"
			, data : formData
			, processData : false
			, contentType : false
			, beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
			, success : function(result){
				if(result > 0){
					alert('상품 등록에 성공하였습니다.');
					location.href="manage.do";
					return;
				}
			}
			, error : function(jqXHR){
				alert('상품 등록에 실패하였습니다.');
				return;
			}
		});
	});
	
	function drawPreview(list){
		//업로드리스트 초기화
		imgFileList = list;
		//초기화
		$('#imagePreview').empty();
		var imgHtml = "";
		$.each(imgFileList, function(index,file){
			//이미지 url
			var imageUrl = URL.createObjectURL(file);
			
			if((index%3) == 0){
				imgHtml += '<div class="row my-3">';
			}
			if(index == 0){
				imgHtml += '<div class="col-4" style="position: relative;">';
				imgHtml += '<p class="h4 fw-bold" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index=1;l">대표이미지</p>';
				imgHtml += '<img class="img-thumbnail img-preview" src="' + imageUrl + '" data-name="' + file.name + '" style="width:100%; height:100%; opacity: 0.8;">';
			}else{
				imgHtml += '<div class="col-4">';
				imgHtml += '<img class="img-thumbnail img-preview" src="' + imageUrl + '" data-name="' + file.name + '" style="width:100%; height:100%;">';
			}
			imgHtml += '</div>';
			if((index%3) == 2){
				imgHtml += '</div>';
			}
		});
		
		if(imgFileList.length % 3 != 2){
			imgHtml += '</div>';
		}
		$('#imagePreview').append(imgHtml);
	}
});
</script>

<div class="row mx-3">
	<div class="col-10">
		<span class="fs-4 fw-bold">기본정보&nbsp;<span class="fs-6 text-danger">*필수입력</span></span>
		<hr/>
		<form action="productEnroll" id="productRegForm" method="post" enctype="multipart/form-data">
			<div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">상품명</label>
				<div class="col-6">
					<input class="form-control" name="product_name" id="productName">
				</div>
				<div class="col-1">
					<span class=""><span id="productNameLength">0</span>/40</span>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">상품 이미지</label>
				<div class="col-10">
					<input type="file" class="form-control" id="productImageUpload" multiple>
					<div id="imagePreviewMain"></div>
					<div id="imagePreview"></div>
				</div>
				<div class="col-1">
					<button type="button" class="btn-close" aria-label="Close" id="imgRemoveBtn"></button>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">카테고리</label>
				<div class="col-2"> 
					<select class="form-select" id="categoryCode"></select>
				</div>
			</div>
			<hr/>
			<!-- <div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">상품 상태</label>
				<div class="col-2 form-check">
					<input class="form-check-input" type="radio" name="product_status" checked="checked">
					<label class="form-check-label">증고 상품</label>
				</div>
				<div class="col-2 form-check">
					<input class="form-check-input" type="radio" name="product_status">
					<label class="form-check-label">새 상품</label>
				</div>
			</div>
			<hr/> -->
			<div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">상품 가격</label>
				<div class="col-2">
					<input type="number" class="form-control" name="product_price" id="productPrice">
				</div>
				<div class="col-1">
					<span class="">원</span>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">상품 설명</label>
				<div class="col-5">
					<textarea class="form-control" id="productContent" rows="3"></textarea>
				</div>
				<div class="col-1">
					<span class=""><span id="productContentLength">0</span>/200</span>
				</div>
			</div>
			<hr/>
			<div class="mb-3 row">
				<label class="col-1 col-form-label fw-bold">거래 지역</label>
				<div class="col-5">
					<select class="form-select" id="locationCode">
				    </select>
				</div>
			</div>
			<hr/>
			<div class="row justify-content-end">
				<div class="col-1">
					<button type="button" class="btn btn-warning" id="productEnrollBtn">등록하기</button>
				</div>
			</div>
		</form>
	</div>
</div>