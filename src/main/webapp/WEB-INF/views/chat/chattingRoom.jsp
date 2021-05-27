<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chatting</title>
</head>
<body>
<script>
	
</script>
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
							  			<div id="message" style="width:480px; text-align:right;">
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
							
						<!-- 판매자의 경우 -->
							<c:choose>
								<c:when test="${flag eq 1}">
									<c:choose>
							  			<c:when test="${empty message.roomBuyerId}">
							  			<div id="message" style="width:480px; text-align:right;">
											<div style="display: inline-block;">
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
										<c:when test="${not empty message.roomBuyerId}">
										<div id="message" style="width:480px; text-align:left;">
											<div style="display: inline-block;">
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
						<input type="text" style="width:330px;"/>
					</td>
					<td>
						<input type="button" onclick="send_message" value="보내기"/>
					</td>
				</tr>
			</table>
		</div>
</body>
</html>