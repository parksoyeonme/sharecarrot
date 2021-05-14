<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  
<!--Custom CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mystore.css" type="text/css" />
<!-- bootstrap css -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous" />
<!--jquery-->

<script src="http://code.jquery.com/jquery-latest.min.js"></script> 

<section id="my-store-container" class="ms_container">
        <hr />
     <div class="container">
            <div class="row">
                <div class="col-lg-3" style="background-color: red; height: 220px;">
                    <div>프로필넣을것</div>
                </div>
                <div class="col-lg-7" style="background-color: orange; height: 220px;">
                    <ul class="amount">
                        <li>
                            <div style="font-size: 20px; font-weight: bold; padding-top: 12px;">
                                아이디
                            </div>
                            <div style="border: 1px solid gold; float: left; width: 20%;">
                                상점오픈일
                            </div>
                            <div style="border: 1px solid red; float: left; width: 13%;">
                                값
                            </div>
                            <div style="border: 1px solid blue; float: left; width: 20%;">
                                상품판매
                            </div>
                            <div style="border: 1px solid red; float: left; width: 13%;">
                                값
                            </div>
                            <div style="border: 1px solid red; float: left; width: 20%;">
                                상점방문수
                            </div>
                            <div style="border: 1px solid red; float: left; width: 13%;">
                                값
                            </div>
                        </li>
                    </ul>
                </div>
                <div id="sidebar" class="col-lg-2">
                    <div id="sticky">Sticky Div</div>
                </div>
                <div class="mystore-btn" style="margin-top: 2px;">
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
            <hr/>
         
       
    </div>

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
$(function () {
    if ($('#sticky').length) { //"#sticky" 확인
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

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
