SELECT USER
FROM DUAL;
--==>>HR

--@ 프로그램 실행 시, 끝난 창은 무조건 다 꺼놓는 습관 들이기!
--@ 오라클도, 웹브라우저도...
--@ 나중에 이런 습관 안들이면, 이쪽 회사에 반영해야할걸 저쪽 회사 거에 반영하고 그렇게 될수 있음!
--@ 창 여러개 띄워놓고, 웹브라우저 창 여러개 띄워놓고.. 하지 말기.
--@ 현재 사용 창만 띄워두기!

--@ 시간 날 때마다 몇 번씩 읽어보기! 이게 이거구나.. 이 단어가 이 단어와 같은 말이구나 읽어보기(동의어의 개념 이해되게)
/*
--※ 참고

1. 관계(relationship, relation)
   - 모든 엔트리(entry)는 단일값을 가진다.
   - 각 열(column)은 유일한 이름을 가지며, 순서는 무의미하다.
   - 테이블의 모든 행(row = 튜플 = tuple)은 동일하지 않으며 순서는 무의미하다.

2. 속성(attribute) --@ ㅣ(세로)
   - 테이블의 열(column)을 나타낸다.
   - 자료의 이름을 가진 최소 논리적 단위 : 객체의 성질, 상태 기술
   - 일반 파일(file)의 항목(아이템 = item = 필드 = field)에 해당한다.
   - 엔티티(entity)의 특성과 상태를 기술
   - 속성(attribute)의 이름은 모두 달라야 한다.
   
3. 튜플(tuple = 엔티티 = entity) --@ ㅡ (가로)
   - 테이블의 행(row)
   - 연관된 몇 개의 속성으로 구성
   - 개념 정보 단위
   - 일반 파일(file)의 레코드(record)에 해당한다.
   - 튜플 변수(tuple variable)
     : 튜플(tuple)을 가리키는 변수, 모든 튜플 집합을 도메인으로 하는 변수
     
4. 도메인(domain)
   - 각 속성(attribute)이 가질 수 있도록 허용된 값들의 집합
   - 속성 명과 도메인 명이 반드시 동일할 필요는 없음
   - 모든 릴레이션에서 모든 속성들의 도메인은 원자적(atomic)이어야 함.
   - 원자적 도메인
     : 도메인의 원소가 더 이상 나누어질 수 없는 단일체일 때를 나타냄.
     
5. 릴레이션(relation)
   - 파일 시스템에서 파일과 같은 개념
   - 중복된 튜플(tuple = entity = 엔티티)을 포함하지 않는다.
      → 모두 상이함(튜플의 유일성)
   - 릴레이션 = 튜플(엔티티 = entity)의 집합. 따라서 튜플의 순서는 무의미하다.
   - 속성(attribute) 간에는 순서가 없다.
*/

--------------------------------------------------------------------------------

--■■■ 무결성(Integrity) ■■■--
/*
1. 무결성에는 개체 무결성(Entity Integrity)
              참조 무결성(Relation Integrity)
              도메인 무결성(Domain Integrity) 이 있다.

2. 개체 무결성
   개체 무결성은 릴레이션에서 저장되는 튜플(tupe)의
   유일성을 보장하기 위한 제약조건이다.
   
3. 참조 무결성
   참조 무결성은 릴레이션 간의 데이터 일관성을
   보장하기 위한 제약조건이다.  
   
4. 도메인 무결성 --@ 일단 데이터 타입이라고 생각하기!
   도메인 무결성은 허용 가능한 값의 범위를
   지정하기 위한 제약조건이다.
   
5. 제약조건의 종류

   - PRIMARY KEY(PK:P) → 부모 테이블의 참조받는 컬럼 → 기본키, 식별자
     해당 컬럼의 값은 반드시 존재해야 하며, 유일해야 한다.
     (UNIQUE 와 NOT NULL 이 결합된 형태) --@ 고유한 값, NOT NULL
     
   - FOREIGN KEY(FK:F:R) → 자식 테이블의 참조하는 컬럼 → 외부키, 외래키, 참조키
     해당 컬럼의 값은 참조되는 테이블의 컬럼 데이터들 중 하나와 
     일치하거나 NULL 을 가진다.
     
   - UNIQUE(UK:U)
     테이블 내에서 해당 컬럼의 값은 항상 유일해야 한다.
     
   - NOT NULL(NN:CK:C)
     해당 컬럼은 NULL 을 포함할 수 없다. --@ 값이 비면 안 된다.
     
   - CHECK(CK:C)
     해당 컬럼에서 저장 가능한 데이터의 값의 범위나 조건을 지정한다.
      
*/
--@ 기계의 수명 깎아먹는거 1. 열, 2. 먼지. 컴퓨터 안 쓸때는 꺼두는게 좋음, 그리고 본체에 먼지 청소해야 함!
--@ 먼지가 습기 흡수해서, 전력 돌 때 고장 발생 가능... 습도높은 장마철 되기 전에 피씨 청소해두는게 좋음!

--------------------------------------------------------------------------------

--■■■ PRIMARY KEY ■■■--

-- 1. 테이블에 대한 기본 키를 생성한다.

-- 2. 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합이다.
--    기본 키는 테이블 당 최대 하나만 존재한다.
--    그러나 반드시 하나의 컬럼으로만 구성되는 것은 아니다.
--    NULL일 수 없고, 이미 테이블에 존재하고 있는 데이터를
--    다시 입력할 수 있도록 처리된다.
--    UNIQUE INDEX 가 자동으로 생성된다. (오라클이 자체적으로 만든다.)
--@ 인덱스는... LIKE 책의 목차 X, 책의 색인 O. 어떤 개념을 보고 싶다면 몇 페이지로 가시오.
--@ 가급적이면 기본 키 사용하는게 좋음!

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] PRIMARY KEY[(컬럼명, ...)]
--@ [] : 생략 가능하다는 의미로 사용한 것!

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- , 컬럼명 데이터타입
-- , CONSTRAINT CONSTRAINT명 PRIMARY KEY(컬럼명[, ...])
--@ 두 방법 다 자주 쓰이나... 가급적 2번 사용하기를 권장. 좀 더 안정적으로 지정, 조회, 확인.

-- 4. CONSTRAINT 추가 시 CONSTRAINT 명을 생략하면
--    오라클 서버가 자동적으로 CONSTRAINT 명을 부여하게 된다.
--    일반적으로 CONSTRAINT 명은 『테이블명_컬럼명_CONSTRAINT약어』
--    형식으로 기술한다.
--@ 오라클 지정 CONSTRAINT 명 사용하는 건 추천하지 않음.. 가급적 우리가 지정하는 게 좋음.


--○ PK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST1
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1, 'TEST'); --@ 요렇게 쓰는 걸 권장!
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST1(COL1) VALUES(4);               --@ 이렇게 써도 되긴함. 명시안한 쪽은 NULL로 넣어짐
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'ABCD');        --> 에러 발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'KKKK');        --> 에러 발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5, 'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL, NULL);       --> 에러 발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL, 'STUDY');    --> 에러 발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES('STUDY');          --> 에러 발생

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST1;
--==>>
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

DESC TBL_TEST1;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 

*/

--○ 제약조건 확인
SELECT *
FROM USER_CONSTRAINTS;
--==>>
/*
HR	REGION_ID_NN	    C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	REG_ID_PK	        P	REGIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	COUNTRY_ID_NN	    C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	COUNTRY_C_ID_PK	    P	COUNTRIES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	COUNTR_REG_FK	    R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	LOC_CITY_NN	        C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	LOC_ID_PK	        P	LOCATIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	LOC_C_ID_FK	        R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	DEPT_ID_PK	    P	DEPARTMENTS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	DEPT_LOC_FK	    R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JOB_ID_PK	    P	JOBS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME
HR	SYS_C007051	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME
*/


SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TBL_TEST1';
--==>>
/*
HR	SYS_C007051	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			21/09/09	HR	SYS_C007051		
*/

--○ 제약조건이 지정된 컬럼 확인(조회)
SELECT *
FROM USER_CONS_COLUMNS;
--==>>
/*
HR	REGION_ID_NN	REGIONS	REGION_ID	
HR	REG_ID_PK	REGIONS	REGION_ID	1
HR	COUNTRY_ID_NN	COUNTRIES	COUNTRY_ID	
HR	COUNTRY_C_ID_PK	COUNTRIES	COUNTRY_ID	1
HR	COUNTR_REG_FK	COUNTRIES	REGION_ID	1
HR	LOC_ID_PK	LOCATIONS	LOCATION_ID	1
HR	LOC_CITY_NN	LOCATIONS	CITY	
HR	LOC_C_ID_FK	LOCATIONS	COUNTRY_ID	1
HR	DEPT_ID_PK	DEPARTMENTS	DEPARTMENT_ID	1
HR	DEPT_NAME_NN	DEPARTMENTS	DEPARTMENT_NAME	
HR	DEPT_MGR_FK	DEPARTMENTS	MANAGER_ID	1
HR	DEPT_LOC_FK	DEPARTMENTS	LOCATION_ID	1
HR	JOB_ID_PK	JOBS	JOB_ID	1
HR	JOB_TITLE_NN	JOBS	JOB_TITLE	
HR	EMP_EMP_ID_PK	EMPLOYEES	EMPLOYEE_ID	1
HR	EMP_LAST_NAME_NN	EMPLOYEES	LAST_NAME	
HR	EMP_EMAIL_NN	EMPLOYEES	EMAIL	
HR	EMP_EMAIL_UK	EMPLOYEES	EMAIL	1
HR	EMP_HIRE_DATE_NN	EMPLOYEES	HIRE_DATE	
HR	EMP_JOB_NN	EMPLOYEES	JOB_ID	
HR	EMP_JOB_FK	EMPLOYEES	JOB_ID	1
HR	EMP_SALARY_MIN	EMPLOYEES	SALARY	
HR	EMP_MANAGER_FK	EMPLOYEES	MANAGER_ID	1
HR	EMP_DEPT_FK	EMPLOYEES	DEPARTMENT_ID	1
HR	JHIST_EMPLOYEE_NN	JOB_HISTORY	EMPLOYEE_ID	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_EMP_FK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_START_DATE_NN	JOB_HISTORY	START_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	START_DATE	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	START_DATE	2
HR	JHIST_END_DATE_NN	JOB_HISTORY	END_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	END_DATE	
HR	JHIST_JOB_NN	JOB_HISTORY	JOB_ID	
HR	JHIST_JOB_FK	JOB_HISTORY	JOB_ID	1
HR	JHIST_DEPT_FK	JOB_HISTORY	DEPARTMENT_ID	1
HR	SYS_C007051	TBL_TEST1	COL1	1
*/

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='TBL_TEST1';
--==>>
/*
HR	SYS_C007051	TBL_TEST1	COL1	1
*/

--○ 제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목 조회
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME
     , UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
  AND UC.TABLE_NAME='TBL_TEST1';
--==>>
/*
HR	SYS_C007051	TBL_TEST1	P	COL1
*/


--○ PK 지정 실습(② 테이블 레벨의 형식)
--  테이블 생성
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--1은 2년차 이후부터 쓰고.... 2년차 전까지는 2로 구문 작성하기!
--2를 쓰면 1은 얼마든지 작성 가능. 1 쓰다보면 2로는 작성 불가능
--==>> Table TBL_TEST2이(가) 생성되었습니다.

--데이터 입력
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST2(COL1) VALUES(4);
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'ABCD');        --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'KKKK');        --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(5, 'ABCD');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(NULL, NULL);       --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(NULL, 'STUDY');    --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES('STUDY');          --> 에러 발생

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

--○ 제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목 조회
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME
     , UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
  AND UC.TABLE_NAME='TBL_TEST2';
--==>>
/*
HR	TEST2_COL1_PK	TBL_TEST2	P	COL1
*/


--○ PK 지정 실습(③ 다중 컬럼 PK 지정 → 복합 프라이머리 키)
-- 테이블 생성
/*
CREATE TABLE TBL_TEST3
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST3_COL2_PK PRIMARY KEY(COL2)
);
*/
--(Ⅹ)
--@ 이건 제약조건을 두 개 만들겠다는 의미. 프라이머리키는 최대 한 개, 불가능...

CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);      --> 에러 발생
INSERT INTO TBL_TEST3(COL1) VALUES(4);                  --> 에러 발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, 'ABCD');    --@ 가능! 복합 프라이머리 키.. 두개가 다 동일할 경우에만 안들어감
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'KKKK');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL);    --> 에러 발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'STUDY'); --> 에러 발생
INSERT INTO TBL_TEST3(COL2) VALUES('TEST');              --> 에러 발생

--ROLLBACK;

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	KKKK
1	TEST
2	ABCD
2	TEST
3	ABCD
*/

--○ PK 지정 실습(④ 테이블 생성 이후 제약조건 추가 → PK 지정)
-- 테이블 생성
CREATE TABLE TBL_TEST4
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST4이(가) 생성되었습니다.

-- ※ 이미 만들어져 있는 테이블에
--    부여하려는 제약조건을 위반한 데이터가 포함되어 있을 경우
--    해당 테이블에 제약조건을 추가하는 것은 불가능하다.

-- 제약조건 추가
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TSET4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4이(가) 변경되었습니다.


-- 데이터 입력
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST4(COL1) VALUES(4);       
/*
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(3, 'ABCD');     --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(2, 'TEST');     --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(1, 'KKKK');     --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(NULL, NULL);    --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(NULL, 'STUDY'); --> 에러 발생
INSERT INTO TBL_TEST4(COL2) VALUES('TEST');              --> 에러 발생
*/
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(2,'ABCD');      --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(2,'KKKK');      --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(5,'ABCD'); 
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(NULL,NULL);     --> 에러 발생
INSERT INTO TBL_TEST4(COL1, COL2) VALUES(NULL,'STUDY');  --> 에러 발생
INSERT INTO TBL_TEST4(COL2) VALUES ('STUDY');            --> 에러 발생

SELECT *
FROM TBL_TEST4;
--==>>
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

COMMIT;
--==>> 커밋 완료.

-- ※ 제약조건 확인용 전용 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
     , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
     , UC.TABLE_NAME "TABLE_NAME"
     , UC.CONSTRAINT_TYPE "CONSTRAINT_TYPE"
     , UCC.COLUMN_NAME "COLUMN_NAME"
     , UC.SEARCH_CONDITION "SEARCH_CONDITION"
     , UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
-->> View VIEW_CONSTCHECK이(가) 생성되었습니다.

--○ 생성된 뷰(VIEW)를 통한 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST4';
--==>> HR	TSET4_COL1_PK	TBL_TEST4	P	COL1	


--------------------------------------------------------------------------------

--■■■ UNIQUE(UK:U) ■■■--

-- 1. 테이블에서 지정한 컬럼의 데이터가 중복되지 않고
--    테이블 내에서 유일할 수 있도록 설저하는 제약조건.
--    PRIMARY KEY 와 유사한 제약조건이지만, NULL 을 허용한다는 차이가 있다.
--    내부적으로 PRIMARY KEY 와 마찬가지로 UNIQUE INDEX 가 자동 생성된다.
--    하나의 테이블 내에서 UNIQUE 제약조건은 여러 번 설정하는 것이 가능하다.
--    즉, 하나의 테이블에 UNIQUE 제약조건을 여러 개 만드는 것이
--    가능하다는 것이다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
--  컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] UNIQUE

-- ② 테이블 레벨의 형식
--  컬럼명 데이터타입
--  , 컬럼명 데이터타입
--  , CONSTRAINT CONSTRAINT명 UNIQUE(컬럼명, ...)

--@ 전화번호, 주민번호 같은거 추가로 못하게 하려고 묶어서 프라이머리 키 해버리면
--@ 오히려 전화번호/주민번호 각각 같은건 추가할수 있게 되어버림...! 두개 다 같을 경우만 추가불가능하기 때문
 

--○ UK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST5
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)     UNIQUE
);
--==>> Table TBL_TEST5이(가) 생성되었습니다.

-- 제약조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST5';
--==>>
/*
HR	SYS_C007055	TBL_TEST5	P	COL1		
HR	SYS_C007056	TBL_TEST5	U	COL2		
*/

-- 데이터 입력
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4);     
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2,'ABCD');      --> 에러 발생
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2,'KKKK');      --> 에러 발생
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5,'ABCD');      --> 에러 발생
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(NULL,NULL);     --> 에러 발생
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(NULL,'STUDY');  --> 에러 발생
INSERT INTO TBL_TEST5(COL2) VALUES ('STUDY');            --> 에러 발생

--@ (null)은 엄밀히 말하면 값이 아님! (null)을 고유한 값으로 취급하지 않음

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	
4	
*/

--○ UK 지정 실습(② 테이블 레벨의 형식)
CREATE TABLE TBL_TEST6
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6이(가) 생성되었습니다.

--@ TEST6..앞으로 지정되는게 아니라 맨뒤(COL2)로 지정! 앞은 달라져도되는데 뒤는 달라지면X

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST6';
--==>>
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/


--○ UK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7이(가) 생성되었습니다.

-- 제약조건 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST7';
--==>> 조회 결과 없음 → 제약조건을 설정하지 않았음

-- 제약조건 추가
ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2));
--==>> Table TBL_TEST7이(가) 변경되었습니다.

-- 제약조건 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/

--------------------------------------------------------------------------------

--■■■ CHECK(CK:C) ■■■--

-- 1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건
--    컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록 처리하며,
--    수정되는 데이터 또한 검사하여 조건에 맞는 데이터로 수정되는 것만 허용하는
--    기능을 수행하게 된다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] CHECK (컬럼 조건)

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- , 컬럼명 데이터타입
-- , CONSTRAINT CONSTRAINT명 CHECK(컬럼 조건)

-- -9999999999999999999990000099999999999 ~ 999999999999999999999999999999999999999

--※ NUMBER(38)      까지...
--   CHAR(2000)      까지...
--   VAHRCHAR2(4000) 까지...
--   NHAR(1000)      까지...
--   NVARCHAR2(2000) 까지...
--@ 요정도는 기억해두기!


--○ CK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST8
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)       CHECK (COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '승균', 100);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '범석', 101);   --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(3, '진희', -1);    --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(4, '지윤', 80);

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST8;
--==>>
/*
1	승균	100
4	지윤	 80
*/

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
HR	SYS_C007061	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007062	TBL_TEST8	P	COL1		
*/


--○ CK 지정 실습(② 테이블 레벨의 형식)

-- 테이블 생성
CREATE TABLE TBL_TEST9
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '승균', 100);
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '범석', 101);   --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(3, '진희', -1);    --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(4, '지윤', 80);

COMMIT;
--==>> 커밋 완료.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST9';
--==>>
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/


--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST10
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
);
--==>> Table TBL_TEST10이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST10';
--==>> 조회 결과 없음 → 지정된 제약조건 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--==>> Table TBL_TEST10이(가) 변경되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/


--○ 실습 문제
-- 다음과 같이 TBL_TESTMEMBER 테이블을 생성하여
-- SSN 컬럼(주민번호 컬럼)에서
-- 데이터 입력 시 성별이 유효한 데이터만 입력될 수 있도록
-- 체크 제약조건을 추가할 수 있도록 한다.
-- → 주민번호 특정자리에 입력 가능한 데이터로 1, 2, 3, 4 를 적용
-- 또한, SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.

-- 테이블 생성
CREATE TABLE TBL_TESTMEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)            --@                     | <- 8번째 자리
, SSN   CHAR(14)                -- 입력 형태 → 'YYMMDD-NNNNNNN'
, TEL   VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER이(가) 생성되었습니다.

--◈ 내가 작성한 코드
-- 제약조건 추가
/*
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SSN 8번째 자리수는 1,2,3,4));

ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN, 8, 1) IN ('1', '2' ,'3', '4')));
--@ 잘못 설정될까봐 무섭당,,,^^ㅠ
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.
*/

-- 제약조건 추가
-- 함께 작성한 코드
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK() );

ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(주민번호 8번째 자리 1개가 '1' 또는 '2' 또는 '3' 또는 '4') );

ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SSN 컬럼의 8번째 자리 1개가 '1' 또는 '2' 또는 '3' 또는 '4') );

ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN, 8, 1) 가 '1' 또는 '2' 또는 '3' 또는 '4') );

ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4')) );
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.


--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TESTMEMBER';
--==>>
/*
HR	TBL_TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TBL_TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN, 8, 1) IN ('1', '2' ,'3', '4')	
*/
--@ 기본적으로 제약조건은 수정 못함... 제약조건 제거하고 다시 만들면 됨!

-- 입력테스트
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '박효빈', '980611-2234567', '010-1111-1111');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(2, '손다정', '940603-2234567', '010-2222-2222');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(3, '이찬호', '941108-1234567', '010-3333-3333');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(4, '손범석', '960816-5234567', '010-4444-4444');
--==>> 에러 발생
/*
명령의 782 행에서 시작하는 중 오류 발생 -
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(4, '손범석', '960816-5234567', '010-4444-4444')
오류 보고 -
ORA-02290: check constraint (HR.TBL_TESTMEMBER_SSN_CK) violated
*/

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '이다영', '951027-9234567', '010-5555-5555');
--==>>
/*
명령의 793 행에서 시작하는 중 오류 발생 -
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '이다영', '951027-9234567', '010-5555-5555')
오류 보고 -
ORA-02290: check constraint (HR.TBL_TESTMEMBER_SSN_CK) violated
*/

--
SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	박효빈	980611-2234567	010-1111-1111
2	손다정	940603-2234567	010-2222-2222
3	이찬호	941108-1234567	010-3333-3333
*/


--------------------------------------------------------------------------------

--■■■ FOREIGN KEY(FK:F:R) ■■■--

-- 1. 참조 키 또는 외래 키(FK)는
--    두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 열이다.
--    한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래 키가 된다.

-- 2. 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조받는 컬럼이 포함된 테이블)이 생성되어야 한다.
--    이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                   REFERENCES 참조테이블명(참조컬럼명)
--                   [ON DELETE CASCADE | ON DELETE SET NULL]

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- , 컬럼명 데이터타입
-- , CONSTRANT CONSTRAINT명 FOREIGN KEY(컬럼명)
--             REFERENCES 참조테이블명(참조컬럼명)
--             [ON DELETE CASCADE | ON DELETE SET NULL]

--@ [] : 생략 가능

-- ※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--    독립적인 하나의 테이블을 생성하여 처리하는 것이 아니라
--    부모 테이블 생성 작업을 먼저 수행해야 한다.
--    그리고 이 때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이
--    설정된 컬럼이 존재해야 한다. --@ ※ 중요함!

--@ 그 대상 대한 테이블에 아무거나 조건잡을 수 있는게 아니라...
--@ PRIMARY, UNIQUE가 설정되어야 고유한 값이라는 게 보장 되므로(중복 불가능)
--@ 어느 10번이지? 하는 혼란 없다는걸 확인받은 후에야 FOREIGN KEY 설정 가능 --@ ※ 더더 중요함!

-- 부모 테이블 생성
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER(5)
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS이(가) 생성되었습니다.

-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '부장');
--==>> 1 행 이(가) 삽입되었습니다. * 4

SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	팀장
*/

COMMIT;
--==>> 커밋 완료.


--○ FK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP1
( SID       NUMBER(5)       PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER(5)       REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1이(가) 생성되었습니다.
--@ FK 지정은 TBL_JOBS가 존재, JIKWI_ID가 존재, 해당 칼럼이 PRIMARY 나 UNIQUE 조건이 걸려있어야 가능

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP1';
--==>>
/*
HR	SYS_C007070	TBL_EMP1	P	SID		
HR	SYS_C007071	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/
--@ NO ACTION 이 있음! 이건 나중에 옵션 볼때 설명할거...
--@ 1정규화를 하면서 테이블을 쪼개면 자동으로 P.K 설정되는게 아님.. P.K를 따로 만들거나, 설정해줘야 함!!

-- 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '최현정', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '최수지', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '정가연', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '이다영', 4);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '손범석', 5);  -- 에러 발생
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '손범석', 1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(6, '정효진'); --@ 입력 가능!
--==>>@ EMP 테이블 가지고 놀 때 사원번호 없는 애들(인턴) 입력 가능했음!
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(7, '손다정', NULL);

SELECT *
FROM TBL_EMP1;
--==>>
/*
1	최현정	1
2	최수지	2
3	정가연	3
4	이다영	4
5	손범석	1
6	정효진	
7	손다정	
*/

COMMIT;
--==>> 커밋 완료.


--○ FK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP2
( SID       NUMBER(5)
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER(5)
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	        TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--○ FK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
--
-- 테이블 생성
CREATE TABLE TBL_EMP3
( SID       NUMBER(5)
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER(5)
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP3';
--==>> 조회 결과 없음 → 제약조건 설정되어 있지 않음

-- 제약조건 추가
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_ PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3이(가) 변경되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP3';
--==>>
/*
HR	EMP3_SID_	TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FORIEN KEY 생성 시 주의사항
--    참조하고자 하는 부모 테이블을 먼저 생성해야 한다.
--    참조하고자 하는 테이블의 대상 컬럼이
--    PRIMARY KEY 나 UNIQUE 제약조건이 있어야 한다.
--    테이블 사이에 PRIMARY KEY 나 FOREIGN KEY 가 정의되어 있으면
--    PRIMARY KEY 제약조건이 설정된 컬럼의 데이터 삭제 시
--    FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.
--    (단, FK 설정 과정에서 『ON DELETE CASCADE』 나
--     『ON DELETE SET NULL』 옵션을 사용하여 설정한 경우에는
--     삭제가 가능하다.)
--       -->@ 대신, 자식 테이블 안 해당 컬럼 사용하는 레코드 자체가 먼저 삭제되고
--            그 다음 부모 테이블 해당 컬럼 삭제. 굉장히 위험한 옵션...
--    부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다.


-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	최현정	1
2	최수지	2
3	정가연	3
4	이다영	4
5	손범석	1
6	정효진	
7	손다정	
*/

-- 이다영 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID=1
WHERE SID=4;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	최현정	1
2	최수지	2
3	정가연	3
4	이다영	1
5	손범석	1
6	정효진	
7	손다정	
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.


-- 부모 테이블(TBL_JOBS)의 부장 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 존재하지 않는 상황.

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 부장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=4;

--확인
SELECT *
FROM TBL_JOBS;
--==>> 
/*
1	사원
2	대리
3	과장
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 부모 테이블(TBL_JOBS)의 사원 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 3건 존재하고 있는 상황.

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS) 의
-- 사원 데이터 삭제
--SELECT *  --@ 먼저 SELECT로 해당 행 맞는지 확인하고 이 SELECT절 DELETE로 바꿔서 삭제하기! 실수 방지 위해.
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=1;
--==>> 에러 발생
/*
명령의 1,085 행에서 시작하는 중 오류 발생 -
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=1
오류 보고 -
ORA-02292: integrity constraint (HR.SYS_C007071) violated - child record found
*/

-- 부모 테이블(TBL_JOBS) 제거
DROP TABLE TBL_JOBS;
--==>> 에러 발생
/*
명령의 1,099 행에서 시작하는 중 오류 발생 -
DROP TABLE TBL_JOBS
오류 보고 -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";
*/


--※ 부모 테이블의 데이터를 자유롭게 삭제하기 위해서는
--   『ON DELETE CASCADE』 옵션 지정이 필요하다.

-- TBL_EMP1 테이블(자식 테이블)에서 FK 제약조건을 제거한 후
-- CASCADE 옵션을 포함하여 다시 FK 제약조건을 설정한다.

--○ 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP1';
--==>>
/*
HR	SYS_C007070	TBL_EMP1	P	SID		
HR	SYS_C007071	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

--○ 제약조건 제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007071;
--==>> Table TBL_EMP1이(가) 변경되었습니다.


--○ 제약조건 제거 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP1';
--==>> HR	SYS_C007070	TBL_EMP1	P	SID		

--@ 오래된 멀티탭... 먼지주의.. 먼지가 많이쌓이면 타면서 펑! 할수 있음
--@ 그러면 두꺼비집 나가면 괜찮은데 안나가면 주위 전자기기 어뎁터들이 충격먹음 ㅠㅠ
--@ 먼지와 물 주의....!

--○ 『ON DELETE CASCADE』 옵션이 포함된 내용으로 제약조건 재지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWIID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;
--==>> Table TBL_EMP1이(가) 변경되었습니다.


--○ 제약조건 재지정 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP1';
--==>>
/*
HR	SYS_C007070	    TBL_EMP1	P	SID		
HR	EMP1_JIKWIID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/
--@ DELETE_RULE : CASECADE 옵션이 부여되었는지, 아닌지 확인하는 컬럼

--@ CASECADE 이거 부여되어있으면 편한게 아니라 조심해야 함....!
--> CASCADE 옵션을 지정한 후에는
--  참조받고 있는 부모 테이블의 데이터를
--  언제든지 제한없이 삭제하는 것이 가능하다.
--  단, ... ... ... 부모 테이블의 데이터가 삭제될 경우
--  이를 참조하는 자식 테이블의 데이터도 모~~~~~~~~~~~두 함께 삭제된다.
--  CHECK~!!!


-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	최현정	1   ←
2	최수지	2
3	정가연	3
4	이다영	1   ←
5	손범석	1   ←
6	정효진	
7	손다정	
*/


--○ TBL_JOBS(부모 테이블)의 사원 데이터 삭제
--SELECT *
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=1;
--==>> 1 행 이(가) 삭제되었습니다.

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
2	대리
3	과장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
2	최수지	2
3	정가연	3
6	정효진	
7	손다정	
*/

--@ 의도치 않게 해당 컬럼과 연결된
--@ 몇십, 몇만건의 회원 데이터 한꺼번에 삭제해버릴수 있음....
--@ 가능하면 쓰지 않는게 좋고, 의도했다면 정말 조심히 사용해야 하는 옵션!
--------------------------------------------------------------------------------

--■■■ NOT NULL(NN:CK:C) ■■■--
--@ 별도의 독립적인 범주라기보다는 CHECK 절의 일부다...라고 보는 경우도 많음
--@ 이거 어디에 넣느냐에 따라 컨트롤하기 까다로워질 수 있음... 잘 봐야 함
--@ 어디는 NOT NULL이 있는데 어디는 없고.... 하는 경우 많음
--@ 우리는 이거 제약조건으로 다룰 것!!!

-- 1. 테이블에서 지정한 컬럼의 데이터가 NULL 인 상태를 갖지 못하도록 하는 제약조건.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터 타입 [CONSTRAINT CONSTRAINT명] NOT NULL

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- , 컬럼명 데이터타입
-- , CONSTRAINT CONSTRAINT명 CHECK(컬럼명 IS NOT NULL)
--@※ 다른 제약조건들은 테이블 레벨로 구현하기를 추천했지만, 
--@   NOT NULL 만큼은 가급적 어지간하면 컬럼 레벨로 구현하기! (※ 중요함!)
--@ 왜인지는.... 제약조건끝내고 이따 팀별 과제 하다보면 느끼게 될듯?

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
--    ADD 보다 MODIFY 절이 더 많이 사용된다.
--@※ ADD 절보다 MODIFY 절 설정하기를 권장!

--    ALTER TABLE 테이블명
--    MODIFY 컬럼명 데이터타입 NOT NULL;

-- 4. 기존 테이블에 데이터가 이미 들어있지 않은 컬럼(→ NULL 인 상태)을
--    NOT NULL 제약조건을 갖게끔 수정하는 경우에는 에러 발생한다.


--○ NOT NULL 지정 실습(① 컬럼 레벨의 형식)
--  테이블 생성
CREATE TABLE TBL_TEST11
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    NOT NULL
);
--==>> Table TBL_TEST11이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(3, NULL);     --> 에러 발생
INSERT INTO TBL_TEST11(COL1) VALUES(4);                 --> 에러 발생

SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/

COMMIT;
--==>> 커밋 완료.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST11';
--==>>
/*
HR	SYS_C007077	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007078	TBL_TEST11	P	COL1		
*/


--○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST12
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/

--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST13
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST13이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST13';
--==>> 조회 결과 없음 → 제약조건이 설정되지 않음

-- 제약조건 추가
ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL) );
--==>> Table TBL_TEST13이(가) 변경되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST13';
--==>>
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/

--※ NOT NULL 제약조건만 TBL_TEST13 테이블의 COL2 에 추가하는 경우
--   다음과 같은 방법도 가능하다.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==>> Table TBL_TEST13이(가) 변경되었습니다.


-- TBL_TEST11 / TBL_TEST12 / TBL_TEST13

-- 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블
DESC TBL_TEST11;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
--> DESC 를 통해 COL2 컬럼이 NOT NULL 인 정보가 확인되는 상황


-- 테이블 레벨에서 NOT NULL 제약조건을 지정한 테이블
DESC TBL_TEST12;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
--@ 실무에선 조인? 등등 연결한 다른 테이블에 있을 것,,,!
--> DESC 를 통해 COL2 컬럼이 NOT NULL 인 정보가 확인되지 않는 상황


-- 테이블 생성 이후 ADD 를 통해 NOT NULL 제약조건을 추가하였으며
-- 또한, MODIFY 절을 통해 NOT NULL 제약조건을 다시 추가한 테이블
DESC TBL_TEST13;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
--> DESC 를 통해 COL2 컬럼이 NOT NULL 인 정보가 확인되는 상황


-- 제약조건 확인 전용 뷰(VIEW) 조회
SELECT *
FROM VIEW_CONSTCHECK --@ 이거 우리가 임의로 만든거...당연 실무에선 없음 이거!
WHERE TABLE_NAME IN('TBL_TEST11', 'TBL_TEST12', 'TBL_TEST13');
--==>>
/*  
HR	SYS_C007077	TBL_TEST11	    C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007078	TBL_TEST11	    P	COL1		
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007083	TBL_TEST13	    C	COL2	"COL2" IS NOT NULL	
*/
--==>>@ NOT NULL은 이래서 컬럼 레벨로 부여하는게 좋음! 실제로 실습해보면 알게 될 것...











