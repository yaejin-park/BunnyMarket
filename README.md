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
   - Notion, WorkBench, Sourcetree 활용
   - 코드 작성 가이드 , 화면 디자인 가이드 
   - 팀규칙 (지각벌금제도, 스스로 코드작성, 모르면 도움 요청하기)
   - 매일 To-do-List 작성, 깃 Push


## 🛠 기술스택
<img src="https://img.shields.io/badge/java-007396?style=flat-square&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat-square&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/html5-E34F26?style=flat-square&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=flat-square&logo=css3&logoColor=white">  <img src="https://img.shields.io/badge/bootstrap-7952B3?style=flat-square&logo=bootstrap&logoColor=white"> <img src="https://img.shields.io/badge/springboot-6DB33F?style=flat-square&logo=springboot&logoColor=white"> <img src="https://img.shields.io/badge/jquery-0769AD?style=flat-square&logo=jquery&logoColor=white"> <img src="https://img.shields.io/badge/mysql-4479A1?style=flat-square&logo=mysql&logoColor=white"> <img src="https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=Amazon%20AWS&logoColor=white"/> 

## 💡 기획배경
**SID Audition 창업아이디어 경진대회** 참가 당시, '내주변 리포터'라는 이름으로 실시간 지역뉴스 SNS를 기획했다. <br>
광범위한 영역의 SNS가 아닌, **지역적 SNS**를 통해 보다 직접적 영향력을 유저에게 줄 수 있다는 생각에서 비롯된 기획이었다. <br>
당시에는 기획에만 그쳐야해서 아쉬웠던 기억이 있어, 직접 이를 발전시켜 개발해보고자 했다.
### 참고사이트
  기능으로는 지역적 SNS로 많이 활용되는 '[당근마켓](https://www.daangn.com/)'를 참고하였다. 하지만 당근마켓은 어플이기 때문에, <br>
  UI/UX는 '[번개장터](https://m.bunjang.co.kr/)'의 웹사이트를 참고해 기획했다.

## 📚 ERD   
<!--<img src="https://user-images.githubusercontent.com/80744051/175081886-3c061efd-d820-4639-881b-c4d6154fd2f8.png"  width="400px"/>-->
![ERD](https://user-images.githubusercontent.com/80744051/175081886-3c061efd-d820-4639-881b-c4d6154fd2f8.png)

## :star2: 기여부분
:point_right:[전체 PPT](https://drive.google.com/file/d/1JhJpskPHEFfbbZIzlTr5h56vigC3Osl_/view?usp=sharing)
<details>
<summary><b>동네거래</b></summary>
 
  ![바니마켓_10](https://user-images.githubusercontent.com/80744051/175097030-ac6d242c-8d1c-400e-9c7a-c401f253560b.jpg)
  ![바니마켓_11](https://user-images.githubusercontent.com/80744051/175097072-2cf64512-db6c-4ae9-9c03-ea19a786a0c9.jpg)
  ![바니마켓_12](https://user-images.githubusercontent.com/80744051/175097158-f16a9c4a-4e30-408f-ae0b-b43b62d9ab70.jpg)
  ![바니마켓_14](https://user-images.githubusercontent.com/80744051/175097276-e642f178-8074-46ad-bd02-5eeb65ccf77a.jpg)
</details>
<details>
 <summary><b>리뷰</b></summary>
 
  ![바니마켓_13](https://user-images.githubusercontent.com/80744051/175097253-cd471440-f26b-46d7-9884-4ff5348181e4.jpg)
</details>
<details>
<summary><b>채팅</b></summary>
 
  ![바니마켓_15](https://user-images.githubusercontent.com/80744051/175097284-9a4eb9d2-1db3-41da-bab0-895e59df80e9.jpg)
</details>


## :triangular_ruler: 주요 로직
<details>
  <summary>채팅 대화 데이터는 어떻게 저장?</summary>
 
 - 고민1
     - 채팅 대화를 DB에 어떻게 저장하지?
     - DB에 채팅방 내역을 인덱스, 아이디
     - DB로 채팅대화 하나 하나를 다 저장하는 건 비효율적 why? 모든 채팅을 다 조회해서 조건에 맞는 채팅대화들을 채팅방으로 가져오는 것은 채팅양이 많아졌을 경우, 비효율적
 - 해결책1
     - 구글링을 하다가, 카카오톡 같은 경우도 서버에 어느 정도 저장을 하겠지만, 기본적으로 로컬(스마트폰 내부)에 저장한다는 정보를 찾음
     - 그렇다면 텍스트 파일 하나에 채팅방 하나의 데이터를 넣으면 되겠다고 생각
 - 고민2
     - 
  
 
</details>

<details>
  <summary>후기 작성</summary>
 
 - 1. 

  
 
</details>

<details>
  <summary>회원 탈퇴시, 데이터들은?</summary>
 
 - 1. 

  
 
</details>


## :unlock: 트러블슈팅
<details>
  <summary>너무 복잡한 테이블 JOIN</summary>

- 야심차게 테이블끼리 컬럼을 JOIN하고 연결시키겠다고 구조를 짰지만, idx, chat_idx, product_idx / seller_id, buyer_id, id 
 
</details>

<details>
  <summary>반응형으로 웹과 태블릿, 모바일 세마리토끼 잡기..</summary>
  
 - 웹이면서 줄어들면 모바일에 최적화 되게 만들어야 하다보니, 전체 UI/UX를 짜는 데 매우 어려움이 많았다.
 
</details>


## 🏸 회고
### 잘한 점
- 한땀 한땀 CSS 작업으로 CSS 마스터


- WebSocket, Thread를 전혀 모르는 채로 채팅 도전하여 실시간 채팅을 완성하다


- 동네 거래 상품의 세세한 기능들
    



### 아쉬웠던 점
- Class명을 규칙없이 뒤죽박죽으로 작명한 것
    - 그때 그때 클래스명을 지었는데, 조금 더 규칙에 맞게 


- 로그인, 회원가입 쪽이 빨리 진행되지 않아, 로그인 여부에 따른 기능을 만드는데 어려움 겪음
    - 유저와 작성자가 같을 때, 로그인을 했을 때 등에 따라 달라지는 화면 구현이 늦어짐
    - 전체 


- 새롭게 추가 되는 기능에 의해 계속 전체 변경 작업 반복
   - 지역설정 부분에서 계속 코드 수정 요청이 들어와서 모든 코드를 또 하나하나 수정해야하는 경우가 한 5번 정도 일어났다.
   - 

