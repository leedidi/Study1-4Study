SELECT USER
FROM DUAL;
--==>> HR

--■■■ 팀별 실습 과제 ■■■--

-- HR 샘플 스키마 ERD 를 이용한 테이블 재구성~!!!

-- 팀별로... HR 스키마에 있는 기본 테이블 (7개)
-- COUNTRIES / DEPARTMENTS / EMPLOYEES / JOBS / JOB_HISTORY / LOCATIONS / REGIONS
-- 을 똑~~~같이 새로 구성한다.

-- 단, 생성하는 테이블의 이름은 『테이블명+팀번호』
-- ex) 1팀의 경우...
-- COUNTRIES01 / DEPARTMENTS01 / EMPLOYEES01 / JOBS01 / JOB_HISTORY01 / LOCATIONS01 / REGIONS01
-- ....
-- 과 같이 구성한다.

-- 1. 기존 테이블의 정보 수집
-- 2. 테이블 생성(컬럼 이름, 자료형, DEFAULT 표현식, NOT NULL 등 ....)
--    제약조건 설정(PK, UK, FK, CK, ... NN)
-- 3. 작성 후 데이터 입력
-- 4. 제출 항목
--    20210909_02_hr_팀별실습과제_3조.sql
--    후기_0조.txt
--@   팀별로 두개 제공... 후기에는 모든 팀원들의 후기가 들어 있어야 함

SELECT *
FROM JOB_HISTORY;

==



SELECT  *
FROM TAB;


SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('COUNTRIES', 'DEPARTMENTS', 'EMPLOYEES', 'JOBS', 'JOB_HISTORY', 'LOCATIONS', 'REGIONS');

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('JOB_HISTORY');


DESC COUNTRIES;
DESC DEPARTMENTS;
DESC EMPLOYEES;
DESC JOBS;
DESC JOB_HISTORY;
DESC LOCATIONS;
DESC REGIONS;


-- MODIFY 대신 ADD로 해서 따옴표 추가!!

-- JOB_HISTORY


이름, 널, 유형, 



컬럼명       널       데이터타입  제약이름      테이블명  KEY  컬럼이름    널 유무
REGION_ID   NOT NULL NUMBER      REGION_ID_NN   REGIONS	    C	REGION_ID	"REGION_ID" IS NOT NULL	
REGION_NAME          VARCHAR2(25)REG_ID_PK      REGIONS	    P	REGION_ID



--- JOB_HISTORY
컬럼명          널      데이터타입   제약이름               테이블명          KEY      컬럼이름        체크 조건
------------- -------- ------------  ---------             ----------      --------   ----------      -----------
EMPLOYEE_ID   NOT NULL NUMBER(6)    JHIST_EMP_FK            JOB_HISTORY      R          EMPLOYEE_ID      (null)
EMPLOYEE_ID   NOT NULL NUMBER(6)    JHIST_EMPLOYEE_NN       JOB_HISTORY      C          EMPLOYEE_ID      (null)
EMPLOYEE_ID   NOT NULL NUMBER(6)    JHIST_EMP_ID_ST_DATE_PK JOB_HISTORY      P         EMPLOYEE_ID       "EMPLOYEE_ID" IS NOT NULL

START_DATE    NOT NULL DATE         JHIST_EMP_ID_ST_DATE_PK JOB_HISTORY      P         START_DATE        (null)
START_DATE    NOT NULL DATE         JHIST_START_DATE_NN     JOB_HISTORY      C         START_DATE         "START_DATE" IS NOT NULL
START_DATE    NOT NULL DATE         JHIST_DATE_INTERVAL     JOB_HISTORY      C         START_DATE        end_date > start_date

END_DATE      NOT NULL DATE         JHIST_END_DATE_NN       JOB_HISTORY      C          END_DATE         "END_DATE" IS NOT NULL
END_DATE      NOT NULL DATE         JHIST_DATE_INTERVAL     JOB_HISTORY      C          END_DATE          end_date > start_date

JOB_ID        NOT NULL VARCHAR2(10) JHIST_JOB_NN            JOB_HISTORY      C          JOB_ID            "JOB_ID" IS NOT NULL
JOB_ID        NOT NULL VARCHAR2(10) JHIST_JOB_FK            JOB_HISTORY      R          JOB_ID             (null)

DEPARTMENT_ID          NUMBER(4)   JHIST_DEPT_FK            JOB_HISTORY      R       DEPARTMENT_ID       (null)


SELECT *
FROM JOB_HISTORY;


-- JOB_ID
-- 테이블 생성
CREATE TABLE TBL_TEST1
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)
);

--JOB_HISTORY
CREATE TABLE JOB_HISTORY
( EMPLOYEE_ID   NUMBER(6)    
, START_DATE    DATE
, END_DATE      DATE
, JOB_ID        VARCHAR2(10)
, DEPARTMENT_ID NUMBER(4)
);

ALTER TABLE JOB_HISTORY
ADD CONSTRAINT JHIST_EMP_ID_ST_DATE_PK PRIMARY KEY(EMPLOYEE_ID);

--COUNTR03_REG_FK
-- 1. 각자 기존 테이블 정보 수집하고
-- 2. 테이블 생성 구문 작성
-- 3. 각 테이블별로 INSERT 구문 작성

--일단 생성도, 실행도 하지는 말고! 작성만 하기 데이터 INSERT도..!
-- TEST13_COL1_XXXX
-- TEST1303_COL1_XXXX
-- C는 체크!