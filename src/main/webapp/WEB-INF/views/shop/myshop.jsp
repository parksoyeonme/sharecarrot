<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

  
<!--Custom CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mystore.css" type="text/css" />
<!--jquery-->
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
<!--icon-->
 <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script>
$(document).ready(function() {
    $.ajax({
           url:"${pageContext.request.contextPath}/shop/myshop.do",
           type: "GET",
			dataType : "json",
			data: {
				prolist : prolist
			},
			success: function(data){
				console.log(data);
				displayList(data);
			},
			error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
		});
           }
    });

</script>

<section id="my-store-container" class="ms_container">
        <hr />
     <div class="container">
            <div class="row">
                <div class="col-lg-3" style="background-color: red; height: 220px;">
                    <div>프로필넣을것</div>
                </div>
                <div class="col-lg-7" style="background-color: #faad4a; height: 220px;">
                    <ul class="amount">
                        <li>
                            <div style="font-size: 36px; font-weight: bold;">
                                ${shop.memberId}
                            </div>
                            <div style="border: 1px solid gold; float: left; width: 22%; color: #ffffff; font-weight: bold;">
                               <i class="fas fa-store" style="font-size:23px;"></i>상점오픈일
                            </div>
                            <div style="border: 1px solid red; float: left; width: 11%;">
                                 ${shop.shopTotalScore}일
                            </div>
                            <div style="border: 1px solid blue; float: left; width: 22%; color: #223465; font-weight: bold;">
                                <i class="fas fa-users" style="font-size:23px;"></i>상점방문수
                            </div>
                            <div style="border: 1px solid red; float: left; width: 11%;">
                                ${shop.shopVisitCount}명
                            </div>
                            <div style="border: 1px solid red; float: left; width: 21%; color: #223465; font-weight: bold;">
                              <i class="fas fa-shopping-cart" style="font-size: 23px;color: skyblue;"></i>상품판매
                            </div>
                            <div style="border: 1px solid red; float: left; width: 13%;">
                                ${shop.shopSellCount}개
                            </div>
                        </li>
                    </ul>
                    <div style="margin-top: 41px; margin-left: 28px; height: 113px; border: 1px solid;"}>
                    	${shop.shopMemo}
                    </div>
                </div>
                <div id="sidebar" class="col-lg-2">
                    <div id="sticky">
                    <div class="history-box">
					    <div class="history-box-container">
					      <!-- 찜 상품 목록 시작-->
					        <div class="jjim">
					          <div class="jjim-title">찜한상품</div>
					          <div class="jjim-count-wrapper">
					            <!-- 찜한 상품 생길 시 count ++, 색상 변경(red)-->
					            <div class="jjim-count">
					              <span>♥</span>
					              <span>0</span>
					            </div>
					          </div>
					        </div>
					      <!--  찜 상품 목록 끝 -->
					      <!-- 최근 본 상품 목록 시작 -->
					        <div class="recent">
					          <div class="recent-title">최근 본 상품</div>
					          <div class="recent-dot"></div>
					          <!-- 최근 본 상품 == null -->
					          <div class="recent-content">최근 본<br/> 상품이 <br/>없습니다</div>
					          <!-- 최근 본 상품 != null => 3개까지 출력. 저장은 DB? Session? -->
					        </div>
					      <!-- 최근 본 상품 목록 끝 -->
					      <!-- TOP 버튼 시작-->
					        <div class="top">
					          <!-- 버튼 클릭 시 화면 최상단으로 이동 : scrollTo() -->
					          <button class="top-btn">TOP</button>
					        </div>
					      <!-- TOP 버튼 끝 -->
					    </div>
					    <!-- 1024px 이하일 경우..... 어떡하지... -->
					</div>
                    
                    
                    
                    
                    </div>
                </div>
                <div class="mystore-btn" style="margin-top: 10px;" >
                    <a href="#" class="gomystore-button">내상점관리</a>
                </div>
            </div>
            <br>
            <div class="col-lg-10">
                <div class="main">
                    <div class="tabs">
                        <div class="tab" data-tab-target="#tab1">
                            <p>상품</p>
                        </div>
                        <div class="tab" data-tab-target="#tab2">
                            <p>상점후기</p>
                        </div>
                    </div>
                </div>
                <div class="content-mystorepro">
                    <div id="tab1" data-tab-content class="itemss active">
                        <div class="div-division">
                            <div class="left">
                                전체
                            </div>
                            <div class="right">
                                00개
                            </div>
                        </div>
                        <div>
                            <div class="wrap-pro">
                                <div class="box box1 boxC"></div>
                                <div class="pro-title"></div>
                                <div class="pro-price"></div>
                            </div>
                            <div class="wrap-pro">
                                <div class="box box1 boxC">사진</div>
                                <div class="pro-title">제목</div>
                                <div class="pro-price">가격</div>
                            </div>
                            <div class="wrap-pro">
                                <div class="box box1 boxC">사진</div>
                                <div class="pro-title">제목</div>
                                <div class="pro-price">가격</div>
                            </div>
                            <div class="wrap-pro">
                                <div class="box box1 boxC">사진</div>
                                <div class="pro-title">제목</div>
                                <div class="pro-price">가격</div>
                            </div>
                            <div class="wrap-pro">
                                <div class="box box1 boxC">사진</div>
                                <div class="pro-title">제목</div>
                                <div class="pro-price">가격</div>
                            </div>
                        </div>
                        <div>빈자리?</div>
                    </div>
                    <div id="tab2" data-tab-content class="itemss">
                        <div class="div-division2">
                            <div class="left2">
                                상점후기
                            </div>
                            <div class="right2">
                                00개
                            </div>
                        </div>
                        <div class="see-review">
                            <div style="float: left; margin-left: 5px;">
                                <table class="review-table">
                                    <thead>
                                        <tr>
                                            <th class="rt-tbl" colspan="2" rowspan="2">프로필</th>
                                            <th class="rt-tbl" colspan="2">아이디</th>
                                        </tr>
                                        <tr>
                                            <td class="rt-tbl" colspan="2">별점</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="rt-tbl" colspan="4">상품제목</td>
                                        </tr>
                                        <tr>
                                            <td class="rt-tbl" colspan="4" rowspan="2">사진들</td>
                                        </tr>
                                        <tr></tr>
                                        <tr>
                                            <td class="rt-tbl" colspan="4">댓글내용</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="float: left; margin-left: 61px;">
                                <table class="review-table">
                                    <thead>
                                        <tr>
                                            <th class="rt-tbl" colspan="2" rowspan="2">프로필</th>
                                            <th class="rt-tbl" colspan="2">아이디</th>
                                        </tr>
                                        <tr>
                                            <td class="rt-tbl" colspan="2">별점</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="rt-tbl" colspan="4">상품제목</td>
                                        </tr>
                                        <tr>
                                            <td class="rt-tbl" colspan="4" rowspan="2">사진들</td>
                                        </tr>
                                        <tr></tr>
                                        <tr>
                                            <td class="rt-tbl" colspan="4">댓글내용</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           
         
       
    </div>
    </section>
<script>
        const tabs = document.querySelectorAll("[data-tab-target]");
        const tabcon = document.querySelectorAll("[data-tab-content]");
        tabs.forEach((tab) => {
            tab.addEventListener("click", () => {
                const target = document.querySelector(tab.dataset.tabTarget);
                tabcon.forEach((tabc_all) => {
                    tabc_all.classList.remove("active");
                });
                target.classList.add("active");
            });
        });
        
        //stick box
        $(function () { // document ready
            if ($('#sticky').length) { // make sure "#sticky" element exists
                var el = $('#sticky');
                var stickyTop = $('#sticky').offset().top; // returns number
                var stickyHeight = $('#sticky').height();
                $(window).scroll(function () { // scroll event
                    var limit = $('#footer').offset().top - stickyHeight - 20;
                    var windowTop = $(window).scrollTop(); // returns number
                    if (stickyTop < windowTop) {
                        el.css({position: 'fixed', top: 0});
                    } else {
                        el.css('position', 'static');
                    }
                    if (limit < windowTop) {
                        var diff = limit - windowTop;
                        el.css({top: diff});
                    }
                });
            }
        });
        
        //찜한상품,최근 본 상품 top
        const topBtn = document.querySelector(".top-btn");
        topBtn.addEventListener("click", e =>{
          e.preventDefault();
          window.scrollTo({top: 0, behavior:"smooth"});
        });
    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
