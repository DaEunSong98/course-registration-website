# course-registration-website

## 1. 개발 
- 학교 수강신청 시스템의 수강 신청 및 삭제, 조회 기능 구현
- 요구 분석을 통해 학생, 강의의 개체를 추출하고, 이들의 관계를 나타내는 E-R다이어그램 및 테이블을 설계
- Oracle DB에 데이터베이스 구축
- 쿼리 작성 및 JSP개발 및 연동

## 2. 역할 분담
- DB설계와 구현 담당 2명
- jsp페이지 구현 1명 및 페이지 간 연동

## 3. Er-diagram

- enroll ( s_id, c.id, e_semester,e_year, c_id_ no :분반 )  
- student ( S.id, S_pWd, S-name, S_major, S_Phone, S_email)  
- course (c_id, c_name, c_unit, c_id_no)  
- course.detail (c_id, c_max: 최대 인원, c_id_no :분반, c_Place :교실, c_time, c_ Semester, C_year)

## 4. 사용한 구현 기술
- PL/SQL, JDBC, 커서  
- 예외처리(트리거), 수강신청/취소(저장 프로시저), 현재 년도에 맞는 학기추출(사용자 정의함수) 
- MODEL1 아키텍처 사용

## 5. 구현 동작
![1](https://user-images.githubusercontent.com/85435343/231026812-09c6f33e-a8c2-4f2c-8ac0-3f940901ef84.PNG)  

![2](https://user-images.githubusercontent.com/85435343/231026816-e98eec7f-8903-493c-ae8e-7f4d175779b4.PNG)  

![3](https://user-images.githubusercontent.com/85435343/231026818-873ce732-6b20-4aef-9641-6c0b5bc0ef28.PNG)   

![4](https://user-images.githubusercontent.com/85435343/231026819-05ddb083-f545-4750-bb91-507d945a03fb.PNG)   
