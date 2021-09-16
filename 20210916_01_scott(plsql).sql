SELECT USER
FROM DUAL;
--==>> SCOTT


--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--  NUM NAME SSN IBSADATE CITY TEL BUSEO JIKWI BASICPAY SUDANG 
--  구조를 갖고 있는 대상 테이블에 데이터 입력 시
--  NUM 컬럼(사원번호)의 값은
--  기존 부여된 사원번호 마지막 번호의 그 다음 번호를 자동으로
--  입력 처리할 수 있는 프로시저로 구성한다.
--  프로시저명 : PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO ,JIKWI, BASICPAY, SUDANG);

/*
실행 예)
EXEC PRC_INSA_INSERT('이다영', '951027-2234567', SYSDATE, '서울', '010-4113-2353', '영업부', '대리', 10000000, 2000000); -- 천만, 이백만

프로시저 호출로 처리된 결과)
1061 이다영 951027-2234567 SYSDATE 서울 010-4113-2353 영업부 대리 10000000, 2000000
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    -- INSERT 쿼리문 수행에 필요한 변수 추가 선언
    V_NUM   TBL_INSA.NUM%TYPE;
BEGIN
    -- 선언한 변수에 값 담아내기
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;

    -- INSERT 쿼리문 구성
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    --COMMIT
    COMMIT;
    
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.



--------------------------------------------------------------------------------

--○ TBL_상품, TBL_입고 테이블을 대상으로...
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진
--   프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 안함)
--   TBL_입고 테이블 구성 컬럼
--   → 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

-- HINT!
-- 재고수량 상품테이블로부터 조회해서 몇개인지 변수에 담기...
-- 입고수량을 재고수량에 더하고 이걸 상품테이블에 UPDATE 하고
-- 입고수량은 INSERT 해야함

--◈ 내가 작성한 코드
/*
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드  IN TBL_입고.상품코드%TYPE
, V_입고수량  IN TBL_입고.입고수량%TYPE
, V_입고단가  IN TBL_입고.입고단가%TYPE
);
IS
    -- CHANGE 쿼리문 수행에 필요한 변수 추가 선언
    V_입고번호      TBL_입고.입고번호%TYPE; -- := 0 
    V_현재재고수량  TBL_상품.재고수량%TYPE;

BEGIN

    -- 선언한 변수에 값 담아내기
    -- 입고번호에,, 들어간값이 현재 없으니까 MAX안댐....?
    SELECT MAX(입고번호)+1 INTO V_입고번호
    FROM TBL_입고;
    
    SELECT 재고수량 INTO V_현재재고수량;
    FROM TBL_상품;
    
    -- TBL_입고 입고번호, 입고수량 변경 --> 변경이아니라 INSERT 해야함!
    -- UPDATE TBL_입고
    -- SET 입고번호 = V_입고번호, 입고수량 = V_입고수량
    -- WHERE 상품코드 = V_상품코드;
    
    -- TBL_입고 입고번호, 입고수량 입력
    --   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
    VALUES(V_입고번호, V_상품코드, SYSDATE, V_입고수량, V_입고단가);
    
    -- TBL_상품 재고수량 변경
    -- HINT!
    -- 재고수량 상품테이블로부터 조회해서 몇개인지 변수에 담기...
    -- 입고수량을 재고수량에 더하고 이걸 상품테이블에 UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 현재재고수량 + V_재고수량
    WHERE 상품코드 = V_상품코드;
    
    -- COMMIT
    COMMIT;
END;
*/

--※ TBL_입고 테이블에 입고 이벤트 발생 시...
--   관련 테이블에서 수행되어야 하는 내용
--   0. SELECT → TBL_입고
--      SELECT NVL(MAX(입고번호), 0)
--      FROM TBL_입고;
--   1. INSERT → TBL_입고
--      INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
--      VALUES(1, 'C001', SYSDATE, 30, 1000);
--   2. UPDATE → TBL_상품
--      UPDATE TBL_상품
--      SET 재고수량 = 기존재고수량 + 30(← 입고수량)
--      WHERE 상품코드='C001';

--@ 1,2번 작성한후 0번 작성.... 의식의 흐름대로!

--@ 위의 요구된 프로시저 내용 복붙해서 사용! 
--@ 프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( 상품코드
, 입고수량
, 입고단가
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드    IN TBL_상품.상품코드%TYPE
, V_입고수량    IN TBL_입고.입고수량%TYPE
, V_입고단가    IN TBL_입고.입고단가%TYPE
)
IS
    -- 아래의 쿼리문을 수행하기 위해 필요한 데이터 변수로 선언
    V_입고번호  TBL_입고.입고번호%TYPE;
BEGIN
    -- 선언한 변수에 값 담아내기
    --@ 현재 입고번호에 입력값 없는 상태! NULL 상태... NVL로 NULL이면 1로 설정하게 실행!
    SELECT NVL(MAX(입고번호), 0) INTO V_입고번호
    FROM TBL_입고;
    
    -- 수행되어야 하는 쿼리문 구성
    -- 1. INSERT → TBL_구성
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES((V_입고번호+1), V_상품코드, V_입고수량, V_입고단가);
    --@ 요기 +1 빼먹었었음!
    
    -- 2. UPDATE → TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
        
END;

--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

--@ UPDATE INSERT 두 개 같이 들어있음... 이거 되게 위험한 구문임!
--@ EX) 은행계좌... 찬호가 장보러 가야하는데 돈이 없음. 옆에 있는 미화에게 돈 빌리기로 함
--@ 미화: 우리은행/100만원      | 찬호: 국민은행/10만원 가지고 있음

--@         30만원감소                 30만원 증가
--@          UPDATE                     UPDATE (둘다 DML구문)
--@    이거실행하는순간 전산장애...       이거 잘 안이루어짐
--@    그러면 싸움남 ㅠ_ㅠ 
--@    미화 "나는 돈 빌려줬어!" / 찬호 "난 돈 안 들어왔어 거짓말하지마!"
--@   (LIKE 통신사 할인받아서 통신사는 500이 차감됐지만 실제 가격에는 안 적용되는것..
--@    선생님 이런 적 있으시다고!!! 원래 일케되면 안되는것...ㅋㅋ
--@  --> 원래 이거 두개 묶어서 하나만 되면 하나 롤백하게 만들음!(트랜젝션 처리) 롤백 되어야 함!)
--@  이게 자주 일어나는 일인가? NO......! 한번도 본적 없음!
--@  --> 이를 위해 예외 처리 함...!
--@ 트랜젝션 컨트롤 랭귀지.....  TCL

--@ 찬호가 미화에게 30만원 빌리기로 함... 계좌이체... 



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
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언(@ 예외처리하려면 변수처럼 선언해야함!)
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성
    IF (V_CITY NOT IN ('서울', '인천', '경기'))
        -- 예외 발생
        -- THEN USER_DEFINE_ERROR 를 발생시키겠다.
        THEN RAISE USER_DEFINE_ERROR;
        --@ LIKE JAVA에서 쓰로우!
    END IF;
    --@ IF 시작했다 IF 끝났다!

    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM), 0) INTO V_NUM    
    FROM TBL_MEMBER;

    -- 쿼리문 구성
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- 커밋
    COMMIT;

    -- 예외 처리 구문
    EXCEPTION  
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울,인천,경기만 입력이 가능합니다.');
            --@ 에러창 띄워주는 구문. (에러번호, 에러 메시지) --@ 2만번까지 오라클 기본 에러 존재
            --@ 사용자 정의 번호는 일반적으로 2만 1번부터 쓰면 됨
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.



--------------------------------------------------------------------------------

--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 변동되는 프로시저를 작성한다.
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가.
--   또한, 출고수량이 재고수량보다 많은 경우...
--   출고 액션을 취소할 수 있도록 처리한다. (출고가 이루어지지 않도록...)
--   프로시저 명 : PRC_출고_INSERT(상품코드, 출고수량, 출고단가)

--◈ 내가 작성한 코드
-- 데이터 입력 시 처리되어야 하는 내용
-- 0. 출고번호는 자동 증가
-- 1. TBL_출고 테이블에 데이터 입력(상품코드, 출고수량, 출고단가)
-- 2. TBL_상품 테이블의 재고수량이 변동
-- 3. 출고 수량이 재고수량보다 많은 경우 출고 액션을 취소할 수 있도록...(롤백..예외 처리!)
--    - 앞에 IF 구문 사용해야 함!
/*
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드      IN TBL_출고.상품코드%TYPE
, V_출고수량      IN TBL_출고.출고수량%TYPE
, V_출고단가      IN TBL_출고.출고단가%TYPE
)
IS
    V_출고번호 TBL_출고.출고번호%TYPE;
    --재고수량 받아와야 할 듯?
    S_재고수량 TBL_상품.재고수량%TYPE;

    -- 사용자 정의 예외에 대한 변수 선언
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성
    
    S_재고수량 := (SELECT 재고수량
                   FROM TBL_상품
                   WHERE 상품코드 = V_상품코드);
    
    IF (V_출고수량 > S_재고수량)
    --IF (V_출고수량 > (SELECT 재고수량
    --                  FROM TBL_수량
    --                  WHERE 제품코드 = V_제품코드)) --> 에러..서브쿼리 안 된다?
        -- 예외 발생
        -- THEN USER_DEFINE_ERROR 를 발생시키겠다.
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    --@ IF 시작했다 IF 끝났다!
    
    -- 선언한 변수에 값 담아내기
    -- 0. 출고번호는 자동 증가
    SELECT NVL(MAX(출고번호)+1,0) INTO V_출고번호
    FROM TBL_출고;
    
    -- 1. TBL_출고 테이블에 데이터 입력(상품코드, 출고수량, 출고단가)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가) -- 출고일자는 디폴트가 SYSDATE니까 생략
    VALUES (V_출고번호, V_상품코드, V_출고수량, V_출고단가);
    
    -- 2. TBL_상품 테이블의 재고수량이 변동
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    -- COMMIT;
    
    -- 3. 출고 수량이 재고수량보다 많은 경우 출고 액션을 취소할 수 있도록...(롤백..예외 처리!)
    -- 예외 처리 구문
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '출고수량이 재고수량보다 많습니다.');
        ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
END;
*/


CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드      IN TBL_상품.상품코드%TYPE
, V_출고수량      IN TBL_출고.출고수량%TYPE
, V_출고단가      IN TBL_출고.출고단가%TYPE
)
IS
    -- 주요 변수 선언
    V_출고번호  TBL_출고.출고번호%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;      -- 사용자 정의 예외
    
BEGIN
    
    -- 쿼리문 수행 이전에 수행 가능 여부 확인 → 기존 재고 확인 → 출고수량과 비교
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 출고를 정상적으로 진행해 줄 것인지 아닌지에 대한 여부 확인
    -- (즉, 출고하려는 수량이 파악한 재고수량보다 많으면... 예외 발생)
    IF (V_출고수량 > V_재고수량)
        -- 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(출고번호), 0) INTO V_출고번호
    FROM TBL_출고;
    
    -- 쿼리문 구성(INSERT → TBL_출고)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가) --@ 출고일자는 생략하면 SYSDATE로!
    VALUES((V_출고번호+1), V_상품코드, V_출고수량, V_출고단가);
    
    -- 쿼리문 구성(UPDATE → TBL_출고)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --커밋
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR --@ 이 에러라면 아래 메시지와 롤백
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
                 ROLLBACK;
        WHEN OTHERS --@ 이외의 다른 에러라면 걍 롤백만!
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.


--○ TBL_출고 테이블에서 출고 수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE(출고번호, 변경할출고수량);

--@@@@@@@
-- 원래 홈런볼 100개
--                                     출고 테이블에 홈런볼 70개 출고
-- 현재 홈런볼 30개



-- 원래 홈런볼 100개
--                                   ▶ 출고 테이블에 2 홈런볼 70개 출고
-- 현재 홈런볼 30개


--PRC_출고_UPDATE(출고번호, 변경할출고수량);
--PRC_출고_UPDATE(2, 40);  --> 아 이게 홈런볼이구나...먼저 얻어내야함

--PRC_출고_UPDATE(2, 40) 으로 업데이트하려면.. 남은 홈런볼은 60개
--(30+70 - 60) 필요! 다시 70개 담아서 100개 만든 다음에 다시 40개 꺼내야 함...그래서 60개

-- PRC_출고_UPDATE(2, 110) 으로 업데이트하려면..
-- 다시 70개 담아서 100개 만든 다음 100개와 비교해서 가능 불가능 따짐
--@@@@@@


--◈ 내가 작성한 코드
-- 데이터 입력 시 처리되어야 하는 내용

-- 0. 출고시 재고수량보다 새로 입력한 출고수량이 많다면 예외처리
-- 0-1) TBL_상품 테이블 재고수량 + TBL_출고 테이블 출고수량 < 새로 입력한 V_출고수량
--      라면 실행 불가, 롤백, 에러 메세지 표시

-- 1. TBL_출고 테이블에서 출고수량 수정 (UPDATE)
-- 1-1) 입력받은 출고 번호에서 이게 홈런볼이구나.. 얻어 내야 함

-- 2. TBL_상품 테이블에서 재고수량 수정 (UPDATE)
-- 1-1) TBL_상품 테이블 재고수량 = (TBL_상품 테이블 재고수량 + TBL_출고 테이블 출고수량) - (새로 입력한 V_출고수량)
/*
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호          IN TBL_출고.출고번호%TYPE
, V_변경할출고수량    IN TBL_출고.출고수량%TYPE
)--;
IS
    -- 주요 변수 선언
    V_변경전출고수량 TBL_출고.출고수량%TYPE;
    V_상품코드       TBL_상품.상품코드%TYPE;
    V_재고수량       TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN

    --V_변경전출고수량
    SELECT 출고수량 INTO V_변경전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --V_상품코드
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    --V_재고수량
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    -- 0. 출고시 재고수량보다 새로 입력한 출고수량이 많다면 예외처리
    -- 0-1) TBL_상품 테이블 재고수량 + TBL_출고 테이블 출고수량 < 새로 입력한 V_출고수량
    --      라면 실행 불가, 롤백, 에러 메세지 표시
    IF (V_재고수량 + V_변경전출고수량 < V_변경할출고수량)
        -- 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 1. TBL_출고 테이블에서 출고수량 수정 (UPDATE)
    -- 쿼리문 구성(UPDATE → TBL_출고)
    UPDATE TBL_출고
    SET 출고수량 = V_변경할출고수량
    WHERE 출고번호 = V_출고번호;
    
    -- 2. TBL_상품 테이블에서 재고수량 수정 (UPDATE)
    -- 쿼리문 구성(UPDATE → TBL_상품)
    --UPDATE TBL_상품
    --SET 재고수량 = 재고수량 + 'TBL_출고의 출고수량' - V_출고수량
    --WHERE 상품코드 = 'V_변경할 출고수량의 상품코드';
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_변경전출고수량 - V_변경할출고수량
    WHERE 상품코드 = V_상품코드;
    
    --커밋
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
    --① 매개변수 구성
    V_출고번호    IN TBL_출고.출고번호%TYPE
,   V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    --③ 주요 변수 추가 선언
    V_상품코드 TBL_상품.상품코드%TYPE;
    
    --⑤ 주요 변수 추가 선언
    V_이전출고수량 TBL_출고.출고수량%TYPE;
    
    --⑦ 주요 변수 추가 선언
    V_재고수량 TBL_상품.재고수량%TYPE;
    
    --⑨ 주요 변수(사용자 정의 예외) 추가 선언
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN

    --④ 상품코드와 이전출고수량 파악을 위해 변경 이전의 출고 내역 확인
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량 --@ 구성 순서가 중요!
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;


    --@ 이 사이! 여야 출고를 정상적으로 시켜줄지 아닐지 판단할수 있음(위 ④에서 변수들 받아와야 하기 때문)
    
    --⑥ 출고를 정상적으로 수행해야 할지 말지의 여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인 → 현재 출고 수량과 비교
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑧ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --   (『재고수량 + 이전출고수량 < 현재출고수량』 인 상황이라면... 사용자 정의 예외 발생)
    --@ 위치 계속 신경 쓰기!
    IF((V_재고수량 + V_이전출고수량) < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    --@ IT 시작했다 IT 끝났다!

    --② 수행해야 할 쿼리문 구성(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;

    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑩ 커밋
    COMMIT;
    
    --⑪ 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
            --@ 원인이 같은 에러는 같게 구성하는게 좋음! 팀플할때도 팀원들이 다 같이 동일하게 하는게 좋음 ㅇㅇ
            --@ 숫자뒤 문자는 다르게 써도 문법적 문제는 없음. 사용자가 보기엔 좀 안좋긴 함... 
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --@ 예외처리 EXCEPTION은 가장 마지막에 해야 함! JAVA처럼 블레이스가 없기 때문에...
    --@ 어디까지가 EXCEPTION인지 모름! 
    --@ BEGIN~EXCEPTION까지가 실행부 / EXCEPTION~END 사이가 예외처리 부분! 이렇게 이해하기!!!!!
    --@ 이렇게이해하면 나중에 약간 헷깔릴수있는 부분 있지만(AND?)..일단 일케 이해하는게 좋음!
    
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.








