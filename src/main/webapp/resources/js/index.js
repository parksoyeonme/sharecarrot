/*-------------------------------이미지 슬라이더 js--------------------------------------------- */

const slideContainer = document.querySelector('.container');
const slide = document.querySelector('.slides');
const nextBtn = document.getElementById('next-btn');
const prevBtn = document.getElementById('prev-btn');
const interval = 5000;  //배너 전환 시간 설정

let slides = document.querySelectorAll('.slide');
let index = 1;
let slideId;

const firstClone = slides[0].cloneNode(true);
const lastClone = slides[slides.length - 1].cloneNode(true);

firstClone.id = 'first-clone';
lastClone.id = 'last-clone';

slide.append(firstClone);
slide.prepend(lastClone);

const slideWidth = slides[index].clientWidth;

slide.style.transform = `translateX(${-slideWidth * index}px)`;

// console.log(slides);

const startSlide = () => {
  slideId = setInterval(() => {
    moveToNextSlide();
  }, interval);
};

const getSlides = () => document.querySelectorAll('.slide');

slide.addEventListener('transitionend', () => {
  slides = getSlides();
  if (slides[index].id === firstClone.id) {
    slide.style.transition = 'none';
    index = 1;
    slide.style.transform = `translateX(${-slideWidth * index}px)`;
  }

  if (slides[index].id === lastClone.id) {
    slide.style.transition = 'none';
    index = slides.length - 2;
    slide.style.transform = `translateX(${-slideWidth * index}px)`;
  }
});


const moveToNextSlide = () => {
  slides = getSlides();
  if (index >= slides.length - 1) return;
  index++;
  slide.style.transition = '.7s ease-out';
  slide.style.transform = `translateX(${-slideWidth * index}px)`;
};

const moveToPreviousSlide = () => {
  if (index <= 0) return;
  index--;
  slide.style.transition = '.7s ease-out';
  slide.style.transform = `translateX(${-slideWidth * index}px)`;
};

/* 배너 내 마우스 위치 시 clearInterval */
slideContainer.addEventListener('mouseenter', () => {
  clearInterval(slideId);
});

/* 배너 마우스 leave 후 함수 재실행 */
slideContainer.addEventListener('mouseleave', startSlide);
/* 버튼을 통한 배너 이동 */
nextBtn.addEventListener('click', moveToNextSlide);
prevBtn.addEventListener('click', moveToPreviousSlide);

startSlide();

/*---------------------------------이미지 슬라이더 js 끝--------------------------------------------- */



/*--------------------------------select 검색 js------------------------------------------ */



const changeOption = () => {
  const selectLocation = document.getElementById("select-location");
  const selectCategory = document.getElementById("select-category");

  let chosenLocation = selectLocation.options[selectLocation.selectedIndex].value;
  let chosenCategory = selectCategory.options[selectCategory.selectedIndex].value;

  console.log(`지역코드 : ${chosenLocation}, 카테고리: ${chosenCategory}`);

  // $.ajax({
  //   type: "POST",
  //   dataType : "json",
  //   data: {
  //     locCode : chosenLocation,
  //     Category : chosenCategory,
  //   },
  //   url: "${pageContext.request.contextPath}/search/mainProductList.do?${_csrf.parameterName}=${_csrf.token}",
  //   success: (data) =>{
  //     console.log(data);
  //   }
  //   ,
  //   error:(request,status,error) =>{
  //           console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  //   }
  // });

}
//   const option ={
//     method: "POST",
//     headers: {
//       'Content-Type': 'application/json'  
//     },
//     body : JSON.stringify({
//       locCode: chosenLocation,
//       category : chosenCategory
//     })
//   }

//   fetch("/sharecarrot/search/mainProductList.do", option)
//   .then(res =>{
//     console.log(res);
//     res.json();
//   })
//   .then(data =>{
//     console.log(JSON.stringify(data));
//   })
// }




/*--------------------------------select 검색 js 끝------------------------------------------ */




/*--------------------------------더보기 버튼 js------------------------------------------ */

// const moreBtn = document.querySelector(".btn-more");

// moreBtn.addEventListener("click", ()=>{
//   // alert("HI, 에이치아이")
//   const div = document.createElement('div');
//   div.textContent = "차차차";
//   const item = document.querySelector(".item");
//   item.append(div);
// });

/*--------------------------------더보기 버튼 js 끝------------------------------------------ */