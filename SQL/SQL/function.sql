CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
RETURN NUMBER
IS
n_year NUMBER;
BEGIN 
select extract(year from dDate)
INTO n_year
from dual;
RETURN n_year;
END;
/


CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
n_semester NUMBER;
n_Month NUMBER;
BEGIN 
select extract(month from dDate)
INTO n_Month
from dual;
if(n_Month>=1 and n_Month<=4) THEN
n_semester:=1;
elsif(n_Month>=5 and n_Month<=10) THEN
n_semester:=2;
else  n_semester:=1;
END IF;
RETURN n_semester;
END;
/



