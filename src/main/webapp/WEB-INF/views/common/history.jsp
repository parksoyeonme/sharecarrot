<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
	.history-box{
    position: fixed;
    top: 102px;
    right: calc(50% - 500px);
    z-index: 20;
	}
    .history-box-container{
      width: 90px;
    }
    /* 공통부분 CSS 시작 */
    .jjim,
    .recent{
      padding: 10px;
      width: 100%;
      border: 1px solid rgb(204, 204, 204);
      background: rgb(255, 255, 255);
      margin-bottom: 6px;
    }
    .jjim{
      border-color: rgb(102, 102, 102);
    }
    .top{
      margin-bottom: 0px;
      padding: 0px;
      border-color: rgb(229, 229, 229);
    }
    
    .jjim-title,
    .recent-title{
      font-size: 12px;
      font-weight: 600;
      color: rgb(102, 102, 102);
      text-align: center;
      margin-bottom: 8px;
    }
    /* 공통부분 CSS 끝 */
    /*찜한 상품 CSS 시작*/
    .jjim-count-wrapper{
      display: flex;
      -webkit-box-pack: center;
      justify-content: center;
    }
    .jjim-count{
      display: flex;
      -webkit-box-align: center;
      align-items: center;
      font-size: 12px;
      color: rgb(204, 204, 204);
      font-weight: 600;
    }
    /*찜한 상품 CSS 끝*/
    /*최근 본 상품 CSS 시작*/
    .recent-dot{
      display: flex;
      -webkit-box-pack: center;
      justify-content: center;
      font-size: 12px;
      color: rgb(247, 0, 0);
      font-weight: 600;
      border-bottom: 2px dotted rgb(136, 136, 136);
    }

    .recent-content{
      height: 120px;
      display: flex;
      flex-direction: column;
      -webkit-box-align: center;
      align-items: center;
      -webkit-box-pack: center;
      justify-content: center;
      color: rgb(204, 204, 204);
      font-size: 12px;
      text-align: center;
    }
    /*최근 본 상품 CSS 끝*/
    /* TOP 버튼 CSS 시작 */
    .top-btn{
      display: flex;
      -webkit-box-align: center;
      align-items: center;
      -webkit-box-pack: center;
      justify-content: center;
      height: 40px;
      width: 100%;
      font-weight: 800;
      font-size: 14px;
      color: rgb(102, 102, 102);
      border: 1px solid rgb(204, 204, 204);
      background-color: transparent;
      outline: none;
    }
    /* TOP 버튼 CSS 끝 */
</style>

<sec:authorize access="isAuthenticated()">
<script>
var totalJjim;
(() => {
	$.ajax({
        type : "GET",
		url: "${pageContext.request.contextPath}/product/getTotalJjimNo.do",
        contentType : "application/json; charset:UTF-8",
	    success: function(data){
			console.log(data);
			
			$('#jjim_count').val(totalJjim);
		},
		error: (request, status, err) =>{
			 console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+err);
	       

		}
	});
	

});
</script>
</sec:authorize>

<div class="history-box">
    <div class="history-box-container">
      <!-- 찜 상품 목록 시작-->
        <div class="jjim">
          <div class="jjim-title">찜한상품</div>
          <div class="jjim-count-wrapper">
            <!-- 찜한 상품 생길 시 count ++, 색상 변경(red)-->
            <div class="jjim-count">
              <span>♥</span>
              <span id="jjim_count">0</span>
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
<script>
  const topBtn = document.querySelector(".top-btn");
  topBtn.addEventListener("click", e =>{
    e.preventDefault();
    window.scrollTo({top: 0, behavior:"smooth"});
  });
</script>