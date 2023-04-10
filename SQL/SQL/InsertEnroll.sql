CREATE OR REPLACE PROCEDURE InsertEnroll
(sStudentId IN VARCHAR2, sCourseId IN VARCHAR2, nCourseIdNo IN NUMBER, result OUT VARCHAR )
IS
too_many_sumCourseUnit EXCEPTION;
too_many_courses EXCEPTION;
too_many_students EXCEPTION;
duplicate_time EXCEPTION;

nYear NUMBER;
day NUMBER;
nSemester NUMBER;
nCourse course%ROWTYPE;
nSumCourseUnit NUMBER;
nCnt NUMBER;
nTeachMax course_detail.c_time%TYPE;

BEGIN
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || 
', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수강 등록을 요청하였습니다.');

nYear:=Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);


SELECT SUM(c.c_unit) 
INTO nSumCourseUnit
FROM  course c, enroll e
WHERE  e.s_id = sStudentId and e.e_year = nYear and 
  e.e_semester = nSemester  and  e.c_id = c.c_id and e.c_id_no = c.c_id_no;

  SELECT c_unit
  INTO nCourse.c_unit
  FROM course
  WHERE c_id = sCourseId and c_id_no = nCourseIdNo;

  IF (nSumCourseUnit + nCourse.c_unit >9)
  THEN  
     RAISE too_many_sumCourseUnit;
  END IF;

SELECT COUNT(*)
  INTO    nCnt
  FROM   enroll
  WHERE  s_id = sStudentId and c_id = sCourseId and e_semester=nSemester
and e_year=nYear;

  IF (nCnt > 0) 
  THEN
     RAISE too_many_courses;
  END IF;

  IF (nCnt > 0) 
  THEN
     RAISE too_many_courses;
  END IF;



SELECT c_max
INTO nTeachMax
FROM course_detail
WHERE c_year=nYear and c_semester=nSemester
and c_id=sCourseId and c_id_no=nCourseIdNo;

SELECT COUNT(*)
INTO nCnt
From enroll 
WHERE e_year=nYear and e_semester=nSemester and 
c_id=sCourseId and c_id_no=nCourseIdNo;

IF (nCnt>=nTeachMax)
THEN  RAISE too_many_students;
END IF;



SELECT COUNT(*) 
  INTO nCnt
  FROM(SELECT c_time FROM course_detail
WHERE c_year=nYear and c_semester = nSemester and
c_id = sCourseId and c_id_no = nCourseIdNo
INTERSECT
SELECT c.c_time
FROM course_detail c, enroll e
WHERE e.s_id=sStudentId and e.e_year=nYear and e.e_semester = nSemester and
      c.c_year=nYear and c.c_semester = nSemester and
      e.c_id=c.c_id and e.c_id_no=c.c_id_no
);
  IF (nCnt > 0)
  THEN
     RAISE duplicate_time;
  END IF;

INSERT INTO enroll(S_ID,C_ID,C_ID_NO,E_YEAR,E_SEMESTER)
VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
COMMIT;
result := '수강신청 등록이 완료되었습니다.';


EXCEPTION
WHEN too_many_sumCourseUnit THEN    
   result := '최대학점을 초과하였습니다';
WHEN too_many_courses THEN
   result := '이미 등록된 과목을 신청하였습니다';
WHEN too_many_students THEN
   result := '수강신청 인원이 초과되어 등록이 불가능합니다';
WHEN duplicate_time THEN
   result := '이미 등록된 과목 중 중복되는 시간이 존재합니다';
WHEN OTHERS THEN
   ROLLBACK;
   result := SQLCODE;


END;
/

