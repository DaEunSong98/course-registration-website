CREATE OR REPLACE PROCEDURE Enroll_sum 
(v_id IN NVARCHAR2, v_year IN NVARCHAR2, v_seme IN NVARCHAR2, v_cnt OUT NUMBER, v_sum OUT NUMBER)
IS
CURSOR enroll_cur(v_id enroll.s_id%TYPE, v_year enroll.e_year%TYPE, v_seme enroll.e_semester%TYPE) IS
SELECT count(e.c_id), SUM(c.c_unit)
FROM enroll e, course c
WHERE e.s_id=v_id and e.c_id=c.c_id and e.e_year=v_year and e.e_semester=v_seme;

enroll_cnt NUMBER;
unit_sum NUMBER; 

BEGIN
OPEN enroll_cur(v_id, v_year, v_seme);
FETCH enroll_cur
INTO v_cnt, v_sum;
DBMS_OUTPUT.PUT_LINE('총 ' || v_cnt || ' 과목과 총 ' || v_sum || ' 학점을 신청하였습니다.');
CLOSE enroll_cur;

EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
END;
/

