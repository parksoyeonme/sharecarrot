<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.js" integrity="sha512-Kdp1G1My+u1wTb7ctOrJxdEhEPnrVxBjAg8PXSvzBpmVMfiT+x/8MNua6TH771Ueyr/iAOIMclPHvJYHDpAlfQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js" integrity="sha512-tL4PIUsPy+Rks1go4kQG8M8/ItpRMvKnbBjQm4d2DQnFwgcBYRRN00QdyQnWSCwNMsoY/MfJY8nHp2CzlNdtZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<script>

//1.웹소켓객체 -> stomp 객체 전달
const ws = new SockJS("${pageContext.request.contextPath}/chat");
const stompClient = Stomp.over(ws);

//2.connect핸들러 작성. 구독
stompClient.connect({}, (frame) => {
	console.log("stomp connected : ", frame);
	
// 	stompClient.subscribe("/sellerChattinRoom.do", (frame) => {
// 		console.log("message from /sellerChattinRoom.do : ", frame);
// 		const msgObj = JSON.parse(frame.body);
// 		console.log(msgObj);
// 		const {from, to, content, type, time} = msgObj;
// 		alert(content + "\n" + new Date(time));
// 	});
	
	stompClient.subscribe("/sellerChattinRoom.do?roomBuyerId=${buyer_id}&shopId=${shop_id}", (message) => {
		console.log("message from /sellerChattinRoom.do?roomBuyerId=${buyer_id}&shopId=${shop_id} : ", message);
	});
});
 
//3.메세지 발행
function sendBtnClick(){
	
// 	var $message = #('#message');
// 	console.log($message);
	
	var roomBuyerId = '${buyer_id}';
	var shopId = '${shop_id}';
	var message = 'test';
	var flag = 1;
	//db에 저장
// 	$.ajax({
        
//         type:"POST",
// //         url:"${pageContext.request.contextPath}/chat/chatEnroll.do?roomSellerId=${buyer_id}&shopId=${shop_id}&message=" + $message.val(),
//         url:"${pageContext.request.contextPath}/chat/chatEnroll.do",
//         data: {
// 			roomBuyerId : roomBuyerId,
// 			shopId : shopId,
// 			message: 'message',
// 			flag: flag
// 		},
// 		success:function(data){
//             console.log('채팅 메세지 db 등록 성공');
//         }                
//     });
	
	//보낼 메세지 테이블에 추가
	
	
	const $message = $("#message");
	const url = "/sellerChattinRoom.do?roomSellerId=${buyer_id}&shopId=${shop_id}"; // $("#stomp-url option:selected")
	
	if($message.val() == '') return;

	sendMessage(url);
};

function sendMessage(url){
// 	const msg = document.getElementByID("message").value();
// 	const message = {
// 		from : 'buyer',
// 		to : 'seller',
// 		content : msg,
// 		type : "chat",
// 		time : Date.now()
// 	};
	
// 	stompClient.send(url, {}, JSON.stringify(message));
// // 	stompClient.send(url, {}, $("#message").val());
// 	$("#message").val(''); // 초기화
	const message = {
		from : 'seller',
		to : 'buyer',
		content : $("#message").val(),
		type : "chat",
		time : Date.now()
	};
	
	stompClient.send(url, {}, JSON.stringify(message));
// 	stompClient.send(url, {}, $("#message").val());
	$("#message").val(''); // 초기화
}
</script>

<head>
<meta charset="UTF-8">
<title>Chatting</title>
</head>

<body>
	 <div style="text-align:center;">
	 	<h2>
	 		<!-- 구매자의 경우 -->
	 		<c:if test="${flag eq 0}">
	 			${seller_id}와의 채팅
	 		</c:if>
	 		<!-- 판매자의 경우 -->
	  	<c:if test="${flag eq 1}">
	 			${buyer_id}와의 채팅
	 		</c:if>
	 	</h2>
	 </div>
	 <div id="previous_message" style="height:270px; width:480px; overflow:scroll;">
	  <c:forEach items="${chattingMessageList}" var="message">
		<!-- 구매자의 경우 -->
			<c:choose>
				<c:when test="${flag eq 0}">
					<c:choose>
			  			<c:when test="${empty message.roomSellerId}">
			  			<div id="msg" style="width:480px; text-align:right;">
							<div style="display: inline-block; margin-right:10px;">
								<table>	
									<tr>
										<td>
											<fmt:formatDate value="${message.messageDate}" pattern="MM.dd HH:mm:ss" /> 
										</td>
										<td>
											<textarea style="resize: none; border: none;"readonly >${message.messageText}</textarea>	
										</td>
									</tr>
								</table>			
							</div>
						</div>
						</c:when>
						<c:when test="${not empty message.roomSellerId}">
						<div id="message" style="width:480px; text-align:left;">
							<div style="display: inline-block; margin-right:10px;">
								<table>	
									<tr>
										<td>
											<textarea style="resize: none; border: none;"readonly >${message.messageText}</textarea>	
										</td>
										<td>
											<fmt:formatDate value="${message.messageDate}" pattern="MM.dd HH:mm:ss" /> 
										</td>
									</tr>
								</table>
							</div>			
						</div>
						</c:when>
					</c:choose>
				</c:when>
			</c:choose>					
		</c:forEach>
	</div>
<div id="chatting_message" style="height:40px;">
	<table>
		<tr>
			<td>
				<span>메세지 : </span>&nbsp;
			</td>
			<td>
				<input type="text" id="message" name="message" class="form-control" style="width:330px;" placeholder="보낼 메세지를 입력하세요.">
			</td>
			<td>
				<input type="button" id="sendBtn" name="sendBtn" onclick="sendBtnClick();" value="보내기"/>
			</td>
		</tr>
	</table>
</div>
</body>


</html>