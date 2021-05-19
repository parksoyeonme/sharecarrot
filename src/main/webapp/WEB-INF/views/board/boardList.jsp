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
	.likeBtn{
		cursor:pointer;
		height:2em;
	}
</style>
<section id="board-container" class="container">

<br />
	<%-- Nav Bars --%>
	<ul class="nav nav-tabs nav-fill" id="navBars">
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq null? 'active' : ''}" aria-current="page" href="${pageContext.request.contextPath}/board/boardList.do${!empty param.locCode ? '?locCode='+=param.locCode : '' }">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C1'? 'active' : ''} " href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C1${!empty param.locCode ? '&locCode='+=param.locCode : '' }">여행/음식</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C2'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C2${!empty param.locCode ? '&locCode='+=param.locCode : '' }">취미생활</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C3'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C3${!empty param.locCode ? '&locCode='+=param.locCode : '' }">헬스/다이어트</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C4'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C4${!empty param.locCode ? '&locCode='+=param.locCode : '' }">반려동물</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${param.boardCategory eq 'C5'? 'active' : ''}" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C5${!empty param.locCode ? '&locCode='+=param.locCode : '' }">회사생활</a>
    </li>
  </ul>
	<div class='mb-2 mt-2'>
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
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goBoardForm();"/>
	</div>
	
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

				var html = "<div class='m-3'>";
						html = "<table class='table'>";
						html += "<tr class='table-dark'>";
							html += "<td>"+elem.memberId+"</td>";
							html += "<th colspan='2'>"+elem.boardTitle+"</th>";
							html += "<td>"+elem.boardEnrollDate+"</td>";
							html += "<td>"+loc+"</td>";
						html += "</tr>";
						
						html += "<tr id='boardImage-tr' class='table-secondary'>";
							html += "<th colspan='5' style='margin: 0 auto;'>";	
								$.each(elem.boardImageList, function(index, img){
									html += "<img src='${pageContext.request.contextPath}/resources/upload/board/"+img.boardImgRenamed+"' class='img-thumbnail' style='width:200px; height:200px;' onclick='window.open(this.src)' />";
								});
							html += "</th>";
						html += "</tr>";
						html += "<tr class='table-secondary'><td colspan='5'>"+elem.boardContent+"</td></tr>";
						
						<%--좋아요 버튼--%>
						<%-- 좋아요테이블에 해당게시물의 번호가 포함되어있는지 확인 --%>
						var likeBool = false;
						<c:forEach var="boardLike" items="${boardLikeList}">
						  var boardNo = "${boardLike.boardNo}";
						  if(boardNo == elem.boardNo){
						    likeBool = true;
						  }
						</c:forEach>
						
						if(likeBool){ <%--좋아요를 누른경우--%>
							html += `<tr class='table-secondary'><td colspan='5'><img id='likeBtn\${elem.boardNo}' class='likeBtn' src='${pageContext.request.contextPath}/resources/images/board/like.png' onclick="likeBtnTrigger('like\${elem.boardNo}', 'likeCntH\${elem.boardNo}', 'likeCnt\${elem.boardNo}', '\${elem.boardNo}', 'likeBtn\${elem.boardNo}');"/><span id='likeCnt\${elem.boardNo}'> \${elem.boardLike} 명이 좋아합니다.</span></td></tr>`;
							html += `<input type='hidden' id='likeCntH\${elem.boardNo}' value='\${elem.boardLike}'/>`;
							html += `<input type='hidden' id='like\${elem.boardNo}' value='1'>`;
							
						} else { <%-- 안누른경우--%>
							html += `<tr class='table-secondary'><td colspan='5'><img id='likeBtn\${elem.boardNo}' class='likeBtn' src='${pageContext.request.contextPath}/resources/images/board/nolike.png' onclick="likeBtnTrigger('like\${elem.boardNo}', 'likeCntH\${elem.boardNo}',  'likeCnt\${elem.boardNo}', '\${elem.boardNo}', 'likeBtn\${elem.boardNo}');"/><span id='likeCnt\${elem.boardNo}'> \${elem.boardLike} 명이 좋아합니다.</span></td></tr>`;
							html += `<input type='hidden' id='likeCntH\${elem.boardNo}' value='\${elem.boardLike}'/>`;
							html += `<input type='hidden' id='like\${elem.boardNo}' value='-1'>`;
						}
						
						
						<%-- 댓글창 --%>
						html += "<tr class='table-secondary'><td colspan='5'>댓글창</td></tr>";
						
						html +="<tr class='table-secondary'>";
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
				html += "</table>";
				html += "</div><br><br><br>";
				
				$(boardList).append(html);
			});
		}
		
	});
	
	function likeBtnTrigger(likeHiddenId, likeCntH, likeCntSpan, boardNo, likeBtn){
		
		//로그인 하지 않았으면 조기리턴
		<sec:authorize access="isAnonymous()">
			alert('로그인 후 이용하실 수 있습니다.');
			return;
		</sec:authorize>
		
		var hidden = $(`#\${likeHiddenId}`);
		var cntSpan = $(`#\${likeCntSpan}`);
		var likeCntH = $(`#\${likeCntH}`);
		var likeCntHVal = Number(likeCntH.val());
		var likeBtnImg = $(`#\${likeBtn}`);
		
		
		var count = 0;
		if(hidden.val() == 1){ // 좋아요가 눌러져 있다면, 좋아요를 취소한경우
			hidden.val('0');
			likeCntH.val(likeCntHVal - 1);
			count = likeCntHVal -1;
			likeBtnImg.attr('src', '${pageContext.request.contextPath}/resources/images/board/nolike.png');
		} else { // 아니라면, 좋아요를 누른경우
			hidden.val('1');
			likeCntH.val(likeCntHVal +1);
			count = likeCntHVal +1;	
			likeBtnImg.attr('src', '${pageContext.request.contextPath}/resources/images/board/like.png');
		}
		cntSpan.html(` \${count} 명이 좋아합니다.`);
		
		
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/board/boardLike.do?${_csrf.parameterName}=${_csrf.token}',
			data : {
				boardNo : boardNo,
				likeCnt : count,
				likeBool : hidden.val(),
				<sec:authorize access="isAuthenticated()">
				memberId : "<sec:authentication property='principal.username' />"
				</sec:authorize>
			},
			success: function(data){
				console.log(data);
			},
			error:function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
		});
	}
	
	function deleteFrm(){
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		
		$("[name=deleteF]").submit();
	}
	

	</script>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
