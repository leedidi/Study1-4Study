--※ 교수 비밀번호 DEFAULT 트리거
CREATE OR REPLACE TRIGGER TRG_PRO_PW
          BEFORE INSERT ON PROFESSOR
          FOR EACH ROW
BEGIN
    :NEW.PRO_PW := :NEW.PRO_LASTSSN;
END;


--※ 학생 비밀번호 DEFAULT 트리거
CREATE OR REPLACE TRIGGER TRG_STU_PW
          BEFORE INSERT ON STUDENT
          FOR EACH ROW
BEGIN
    :NEW.STU_PW := :NEW.STU_LASTSSN;
END;

/*
성적 정보 입력 프로시저 (성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리)
성적 정보 수정 프로시저
성적 정보 삭제 프로시저

- 그리고 에러 20004...이후 추가해야 할거 생기면 카톡방에 보내기

-- 성적 테이블
INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
VALUES();
*/

-- 예시

-- 교수자 계정 생성 프로시저
CREATE OR REPLACE PROCEDURE PRC_PRO_INSERT
( V_ID          IN PROFESSOR.PRO_ID%TYPE
, V_NAME        IN PROFESSOR.PRO_NAME%TYPE
, V_FIRSTSSN    IN PROFESSOR.PRO_FIRSTSSN%TYPE
, V_LASTSSN     IN PROFESSOR.PRO_LASTSSN%TYPE
)
IS
    TEMP_NUM NUMBER;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    SELECT COUNT(*) INTO TEMP_NUM
    FROM PROFESSOR
    WHERE PRO_FIRSTSSN = V_FIRSTSSN
      AND PRO_LASTSSN = V_LASTSSN;

    IF (TEMP_NUM != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    INSERT INTO PROFESSOR(PRO_ID, PRO_NAME, PRO_FIRSTSSN, PRO_LASTSSN)
    VALUES(V_ID, V_NAME, V_FIRSTSSN, V_LASTSSN);
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '동일한 교수자가 존재합니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
END;

-- STRAT...★

INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
VALUES('A001', 'A001', 'A001', 80, 90, 90);

-- 수강신청번호와 과목개설번호가 해당 테이블들에 입력되어 있어야 입력할수 있도록 처리해야하나...?
-- 성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리
-- 배정된 과목 중에서 강의 진행이 되지 않은 과목은 성적 처리 화면으로 전환되지 않아야 한다. 

/*
-- 1. 성적 정보 입력 프로시저 (성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리)
-- 1개만 예외처리..
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
, V_REG_NO        IN SCORE.REG_NO%TYPE
, V_LIST_NO       IN SCORE.LIST_NO%TYPE
, V_ATTEND_SCORE  IN SCORE.ATTEND_SCORE%TYPE
, V_PRAC_SCORE    IN SCORE.PRAC_SCORE%TYPE
, V_WRITE_SCORE   IN SCORE.WRITE_SCORE%TYPE
)
IS
    V_SUB_STARTDATE     SUB_LIST.SUB_STARTDATE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    SELECT SUB_STARTDATE INTO V_SUB_STARTDATE
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    IF (V_SUB_STARTDATE > SYSDATE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
    VALUES(V_SCORE_NO, V_REG_NO, V_LIST_NO, V_ATTEND_SCORE, V_PRAC_SCORE, V_WRITE_SCORE);
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009, '강의가 진행되지 않은 과목입니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
END;
--==>> Procedure PRC_SCORE_INSERT이(가) 컴파일되었습니다.
*/
/*
DROP PROCEDURE SCORE_INSERT;
--==>> Procedure SCORE_INSERT이(가) 삭제되었습니다.

DROP PROCEDURE SCORE_PRO_INSERT;
--==>> Procedure SCORE_PRO_INSERT이(가) 삭제되었습니다.

DROP PROCEDURE SCORE_PRO_UPDATE;
--==>> Procedure SCORE_PRO_UPDATE이(가) 삭제되었습니다.

DROP PROCEDURE SCORE_PRO_DELETE;
--==>> Procedure SCORE_PRO_DELETE이(가) 삭제되었습니다.
*/


-- 1. 성적 정보 입력 프로시저 (성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리)
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
, V_REG_NO        IN SCORE.REG_NO%TYPE
, V_LIST_NO       IN SCORE.LIST_NO%TYPE
, V_ATTEND_SCORE  IN SCORE.ATTEND_SCORE%TYPE
, V_PRAC_SCORE    IN SCORE.PRAC_SCORE%TYPE
, V_WRITE_SCORE   IN SCORE.WRITE_SCORE%TYPE
)
IS
    V_SUB_STARTDATE      SUB_LIST.SUB_STARTDATE%TYPE;
    TEMP_NUM             NUMBER;
    USER_DEFINE_ERROR1   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
BEGIN

    -- 성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리
    SELECT SUB_STARTDATE INTO V_SUB_STARTDATE
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    IF (V_SUB_STARTDATE > SYSDATE)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- 성적 입력시 해당 성적(성적번호)이 성적 테이블에 이미 존재하면 예외처리
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;

    IF (TEMP_NUM != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
    VALUES(V_SCORE_NO, V_REG_NO, V_LIST_NO, V_ATTEND_SCORE, V_PRAC_SCORE, V_WRITE_SCORE);
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20009, '강의가 진행되지 않은 과목입니다.');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20015, '입력한 성적이 이미 존재합니다.');
            -- '입력한 과목의 성적이 이미 존재합니다.'...? 
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_INSERT이(가) 컴파일되었습니다.



-- 성적번호만 받아오기,,,? 성적번호, 수강신청번호, 과목개설번호 등등 다받아오기...?
-- 일단 성적 번호만 받아와도 될 거 같음!
-- 성적 입력 전용 화면에서 자신의 강의를 수강한 학생들의 이름은 자동으로 입력되어 있고, 
-- 교수자는 학생 개개인의 성적만 입력하도록 한다. 
-- 해당 성적번호가 존재하지 않으면 존재하지 않는 성적입니다.../ 각각의 점수가 0~100이 안됩니다...
-- 후자가 나을거 같음!
-- 근데 하나씩 나눠야 하나.... ?? 출결실기필기 하나씩? 아님 합쳐서,,,?

/*
-- 2. 성적 정보 수정 프로시저
-- 1개만 예외처리..
CREATE OR REPLACE PROCEDURE PRC_SCORE_UPDATE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
, V_ATTEND_SCORE  IN SCORE.ATTEND_SCORE%TYPE
, V_PRAC_SCORE    IN SCORE.PRAC_SCORE%TYPE
, V_WRITE_SCORE   IN SCORE.WRITE_SCORE%TYPE
)
IS
    USER_DEFINE_ERROR EXCEPTION;
BEGIN

    IF ( (V_ATTEND_SCORE NOT BETWEEN 0 AND 100) OR (V_PRAC_SCORE NOT BETWEEN 0 AND 100)
         OR (V_WRITE_SCORE NOT BETWEEN 0 AND 100) )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE SCORE
    SET ATTEND_SCORE = V_ATTEND_SCORE, PRAC_SCORE = V_PRAC_SCORE, WRITE_SCORE = V_WRITE_SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20010, '점수는 [0 - 100]점 범위 내에서 입력 가능합니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;        

END;
--==>> Procedure PRC_SCORE_UPDATE이(가) 컴파일되었습니다.
*/

-- 2. 성적 정보 수정 프로시저
CREATE OR REPLACE PROCEDURE PRC_SCORE_UPDATE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
, V_ATTEND_SCORE  IN SCORE.ATTEND_SCORE%TYPE
, V_PRAC_SCORE    IN SCORE.PRAC_SCORE%TYPE
, V_WRITE_SCORE   IN SCORE.WRITE_SCORE%TYPE
)
IS
    TEMP_SCORE_NO        SCORE.SCORE_NO%TYPE;
    USER_DEFINE_ERROR1   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
BEGIN
    
    -- 성적 입력시 각 성적 점수가 [0-100]점을 벗어나면 예외처리
    IF ( (V_ATTEND_SCORE NOT BETWEEN 0 AND 100) OR (V_PRAC_SCORE NOT BETWEEN 0 AND 100)
         OR (V_WRITE_SCORE NOT BETWEEN 0 AND 100) )
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- 성적 입력시 해당 성적(성적번호)이 성적 테이블에 존재하지 않으면 예외처리
    SELECT SCORE_NO INTO TEMP_SCORE_NO
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    IF (V_SCORE_NO != TEMP_SCORE_NO)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    UPDATE SCORE
    SET ATTEND_SCORE = V_ATTEND_SCORE, PRAC_SCORE = V_PRAC_SCORE, WRITE_SCORE = V_WRITE_SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20010, '점수는 [0 - 100]점 범위 내에서 입력 가능합니다.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20011, '입력한 성적이 존재하지 않습니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;        

END;
--==>> Procedure PRC_SCORE_UPDATE이(가) 컴파일되었습니다.

-- 3. 성적 정보 삭제 프로시저

CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
)
IS
    TEMP_SCORE_NO       SCORE.SCORE_NO%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    -- 성적 입력시 해당 성적(성적번호)이 성적 테이블에 존재하지 않으면 예외처리
    SELECT SCORE_NO INTO TEMP_SCORE_NO
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    IF (V_SCORE_NO != TEMP_SCORE_NO)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DELETE
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20011, '입력한 성적이 존재하지 않습니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_SCORE_DELETE이(가) 컴파일되었습니다.

-- 출력 에러 구문들
RAISE_APPLICATION_ERROR(-20009, '강의가 진행되지 않은 과목입니다.');
RAISE_APPLICATION_ERROR(-20010, '점수는 [0 - 100]점 범위 내에서 입력 가능합니다.');
RAISE_APPLICATION_ERROR(-20011, '입력한 성적이 존재하지 않습니다.');

RAISE_APPLICATION_ERROR(-20015, '입력한 성적이 이미 존재합니다.');









---★ 최종본


-- 1. 성적 정보 입력 프로시저 (성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리)
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
, V_REG_NO        IN SCORE.REG_NO%TYPE
, V_LIST_NO       IN SCORE.LIST_NO%TYPE
, V_ATTEND_SCORE  IN SCORE.ATTEND_SCORE%TYPE
, V_PRAC_SCORE    IN SCORE.PRAC_SCORE%TYPE
, V_WRITE_SCORE   IN SCORE.WRITE_SCORE%TYPE
)
IS
    TEMP_NUM             NUMBER;
    V_SUB_STARTDATE      SUB_LIST.SUB_STARTDATE%TYPE;
    USER_DEFINE_ERROR1   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
BEGIN
    
    -- 성적 입력시 해당 성적(성적번호)이 성적 테이블에 이미 존재하면 예외처리
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;

    IF (TEMP_NUM != 0)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- 성적 입력시 과목개설일이 SYSDATE 보다 미래면 예외처리
    SELECT SUB_STARTDATE INTO V_SUB_STARTDATE
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    IF (V_SUB_STARTDATE > SYSDATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
    VALUES(V_SCORE_NO, V_REG_NO, V_LIST_NO, V_ATTEND_SCORE, V_PRAC_SCORE, V_WRITE_SCORE);
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20015, '입력한 성적이 이미 존재합니다.');
            -- '입력한 과목의 성적이 이미 존재합니다.'...? 
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20009, '강의가 진행되지 않은 과목입니다.');
                ROLLBACK;        
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_INSERT이(가) 컴파일되었습니다.


-- 2. 성적 정보 수정 프로시저
CREATE OR REPLACE PROCEDURE PRC_SCORE_UPDATE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
, V_ATTEND_SCORE  IN SCORE.ATTEND_SCORE%TYPE
, V_PRAC_SCORE    IN SCORE.PRAC_SCORE%TYPE
, V_WRITE_SCORE   IN SCORE.WRITE_SCORE%TYPE
)
IS
    TEMP_NUM             NUMBER;
    USER_DEFINE_ERROR1   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
BEGIN

    -- 성적 입력시 해당 성적(성적번호)이 성적 테이블에 존재하지 않으면 예외처리
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;

    IF (TEMP_NUM = 0)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- 성적 입력시 각 성적 점수가 [0-100]점을 벗어나면 예외처리
    IF ( (V_ATTEND_SCORE NOT BETWEEN 0 AND 100) OR (V_PRAC_SCORE NOT BETWEEN 0 AND 100)
         OR (V_WRITE_SCORE NOT BETWEEN 0 AND 100) )
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    UPDATE SCORE
    SET ATTEND_SCORE = V_ATTEND_SCORE, PRAC_SCORE = V_PRAC_SCORE, WRITE_SCORE = V_WRITE_SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20011, '입력한 성적이 존재하지 않습니다.');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20010, '점수는 [0 - 100]점 범위 내에서 입력 가능합니다.');
                ROLLBACK;        
        WHEN OTHERS
            THEN ROLLBACK;        

END;
--==>> Procedure PRC_SCORE_UPDATE이(가) 컴파일되었습니다.


-- 3. 성적 정보 삭제 프로시저

CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
)
IS
    TEMP_NUM            NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    -- 성적 삭제시 해당 성적(성적번호)이 성적 테이블에 존재하지 않으면 예외처리
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;

    IF (TEMP_NUM = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DELETE
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20011, '입력한 성적이 존재하지 않습니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_SCORE_DELETE이(가) 컴파일되었습니다.

-- 출력 에러 구문들
RAISE_APPLICATION_ERROR(-20009, '강의가 진행되지 않은 과목입니다.');
RAISE_APPLICATION_ERROR(-20010, '점수는 [0 - 100]점 범위 내에서 입력 가능합니다.');
RAISE_APPLICATION_ERROR(-20011, '입력한 성적이 존재하지 않습니다.');
RAISE_APPLICATION_ERROR(-20015, '입력한 성적이 이미 존재합니다.');

--예시)
--○ 과정 정보 입력 프로시저
CREATE OR REPLACE PROCEDURE PRC_CUR_INSERT
( V_CUR_NAME        IN CURRICULUM.CUR_NAME%TYPE
, V_CUR_STARTDATE   IN CURRICULUM.CUR_STARTDATE%TYPE
, V_CUR_ENDDATE      IN CURRICULUM.CUR_ENDDATE%TYPE
, V_ROOM_NO         IN CURRICULUM.ROOM_NO%TYPE
)
IS
    V_CUR_NO    CURRICULUM.CUR_NO%TYPE;
    
    TEMP_RNUM    NUMBER; --입력한 강의실이 존재하는지 확인을 위한 임시변수
    TEMP_NNUM    NUMBER; --입력한 과정명이 중복인지 확인을 위한 임시변수
    
    STARTDATE_ERROR   EXCEPTION; --시작일>끝일일때 발생하는 에러
    ROOM_ERROR   EXCEPTION; --입력한 강의실이 존재하지 않을 경우 발생하는 에러
    NAME_ERROR   EXCEPTION; --입력한 과정명이 중복일 경우 발생하는 에러
BEGIN
    --시작일을 끝일보다 미래로 입력할 경우 에러 발생
    IF (V_CUR_STARTDATE>V_CUR_ENDDATE)
        THEN RAISE STARTDATE_ERROR;
    END IF;
    
    --입력한 강의실이 존재하지 않을 경우 에러 발생
    SELECT COUNT(*) INTO TEMP_RNUM
    FROM ROOM
    WHERE ROOM_NO=V_ROOM_NO;
    
    IF (TEMP_RNUM=0)
        THEN RAISE ROOM_ERROR;
    END IF;
    
    --과정명(UNIQUE)은 중복되면 안됨
    SELECT COUNT(*) INTO TEMP_NNUM
    FROM CURRICULUM
    WHERE CUR_NAME=V_CUR_NAME;
    
    IF (TEMP_NNUM!=0)
        THEN RAISE NAME_ERROR;
    END IF;
    
    --과정번호 생성(CUR-1, CUR-2, ..., CUR-999 의 형태)
    V_CUR_NO := ('CUR-' || TO_CHAR(SEQ_CURRICULUM.NEXTVAL));
    
    --INSERT 쿼리문 작성
    INSERT INTO CURRICULUM(CUR_NO, CUR_NAME, CUR_STARTDATE, CUR_ENDDATE, ROOM_NO)
    VALUES(V_CUR_NO, V_CUR_NAME, V_CUR_STARTDATE, V_CUR_ENDDATE, V_ROOM_NO);
    
    COMMIT;
    
    -- 예외처리
    EXCEPTION
        WHEN STARTDATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '시작일은 종료일 이전 날짜로 설정해야 합니다.');
        WHEN ROOM_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007, '입력한 강의실이 존재하지 않습니다.');
        WHEN NAME_ERROR
            THEN RAISE_APPLICATION_ERROR(-20012, '입력한 과정명이 이미 존재합니다.');
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==> Procedure PRC_CUR_INSERT이(가) 컴파일되었습니다.










-- 시퀀스 만들기 완료
-- 시퀀스 입력구문에 넣기

--과정번호 생성(CUR-1, CUR-2, ..., CUR-999 의 형태)
    V_CUR_NO := ('CUR-' || TO_CHAR(SEQ_CURRICULUM.NEXTVAL));




-- ★ 지금 만든 부분

-- <<SUB_LIST>> 과목개설 테이블

-- 1) 과목개설 입력 프로시저 
CREATE OR REPLACE PROCEDURE PRC_SLI_INSERT
( V_LIST_NO           IN SUB_LIST.LIST_NO%TYPE
, V_CUR_NO            IN SUB_LIST.CUR_NO%TYPE
, V_SUB_NO            IN SUB_LIST.SUB_NO%TYPE
, V_SUB_STARTDATE     IN SUB_LIST.SUB_STARTDATE%TYPE
, V_SUB_ENDDATE       IN SUB_LIST.SUB_ENDDATE%TYPE
, V_PRO_ID            IN SUB_LIST.PRO_ID%TYPE
, V_ATTEND_DIV        IN SUB_LIST.ATTEND_DIV%TYPE
, V_PRAC_DIV          IN SUB_LIST.PRAC_DIV%TYPE
, V_WRITE_DIV         IN SUB_LIST.WRITE_DIV%TYPE
)
IS
    V_SLI_NO        SUB_LIST.LIST_NO%TYPE;  -- 시퀀스 설정에 필요한 변수
    TEMP_NUM        NUMBER;                 -- 과목번호 존재여부 확인에 필요한 변수
    
    DATE_ERROR      EXCEPTION; -- 1. 과목번호가 이미 존재할 때 발생하는 에러
    SUB_NO_ERROR    EXCEPTION; -- 2. 과목 시작일이 과목 종료일보다 미래일 때 발생하는 에러
    DIV_ERROR       EXCEPTION; -- 3. 출결, 실기, 필기 배점이 각각 0보다 작을 때 발생하는 에러
    DIV_SUM_ERROR   EXCEPTION; -- 4. 출결, 실기, 필기 배점을 합치면 100이 되지 않을 때 발생하는 에러
    
BEGIN
    -- 1. 과목번호가 이미 존재할 때 에러 발생
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SUB_LIST
    WHERE SUB_NO = V_SUB_NO;
    
    IF (TEMP_NUM != 0)
        THEN RAISE SUB_NO_ERROR;
    END IF;
    
    -- 2. 과목 시작일 > 과목 종료일일 때 에러 발생
    IF (V_SUB_STARTDATE > V_SUB_ENDDATE)
        THEN RAISE DATE_ERROR;
    END IF;

    -- 3. 출결, 실기, 필기 배점이 각각 0보다 작을 때 에러 발생
    IF ( (V_ATTEND_DIV < 0) OR (V_PRAC_DIV < 0) OR (V_WRITE_DIV < 0) )
        THEN RAISE DIV_ERROR;
    END IF;
    
    -- 4. 출결, 실기, 필기 배점을 합치면 100이 되지 않을 때 에러 발생
    IF (V_ATTEND_DIV + V_PRAC_DIV + V_WRITE_DIV != 100)
        THEN RAISE DIV_SUM_ERROR;
    END IF;

    -- 과정번호 생성(시퀀스 활용을 통해 자동 증가되게 설정)
    V_SLI_NO := ('SLI-' || TO_CHAR(SEQ_SUB_LIST.NEXTVAL));
    
    -- INSERT 구문 작성
    INSERT INTO SUB_LIST(LIST_NO, CUR_NO, SUB_NO, SUB_STARTDATE, SUB_ENDDATE, PRO_ID, ATTEND_DIV, PRAC_DIV, WRITE_DIV)
    VALUES(V_SLI_NO, V_CUR_NO, V_SUB_NO, V_SUB_STARTDATE, V_SUB_ENDDATE, V_PRO_ID, V_ATTEND_DIV, V_PRAC_DIV, V_WRITE_DIV);
    
    COMMIT;
    
    -- 예외 처리
    EXCEPTION 
        WHEN SUB_NO_ERROR
            THEN RAISE_APPLICATION_ERROR(-20022, '이미 등록된 과목입니다.'); 
            ROLLBACK;
        WHEN DATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '시작일은 종료일 이전 날짜로 설정해야 합니다.');
            ROLLBACK;
        WHEN DIV_ERROR
            THEN RAISE_APPLICATION_ERROR(-20024, '배점은 [0] 이상 입력 가능합니다.');
            ROLLBACK;
        WHEN DIV_SUM_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008, '배점의 총합은 100점이어야 합니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SLI_INSERT이(가) 컴파일되었습니다.


-- +) SEQ_SUB_LIST 시퀀스 생성 구문
CREATE SEQUENCE SEQ_SUB_LIST   -- 시퀀스 생성 기본 구문
START WITH 1                   -- 시작값
INCREMENT BY 1                 -- 증가값
NOMAXVALUE                     -- 최대값 제한 안둠
NOCACHE; 
--==>> Sequence SEQ_SUB_LIST이(가) 생성되었습니다.


-- 2) 과목개설 삭제 프로시저 
CREATE OR REPLACE PROCEDURE PRC_SLI_DELETE
( V_LIST_NO     SUB_LIST.LIST_NO%TYPE
)
IS
    TEMP_NUM        NUMBER;
    SUB_NO_ERROR    EXCEPTION; -- 과목번호가 존재하지 않을 때 발생하는 에러
BEGIN

    -- 과목번호가 존재하지 않을 때 에러 발생
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    IF (TEMP_NUM = 0)
        THEN RAISE SUB_NO_ERROR;
    END IF;
    
    -- DELETE 구문 작성
    DELETE
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN SUB_NO_ERROR
            THEN RAISE_APPLICATION_ERROR(-20023, '입력한 과목이 존재하지 않습니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SLI_DELETE이(가) 컴파일되었습니다.



-- <<DROP_RES>> 중도탈락사유 테이블

-- 1) 중도탈락사유 입력 프로시저
CREATE OR REPLACE PROCEDURE PRC_DRP_INSERT
( V_REASON        DROP_RES.REASON%TYPE
)
IS
    V_DRP_NO        DROP_RES.REASON_NO%TYPE;  -- 시퀀스 설정에 필요한 변수
    TEMP_NUM        NUMBER;                   -- 탈락사유번호 존재여부 확인에 필요한 변수
    
    REASON_ERROR    EXCEPTION; -- 동일 탈락사유가 이미 존재할 때 발생하는 에러
BEGIN
    -- 동일 탈락사유가 이미 존재할 때 에러 발생(UNIQUE)
    SELECT COUNT(*) INTO TEMP_NUM
    FROM DROP_RES
    WHERE REASON = V_REASON;
    
    IF (TEMP_NUM != 0)
        THEN RAISE REASON_ERROR;
    END IF;
    
    -- 탈락사유번호 생성(시퀀스 활용을 통해 자동 증가되게 설정)
    V_DRP_NO := ('DRP-' || TO_CHAR(SEQ_DROP_RES.NEXTVAL));
    
    -- INSERT 구문 작성
    INSERT INTO DROP_RES(REASON_NO, REASON)
    VALUES(V_DRP_NO, V_REASON);
    
    COMMIT;
    
    -- 예외 처리
    EXCEPTION 
        WHEN REASON_ERROR
            THEN RAISE_APPLICATION_ERROR(-20030, '이미 등록된 탈락사유입니다.'); 
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_DRP_INSERT이(가) 컴파일되었습니다.

-- +) SEQ_DROP_RES 시퀀스 생성 구문
CREATE SEQUENCE SEQ_DROP_RES   -- 시퀀스 생성 기본 구문
START WITH 1                   -- 시작값
INCREMENT BY 1                 -- 증가값
NOMAXVALUE                     -- 최대값 제한 안둠
NOCACHE; 
--==>> Sequence SEQ_DROP_RES이(가) 생성되었습니다.


