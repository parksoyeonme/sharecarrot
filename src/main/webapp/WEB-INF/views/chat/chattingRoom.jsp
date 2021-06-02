<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html>

<style>
div.rightmsg {
	width:560px; text-align:right;
}
div.submsg {
	display: inline-block; margin-right:10px;
}
div.leftmsg {
	width:560px; text-align:left;
}
div#previous_message{
	background-color: rgb(178, 199, 217);
}
div#title{
	background-color: rgb(169, 189, 206);
}
td.rightmsg{
		box-sizing: border-box;
		background-color: rgb(255, 235, 51);
		border-radius: 5px;
		padding-right: 5px;
		padding-left : 5px;
}
td.leftmsg{
		box-sizing: border-box;
		background-color: white;
		border-radius: 5px;
		padding-right: 5px;
		padding-left : 5px;
}
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.js" integrity="sha512-Kdp1G1My+u1wTb7ctOrJxdEhEPnrVxBjAg8PXSvzBpmVMfiT+x/8MNua6TH771Ueyr/iAOIMclPHvJYHDpAlfQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js" integrity="sha512-tL4PIUsPy+Rks1go4kQG8M8/ItpRMvKnbBjQm4d2DQnFwgcBYRRN00QdyQnWSCwNMsoY/MfJY8nHp2CzlNdtZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" />	

<script>

//1.웹소켓객체 -> stomp 객체 전달
const ws = new SockJS("${pageContext.request.contextPath}/stomp");
const stompClient = Stomp.over(ws);
var html = "";
var $div = "";

//2.connect핸들러 작성. 구독
stompClient.connect({}, (frame) => {
	console.log("stomp connected : ", frame);
	
	
// 	stompClient.subscribe("/chattinRoom.do?roomNo=${roomNo}", (message) => {
	stompClient.subscribe("/chattingRoom/${roomNo}", (message) => {
			
		const msgObj = JSON.parse(message.body);
		const {roomBuyerId, roomSellerId, messageText, roomNo, messageDate} = msgObj;
		var time = new Date(messageDate);
		var hour = time.getHours();
		var minute = time.getMinutes();
		var second = time.getSeconds();
				
		var realtime = (time.getMonth()+1) + "." + (time.getDay()-1) + " " 
		+ (("0" + hour).slice(-2)) + ":" + (("0" + minute).slice(-2)) + ":" + (("0"+second).slice(-2));
// 		console.log(realtime);
		$div = "";
		html = "";
		console.log(messageDate);
		if('${flag}' == 0){
			if(roomSellerId!=null){
// 				div = document.getElementById('previous_message');					
				$div = $('#previous_message');					
				html += "<div class='leftmsg'>";
				html += "<div class='submsg'>";
				html += "<table id='#flag0_buyer_tbl'>";
				html += "<tr>";
				html += "<td style='width:5px;'></td>";
				html += "<td class='leftmsg' style='width:150px;'><p>"+ messageText +"</p></td>";
				html += "<td>" + realtime + "</td>";
				html += "</tr>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				
				$div.append(html);	
				$div.scrollTop($div[0].scrollHeight);

			}
		}else if('${flag}' == 1){
			if(roomBuyerId!=null){
// 				console.log("구매자한테 받았습니다.");
// 				console.log(message);
// 				console.log(table);
				
				$div = $('#previous_message');
				html += "<div class='leftmsg'>";
				html += "<div class='submsg'>";
				html += "<table id='#flag1_seller_tbl'>";
				html += "<tr>";
				html += "<td style='width:5px;'></td>";
				html += "<td class='rightmsg' style='width:150px;'><p>"+ messageText +"</p></td>";
				html += "<td>" + realtime + "</td>";
				html += "</tr>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				$div.scrollTop($('#scrollDiv').prop('scrollHeight'));

				$div.append(html);
				$div.scrollTop($div[0].scrollHeight);
			}
		}
		
		

		
	});
});
 
//3.메세지 발행
function sendBtnClick(){	
	//보낼 메세지 테이블에 추가
	
	
	if($("#message").val().length > 100){
		alert('글자수는 100자를 넘을 수 없습니다.');
		//글자수 제한의 경우 썼던 글자 지우고 싶으면 아래 주석 풀기
// 		$("#message").val(''); 
		return;
	}
	const $message = $("#message");
	const url = "/chat/chattingRoom/${roomNo}"; // $("#stomp-url option:selected")
	
	if($message.val() == '') return;

	sendMessage(url);
};

var $dv = "";
var inputHtml = "";


function sendMessage(url){
	

	var flag = ${flag};
	var sender;
	var receiver;
	$dv = "";
	inputHtml = "";
	
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

	var time = new Date(Date.now());
	var realtime = (time.getMonth()+1) + "." + (time.getDay()-1) + " " 
	+ (("0" + time.getHours()).slice(-2)) + ":" + (("0" + time.getMinutes()).slice(-2)) + ":" + (("0" + time.getSeconds()).slice(-2));	
	
	if('${flag}' == 0){
		
		if(receiver==null){
			$dv = $('#previous_message');	
			inputHtml += "<div class='rightmsg'>";
			inputHtml += "<div class='submsg'>";
			inputHtml += "<table id='#flag0_buyer_tbl'>";
			inputHtml += "<tr>";
			inputHtml += "<td>" + realtime + "</td>";
			inputHtml += "<td class='rightmsg' style='width:150px;'><p>"+ $("#message").val() +"</p></td>";
			inputHtml += "</tr>";
			inputHtml += "</table>";
			inputHtml += "</div>";
			inputHtml += "</div>";
			$dv.append(inputHtml);
			$dv.scrollTop($dv[0].scrollHeight);
		}
	}else if('${flag}' == 1){
		if(sender==null){
//			console.log(table);		
			$dv = $('#previous_message');
			inputHtml += "<div class='rightmsg'>";
			inputHtml += "<div class='submsg'>";
			inputHtml += "<table id='#flag1_seller_tbl'>";
			inputHtml += "<tr>";
			inputHtml += "<td>" + realtime + "</td>";
			inputHtml += "<td class='rightmsg' style='width:150px;'><p>"+ $("#message").val() +"</p></td>";
			inputHtml += "</tr>";
			inputHtml += "</table>";
			inputHtml += "</div>";
			inputHtml += "</div>";
			$dv.append(inputHtml);	
			$dv.scrollTop($dv[0].scrollHeight);
		}
		
	}
	
// 	console.log($table);
// 	html += "<tr>";
// 	html += "<td><textarea style='resize: none; border: none;'readonly >$('#message').val()</textarea></td>";
// 	html += "</tr>";
// 	$table.append(html);	
	
	stompClient.send(url, {}, JSON.stringify(message));
	$("#message").val(''); // 초기화
	$("#message").focus();
}

$(document).ready(function(){
	// 엔터로도 채팅 보낼 수 있게 처리
	$("#message").keydown(function (key) {
		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
			sendBtnClick();
		}
	});
});

</script>

<head>
<meta charset="UTF-8">
<title>Chatting</title>
</head>

<body>
<div id="total">
	<div id="title" style="text-align:center;">
	 	
	 		<!-- 구매자의 경우 -->
	 		<c:if test="${flag eq 0}">
	 			<h2>${seller_id}와의 채팅</h2>
			 	<table style="width:471px;">
			 		<tr>
			 			<td style="text-align:left; padding-left : 10px;"> 상대 : ${seller_id} </td>
			 			<td style="text-align:right; padding-right: 30px;"> 나 : ${buyer_id}  </td>
			 		</tr>
			 	</table>
	 		</c:if>
	 		<!-- 판매자의 경우 -->
	  	<c:if test="${flag eq 1}">
	 			<h2>${buyer_id}와의 채팅</h2>
			 	<table style="width:471px;">
			 		<tr>
			 			<td style="text-align:left; padding-left : 10px;"> 상대 : ${buyer_id} </td>
			 			<td style="text-align:right; padding-right: 30px;"> 나 : ${seller_id}  </td>
			 		</tr>
			 	</table>
	 		</c:if>
	 	

	 </div>
	 <div id="previous_message" style="height:270px; width:580px; overflow:auto;">
	  <!-- 공간 이격용 -->
	  <p></p>
<!-- 	  <input type='button' style='height:1px; margin-top:0px; visibility:hidden'/> -->
	  <c:forEach items="${chattingMessageList}" var="message">
		<!-- 구매자의 경우 -->
			<c:choose>
				<c:when test="${flag eq 0}">
					<c:choose>
			  			<c:when test="${empty message.roomSellerId}">
			  			<div class="rightmsg">
							<div class="submsg">
								<table id="flag0_buyer_tbl">	
									<tr>
										<td>
											<fmt:formatDate value="${message.messageDate}" pattern="M.d HH:mm:ss" /> 
										</td>
										<td class='rightmsg' style='width:150px;'>
											<p>${message.messageText}</p>	
										</td>
									</tr>
								</table>			
							</div>
						</div>
						</c:when>
						<c:when test="${not empty message.roomSellerId}">
						<div class="leftmsg">
							<div class="submsg">
								<table id="flag0_seller_tbl">	
									<tr>
										<td style="width:5px;"></td>
										<td class='leftmsg' style='width:150px;'>
											<p>${message.messageText}</p>	
										</td>
										<td>
											<fmt:formatDate value="${message.messageDate}" pattern="M.d HH:mm:ss" /> 
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
			  			<div class="rightmsg">
							<div class="submsg">
								<table id="flag1_buyer_tbl">	
									<tr>
										<td>
											<fmt:formatDate value="${message.messageDate}" pattern="M.d HH:mm:ss" /> 
										</td>
										<td class='rightmsg' style='width:150px;'>
											<p>${message.messageText}</p>	
										</td>
									</tr>
								</table>			
							</div>
						</div>
						</c:when>
						<c:when test="${not empty message.roomBuyerId}">
						<div class="leftmsg">
							<div class="submsg">
								<table id="flag1_seller_tbl">	
									<tr>
										<td style="width:5px;"></td>
										<td class='leftmsg' style='width:150px;'>
											<p>${message.messageText}</p>	
										</td>
										<td>
											<fmt:formatDate value="${message.messageDate}" pattern="M.d HH:mm:ss" /> 
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
</div>
<div id="send_message" style="width:580px; height:40px; margin-top:10px;">
	<table>
		<tr>
			<td>
				<span>메세지 : </span>&nbsp;
			</td>
			<td>
				<input type="text" id="message" name="message" class="form-control" style="width:400px;" placeholder="보낼 메세지를 입력하세요.">
			</td>
			<td>
				<input type="button" id="sendBtn" name="sendBtn" onclick="sendBtnClick();" value="보내기"/>
			</td>
		</tr>
	</table>
</div>
</body>


</html>