
select STORE_NAME from STORE_Lab2 natural join REGION_Lab2 where REGION_DESCRIPT = 'East';

select STORE_NAME from STORE_Lab2 natural join REGION_Lab2 where REGION_DESCRIPT = 'West';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where STORE_NAME = 'Access Junction';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where STORE_NAME = 'Database Corner';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where STORE_NAME = 'Tuple Charge';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where STORE_NAME = 'Attribute Alley';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where STORE_NAME = 'Primary Key Point';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where REGION_DESCRIPT = 'EAST';

select EMP_LNAME from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where REGION_DESCRIPT = 'West';

select EMP_LNAME, EMP_DOB from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where REGION_DESCRIPT = 'East' and EMP_DOB < '1978-01-01';

select EMP_LNAME, EMP_DOB from EMPLOYEE_Lab2 left outer join STORE_Lab2 on EMPLOYEE_Lab2.STORE_CODE = STORE_Lab2.STORE_CODE natural join REGION_Lab2 where REGION_DESCRIPT = 'West' and EMP_DOB > '1973-01-01';



