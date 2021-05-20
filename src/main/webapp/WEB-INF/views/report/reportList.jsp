<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
<jsp:param value="신고게시판" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
 .searchlist{
 	margin-left: 1000px;
 }
</style>
<script>
$(() => {
	$("tr[data-no]").click(e => {
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		
		location.href = `${pageContext.request.contextPath}/report/reportDetail.do?no=\${no}`;
	});
	
    $( "#searchTitle" ).autocomplete({
      source: function(request, response){
    	  //서버통신 이후 success메소드에서 response를 호출할 것!
    	  //console.log(request); // 사용자 입력값
    	  //console.log(response); // response([{label:?, value:?}, {label:?, value:?},....])
    	  
    	  //ajax호출
    	  $.ajax({
    		  url: `${pageContext.request.contextPath}/report/searchTitle.do`,
    		  data: {
    			  searchTitle: request.term
    		  },
    		  //method: "GET",
    		  //dataType: "json"
    		  success(data){
    			  //console.log(data);
    			  var res = $.map(data, (board) => ({
    				  label: board.title,
    				  value: board.title,
    				  no: board.no
    			  }));
    			  //console.log(res);
    			  response(res);
    		  },
    		  error(xhr, status, err){
    			  console.log(xhr, status, err);
    		  }
    		  
    	  })
    	  
      },
      focus: function(){ return false },
      select: function(e, selected){
    	  //console.log(e);
    	  //console.log(selected.item.no);
    	  const no = selected.item.no;
    	  location.href = `${pageContext.request.contextPath}/report/reportDetail.do?no=\${no}`;
      }
    });
});
</script>
<section id="board-container" class="container">
	<h1>신고 합니다</h1>
	<div class="searchlist">
	<select id="clikesearch" required>
	  <option value="select">검색</option>
	  <option value="date">날짜</option>
	</select>
	<input type="text" placeholder="검색.." id="searchTitle" />
	<input type="button" value="검색" id="searchButton" />
	</div>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>신고자</th>
			<th>피신고자</th>
			<th>신고일</th>
			<th>처리 결과</th> 
			<th>처리 날짜</th>
		</tr>
		<c:forEach items="${reportList}" var="report">
		<tr data-no="${report.reportNo}">
			<td>${report.reportNo}</td>
			<td>${report.reportTitle}</td>
			<td>${report.memberId}</td>
			<td>${report.shopId}</td>
			<td><fmt:formatDate value="${report.reportDate}" pattern="yy/MM/dd"/></td>
			<td>${report.reportProcessYn}</td>
			<td><fmt:formatDate value="${report.reportProcessingDate}" pattern="yy/MM/dd"/></td>
			
		</tr>
		</c:forEach>
		
	</table>
	${pageBar}
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
