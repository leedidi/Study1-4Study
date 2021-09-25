SELECT USER
FROM DUAL;
--==>> HR


--○ 세 개 이상의 테이블 조인(JOIN)

-- 형식1(SQL 1992 CODE)
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
  AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;

-- 형식2(SQL 1999 CODE)
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명1
               JOIN 테이블명3
               ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;

-- HR 계정 소유 테이블 또는 뷰 목록 조회
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

--○ HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS 테이블을 대상으로
--   직원들의 정보를 FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
--   항목을 조회한다.

--◈ 내가 작성한 코드
--1. 92 코드
--1.
SELECT *
FROM HR.JOBS;
--2.
SELECT *
FROM HR.EMPLOYEES;
--3.
SELECT *
FROM HR.DEPARTMENTS;

--1, 2 공통칼럼 : JOB_ID
--2, 3 공통칼럼 : DEPARTMENT_ID

SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
  AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
  
SELECT HR.EMPLOYEES.FIRST_NAME, HR.JOBS.JOB_TITLE, HR.DEPARTMENTS.DEPARTMENT_NAME
FROM  HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS
WHERE HR.JOBS.JOB_ID = HR.EMPLOYEES.JOB_ID
  AND HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID(+);

--2. 99 코드
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명1
               JOIN 테이블명3
               ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
               
SELECT HR.EMPLOYEES.FIRST_NAME, HR.JOBS.JOB_TITLE, HR.DEPARTMENTS.DEPARTMENT_NAME
FROM HR.EMPLOYEES JOIN HR.JOBS
                  ON HR.JOBS.JOB_ID = HR.EMPLOYEES.JOB_ID 
                  LEFT JOIN HR.DEPARTMENTS
                  ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID;
                  
-- (+), (LEFT JOIN) 써야 107건 나옴!

SELECT COUNT(*)
FROM EMPLOYEES;
--==>> 107

SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 106



-- EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS 테이블을 대상으로
-- 직원들의 정보를 다음과 같이 조회한다.
-- FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
-- (~12:28)

--◈ 내가 작성한 코드
-- 기반 테이블 조회
--1
SELECT *
FROM EMPLOYEES;

--2
SELECT *
FROM DEPARTMENTS;

--3
SELECT *
FROM JOBS;

--4
SELECT *
FROM LOCATIONS;

--5
SELECT *
FROM COUNTRIES;

--6
SELECT *
FROM REGIONS;

--
/*
1-2 : DEARTMENT_ID
1-3 : JOB_ID
1-4 : 겹치는게 없음.. 2-4: LOCATION_ID
1-5 : 겹치는거 없음.. 4-5: COUNTRY_ID
1-6 : 겹치는거 없음...5-7: REGION_ID
*/

-- EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS 테이블을 대상으로
-- 직원들의 정보를 다음과 같이 조회한다.
-- FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
-- (~12:28)
--1. 92코드 기반
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
  AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
  
SELECT *
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND E.MANAGER_ID = D.MANAGER_ID(+)
  AND E.JOB_ID = J.JOB_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
-- + 붙여야 107명 나옴!
  
--2. 99코드 기반
--@ 위와 비슷한 형식으로 하면 될 듯...