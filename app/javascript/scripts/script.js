// // const swiper = new Swiper('.swiper', {
// //   // Optional parameters
// //   loop: true,
// //   grabCursor: true,
// //   spaceBetween: 30,

// import Swiper from "swiper"
//   // document.addEventListener('DOMContentLoaded', () => {
//     const swiper = new Swiper('.swiper-slider', {
//       loop: true,
//       grabCursor: true,
//       spaceBetween: 30,

//   // If we need pagination
//   pagination: {
//     el: '.swiper-pagination',
//     clickable: true,
//     dynamicBullets: true,
//   },

//   // Navigation arrows
//   navigation: {
//     nextEl: '.swiper-button-next',
//     prevEl: '.swiper-button-prev',
//   },

//   // Responsive breakpoints
//   breakpoints: {
//     0: {
//       slidesPerView: 1
//     },
//     620: {
//       slidesPerView: 1
//     },
//     1024: {
//       slidesPerView: 1
//     },
//   }
// });
// // });


import Swiper from "swiper";

document.addEventListener('DOMContentLoaded', () => {
  const swiper = new Swiper('.swiper', {
    loop: true,
    grabCursor: true,
    spaceBetween: 30,
    slidesPerView: 3,
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
      dynamicBullets: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    breakpoints: {
      0: { slidesPerView: 1 },
      620: { slidesPerView: 2 },
      1024: { slidesPerView: 4 },
    }
  });
});
