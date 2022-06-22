# :rabbit: 바니마켓 : 바로 니곁에 마켓
 지역적으로 물품거래, 소통이 가능한 중고거래 사이트<br>
![image](https://user-images.githubusercontent.com/80744051/175080170-d8b23e14-0869-4417-9259-2ee7cb6c3d97.png)
- 반응형 웹사이트(PC/Tablet/Mobile)
- 동네 설정 기반으로 해당 동네의 물품거래, 커뮤니티 노출

<!--
> **참고사이트**<br>
> <img src="https://user-images.githubusercontent.com/80744051/175088472-331830ce-93e4-45fa-ad46-77d5a751a980.png"  width="130px"/>[링크](https://www.daangn.com/)&nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/80744051/175094101-f2cb6435-a708-46c2-8d54-44bd879be00c.png"  width="130px"/>[링크](https://m.bunjang.co.kr/)<br>
-->

## :two_men_holding_hands:팀프로젝트
 - **개발기간** : 2021.11.03 - 2021.12.09 <br>
 - **개발인원** : 6명<br>
 - **역할분담**<br>
   - **박예진(본인)** : 동네거래, 리뷰, 채팅
   - 한희규 : 메인, 로그인, 회원가입, 동네인증, 동네행사, 반응형 작업
   - 조민경 : 동네소식, 마이페이지(내 정보, 모아보기)
   - 배유정 : 동네생활, 마이페이지(판매내역, 내 상점, 나의 후기)
   - 이호진 : 소개, 공지사항,리뷰
   - 정이담 : FnQ, 약관, 마이페이지(관심상품)
 - **협업과정**
   - Notion 활용
   - 코드 작성 가이드
   - 화면 디자인 가이드
   - 팀규칙 (지각벌금제도, 스스로 코드작성, 모르면 꼭 도움요청)
   - 매일 To-do-List 작성

## 기술스택
<img src="https://img.shields.io/badge/java-007396?style=flat-square&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat-square&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/html5-E34F26?style=flat-square&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=flat-square&logo=css3&logoColor=white">  <img src="https://img.shields.io/badge/bootstrap-7952B3?style=flat-square&logo=bootstrap&logoColor=white"> <img src="https://img.shields.io/badge/springboot-6DB33F?style=flat-square&logo=springboot&logoColor=white"> <img src="https://img.shields.io/badge/jquery-0769AD?style=flat-square&logo=jquery&logoColor=white"> <img src="https://img.shields.io/badge/mysql-4479A1?style=flat-square&logo=mysql&logoColor=white"> <img src="https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=Amazon%20AWS&logoColor=white"/> 

## 기획배경
**SID Audition 창업아이디어 경진대회** 참가 당시, '내주변 리포터'라는 이름으로 실시간 지역뉴스 SNS를 기획했다. <br>
광범위한 영역의 SNS가 아닌, **지역적 SNS**를 통해 보다 직접적 영향력을 유저에게 줄 수 있다는 생각에서 비롯된 기획이었다. <br>
당시에는 기획에만 그쳐야해서 아쉬웠던 기억이 있어, 직접 이를 발전시켜 개발해보고자 했다.
### 참고사이트
  기능으로는 지역적 SNS로 많이 활용되는 '[당근마켓](https://www.daangn.com/)'를 참고하였다. 하지만 당근마켓은 어플이기 때문에, <br>
  UI/UX는 '[번개장터](https://m.bunjang.co.kr/)'의 웹사이트를 참고해 기획했다.

## ERD   
<!--<img src="https://user-images.githubusercontent.com/80744051/175081886-3c061efd-d820-4639-881b-c4d6154fd2f8.png"  width="400px"/>-->
![ERD](https://user-images.githubusercontent.com/80744051/175081886-3c061efd-d820-4639-881b-c4d6154fd2f8.png)

## 기여부분
:point_right:[PPT 보러가기](https://drive.google.com/file/d/1JhJpskPHEFfbbZIzlTr5h56vigC3Osl_/view?usp=sharing)
![바니마켓_10](https://user-images.githubusercontent.com/80744051/175097030-ac6d242c-8d1c-400e-9c7a-c401f253560b.jpg)
![바니마켓_11](https://user-images.githubusercontent.com/80744051/175097072-2cf64512-db6c-4ae9-9c03-ea19a786a0c9.jpg)
![바니마켓_12](https://user-images.githubusercontent.com/80744051/175097158-f16a9c4a-4e30-408f-ae0b-b43b62d9ab70.jpg)
![바니마켓_13](https://user-images.githubusercontent.com/80744051/175097253-cd471440-f26b-46d7-9884-4ff5348181e4.jpg)
![바니마켓_14](https://user-images.githubusercontent.com/80744051/175097276-e642f178-8074-46ad-bd02-5eeb65ccf77a.jpg)
![바니마켓_15](https://user-images.githubusercontent.com/80744051/175097284-9a4eb9d2-1db3-41da-bab0-895e59df80e9.jpg)

## 주요 로직
> ### 동네거래
> - 상품목록 출력 시, 고려사항
    - 페이징에 따른 상품리스트 출력
    - 현재 지역에 해당하는 상품리스트 출력
    - 

  - 판매상태
    - 판매중/예약중/판매완료 로 판매상태 구분
    - 판매자의 VIEW
      -  판매상태를 변경 가능
    - 구매자의 VIEW


## 트러블슈팅
<details>
  <summary>반응형 웹 작업시, class 붙이기</summary>
  <div markdown="1">       
    {토글리스트의 content}
  </div>
  <div markdown="1">       
    {토글리스트의 content}
  </div>
</details>

- 반응형으로 
- 어플과 웹사이트의 UI/UX는 천지차이이다.

## 회고 / 느낀 점
- Class명, ID명 등 개발컨벤션 잘 지키기
- Class명을 달 때,
- CSS에 대해 매울

- 새롭게 추가 되는 기능에 의해 계속 전체 변경 작업 반복 (매우 시간 많이 잡아먹었음)

- 트러블 슈
