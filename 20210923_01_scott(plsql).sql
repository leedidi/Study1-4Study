SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ BEFORE ROW TRIGGER 에 대한 상황 실습 ■■■--
--※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

--○ TRIGGER 작성(TRG_TEST2_DELETE)
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
        BEFORE
        DELETE ON TBL_TEST2
        --@ 여기까지 쓰면 STATEMENT 트리거
        FOR EACH ROW
        --@ 각각의 행.. 여기까지 쓰면 ROW 트리거! ROW 트리거는 이거 있어야함~!
        -->> 타겟은 여기....! 여기를 지워야 하는 것
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE=:OLD.CODE; --@ 시간을 멈춰서 그 시간 기준으로 앞은 :OLD, :NEW라고 생각하기!
                          --@ 삭제되기 이전의 코드!
END;
--==>> Trigger TRG_TEST2_DELETE이(가) 컴파일되었습니다.

--※ 『:OLD』
--  참조 전 열의 값
--  (INSERT : 입력하기 이전 자료, DELETE : 삭제하기 이전 자료, 삭제할 자료)
--@ EX> 내가 INSERT를 하고 싶은데 이거 INSERT 하기 이전에 이전 상태값을 사용해서 뭘 하고 싶음... 하면 :OLD 쓰는 것!

--※ UPDATE → DELETE 그리고 INSERT 가 결합된 형태
--             이 과정에서 UPDATE 하기 이전의 자료는 :OLD
--             이 과정에서 UPDATE 한 후의 자료는 :NEW



--■■■ AFTER ROW TRIGGER 에 대한 상황 실습 ■■■--
--※ 참조 테이블 관련 트랜잭션 처리

-- TBL_상품, TBL_입고, TBL_출고

--○ TBL_입고 테이블의 데이터 입력 시(입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량 변동 트리거 작성(TRG_IBGO)

--◈ 내가 작성한 코드
--@ TRG_IBGO(상품코드, 입고수량) 으로 만들어야하나,,,,,? 이건 트랜잭션이고 만들건 트리거,,,
--@ 트랜잭션과 트리거,,,,,,,
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        UPDATE ON TBL_입고
        FOR EACH ROW
BEGIN
    SELECT 상품코드 INTO V.상품코드
    FROM TBL_입고
    WHERE 입고수량 = 입력된 입고수량;

    --SET 입력된 TBL.입고의 제품코드와 같은 TBL.상품의 재고수량 
    UPDATE TBL_상품
    SET 재고수량 = 입력된 입고수량
    WHERE SELECT 상품코드 = V.상품코드;
END;
*/
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW
        --@ 각각의 행 확인해서 어디에 입고되었는지 확인해야함...
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + 새로입고되는 입고수량
             WHERE 상품코드 = 새로입고되는 상품코드;
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW
        --@ 각각의 행 확인해서 어디에 입고되었는지 확인해야함...
BEGIN
    IF (INSERTING) --@ 여기선 IF문 사용 크게 필요 없는데 나중에 응용해서 사용할때 틀 참고하라고 IF문 사용한 것...
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.


--○ TBL_상품, TBL_입고, TBL_출고 의 관계에서
--   입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_IBGO 트리거를 재구성한다.
--@ UPDATE, DELETE 됐을 때도 트랜잭션할수 있도록....

--○ TBL_상품, TBL_입고, TBL_출고 의 관계에서
--   출고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_CHULGO 트리거를 작성한다.

--------------------------------------------------------------------------------
--@ 팀별구성... AND 과제 형식으로 카페에 올리는 형태
--@ 같이풀거 아님! 그후 팀별 쉐어후 과제 제출

--○1. TBL_상품, TBL_입고, TBL_출고 의 관계에서
--     입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--     TRG_IBGO 트리거를 재구성한다.

-- 내가 작성한 코드
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_입고 OR TBL_출고
        FOR EACH ROW
BEGIN
    --IF (INSERTING) 
    IF (INSERTING)-- ON TBL_입고
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (INSERTING)-- ON TBL_출고
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;  
    END IF;
END;
*/
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_입고
        FOR EACH ROW
BEGIN
    IF (INSERTING) 
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드; --이게틀린거같은데,,,,! 새로운 입고수량의 상품코드?
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;
*/
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.
-- 예외처리...!!

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_입고 --@ 주의!
        FOR EACH ROW
DECLARE
     V_재고수량     TBL_상품.재고수량%TYPE;
     
     USER_DEFINE_ERROR  EXCEPTION;
     
BEGIN
   IF (INSERTING) 
       THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
             
   ELSIF (UPDATING)
          THEN SELECT 재고수량 INTO V_재고수량
                FROM TBL_상품
                WHERE 상품코드 = :NEW.상품코드;
            
            IF (V_재고수량 - :OLD.입고수량 + :NEW.입고수량 <0)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
            UPDATE TBL_상품
            SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
            WHERE 상품코드 = :NEW.상품코드;
            
  ELSIF (DELETING)
         THEN SELECT 재고수량 INTO V_재고수량
                FROM TBL_상품
                WHERE 상품코드 = :OLD.상품코드;
            
            IF (V_재고수량 - :OLD.입고수량 <0)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
            UPDATE TBL_상품
            SET 재고수량 = 재고수량 - :OLD.입고수량
            WHERE 상품코드 = :OLD.상품코드;
            
  END IF;
  
  -- 예외 처리
  EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.



--○ 2. TBL_상품, TBL_입고, TBL_출고 의 관계에서
--      출고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--      TRG_CHULGO 트리거를 작성한다.

CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_출고
        FOR EACH ROW
DECLARE
     V_재고수량     TBL_상품.재고수량%TYPE;
     
     USER_DEFINE_ERROR  EXCEPTION;        
     
BEGIN
    IF (INSERTING) 
        THEN SELECT 재고수량 INTO V_재고수량
             FROM TBL_상품
             WHERE 상품코드 = :NEW.상품코드;
             
        IF V_재고수량 - :NEW.출고수량 < 0
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
    
        UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
             
    ELSIF (UPDATING)
        THEN SELECT 재고수량 INTO V_재고수량
                 FROM TBL_상품
                 WHERE 상품코드 = :NEW.상품코드;
                 
            IF V_재고수량 + :OLD.출고수량 - :NEW.출고수량 < 0
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
           UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
             
    ELSIF (DELETING)
          THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
    
    --INSERT 뉴 DELETE 올드...
    
    -- 예외 처리
    EXCEPTION
     WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
END;
--==>> Trigger TRG_CHULGO이(가) 컴파일되었습니다.

--@ INSERT, UPDATE에 예외 처리...

--@ 트리거에서는 예외처리 할 필요 없음....!! --> 수정판

-- ○ TBL_상품, TBL_입고, TBL_출고의 관계에서
--    입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--    TRG_IBGO 트리거를 재구성한다.

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_입고
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
    
END;

-- ○ TBL_상품, TBL_입고, TBL_출고의 관계에서
--    출고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--    TRG_CHULGO 트리거를 작성한다.

CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_출고
        FOR EACH ROW
BEGIN    
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;

END;

--------------------------------------------------------------------------------

--■■■ PACKAGE(패키지) ■■■--

-- 1. PL/SQL 의 패키지는 관계되는 타입, 프로그램 객체,
--    서브 프로그램(PROCEDURE, FUNCTION 등)을 논리적으로 묶어놓은 것으로
--    오라클에서 제공하는 패키지 중 하나가 바로 『DBMS_OUTPUT』 이다.
--@ 논리적으로 묶음 처리해 놓은 것이 핵심!
--@ 비슷한 기능,목적 등으로 사용되는 애들이야~! 묶어 놓음 EX> UTIL, IO패키지 등등...

-- 2. 패키지는 서로 유사한 업무에 사용되는 여러 개의 프로시저와 함수를
--    하나의 패키지로 만들어 관리함으로써 향후 유지보수가 편리하고
--    전체 프로그램을 모듈화 할 수 있는 장점이 있다.

-- 3. 패키지는 명세부(PACKAGE SPECIFICATION)DHK
--    몸체부(PACKAGE BODY)로 구성되어 있으며,
--    명세 부분에는 TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR,
--    SUBPROGRAM 이 선언되고
--    몸체 부분에는 이들의 실제 내용이 존재하게 된다.
--    그리고 호출할 때에는 『패키지명.프로시저명』 형식의 참조를 이용해야 한다.

-- 4. 형식 및 구조부(명세부)
/*
CREATE [OR REPLACE] PACKAGE 패키지명
IS
    전역변수 선언;
    커서 선언;
    예외 선언;
    함수 선언;
    프로시저 선언;
        :
END 패키지명;
*/
--@ 패키지 안에 이런게 있구나..어떤걸로 구성되어 있구나.. 알게 해주는 역할
--@ 4,5번은 같은 내용이 들어 있어야 함!

-- 5. 형식 및 구조(몸체부)
/*
CREATE [OR REPLACE] PACKAGE BODY 패키지명
IS
    FUNCTION 함수명[(인수, ...)]
    RETURN 자료형
    IS
        변수 선언;
    BEGIN
        함수 몸체 구성 코드;
        RETURN 값;
    END;
    
    PROCEDURE 프로시저명[(인수, ...)]
    IS
        변수 선언;
    BEGIN
        프로시저 몸체 구성 코드;
    END;

END 패키지명;
*/


--○ 주민번호 입력 시 성별을 반환하는 함수
--   이 함수를 구성요소로 하는 패키지 작성

--@ 이 함수자체가 에러 있으면 안 됨! 에러있는 함수가지고 패키지 만들 수 없음
-- 함수 준비
CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)
RETURN VARCHAR2
IS
    V_RESULT VARCHAR2(20);
BEGIN
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '남자';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '여자';
    ELSE
        V_RESULT := '확인불가';
    END IF;
    
    RETURN V_RESULT;
    --@ 이렇게 만들어진 함수는 V_RESULT로 반환한다.
    
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


-- 패키지 등록
-- 1. 명세부 작성
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK; --@ 맨위, 아래 패키지명은 정확히 같아야 함
--==>> Package INSA_PACK이(가) 컴파일되었습니다.


-- 2. 몸체부 작성
CREATE OR REPLACE PACKAGE BODY INSA_PACK --@ 요기에 바디 추가!
IS
    -- 위 함수준비에서 복붙... CREATE OR REPLACE 만 삭제
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
            THEN V_RESULT := '남자';
        ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
            THEN V_RESULT := '여자';
        ELSE
            V_RESULT := '확인불가';
        END IF;
        
        RETURN V_RESULT;
        --@ 이렇게 만들어진 함수는 V_RESULT로 반환한다.
    
    END;

END INSA_PACK;
--==>> Package Body INSA_PACK이(가) 컴파일되었습니다.

-- 오라클 끝!





