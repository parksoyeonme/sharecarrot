<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/history.jsp" />
  
<!-- 구매자의 채팅 팝업. 동일한 chattingRoom.do를 사용하게 하였음. -->
<script>
function chatting_popup(roomBuyerId){
// 	var loginUser = <sec:authentication property="principal.memberId"/>;
// 	var shopId = ${product.shopId};
	var url = "${pageContext.request.contextPath}/chat/chattingRoom.do?roomBuyerId=" + roomBuyerId + "&shopId=${shopId}";
	console.log(url);
	var popupWidth = 500;
	var popupHeight = 400;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (popupHeight / 2) - 50;
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	window.open(url, "chat", "width=" + popupWidth + ", height=" + popupHeight + ", left="+popupX+", top=" + popupY).focus();
}

</script>

<style>

div#chatting-container{width:800px; margin:0 auto; text-align:center;}
div#update-container input, div#update-container select {margin-bottom:10px;}
</style>


<div id="chatting-container" class="mx-auto text-center" >

	<div style="margin-top:50px; margin-bottom:50px;">
		<h1>내 채팅 내역</h1>
		<hr />
	</div>

	<div style="text-align:center; display:inline-block;">
		<table style="width:300px;">
			<tr>
				<th>구매자</th>
				<th></th>
			</tr>
			<c:forEach items="${chattingRoomList}" var="message" varStatus="status">
				<tr style="height:40px;">
					<td>${message.roomBuyerId}</td>
					<td>
						<a onclick="chatting_popup('${message.roomBuyerId}');"><sub>
			               <svg style="color:green;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-plus-fill" viewBox="0 0 16 16">
			                 <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM12.5 1a.5.5 0 0 1 .5.5V3h1.5a.5.5 0 0 1 0 1H13v1.5a.5.5 0 0 1-1 0V4h-1.5a.5.5 0 0 1 0-1H12V1.5a.5.5 0 0 1 .5-.5z"/>
			               </svg> 채팅하기</sub>
			            </a>
		            </td>
				</tr>
			</c:forEach>
		</table>
	</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>