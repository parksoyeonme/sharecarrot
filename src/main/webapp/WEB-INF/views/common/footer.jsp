<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	</section>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
	
	<style>
		 a:link { color: black; text-decoration: none;}
		 a:visited { color: gray; text-decoration: none;}
		 a:hover { color: blue; text-decoration: underline;}
		 
		 
		 footer{
				 background-color:#f8f9fa; 
				 width: 1024px; 
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
		 }
		 .footer-maindiv{
		  	width:1024px;
		 	text-align:left;
		 }
		 .footer-mainsub1{
 		  	width:500px;
		 	float:left;
		 }
		 .footer-mainsub2{
 		  	width:500px;
		 	display:inline-block;
		 	style="clear:both"
		 }
		 .footer-subdiv{
		 	text-align:left;
		 }
	</style>
	<footer>
		<hr />
		<div class="footer-maindiv">
			<div class="footer-mainsub1">
 	           <img src="${pageContext.request.contextPath}/resources/images/mainlogo.png" style="max-height: 50px;">
			</div>
			<div class="footer-mainsub2">		
				<table class="table table-borderless footer-table">
					<tbody>
						<tr>
							<td><strong><a href="${pageContext.request.contextPath}/etc/corpInfo.do">회사소개</a></strong></td>
							<td><strong><a href="${pageContext.request.contextPath}/etc/terms">이용약관</a></strong></td>
						</tr>
						<tr>
							<td><strong><a href="#">광고주센터</a></strong></td>
							<td><strong><a href="${pageContext.request.contextPath}/etc/privacypolicy">개인정보처리방침</a></strong></td>
						</tr>
						<tr>
							<td><strong><a href="#">동네가게</a></strong></td>
							<td><strong><a href="#">위치기반서비스 이용약관</a></strong></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
			<hr/>
		<div class="footer-subdiv">
			<p>© 2021 Costay, Inc. All rights reserved | 대표 FSS | 사업자등록번호 111-11-11111 
				<strong>find us on...</strong><br>
			주소 (06234) 서울 강남구 테헤란로14길 6 남도빌딩 | 이메일 costay@fss.com | 연락처 010-1111-1111</p> 
			<!-- 이미지버튼 삽입 -->
            <img src="${pageContext.request.contextPath}/resources/images/instagram.jpg" style="max-height: 45px;">
            <img src="${pageContext.request.contextPath}/resources/images/facebook.jpg" style="max-height: 45px;">		
            <img src="${pageContext.request.contextPath}/resources/images/blog.png" style="max-height: 45px;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <img src="${pageContext.request.contextPath}/resources/images/language.png" style="max-height: 45px;">
            <span><a>한국</a></span>
		</div>
	</footer>
</body>
</html>