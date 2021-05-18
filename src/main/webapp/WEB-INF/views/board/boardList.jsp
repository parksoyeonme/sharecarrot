<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
</style>
<section id="board-container" class="container">
<br />

	<%-- Nav Bars --%>
	<ul class="nav nav-tabs nav-fill" id="navBars">
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq null? 'active' : ''}" aria-current="page" href="${pageContext.request.contextPath}/board/boardList.do">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C1'? 'active' : ''} " href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C1">여행/음식</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C2'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C2">취미생활</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C3'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C3">헬스/다이어트</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C4'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C4">반려동물</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C5'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C5">회사생활</a>
    </li>
  </ul>

	<select class="col-md-2" id="selectLocation" required>
	  <option selected value="">전체지역</option>
	  <c:forEach items="${locationList}" var="location">
	  	<option value="${location.locCode}" ${param.locCode eq location.locCode ? 'selected' : ''}>${location.locName}</option>
	  </c:forEach>
	</select>
	<select class="col-md-2" id="validationCustom04" required>
	  <option value="latest">최신순</option>
	  <option value="hottest">인기순</option>
	</select>
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success pull-right" onclick="goBoardForm();"/>

	<div id="boardList">
	</div>
	<button id="searchMore" class="btn btn-outline-primary btn-block col-sm-10 mx-auto">더 보기</button>
	
	<script>
	function goBoardForm(){
		location.href="${pageContext.request.contextPath}/board/boardEnroll.do";
	}
	
	$(document).ready(function(){
		var boardListCnt = $(boardList).children().length;
		var boardCategory = '<c:out value="${param.boardCategory}"/>';
		var locCode = '<c:out value="${param.locCode}"/>';
		var cPage = 1;
		const numPerPage = 5;
		
		readBoardList(cPage++);
		
		$(searchMore).click(function(){
			readBoardList(cPage++);
		});

		$("#selectLocation").change(function(e){
			var locCode = e.target.value;
			var url = boardCategory == null || boardCategory == '' ? "" : "&boardCategory="+boardCategory;
			console.log(url);
			location.href="${pageContext.request.contextPath}/board/boardList.do?locCode=" + locCode + url;
			/* readBoardList(null, locCode); */
		});
		
		function readBoardList(index){
			$.ajax({
				type: "GET",
				dataType : "json",
				data: {
					boardCategory : boardCategory,
					locCode : locCode,
					cPage: index,
					numPerPage: numPerPage
				},
				url: "${pageContext.request.contextPath}/board/searchBoardList.do?${_csrf.parameterName}=${_csrf.token}",
				success: function(data){
					console.log(data);
					displayList(data);
				},
				error:function(request,status,error){
		            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		           }
			});
		}
		
		
		function displayList(data){
			$.each(data, function(index, elem){
				<%-- 유저 지역 검색 --%>
				var loc = "";
				<c:forEach items='${locationList}' var='location'>
					if('${location.locCode}' == elem.locCode)
						loc = '${location.locName}';
				</c:forEach>

				var html = "<table class='table table-striped table-hover'>";
						html += "<tr>";
							html += "<td>"+elem.memberId+"</td>";
							html += "<th colspan='2'>"+elem.boardTitle+"</th>";
							html += "<td>"+elem.boardEnrollDate+"</td>";
							html += "<td>"+loc+"</td>";
						html += "</tr>";
						
						html += "<tr id='boardImage-tr'>";
							html += "<td colspan='5' style='margin: 0 auto;'>";	
								$.each(elem.boardImageList, function(index, img){
									html += "<img src='${pageContext.request.contextPath}/resources/upload/board/"+img.boardImgRenamed+"' class='img-thumbnail' style='width:200px; height:200px;' onclick='window.open(this.src)' />";
								});
							html += "</td>";
						html += "</tr>";
						html += "<tr><td colspan='5'>"+elem.boardContent+"</td></tr>";
						html += "<tr><td><input type='button' class='btn btn-danger' value='좋아요'/></td><td>"+elem.boardLike+"</td></tr>";
						html += "<tr><td colspan='5'>댓글창</td></tr>";
						html +="<tr>";
							html += "<td colspan='4'>";
								html += "<textarea id='boardCommentText' style='width:100%;'></textarea>";
							html += "</td>";
							html += "<td>";
								html += "<input type='button' class='btn btn-primary' value='댓글 등록' />";
							html += "</td>";
						html += "</tr>";
						//로그인 한경우 수정/삭제버튼 추가
						<sec:authorize access="isAuthenticated()">
						if(elem.memberId == "<sec:authentication property='principal.username'/>"){
							html += "<tr><td></td><td></td><td></td>";
							html += "<td>";
							html += `<input type='button' class='btn btn-danger' onclick="location.href='${pageContext.request.contextPath}/board/boardUpdate.do?boardNo=\${elem.boardNo}';" value='수정'/>`;
							html += "</td>";
							html += "<td>";
							html += `<form name='deleteF' id='deleteFrm\${elem.boardNo}' action='${pageContext.request.contextPath}/board/boardDelete.do?${_csrf.parameterName}=${_csrf.token}' method='POST'>`;
							html += `<button onclick='deleteFrm();' type='button' class='btn btn-danger d-inline'>삭제</button>`;
							html += `<input name='boardNo' type='hidden' value='\${elem.boardNo}'/>`;
							html += "</form>";
							html += "</td>";
							html += "</tr>";			
						}
						
						</sec:authorize>
				html += "<hr/></table>";
				
				$(boardList).append(html);
			});
		}
	});
	
	function deleteFrm(){
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		
		$("[name=deleteF]").submit();
	}
	

	</script>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
