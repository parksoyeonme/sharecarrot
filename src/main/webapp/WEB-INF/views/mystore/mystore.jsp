<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!--Custom CSS-->
    <link rel="stylesheet" href="./resources/css/style.css" type="text/css">
     <!-- bootstrap css -->
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
     <!--jquery-->
     <script src="http://code.jquery.com/jquery-latest.min.js"></script> 

</head>

<body>
    <header>
        <ul class="nav nav-pills nav-fill" id="header-nav">
            <li class="nav-item" style="padding-top: 7px;">
                <img src="${pageContext.request.contextPath}/resources/images/mainlogo.png" style="max-height: 50px;">
            </li>
            <li class="nav-item">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="지역 혹은 물품을 검색해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
                </div>
            </li>
            <li class="nav-item">
                <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                    <button type="button" class="btn btn-primary">로그인</button>
                    <button type="button" class="btn btn-primary">회원가입</button>
                    <button type="button" class="btn btn-primary">판매하기</button>
                    <button type="button" class="btn btn-primary">내상점</button>
                    <div class="btn-group" role="group">
                      <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        카테고리
                      </button>
                      <ul class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                        <li><a class="dropdown-item" href="#">상품카테고리</a></li>
                        <li><a class="dropdown-item" href="#">동네생활게시판</a></li>
                        <li><a class="dropdown-item" href="#">신고게시판</a></li>
                        <li><a class="dropdown-item" href="#">공지사항</a></li>
                        <li><a class="dropdown-item" href="#">계정설정</a></li>
                      </ul>
                    </div>
                  </div>
            </li>
          </ul>
        </header>
        <hr>
    <div class="container">
        <div class="row">
            <div class="col-md-3" style="background-color: red; height: 220px;">
             <div>프로필넣을것</div>
            </div>
            
            <div class="col-md-7" style="background-color: orange;">
                <ul class="amount">
                    <li>
                         <div style="font-size: 20px; font-weight: bold;">
                            아이디
                         </div>
                        <div style="border: 1px solid gold; float: left; width: 33%;">
                        상점오픈일
                        </div>
                        <div style="border: 1px solid red; float: left; width: 33%;">
                        상점방문수
                        </div>
                        <div style="border: 1px solid blue; float: left; width: 33%;">
                        상품판매
                        </div>
                    </li>
               </ul>
            </div>
            <a href="#" class="mystore-button">sharecarrot</a>
          </div>
          <br>
          
          <hr>
          <div class="col-md-10">
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
          <div class="content">
            <div id="tab1" data-tab-content class="items active">
              <h2>상품</h2>
              <p>상품들어갈꺼</p>
            </div>
            <div id="tab2" data-tab-content class="items">
              <h2>상점후기</h2>
              <p>상점후기들어간거</p>
            </div>
            
          </div>
        </div>
          <hr>
          
         <footer>
           푸터 자리
         </footer>
       
    </div>


</body>
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
</html>