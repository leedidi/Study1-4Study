SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ FUNCTION(함수) ■■■--

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명
[(
    매개변수1 자료형
  , 매개변수2 자료형
)]
RETURN 데이터타입        --@ (값)이 어떤 데이터타입, 어떤 유형을 반환한다는거 미리 보여줌
IS
    -- 주요 변수 선언(지역 변수)
BEGIN
    -- 실행문
    ...
    RETURN (값);
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--   FUNCTION 은 반드시 단일 값만 반환한다.

 
--○ TBL_INSA 테이블에서
--   주민등록번호를 가지고 성별을 조회한다.

SELECT *
FROM TBL_INSA;
 
SELECT NAME, SSN, DECODE( SUBSTR(SSN,8,1), '1', '남자', '2', '여자', '확인불가' )"성별"
FROM TBL_INSA;

/*
         ↓ 주민등록번호
        \   /
     ----   --------------
     |                   |
     ----------------   --
                     /  \
                      ↓ 성별
*/
 
--○ FUNCTION 생성
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민등록번호) → 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER
( VSSN  VARCHAR2    -- 매개변수 : 자릿수(길이) 지정 안함
)--@ 매개변수 넘겨줄 것 명시
RETURN VARCHAR2     -- 반환 자료형 : 자릿수(길이 지정 안함) -@ 명심할거 1. RETURN 사용! 2. 길이지정 X
    --@여기까지 선언부
IS
    -- 주요 변수 선언
    VRESULT VARCHAR2(20);
BEGIN
    -- 연산 및 처리
    IF ( SUBSTR(VSSN, 8, 1) IN ('1', '3') )
        THEN VRESULT := '남자';
    ELSIF ( SUBSTR(VSSN, 8, 1) IN ('2', '4') )
        THEN VRESULT := '여자';
    ELSE
        VRESULT := '성별확인불가';
    END IF; --@ IF 시작했다 IF 끝났다!
    
    -- 최종 결과값 반환
    RETURN VRESULT;
    
END;
--@ 여기까지 몸체
--==>> Function FN_GENDER이(가) 컴파일되었습니다.
 

--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아
--   A의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
--   함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000

FN_POW(10, 3)
      --------
            10 * 10 * 10 = 1000
        1 * 10 * 10 * 10 = 1000
        0 * 10 * 10 * 10 = 0
*/

/*
--◈ 내가 작성한 코드
CREATE OR REPLACE FUNCTION FN_POW
( N1    NUMBER
, N2    NUMBER
)
RETURN NUMBER
IS
    VRESULT NUMBER := 1;
    N       NUMBER := N2;
BEGIN
    --POWER 사용X
    --반복문.......
    LOOP
        EXIT WHEN N<=0;
        VRESULT := VRESULT * N1;
        N := N - 1;
    END LOOP;
    
    RETURN VRESULT;
END;
--
--

DECLARE
    N   NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N>=10;
        N := N + 1;                 -- N++;   N+=1;
    END LOOP;
END;
*/

CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER) -- 매개변수
RETURN NUMBER
IS
    V_RESULT    NUMBER := 1;        -- 누적 곱
    V_NUM       NUMBER;
BEGIN

    FOR V_NUM IN 1 ..  B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    -- CHECK~!!!
    RETURN V_RESULT;
END;
-- @ 오류...! ㅎㅎ 나중에 확인 --> 오류 해결 완료!
--==>> Function FN_POW이(가) 컴파일되었습니다.




--* 과제
--@ 카페에 올리기! 풀다가 스스로 못 해결하겠으면 카페 다른 식구들 코드 참고해도 됨....


SELECT *
FROM TBL_INSA;

--○ 과제 1
-- TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
-- 급여는 『(기본급*12)+수당』 을 기반으로 연산을 수행한다.
-- 함수명 : FN_PAY(기본급, 수당)

CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER, SUDANG NUMBER) -- 매개변수
RETURN NUMBER
IS
    -- 주요 변수 선언
    V_YEARPAY     NUMBER;
BEGIN
    -- 연산 및 처리
    V_YEARPAY := (BASICPAY * 12) + SUDANG;
    
    -- 최종 결과값 반환
    RETURN V_YEARPAY;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.


--○ 과제 2
-- TBL_INSA 테이블의 입사일을 기준으로
-- 현재까지의 근무년수를 반환하는 함수를 정의한다.
-- 단, 근무년수는 소수점 이하 한자리까지 계산한다.
-- 함수명 : FN_WORKYEAR(입사일)

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    -- 주요 변수 선언
    -- 현재까지의 근무년수(소수점 이하 한자리까지)
    V_WORKYEAR    NUMBER;
BEGIN
    -- 연산 및 처리
    V_WORKYEAR := TRUNC((SYSDATE - IBSADATE)/365, 1);
    
    -- 최종 결과값 반환
    RETURN V_WORKYEAR;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- 정적 PL/SQL문 → DML문, TCL문만 사용 가능하다.             --@ 상황에 따라 변하지 않는...
-- 동적 PL/SQL문 → DML문, DDL문, DCL문, TCL문 사용 가능하다. --@ 상황에 따라 변하는...

--@ 위에 INSERT 등 사용하고 아래에 CREATE, GRANT 등 사용하면... INSERT도 커밋되어버림! 롤백해도 인서트 취소되지 X

--------------------------------------------------------------------------------

--■■■ PROCEDURE(프로시저) ■■■--

--@ 데이터에서는 함수보다 많이 사용될수도... '절차적'! <- 핵심 단어임

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두엇다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[(
    매개변수 IN 데이터타입
  , 매개변수 OUT 데이터타입
  , 매개변수 INOUT 데이터타입
)]
IS
    -- 주요 변수 선언
BEGIN
    -- 실행 구문
    ...
    [EXCEPTION]
        -- 예외 처리 구문
END;
*/

--@ 중요한 거!
--@ 1. RETURN 문이 없음
--@ 2. IN, OUT, INOUT 다 가능.. 물론 사용은 IN 파라미터가 독보적

--※ FUNCTION 과 비교했을 때...
--  『RETURN 반환자료형』 부분이 존재하지 않으며,
--  『RETURN』문 자체도 존재하지 않으며,
--  프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--  IN, OUT, INOUT 으로 구분된다.
--@ IN, OUT, INOUT 다 있기 때문에... 입력 매개변수 실행 시 IN 꼭 써야 함!

-- 3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2, ...)];
-@ [] : 생략 가능!
*/


--○ INSERT 쿼리 실행을 프로시저로 작성 ( → INSERT 프로시저)
--@ 못된 예...! 
--@ 그냥 이해를 시키기 위한 예시임! 실제로는 이렇게 하지 않음.. 이렇게 하라는 얘기 X

-- 실습 테이블 생성(TBL_STUDENTS)
/*
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(20)
, ADDR  VARCHAR2(100)
);
*/ 
--20210915_02_scott으로 옮겨서 작성 완료!

-- 프로시저 생성(작성)
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
--, V_ADDR    IN TBL_STUDNETS.ADDR%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- 주요 변수 선언
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    --커밋
    COMMIT;
END;
-- 오류,,,!^^ㅠ
--==>> Procedure PRC_STUDENTS_INSERT이(가) 컴파일되었습니다. (오류 해결)


--○ TBL_SUNGJUK 테이블에 데이터 입력 시
--   특정 항목의 데이터(학번, 이름, 국어점수, 영어점수, 수학점수)만 입력하면
--   내부적으로 총점, 평균, 등급 항목이 함께 입력 처리될 수 있도록 하는
--   프로시저를 생성한다.
--   프로시저 명 : PRC_SUNGJUK_INSERT()
/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '김진희', 90, 80, 70);

프로시저 호출로 처리된 결과)
학번    이름    국어점수    영어점수    수학점수    총점   평균   등급
 1     김진희     90           80          70       240     80     B  
*/

--◈ 내가 작성한 코드
/*
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
, V_TOT         IN TBL_SUNGJUK.TOT%TYPE
, V_AVG         IN TBL_SUNGJUK.AVG%TYPE
, V_GRADE       IN TBL_SUNGJUK.GRADE%TYPE
)
IS
    -- 주요 변수 선언
    GC  CHAR(1);
    
BEGIN
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT);
    
    INSERT INTO TBL_SUNGJUK((KOR+ENG+MAT), (KOR+ENG+MAT)/3
  , (IF (KOR+ENG+MAT)/3 >= 90
        THEN GC := 'A'
    ELSIF (KOR+ENG+MAT)/3 >= 80
        THEN GC := 'B'
    ELSIF (KOR+ENG+MAT)/3 >= 70
        THEN GC := 'C'
    ELSIF (KOR+ENG+MAT)/3 >= 60
        THEN GC := 'D'
    ELSE
        GC := 'F'
    END IF;))
    VALUES(V_TOT, V_AVG, V_GRADE)
END;
*/

/*
이름     널?       유형           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)      
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
--@ 입력 매개변수: 내부적으로 이거 건내줄 테니까 이걸 가지고 출력해!
--@ 출력 매개변수: 내가 그릇 줄게.. 네가 처리한 내용 이걸 이 그릇에 담아서 출력해줘!
--@ 이웃사촌끼리... 음식 물물교환. 내가 깍두기 그릇담아서 줄게 네가 김치 그릇담아서 줘!
IS
    -- 아래의 INSERT 쿼리문을 수행하는데 필요한 주요 변수 선언
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
--@ 이건 내부에서 사용하는 지역변수.. IN, OUT 등 사용할 필요 없음!
--@ 위는 ; 찍지 않음...(, 로 구성) 아래 선언부는 ; 찍음. 각각 독립적으로 선언해 줘야 함

BEGIN
    -- 아래의 INSERT 쿼리문을 수행하기 위해서는
    -- 위에서 선언한 변수들에 값을 담아내야 한다.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF (V_AVG >= 90)
    --@ 실무적 팁...! IF 뒤에는 () 붙여주는게 좋음!
    --@ 문법적 필수 요소는 아니지만, 실무적으로 사용할때는 가급적 붙여주기를 권장
    --@ () 조건으로 인식!
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE   
        V_GRADE := 'F';
    END IF;
    
    -- 위의 일련의 과정(line 373 ~ 386)을 통해 담아낸 값들로
    -- INSERT 쿼리문 실행
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
                                                  ----------------------
                                                  
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUNGJUK 테이블에서
--   특정 학생의 점수(학번, 국어, 영어, 수학)
--   데이터 수정 시 총점, 평균, 등급까지 수정하는 프로시저를 작성한다.
--   프로시저 명 : PRC_SUNGJUK_UPDATE()
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2, 100, 100, 100);

프로시저 호출로 처리된 결과)
학번    이름    국어점수    영어점수    수학점수    총점   평균   등급
 2     김소연     100          100         100       300    100    A  
*/

--◈ 내가 작성한 코드
/*
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;

BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF (V_AVG >= 90)   
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --INSERT INTO TBL_SUNGJUK(HAKBUN, KOR, ENG, MAT, TOT, AVG, GRADE)
    --VALUES(V_HAKBUN, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    --UPDATE TBL_AAA
    --SET NAME = '?'
    --WHERE GRADE = 'A';
    
    --UPDATE TBL_SUNGJUK(HAKBUN, KOR, ENG, MAT, TOT, AVG, GRADE)
    --SET(V_HAKBUN, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    --UPDATE TBL_SUNGJUK(KOR, ENG, MAT, TOT, AVG, GRADE)
    --SET(V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE)
    --WHERE HAKBUN = V_HAKBUN;
    
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.
--==>> @ 흑흑 됐다........ㅠㅠ
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- UPDATE 진행 시 필요한 데이터를 담아낼 주요 변수 선언
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 아래 UPDATE 쿼리문 수행을 위해
    -- 위에서 선언한 변수들에 값을 담아내기
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE   
        V_GRADE := 'F';
    END IF;
    
    -- UPDATE 쿼리문 수행
    UPDATE TBL_SUNGJUK
    SET KOR=V_KOR, ENG=V_ENG, MAT=V_MAT, TOT=V_TOT, AVG=V_AVG, GRADE=V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- COMMIT
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.


--○ TBL_STUDENTS 테이블에서
--   전화번호와 주소 데이터를 수정하는(변경하는) 프로시저를 작성한다.
--   단, ID 와 PW 가 일치하는 경우에만 수정을 진행할 수 있도록 한다.
--   프로시저 명 : PRC_STUDENTS_UPDATE()
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '인천');

프로시저 호출로 처리된 결과
superman    손범석 010-9999-9999   인천
*/

--◈ 내가 작성한 코드
/*
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_STUDENTS.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
-- 변수 따로 필요 없음
BEGIN
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    --WHERE ID = V_ID, V_PW= TBL_IDPW의 PW; (java006$)
    WHERE ID = V_ID AND (SELECT PW
                         FROM TBL_IDPW
                         WHERE ID = V_ID) = V_PW;
    --  COMMIT
    COMMIT;
END;
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_STUDENTS.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
--@ 여기 IN 명시 안하면 INOUT으로 써지는듯?
IS
BEGIN
    -- UPDATE 쿼리문 구성
    --UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
    --        FROM TBL_IDPW I JOIN TBL_STUDETS S
    --        ON I.ID = S.ID) T
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
            FROM TBL_IDPW I JOIN TBL_STUDENTS S
            ON I.ID = S.ID) T
    SET T.TEL=V_TEL, T.ADDR=V_ADDR
    WHERE T.ID=V_ID AND T.PW=V_PW;
    
    -- COMMIT
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.


--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--  NUM NAME SSN CITY TEL BUSEO JIKWI BASICPAY SUDANG 
--  구조를 갖고 있는 대상 테이블에 데이터 입력 시
--  NUM 컬럼(사원번호)의 값은
--  기존 부여된 사원번호 마지막 번호의 그 다음 번호를 자동으로
--  입력 처리할 수 있는 프로시저로 구성한다.
--  프로시저명 : PRC_INSA_INSERT(NUM, SSN, IBSADATE, CITY, TEL, BUSEO ,JIKWI, BASICPAY, SUDANG);

/*
실행 예)
EXEC PRC_INSA_INSERT('이다영', '951027-2234567', SYSDATE, '서울', '010-4113-2353', '영업부', '대리', 10000000, 2000000); -- 천만, 이백만

프로시저 호출로 처리된 결과)
1061 이다영 951027-2234567 SYSDATE 서울 010-4113-2353 영업부 대리 10000000, 2000000
*/
-- 내가 작성한 코드
/*
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NUM         IN TBL_INSA
, V_SSN         IN
, V_IBSADATE
, V_CITY
, V_TEL
, V_BUSEO
, V_JIKWI
, V_BASICPAY
, V_SUDANG
)
;
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( '이다영' 
, '951027-2234567'
, SYSDATE 
, '서울' 
, '010-4113-2353' 
, '영업부'
, '대리' 
, 10000000
, 2000000
)
IS
BEGIN
END;


















