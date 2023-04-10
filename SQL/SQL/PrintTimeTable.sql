CREATE OR REPLACE PROCEDURE SelectTimeTable_print                                                
(sStudentId IN VARCHAR2, nYear IN VARCHAR2, nSemester IN VARCHAR2, p_cursor OUT SYS_REFCURSOR)
IS
cnt NUMBER;
BEGIN 
OPEN p_cursor FOR
select c.c_time, c.c_id,a.c_name,c.c_id_no, a.c_unit,c.c_place
from course a, course_detail c, enroll e
where e.e_year=nYear and e.s_id=sStudentId and e.e_semester=nSemester 
and c.c_id=a.c_id and a.c_id=e.c_id 
ORDER BY c.c_time;
END;
/
