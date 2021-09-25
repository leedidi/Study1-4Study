

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

교수자 명, 배정된 과목명, 과목 기간(시작 연월일, 끝 연월일), 교재 명, 강의실, 
 강의 진행 여부(강의 예정, 강의 중, 강의 종료)를
 
 
 --■■■ 프로시저 내에서의 예외 처리 ■■■ --

--○ TBL_MEMBER 테이블에서 데이터를 입력하는 프로시저 작성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목에 '서울', '인천', '경기' 만 입력이 가능하도록 구성한다.
--   허용된 지역 외의 지역을 프로시저 호출을 통해 입력하려고 하는 경우
--   예외 처리를 하려고 한다.
--   프로시저 명 : PRC_MEMBER_INSERT(이름, 전화번호, 지역)

-- 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS

    V_NUM   TBL_MEMBER.NUM%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN

    IF (V_CITY NOT IN ('서울', '인천', '경기'))
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    SELECT NVL(MAX(NUM), 0) INTO V_NUM    
    FROM TBL_MEMBER;

    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    COMMIT;

    EXCEPTION  
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울,인천,경기만 입력이 가능합니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.




CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
(V_NAME     IN TBL_ADMIN.NAME%TYPE				-- 이름
,V_SIGNDATE IN TBL_ADMIN.SIGNDATE%TYPE			-- 등록일
)
IS
    V_ID    TBL_ADMIN.ID%TYPE;
BEGIN
    
    INSERT INTO TBL_IDPW VALUES ('A'||TO_CHAR(SEQ_IDPW.NEXTVAL)||V_NAME, 'java006$' , 'A');  
    
    
    SELECT ID INTO V_ID
    FROM TBL_IDPW
    WHERE PW = 'java006$';
    
    INSERT INTO TBL_ADMIN VALUES(CONCAT('AD',TO_CHAR(SEQ_ADMIN.NEXTVAL)),V_ID,V_NAME,V_SIGNDATE);
    COMMIT;   
END;
