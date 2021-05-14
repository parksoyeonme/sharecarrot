<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
</style>
<section id="board-container" class="container">
<br />
	<ul class="nav nav-tabs nav-fill" id="navBars">
    <li class="nav-item">
      <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/board/boardList.do">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C1">여행/음식</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C2">취미생활</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C3">헬스/다이어트</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C4">반려동물</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do?boardCategory=C5">회사생활</a>
    </li>
  </ul>

  <script>
    const navItem = $("ul .nav-item");
    navItem.click(function(e){
      navItem.removeClass('active');
      $.each(navItem, function(index, item){
        let tagA = $(item).find('a');
        tagA.removeClass('active');
      });
      $(e.target).addClass('active');
    });
  </script>

	<select class="col-md-2" id="selectLocation" required>
	  <option selected disabled value="">지역선택</option>
	  <c:forEach items="${locationList}" var="location">
	  	<option value="${location.locCode}">${location.locName}</option>
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
		var boardCategory = '<c:out value="${param.boardCategory}" />'
		var cPage = 1;
		var numPerPage = 5;
		
		readBoardList(cPage++);
		
		$(searchMore).click(function(){
			readBoardList(cPage++);
		});

		$("#selectLocation").change(function(e){
			var locCode = e.target.value;
			readBoardList(cPage++, locCode);
		});
		
		function readBoardList(index, code){
			console.log(code);
			$.ajax({
				type: "GET",
				dataType : "json",
				data: {
					boardCategory : boardCategory,
					locCode : code,
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
							html += "<td colspan='4' style='margin: 0 auto;'>";	
								$.each(elem.boardImageList, function(index, img){
									html += "<img src='${pageContext.request.contextPath}/resources/upload/board/"+img.boardImgRenamed+"' class='img-thumbnail' style='width:200px; height:200px;' onclick='window.open(this.src)' />";
								});
							html += "</td>";
						html += "</tr>";
						html += "<tr><td colspan='5'>"+elem.boardContent+"</td></tr>";
						html += "<tr><td><input type='button' class='btn btn-danger' value='좋아요'/></td><td>"+elem.boardLike+"</td></tr>";
						html += "<tr><td colspan='5'>댓글창</td></tr>";
						html +="<tr>";
							html += "<td colspan='5'>";
								html += "<textarea id='boardCommentText' style='width:80%;'></textarea>";
								html += "<input type='button' class='btn btn-primary' value='댓글 등록' style='margin-top: -50px;'/>";
							html += "</td>";
						html += "</tr>";
				html += "</table>";
				
				$(boardList).append(html);
			});
		}
	});
	</script>
	<%-- >

			<tr>
				<td colspan="4">
					<textarea id="boardCommentText" style="width:80%;"></textarea>
					<input type="button" class="btn btn-primary" value="댓글 등록" style="margin-top: -50px;"/>
				</td>
			</tr>
		</table>
		<hr />
	</c:forEach> --%>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
