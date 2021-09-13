SELECT USER
FROM DUAL;
--==>> HR

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.
--○ EMPLOYEES 테이블에서 SALARY 를
--  각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--  Finace → 10%
--  Executive → 15%
--  Accounting → 20%
--  (쿼리문 구성 및 결과 확인 후 ROLLBACK)

-- 나머지 → 0%(생략된 구문)

SELECT *
FROM DEPARTMENTS;
--◈내가 작성한 코드
/*
--SET
SELECT Finace의 SALARY*1.10, Executive의 SALARY*1.15, Accounting의 샐러리*1.20
FROM EMPLOYEES
WHERE 각 부서 이름이 Finace, Executive, Accounting;

SELECT Finace의 SALARY*1.10, Executive의 SALARY*1.15, Accounting의 샐러리*1.20
FROM EMPLOYEES
WHERE 각 부서 이름이 Finace, Executive, Accounting;

SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;
-- EMPLOYEES와 DEAPRTMENT 겹치는 컬럼 : DEPARTMENT_ID

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME IN ('Finace', 'Executive', 'Accounting'); );


SELECT (DEPARTMENT_ID * 1.1
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME IN ('Finace', 'Executive', 'Accounting') )
FROM EMPLOYEES; 

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE='Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE='Sales Manager')
      AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006; --@ 조건이니까 AND/OR 사용!

--Finace의 SALARY*1.10, Executive의 SALARY*1.15, Accounting의 샐러리*1.20
UPDATE EMPLOYEES
SET SALARY =  (SELECT SALARY * 1.1
              FROM DEPARTMENTS
              WHERE JOB_TITLE='Sales Manager'
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME IN ('Finace', 'Executive', 'Accounting');
*/


SELECT *
FROM EMPLOYEES;
SELECT *
FROM DEPARTMENTS;


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finace'의 부서아이디)
                                THEN SALARY * 1.1
                                WHEN ('Executive'의 부서아이디)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'의 부서아이디)
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END
WHERE DEPARTMENT_ID IN ('Finace'의 부서아이디, 'Exceutive'의 부서아이디, 'Accounting'의 부서아이디)


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finace'의 부서아이디)
                                THEN SALARY * 1.1
                                WHEN ('Executive'의 부서아이디)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'의 부서아이디)
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END;
--@ WHERE 조건절이 없어도 이미 SET절에서 조건 들어감! 둘다 같은 구문.. 대신
--@ WHER 부터 메모리에 퍼올리기 때문에 위 구문이 메모리 좀더 아낄수는 있음


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finace'의 부서아이디)
                                THEN SALARY * 1.1
                                WHEN ('Executive'의 부서아이디)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'의 부서아이디)
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END;

-- ('Finace'의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME='Finance'; --@ 대소문자 엄격히 구별 주의!
--==>> 100

-- ('Executive'의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME='Executive';
--==>> 90

-- ('Accounting'의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME='Accounting';
--==>> 110



UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END
WHERE DEPARTMENT_ID IN ((SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='Finance')
                        , (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='Executive')
                        , (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='Accounting'));
--==>> 11개 행 이(가) 업데이트되었습니다.
--@ 서브쿼리로 실행되는 절이 먼저 업데이트 되어야 하기 때문에 괄호로 한번더 묶어줌!

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (90, 100, 110);
--==>> 
/*
Steven	King	SKING	515.123.4567	2003-06-17	AD_PRES	27600			90
101	Neena	Kochhar	NKOCHHAR	515.123.4568	2005-09-21	AD_VP	19550		100	90
102	Lex	De Haan	LDEHAAN	515.123.4569	2001-01-13	AD_VP	19550		100	90
108	Nancy	Greenberg	NGREENBE	515.124.4569	2002-08-17	FI_MGR	13208.8		101	100
109	Daniel	Faviet	DFAVIET	515.124.4169	2002-08-16	FI_ACCOUNT	9900		108	100
110	John	Chen	JCHEN	515.124.4269	2005-09-28	FI_ACCOUNT	9020		108	100
111	Ismael	Sciarra	ISCIARRA	515.124.4369	2005-09-30	FI_ACCOUNT	8470		108	100
112	Jose Manuel	Urman	JMURMAN	515.124.4469	2006-03-07	FI_ACCOUNT	8580		108	100
113	Luis	Popp	LPOPP	515.124.4567	2007-12-07	FI_ACCOUNT	7590		108	100
205	Shelley	Higgins	SHIGGINS	515.123.8080	2002-06-07	AC_MGR	14409.6		101	110
206	William	Gietz	WGIETZ	515.123.8181	2002-06-07	AC_ACCOUNT	9960		205	110
*/

ROLLBACK;
--==>> 롤백 완료.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END;
--==>> 107개 행 이(가) 업데이트되었습니다.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (90, 100, 110);
--==>>
/*
100	Steven	King	SKING	515.123.4567	2003-06-17	AD_PRES	27600			90
101	Neena	Kochhar	NKOCHHAR	515.123.4568	2005-09-21	AD_VP	19550		100	90
102	Lex	De Haan	LDEHAAN	515.123.4569	2001-01-13	AD_VP	19550		100	90
108	Nancy	Greenberg	NGREENBE	515.124.4569	2002-08-17	FI_MGR	13208.8		101	100
109	Daniel	Faviet	DFAVIET	515.124.4169	2002-08-16	FI_ACCOUNT	9900		108	100
110	John	Chen	JCHEN	515.124.4269	2005-09-28	FI_ACCOUNT	9020		108	100
111	Ismael	Sciarra	ISCIARRA	515.124.4369	2005-09-30	FI_ACCOUNT	8470		108	100
112	Jose Manuel	Urman	JMURMAN	515.124.4469	2006-03-07	FI_ACCOUNT	8580		108	100
113	Luis	Popp	LPOPP	515.124.4567	2007-12-07	FI_ACCOUNT	7590		108	100
205	Shelley	Higgins	SHIGGINS	515.123.8080	2002-06-07	AC_MGR	14409.6		101	110
206	William	Gietz	WGIETZ	515.123.8181	2002-06-07	AC_ACCOUNT	9960		205	110
*/

SELECT *
FROM EMPLOYEES;


ROLLBACK;
--==>> 롤백 완료.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN('Finance', 'Executive', 'Accounting'));
                        --@ CASE WHEN THEN ELSE... 는 이렇게 줄일 수 없지만 WHERE절은 이렇게 줄일 수 있음
--==>> 11개 행 이(가) 업데이트되었습니다.


ROLLBACK;
--==>> 롤백 완료.


--■■■ DELETE ■■■--

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문.

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

--@ 주의할 점 두가지!
--@ 1. DELETE에는 FROM절 있어도 없어도 되지만... 우리는 쓰기로 함! SELECT 먼저 쓰고 확인하고 지울 거기 때문
--@ 2. WHERE절 없어도 되지만... 일단 조건 쓰고 별도로 조건절 안 필요하면 그때 지우기로 함

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 직원들의 정보를 삭제한다.
--   단, 부서명이 'IT'인 경우로 한정한다.

--※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상)
--   다른 테이블(혹은 자기 자신 테이블)에 의해 참조당하는 경우
--   삭제되지 않을 수 있다는 사실을 염두해야 하며...
--   그에 대한 이유도 알아야 한다.

/*
--◈ 내가 작성한 코드
SELECT *
FROM EMPLOYEES
WHERE 부서명이 IT;

--DEPARTMENT_ID...
SELECT *
FROM EMPLOYEES
WHERE 부서 아이디가 IT의 부서아이디(DEPARTMENT_ID);

SELECT *
FROM DEPARTMENTS;

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');

--==>>
--103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03	IT_PROG	9000		102	60
--104	Bruce	Ernst	BERNST	590.423.4568	2007-05-21	IT_PROG	6000		103	60
--105	David	Austin	DAUSTIN	590.423.4569	2005-06-25	IT_PROG	4800		103	60
--106	Valli	Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
--107	Diana	Lorentz	DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
--명령의 309 행에서 시작하는 중 오류 발생 -
--DELETE
--FROM EMPLOYEES
--WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
--                       FROM DEPARTMENTS
--                       WHERE DEPARTMENT_NAME = 'IT')
--오류 보고 -
--ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT' 의 부서번호);


--('IT' 의 부서번호)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*  
103	Alexander	Hunold	    AHUNOLD	    590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	    Ernst	    BERNST	    590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	    Austin	    DAUSTIN	    590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	    Lorentz	    DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


--■■■ 뷰(VIEW) ■■■--

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들을
--    정화하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

--    가상의 테이블이란 뷰가 실제로 존재하는 테이블(객체)이 아닐
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이며
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다는 것이다.
--@   실제로 테이블이 만들어지는게 아니라, 뷰 실행시 쿼리문이 저장되어서 뷰 실행시 쿼리문이 다시 실행되는 것!

-- 2. 형식 및 구조
-- CREATE [OR REPLCAE] VIEW 뷰이름
-- [(ALIAS[, ALIAS, ...])] --@ 별칭
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPRION]
-- [WITH READ ONLY];

-- ○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.

--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;

--○ 뷰(VIEW) 구조 확인
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25)
*/

--@※ 유용한 팁!
-- ○ 뷰(VIEW) 소스 확인                  -- CHECK~!!!
SELECT VIEW_NAME, TEXT                    -- TEXT
FROM USER_VIEWS                           -- USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>> 
/*
VIEW_EMPLOYEES	"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
*/
--@ 뷰를 만들었던 구문이 그대로 보여짐! 뷰를 실행시 어떤 쿼리가 돌아가느냐 확인해보고 싶다면 뷰소스는 이 코드 사용!


--@ SQL 파트 끝!










