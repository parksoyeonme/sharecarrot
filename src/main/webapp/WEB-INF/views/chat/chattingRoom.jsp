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
const ws = new SockJS("${pageContext.request.contextPath}/stomp");
const stompClient = Stomp.over(ws);
var table;
var row;
var html = "";
var div = "";

//2.connect핸들러 작성. 구독
stompClient.connect({}, (frame) => {
	console.log("stomp connected : ", frame);
	
// 	stompClient.subscribe("/chattinRoom.do?roomNo=${roomNo}", (message) => {
	stompClient.subscribe("/chattingRoom/${roomNo}", (message) => {
			
		const msgObj = JSON.parse(message.body);
		const {roomBuyerId, roomSellerId, messageText, roomNo, messageDate} = msgObj;

		if('${flag}' == 0){
			if(roomSellerId!=null){
// 				console.log("판매자한테 받았습니다.");
// 				console.log(message);
				table = document.getElementById('flag0_buyer_tbl');  //행을 추가할 테이블	
// 				console.log(table);
				
				if(table == null){
					div = document.getElementById('previous_message');					
					html += "<table id='#flag1_seller_tbl'>";
					html += "<tr>";
					html += "<td><textarea style='resize: none; border: none;'readonly >"+ messageText +"</textarea></td>";
					html += "</tr>";
					html += "</table>";
					
					div.append(html);	
				}else{
					html += "<tr>";
					html += "<td><textarea style='resize: none; border: none;'readonly >"+ messageText +"</textarea></td>";
					html += "</tr>";
					table.append(html);
				}
				
			}
		}else if('${flag}' == 1){
			if(roomBuyerId!=null){
// 				console.log("구매자한테 받았습니다.");
// 				console.log(message);
				table = document.getElementById('flag1_seller_tbl');  //행을 추가할 테이블	
// 				console.log(table);
				
				if(table == null){
					div = document.getElementById('previous_message');	
					html += "<table id='#flag1_seller_tbl'>";
					html += "<tr>";
					html += "<td><textarea style='resize: none; border: none;'readonly >"+ messageText +"</textarea></td>";
					html += "</tr>";
					html += "</table>";
					div.append(html);
				}else{
					html += "<tr>";
					html += "<td><textarea style='resize: none; border: none;'readonly >"+ messageText +"</textarea></td>";
					html += "</tr>";
					table.append(html);
				}
				
				
			}
		}
		
		

		
	});
});
 
//3.메세지 발행
function sendBtnClick(){	
	//보낼 메세지 테이블에 추가
	
	const $message = $("#message");
	const url = "/chat/chattingRoom/${roomNo}"; // $("#stomp-url option:selected")
	
	if($message.val() == '') return;

	sendMessage(url);
};

var html = "";
var $table;

function sendMessage(url){
	var flag = ${flag};
	var sender;
	var receiver;

	if(${flag}==0){
		sender = '${buyer_id}';
		receiver = null;
	}else if(${flag} == 1){
		sender = null;
		receiver = '${seller_id}';
	}
	
	const message = {
		roomBuyerId : sender,
		roomSellerId : receiver,
		messageText : $("#message").val(),
		roomNo : '${roomNo}',
		messageDate : Date.now()
	};
	
// 	console.log('보낼 때 : ' + '${flag}');
	
// 	if('${flag}' == 0){
		
// 		if(receiver==null){
// 			console.log("구매자한테 받았습니다.");
// 			console.log(message);
// 			$table = $('#flag0_buyer_tbl');  //행을 추가할 테이블 							
// 		}
// 		//buyer가 보낸 메세지가 오른쪽으로 가게 정렬
// 		else if(receiver!=null){
// 			console.log("판매자한테 받았습니다.");
// 			console.log(message);
// 			$table = $('#flag0_seller_tbl');  //행을 추가할 테이블	
// 		}
// 	}else if('${flag}' == 1){
		
// 		if(sender==null){
// 			console.log("구매자한테 받았습니다.");
// 			console.log(message);
// 			$table = $('#flag1_buyer_tbl');  //행을 추가할 테이블 							
// 		}
// 		//buyer가 보낸 메세지가 오른쪽으로 가게 정렬
// 		else if(sender!=null){
// 			console.log("판매자한테 받았습니다.");
// 			console.log(message);
// 			$table = $('#flag1_seller_tbl');  //행을 추가할 테이블	
// 		}
// 	}
	
// 	console.log($table);
// 	html += "<tr>";
// 	html += "<td><textarea style='resize: none; border: none;'readonly >$('#message').val()</textarea></td>";
// 	html += "</tr>";
// 	$table.append(html);	
	
	stompClient.send(url, {}, JSON.stringify(message));
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
			  			<div id="buyerMsg" style="width:480px; text-align:right;">
							<div style="display: inline-block; margin-right:10px;">
								<table id="flag0_buyer_tbl">	
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
								<table id="flag0_seller_tbl">	
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
			<!-- 판매자의 경우 -->
			<c:choose>
				<c:when test="${flag eq 1}">
					<c:choose>
			  			<c:when test="${empty message.roomBuyerId}">
			  			<div id=sellerMsg style="width:480px; text-align:right;">
							<div style="display: inline-block;">
								<table id="flag1_buyer_tbl">	
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
						<c:when test="${not empty message.roomBuyerId}">
						<div id="message" style="width:480px; text-align:left;">
							<div style="display: inline-block;">
								<table id="flag1_seller_tbl">	
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