<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/history.jsp" />
  
<!--Custom CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mystore.css" type="text/css" />
<!--jquery-->
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
<!--icon-->
 <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script>
   console.log('test');
</script>

<section id="my-store-container" class="ms_container">
        <hr />
     <div class="container">
            <div class="row">
                <div class="col-lg-3" style="height: 220px; border: 2px solid #FA8440;">
                    <div><img id="profileImg" src='${pageContext.request.contextPath}/resources/upload/member/${profile}' style="width: 281px; height: 217px; margin-left: -12px;"></div>
                </div>
                <div class="col-lg-7" style="width: 590px;background-color: #faad4a; height: 220px;" border: 2px solid #faad4a;>
                    <ul class="amount">
                        <li>
                            <div style="font-size: 36px; font-weight: bold;">
                                ${shop.memberId}
                            </div>
                            <div style="border: 1px solid gold; float: left; width: 22%; font-weight: bold;">
                               <i class="fas fa-store" style="font-size:23px;"></i>상점오픈일
                            </div>
                            <div style="border: 1px solid red; float: left; width: 11%;">
<%--                                  ${shop.shopTotalScore}일 --%>
                                 ${openday}일
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
                    <div style="margin-top: 41px; margin-left: 28px; height: 72px; border: 1px solid;"}>
                     
                    	${shop.shopMemo}
                    </div>
                    
                     <div class="mystore-btn" style="margin-top: 10px;  margin-left: 9px; " >
                    <a href="${pageContext.request.contextPath }/shopmanage/shopManageBase.do" class="gomystore-button">내상점관리</a>
                    <a href="#" class="gomystore-button">신고하기</a>
                      </div>
                  
                    <script>
                       const tempParam = {
                             shopId: "${shop.shopId}",
                       }
                    </script>
                </div>
                <div id="sidebar" class="col-lg-2">
                  
                    
                    </div>
                </div>
               
            
               
            </div>
            <br>
            <div class="col-lg-9" style="margin-left: 55px;">
                <div class="main">
                    <div class="tabs" style="margin-left: 20px;">
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
                        <jsp:include page="myshopProductList.jsp"></jsp:include>
                    </div>
                    <div id="tab2" data-tab-content class="itemss">
                        <jsp:include page="myshopReviewList.jsp"></jsp:include>
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
        

    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>