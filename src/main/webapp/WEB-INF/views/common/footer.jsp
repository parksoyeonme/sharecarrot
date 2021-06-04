<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />



</section>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">

<style>
a:link { color: black; text-decoration: none;}
a:visited { color: gray; text-decoration: none;}
a:hover { color: blue; text-decoration: underline;}

footer{
	background-color:#ffffff; 
	/* width: 1024px;  */
	margin:0 auto; 
	text-align:center; 
	background-clip:content-box; 
	height: 300px; 
}

table.footer-table{
	width: 500px;
	text-align:right;
}
table.footer-table td{
	width: 200px;
	padding-bottom: 40px;
}

.footer-maindiv{
	display: flex;
	height: 300px;
	/* width:1024px; */
	text-align:left;
	margin: 0 20px;
	justify-content: center;
}
.footer-mainsub1{
	width:500px;
	float:left;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
}
.footer-mainsub2{
	margin-top: 20px;
	width:500px;
	display:inline-block;
 	/* style:"clear:both" */
}
.footer-subdiv{
	text-align:center;
}
.footer-subdiv p {
	margin: 0 20px;
	font-weight: 500;
}
.footer-info, .footer-links,.footer-copyright{
	margin: 5px 0;
	color : gray;
	font-weight: 400;
} 
.footer-info p{
		margin: 5px 0;
}
.links-titles strong{
	font-size: 20px;
	border-bottom: 2px solid #f7863b;
}
.footer-links img:not(:nth-child(4)):hover{
	transform: scale(1.1);
	transition: 0.5s;
}
</style>
<footer id="footer">
	<hr />
	<div class="footer-maindiv">
		<div class="footer-mainsub1">
			<div class="footer-img-container">
				<img src="${pageContext.request.contextPath}/resources/images/mainlogo.png" style="max-height: 50px;">
			</div>
			<div class="footer-info">
				<p class="master-info">대표 FSS | 사업자등록번호 111-11-11111</p>
					<!-- <strong>find us on...</strong><br> -->
					<p class="address-info">주소 (06234) 서울 강남구 테헤란로14길 6 남도빌딩</p>
					<p class="contact-info">이메일 sharecarrot@fss.com | 연락처 010-1111-1111</p> 
				</div>
				<!-- 이미지버튼 삽입 -->
				<div class="footer-links">
				<img src="${pageContext.request.contextPath}/resources/images/instagram.jpg" onclick="location.href='https://www.instagram.com';" style="cursor: pointer; max-height: 45px;">
				<img src="${pageContext.request.contextPath}/resources/images/facebook.jpg" onclick="location.href='https://www.facebook.com';" style="cursor: pointer; max-height: 45px;">		
				<img src="${pageContext.request.contextPath}/resources/images/blog.png" onclick="location.href='http://blog.naver.com';" style="cursor: pointer; max-height: 45px;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<img src="${pageContext.request.contextPath}/resources/images/language.png" style="max-height: 45px;">
				<span>
					<a href="<c:url value="/?lang=ko" />">한국어</a>
					|
					<a href="<c:url value="/?lang=en" />">English</a>
				</span>
			</div>
	</div>
	<div class="footer-mainsub2">		
		<table class="table table-borderless footer-table">
			<tbody>
				<tr class="links-titles">
					<td class="links-title"><strong>ABOUT</strong></td>
					<td class="links-title"><strong>POLICY</strong></td>
				</tr>
				<tr>
					<td><strong><a href="#">회사소개</a></strong></td>
					<td><strong><a href="#">이용약관</a></strong></td>
				</tr>
				<tr>
					<td><strong><a href="#">광고주센터</a></strong></td>
					<td><strong><a href="#">개인정보처리방침</a></strong></td>
				</tr>
				<tr>
					<td><strong><a href="#">동네가게</a></strong></td>
					<td><strong><a href="#">위치기반서비스 이용약관</a></strong></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
	<!-- <hr/> -->
<div class="footer-subdiv">
	<div class="footer-copyright">
		<p>© 2021 Sharecarrot, Inc. All rights reserved</p>
	</div>
		</div>
	</footer>
</body>
</html>