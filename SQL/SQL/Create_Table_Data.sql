CREATE TABLE student(
s_id VARCHAR2(20) NOT NULL,
s_pwd VARCHAR2(20) NOT NULL,
s_name VARCHAR2(20) NOT NULL,
s_major VARCHAR2(30) NOT NULL,
s_phone VARCHAR2(50),
s_email VARCHAR(30),
PRIMARY KEY (s_id)
);

INSERT INTO STUDENT VALUES ('1700000', 'abcde', '김숙명', '법학부', '01012123434','abcde@naver.com');
INSERT INTO STUDENT VALUES ('1711982', 'aaaaa','김제경', '컴퓨터과학','01012345678','abcdedffs@naver.com');
INSERT INTO STUDENT VALUES ('1712569', 'bbbbb','윤다현', '소프트웨어융합','01098887536','abewsrfg@naver.com');
INSERT INTO STUDENT VALUES ('1713918', 'ccccc','송다은', '컴퓨터과학','01026063606','agjgiug@naver.com');
INSERT INTO STUDENT (s_id, s_pwd, s_name, s_major) VALUES ('1400000', 'zzzzz','눈송이', '통계학과');







CREATE TABLE course(
c_id VARCHAR2(20) NOT NULL,
c_id_no NUMBER(20),
c_name VARCHAR2(40) NOT NULL,
c_unit NUMBER NOT NULL,
PRIMARY KEY (c_id)
);

INSERT INTO course
VALUES('C800',3,'데이터베이스 프로그래밍',3);
INSERT INTO course
VALUES('C900',3,'객체지향윈도우즈프로그래밍',3);
INSERT INTO course
VALUES('M100',3,'멀티미디어개론',3);
INSERT INTO course
VALUES('M200',3,'선형대수',3);
INSERT INTO course
VALUES('M300',3,'그래픽 활용',3);
INSERT INTO course
VALUES('M400',3,'윈도우즈 프로그래밍',3);
INSERT INTO course
VALUES('M500',3,'컴퓨터 그래픽스',3);
INSERT INTO course
VALUES('M600',3,'멀티미디어 처리',3);
INSERT INTO course
VALUES('M700',3,'게임프로그래밍',3);





CREATE TABLE enroll(
s_id VARCHAR2(20),
c_id VARCHAR2(20), 
c_id_no VARCHAR2(20),
e_year VARCHAR2(20),
e_semester VARCHAR2(20),
FOREIGN KEY (s_id) REFERENCES student (s_id),
FOREIGN KEY (c_id) REFERENCES course (c_id),
PRIMARY KEY (s_id, c_id, e_year, e_semester)
);

INSERT INTO enroll VALUES('1712569', 'M500', '3', '2019', '2');
INSERT INTO enroll VALUES('1713918', 'M700', '3', '2019', '2');
INSERT INTO enroll VALUES('1711982', 'M400', '3', '2019', '2');
INSERT INTO enroll VALUES('1700000', 'M100', '3', '2019', '1');
INSERT INTO enroll VALUES('1700000', 'M400', '3', '2019', '2');
INSERT INTO enroll VALUES('1700000', 'C800', '3', '2019', '2');









CREATE TABLE course_detail(
c_id VARCHAR2(20) NOT NULL,
c_id_no NUMBER,
c_year VARCHAR2(20),
c_semester VARCHAR2(20),
c_time VARCHAR2(20),
c_place VARCHAR2(20),
c_max NUMBER,
FOREIGN KEY (c_id) REFERENCES course (c_id),
PRIMARY KEY (c_id, c_id_no, c_year, c_semester)
);


INSERT INTO  course_detail
VALUES('C800',3,2020,2,1,'명신관 201호',20);

INSERT INTO course_detail
VALUES('C900',3,2020,2,2,'새힘관 201호',0);

INSERT INTO course_detail
VALUES('M100',3,2020,2,2,'명신관 202호',20);

INSERT INTO course_detail
VALUES('M300',3,2020,2,2,'새힘관 202호',20);

INSERT INTO course_detail
VALUES('M400',3,2020,2,4,'명신관 203호',20);

INSERT INTO course_detail
VALUES('M500',3,2020,2,5,'새힘관 203호',20);

INSERT INTO course_detail
VALUES('M600',3,2020,2,6,'명신관 204호',20);

INSERT INTO course_detail
VALUES('M700',3,2020,2,7,'새힘관 204호',20);

INSERT INTO course_detail
VALUES('M200',3,2020,2,2,'명신관 205호',20);
