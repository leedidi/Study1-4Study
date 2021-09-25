    
-- ◈ 테이블 생성 구문 작성

--> 테이블 생성구문 안에서 작성하려면... 이렇게!
CREATE TABLE JOB_HISTORY03 
(...
, CONSTRAINT JHIST03_EMP_ID_ST_DATE_PK PRIMARY KEY(EMPLOYEE_ID, START_DATE)
, CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );


--1. PRIMARY KEY 삽입 구문 작성 예제 (P.K)
ALTER TABLE 해당테이블명
ADD CONSTRAINT TBL뺀 해당테이블명_해당컬럼명_PK PRIMARY KEY(해당컬럼명);
-----------------------------------------------------------------------
--ex1> 컬럼 레벨의 형식
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TSET4_COL1_PK PRIMARY KEY(COL1);
--ex2> 테이블 레벨의 형식
CREATE TABLE JOB_HISTORY03 
(...
, CONSTRAINT JHIST03_EMP_ID_ST_DATE_PK PRIMARY KEY(EMPLOYEE_ID, START_DATE));


--2. FORIGN KEY 삽입 구문 작성 예제 (F.K)
ALTER TABLE 참고받는테이블명
ADD CONSTRAINT TBL뺀 참고받는테이블명_해당컬럼명_FK FOREIGN KEY(해당컬럼명)
               REFERENCES 참고할테이블명전체(해당컬럼명); -- TBL뺀거는 임의.... CONSTRINT 와 FOREIGN 사이는 키이름.
                                                           -- 개인 임의로 지정 가능!
-------------------------------------------------------------------------------
--ex1> 컬럼 레벨의 형식
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID);
--ex2> 테이블 레벨의 형식
CREATE TABLE TBL_EMP3
(...
, CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID));
                 
--3. CHECK KEY 삽입 구문 작성 예제 
ALTER TABLE 해당테이블명
ADD CONSTRAINT TBL뺀해당테이블명_해당컬럼명_CK CHECK(조건);
--------------------------------------------------------------------------------
--ex1> 컬럼 레벨의 형식
ALTER TABLE TBL_TEST10
ADD CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--ex2> 테이블 레벨의 형식
CREATE TABLE TBL_TEST10
(...
, CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));

--4. NOT NULL 구문 (NOT NULL 구문도 C로 들어감..!)
ALTER TABLE 해당테이블명
MODIFY 해당컬럼명 NOT NULL;

ALTER TABLE 해당테이블명
ADD CONSTRAINT TBL뺀해당테이블명_해당컬럼명_NN CHECK("해당컬럼명" IS NOT NULL);  -- " "는 임의로 넣고 빼고 가능..
-- 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
-- ADD 보다 MODIFY 절이 더 많이 사용된다.
--@※ ADD 절보다 MODIFY 절 설정하기를 권장!

CREATE TABLE EMPLOYEES03
( EMPLOYEE_ID       NUMBER(6)
, FIRST_NAME        VARCHAR2(20)
, LAST_NAME         VARCHAR2(25)    CONSTRAINT EMP03_LAST_NAME_NN NOT NULL
, EMAIL             VARCHAR2(25)    CONSTRAINT EMP03_EMAIL_NN NOT NULL
, PHONE_NUMBER      VARCHAR2(20)
, HIRE_DATE         DATE            CONSTRAINT EMP03_HIRE_DATE_NN NOT NULL
, JOB_ID            VARCHAR2(10)    CONSTRAINT EMP03_JOB_NN NOT NULL
, SALARY            NUMBER(8,2)
); --요런 식으로 옆에 넣을수도 있는 듯!
--------------------------------------------------------------------------------
--ex1> 컬럼 레벨의 형식
--ex1-1> MODIFY → NOT NULL 제약조건만 단독으로 사용시 가능
ALTER TABLE TBL_TEST14
MODIFY COL2 NOT NULL;
--ex1-2> ADD
ALTER TABLE TBL_TEST14
ADD CONSTRAINT TEST14_COL2_NN CHECK("COL2" IS NOT NULL);.
--ex2> 테이블 레벨의 형식
CREATE TABLE TBL_TEST14
(...
, CONSTRAINT TEST14_COL2_NN CHECK("COL2" IS NOT NULL));

CREATE TABLE EMPLOYEES03
( EMPLOYEE_ID       NUMBER(6)
, FIRST_NAME        VARCHAR2(20)
, LAST_NAME         VARCHAR2(25)    CONSTRAINT EMP03_LAST_NAME_NN NOT NULL
);
-- 둘다 가능한 듯... 근데 일단 필기에는 첫번째 방법으로 나와있음(, CONSTRAINT...)
