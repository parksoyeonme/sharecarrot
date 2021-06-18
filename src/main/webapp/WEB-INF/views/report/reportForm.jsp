<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param value="게시글 작성" name="title"/>
</jsp:include>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
    div#board-container {
        width: 800px;
        text-align: center;
        margin-top: 40px;
        margin-bottom: 50px;
    }
    /* 부트스트랩 : 파일라벨명 정렬*/
    div#board-container label.custom-file-label {
        text-align: left;
    }
</style>
<script>
    // console.log("@@@shop : ", '${shop}');
    var i = 1;
    var html = "";
    $(() => {
        $("#addImgBtn").click(function () {
            html = "";
            i++;
            if (i > 10) {
                alert("이미지 파일은 최대 10개까지만 등록이 가능합니다.");
                return;
            }
            html += "<tr>";
            html += "<td colspan='2'>";
            html += "<input type='file' style='margin-left: 134px' class='form-control' id='upfile" + i + "' name='upfile'>";
            html += "</td>";
            html += "</tr>";
            $("#upfiletr").after(html);
            // append(html);
            // $("#imgContainer").append("<input type='file' class='form-control' id='upfile"+i+"' name='upfile'>");
        });
    });
    function reportValidate() {
        var $reportTitle = $("[name=reportTitle]");
        var $reportContent = $("[name=reportContent]");
        if (/^(.|\n)+$/.test($reportTitle.val()) == false) {
            alert("제목을 입력하세요");
            return false;
        }
        if (/^(.|\n)+$/.test($reportContent.val()) == false) {
            alert("내용을 입력하세요");
            return false;
        }
        return true;
    }
    /* function cancel(shopId) {
        location.href = "${pageContext.request.contextPath}/shop/myshop.do?shopId=" + shopId;
    } */
    function cancel(){
    	history.go(-1);
    	
    }
</script>
<div id="board-container" class="row mx-3 mx-auto text-center">
    <span class="fs-4 fw-bold">신고하기&nbsp;<span class="fs-6 text-danger">*필수입력</span></span>
    <hr/>
    <div style="margin-left: -34px;" class="col-12">
		<form
   			name="reportFrm" action="${pageContext.request.contextPath}/report/reportEnroll.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return reportValidate();">
            <!-- 테이블 -->
            <div class="mb-3 row">
                <label class="col-2 col-form-label fw-bold">제목</label>
                <div class="col-9">
                    <input class="form-control" name="reportTitle" id="reportTitle" placeholder="제목을 입력하세요" required></div>
                    <div class="col-1">
                        <span class=""><span id="productNameLength">0</span>/40</span>
                    </div>
            </div>
            <hr/>
            <div class="mb-3 row">
                <label class="col-2 col-form-label fw-bold">신고 이미지</label>
                <div class="col-9" id="upfiletr">
                    <div class="input-group" id="imgContainer">
                        <input type="file" class="form-control" id="upfile1" name="upfile">
                    </div>
                </div>
                <div class="col-1">
                    <input type="button" class="btn btn-warning" id="addImgBtn" value="이미지 추가"/>
                </div>
            </div>
          	<hr/>
          	<div class="mb-3 row">
            	<label class="col-2 col-form-label fw-bold">신고자</label>
              	<div class="col-3">
                	<input type="text" class="form-control" name="memberId" id="memberId" value="<sec:authentication property="principal.username"/>" readonly required>
               	</div>
            </div>
           	<hr/>
	       	<div class="mb-3 row">
	           <label class="col-2 col-form-label fw-bold">신고할 상점</label>
	           <div class="col-3">
	               <input type="text" class="form-control" name="shopId" id="shopId" value="${shop.shopId}" readonly required>
	           </div>
	       	</div>
           	<hr/>
           	<div class="mb-3 row">
               <label class="col-2 col-form-label fw-bold">신고내용</label>
               <div class="col-9">
                   <textarea class="form-control" name="reportContent" placeholder="내용" required></textarea>
               </div>
               <div class="col-1">
                   <span class=""><span id="productContentLength">0</span>/200</span>
               </div>
           </div>
           	<hr/>
           	<div class="row justify-content-end">
               <div class="col-2">
                   <input type="submit" class="btn btn-warning" style="margin-left: -76px;" value="신고등록">
                   <input type="button" onclick="cancel();" class="btn btn-warning" value="취소">
               </div>
            </div>
        </form>
     </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>