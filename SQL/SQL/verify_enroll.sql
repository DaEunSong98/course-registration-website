CREATE OR REPLACE PROCEDURE SelectTimeTable 
(sStudentId IN VARCHAR2, nYear IN NUMBER, nSemester IN NUMBER)
IS

vTIME VARCHAR2(30);
vCID VARCHAR2(30);
vCNAME VARCHAR2(30);
vCIDNO VARCHAR2(30);
vUNIT NUMBER;
vPLACE VARCHAR2(30);
v_out1 NUMBER;
v_out2 NUMBER;

CURSOR cur_timeTable
IS
SELECT cd.c_time, c.c_id, c.c_name, cd.c_id_no, c.c_unit, cd.c_place
FROM course c, course_detail cd, enroll e
WHERE e.e_year=nYear and e.s_id=sStudentId and e.e_semester=nSemester 
and cd.c_id=c.c_id and cd.c_id=e.c_id
ORDER BY cd.c_time;

BEGIN
OPEN cur_TimeTable;
DBMS_OUTPUT.PUT_LINE(nYear || '년도' || nSemester || '학기의' || sStudentId || '님의 수강신청 시간표입니다.');
LOOP
FETCH cur_timeTable
INTO vTIME, vCID, vCNAME, vCIDNO, vUNIT, vPLACE; 
EXIT WHEN cur_timeTable%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('교시: ' || vTIME || ', 과목번호: ' || vCID || ', 과목명: ' || 
vCNAME || ', 분반: ' || vCIDNO || ', 학점: ' || vUNIT || ', 장소: ' || vPLACE);
END LOOP;
CLOSE cur_timeTable;

Enroll_sum(sStudentId, nYear, nSemester, v_out1, v_out2);

EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
END;
/