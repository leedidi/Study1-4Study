--�� ���� ��й�ȣ DEFAULT Ʈ����
CREATE OR REPLACE TRIGGER TRG_PRO_PW
          BEFORE INSERT ON PROFESSOR
          FOR EACH ROW
BEGIN
    :NEW.PRO_PW := :NEW.PRO_LASTSSN;
END;


--�� �л� ��й�ȣ DEFAULT Ʈ����
CREATE OR REPLACE TRIGGER TRG_STU_PW
          BEFORE INSERT ON STUDENT
          FOR EACH ROW
BEGIN
    :NEW.STU_PW := :NEW.STU_LASTSSN;
END;

/*
���� ���� �Է� ���ν��� (���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��)
���� ���� ���� ���ν���
���� ���� ���� ���ν���

- �׸��� ���� 20004...���� �߰��ؾ� �Ұ� ����� ī��濡 ������

-- ���� ���̺�
INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
VALUES();
*/

-- ����

-- ������ ���� ���� ���ν���
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
            THEN RAISE_APPLICATION_ERROR(-20002, '������ �����ڰ� �����մϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
END;

-- STRAT...��

INSERT INTO SCORE(SCORE_NO, REG_NO, LIST_NO, ATTEND_SCORE, PRAC_SCORE, WRITE_SCORE)
VALUES('A001', 'A001', 'A001', 80, 90, 90);

-- ������û��ȣ�� ���񰳼���ȣ�� �ش� ���̺�鿡 �ԷµǾ� �־�� �Է��Ҽ� �ֵ��� ó���ؾ��ϳ�...?
-- ���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��
-- ������ ���� �߿��� ���� ������ ���� ���� ������ ���� ó�� ȭ������ ��ȯ���� �ʾƾ� �Ѵ�. 

/*
-- 1. ���� ���� �Է� ���ν��� (���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��)
-- 1���� ����ó��..
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
            THEN RAISE_APPLICATION_ERROR(-20009, '���ǰ� ������� ���� �����Դϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
END;
--==>> Procedure PRC_SCORE_INSERT��(��) �����ϵǾ����ϴ�.
*/
/*
DROP PROCEDURE SCORE_INSERT;
--==>> Procedure SCORE_INSERT��(��) �����Ǿ����ϴ�.

DROP PROCEDURE SCORE_PRO_INSERT;
--==>> Procedure SCORE_PRO_INSERT��(��) �����Ǿ����ϴ�.

DROP PROCEDURE SCORE_PRO_UPDATE;
--==>> Procedure SCORE_PRO_UPDATE��(��) �����Ǿ����ϴ�.

DROP PROCEDURE SCORE_PRO_DELETE;
--==>> Procedure SCORE_PRO_DELETE��(��) �����Ǿ����ϴ�.
*/


-- 1. ���� ���� �Է� ���ν��� (���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��)
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

    -- ���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��
    SELECT SUB_STARTDATE INTO V_SUB_STARTDATE
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    IF (V_SUB_STARTDATE > SYSDATE)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- ���� �Է½� �ش� ����(������ȣ)�� ���� ���̺� �̹� �����ϸ� ����ó��
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
            THEN RAISE_APPLICATION_ERROR(-20009, '���ǰ� ������� ���� �����Դϴ�.');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20015, '�Է��� ������ �̹� �����մϴ�.');
            -- '�Է��� ������ ������ �̹� �����մϴ�.'...? 
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_INSERT��(��) �����ϵǾ����ϴ�.



-- ������ȣ�� �޾ƿ���,,,? ������ȣ, ������û��ȣ, ���񰳼���ȣ ��� �ٹ޾ƿ���...?
-- �ϴ� ���� ��ȣ�� �޾ƿ͵� �� �� ����!
-- ���� �Է� ���� ȭ�鿡�� �ڽ��� ���Ǹ� ������ �л����� �̸��� �ڵ����� �ԷµǾ� �ְ�, 
-- �����ڴ� �л� �������� ������ �Է��ϵ��� �Ѵ�. 
-- �ش� ������ȣ�� �������� ������ �������� �ʴ� �����Դϴ�.../ ������ ������ 0~100�� �ȵ˴ϴ�...
-- ���ڰ� ������ ����!
-- �ٵ� �ϳ��� ������ �ϳ�.... ?? ���Ǳ��ʱ� �ϳ���? �ƴ� ���ļ�,,,?

/*
-- 2. ���� ���� ���� ���ν���
-- 1���� ����ó��..
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
            THEN RAISE_APPLICATION_ERROR(-20010, '������ [0 - 100]�� ���� ������ �Է� �����մϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;        

END;
--==>> Procedure PRC_SCORE_UPDATE��(��) �����ϵǾ����ϴ�.
*/

-- 2. ���� ���� ���� ���ν���
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
    
    -- ���� �Է½� �� ���� ������ [0-100]���� ����� ����ó��
    IF ( (V_ATTEND_SCORE NOT BETWEEN 0 AND 100) OR (V_PRAC_SCORE NOT BETWEEN 0 AND 100)
         OR (V_WRITE_SCORE NOT BETWEEN 0 AND 100) )
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- ���� �Է½� �ش� ����(������ȣ)�� ���� ���̺� �������� ������ ����ó��
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
            THEN RAISE_APPLICATION_ERROR(-20010, '������ [0 - 100]�� ���� ������ �Է� �����մϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20011, '�Է��� ������ �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;        

END;
--==>> Procedure PRC_SCORE_UPDATE��(��) �����ϵǾ����ϴ�.

-- 3. ���� ���� ���� ���ν���

CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
)
IS
    TEMP_SCORE_NO       SCORE.SCORE_NO%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    -- ���� �Է½� �ش� ����(������ȣ)�� ���� ���̺� �������� ������ ����ó��
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
            THEN RAISE_APPLICATION_ERROR(-20011, '�Է��� ������ �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_SCORE_DELETE��(��) �����ϵǾ����ϴ�.

-- ��� ���� ������
RAISE_APPLICATION_ERROR(-20009, '���ǰ� ������� ���� �����Դϴ�.');
RAISE_APPLICATION_ERROR(-20010, '������ [0 - 100]�� ���� ������ �Է� �����մϴ�.');
RAISE_APPLICATION_ERROR(-20011, '�Է��� ������ �������� �ʽ��ϴ�.');

RAISE_APPLICATION_ERROR(-20015, '�Է��� ������ �̹� �����մϴ�.');









---�� ������


-- 1. ���� ���� �Է� ���ν��� (���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��)
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
    
    -- ���� �Է½� �ش� ����(������ȣ)�� ���� ���̺� �̹� �����ϸ� ����ó��
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;

    IF (TEMP_NUM != 0)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- ���� �Է½� ���񰳼����� SYSDATE ���� �̷��� ����ó��
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
            THEN RAISE_APPLICATION_ERROR(-20015, '�Է��� ������ �̹� �����մϴ�.');
            -- '�Է��� ������ ������ �̹� �����մϴ�.'...? 
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20009, '���ǰ� ������� ���� �����Դϴ�.');
                ROLLBACK;        
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_INSERT��(��) �����ϵǾ����ϴ�.


-- 2. ���� ���� ���� ���ν���
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

    -- ���� �Է½� �ش� ����(������ȣ)�� ���� ���̺� �������� ������ ����ó��
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SCORE
    WHERE SCORE_NO = V_SCORE_NO;

    IF (TEMP_NUM = 0)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- ���� �Է½� �� ���� ������ [0-100]���� ����� ����ó��
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
            THEN RAISE_APPLICATION_ERROR(-20011, '�Է��� ������ �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20010, '������ [0 - 100]�� ���� ������ �Է� �����մϴ�.');
                ROLLBACK;        
        WHEN OTHERS
            THEN ROLLBACK;        

END;
--==>> Procedure PRC_SCORE_UPDATE��(��) �����ϵǾ����ϴ�.


-- 3. ���� ���� ���� ���ν���

CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
( V_SCORE_NO      IN SCORE.SCORE_NO%TYPE
)
IS
    TEMP_NUM            NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    -- ���� ������ �ش� ����(������ȣ)�� ���� ���̺� �������� ������ ����ó��
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
            THEN RAISE_APPLICATION_ERROR(-20011, '�Է��� ������ �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_SCORE_DELETE��(��) �����ϵǾ����ϴ�.

-- ��� ���� ������
RAISE_APPLICATION_ERROR(-20009, '���ǰ� ������� ���� �����Դϴ�.');
RAISE_APPLICATION_ERROR(-20010, '������ [0 - 100]�� ���� ������ �Է� �����մϴ�.');
RAISE_APPLICATION_ERROR(-20011, '�Է��� ������ �������� �ʽ��ϴ�.');
RAISE_APPLICATION_ERROR(-20015, '�Է��� ������ �̹� �����մϴ�.');

--����)
--�� ���� ���� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_CUR_INSERT
( V_CUR_NAME        IN CURRICULUM.CUR_NAME%TYPE
, V_CUR_STARTDATE   IN CURRICULUM.CUR_STARTDATE%TYPE
, V_CUR_ENDDATE      IN CURRICULUM.CUR_ENDDATE%TYPE
, V_ROOM_NO         IN CURRICULUM.ROOM_NO%TYPE
)
IS
    V_CUR_NO    CURRICULUM.CUR_NO%TYPE;
    
    TEMP_RNUM    NUMBER; --�Է��� ���ǽ��� �����ϴ��� Ȯ���� ���� �ӽú���
    TEMP_NNUM    NUMBER; --�Է��� �������� �ߺ����� Ȯ���� ���� �ӽú���
    
    STARTDATE_ERROR   EXCEPTION; --������>�����϶� �߻��ϴ� ����
    ROOM_ERROR   EXCEPTION; --�Է��� ���ǽ��� �������� ���� ��� �߻��ϴ� ����
    NAME_ERROR   EXCEPTION; --�Է��� �������� �ߺ��� ��� �߻��ϴ� ����
BEGIN
    --�������� ���Ϻ��� �̷��� �Է��� ��� ���� �߻�
    IF (V_CUR_STARTDATE>V_CUR_ENDDATE)
        THEN RAISE STARTDATE_ERROR;
    END IF;
    
    --�Է��� ���ǽ��� �������� ���� ��� ���� �߻�
    SELECT COUNT(*) INTO TEMP_RNUM
    FROM ROOM
    WHERE ROOM_NO=V_ROOM_NO;
    
    IF (TEMP_RNUM=0)
        THEN RAISE ROOM_ERROR;
    END IF;
    
    --������(UNIQUE)�� �ߺ��Ǹ� �ȵ�
    SELECT COUNT(*) INTO TEMP_NNUM
    FROM CURRICULUM
    WHERE CUR_NAME=V_CUR_NAME;
    
    IF (TEMP_NNUM!=0)
        THEN RAISE NAME_ERROR;
    END IF;
    
    --������ȣ ����(CUR-1, CUR-2, ..., CUR-999 �� ����)
    V_CUR_NO := ('CUR-' || TO_CHAR(SEQ_CURRICULUM.NEXTVAL));
    
    --INSERT ������ �ۼ�
    INSERT INTO CURRICULUM(CUR_NO, CUR_NAME, CUR_STARTDATE, CUR_ENDDATE, ROOM_NO)
    VALUES(V_CUR_NO, V_CUR_NAME, V_CUR_STARTDATE, V_CUR_ENDDATE, V_ROOM_NO);
    
    COMMIT;
    
    -- ����ó��
    EXCEPTION
        WHEN STARTDATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '�������� ������ ���� ��¥�� �����ؾ� �մϴ�.');
        WHEN ROOM_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007, '�Է��� ���ǽ��� �������� �ʽ��ϴ�.');
        WHEN NAME_ERROR
            THEN RAISE_APPLICATION_ERROR(-20012, '�Է��� �������� �̹� �����մϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==> Procedure PRC_CUR_INSERT��(��) �����ϵǾ����ϴ�.










-- ������ ����� �Ϸ�
-- ������ �Է±����� �ֱ�

--������ȣ ����(CUR-1, CUR-2, ..., CUR-999 �� ����)
    V_CUR_NO := ('CUR-' || TO_CHAR(SEQ_CURRICULUM.NEXTVAL));




-- �� ���� ���� �κ�

-- <<SUB_LIST>> ���񰳼� ���̺�

-- 1) ���񰳼� �Է� ���ν��� 
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
    V_SLI_NO        SUB_LIST.LIST_NO%TYPE;  -- ������ ������ �ʿ��� ����
    TEMP_NUM        NUMBER;                 -- �����ȣ ���翩�� Ȯ�ο� �ʿ��� ����
    
    DATE_ERROR      EXCEPTION; -- 1. �����ȣ�� �̹� ������ �� �߻��ϴ� ����
    SUB_NO_ERROR    EXCEPTION; -- 2. ���� �������� ���� �����Ϻ��� �̷��� �� �߻��ϴ� ����
    DIV_ERROR       EXCEPTION; -- 3. ���, �Ǳ�, �ʱ� ������ ���� 0���� ���� �� �߻��ϴ� ����
    DIV_SUM_ERROR   EXCEPTION; -- 4. ���, �Ǳ�, �ʱ� ������ ��ġ�� 100�� ���� ���� �� �߻��ϴ� ����
    
BEGIN
    -- 1. �����ȣ�� �̹� ������ �� ���� �߻�
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SUB_LIST
    WHERE SUB_NO = V_SUB_NO;
    
    IF (TEMP_NUM != 0)
        THEN RAISE SUB_NO_ERROR;
    END IF;
    
    -- 2. ���� ������ > ���� �������� �� ���� �߻�
    IF (V_SUB_STARTDATE > V_SUB_ENDDATE)
        THEN RAISE DATE_ERROR;
    END IF;

    -- 3. ���, �Ǳ�, �ʱ� ������ ���� 0���� ���� �� ���� �߻�
    IF ( (V_ATTEND_DIV < 0) OR (V_PRAC_DIV < 0) OR (V_WRITE_DIV < 0) )
        THEN RAISE DIV_ERROR;
    END IF;
    
    -- 4. ���, �Ǳ�, �ʱ� ������ ��ġ�� 100�� ���� ���� �� ���� �߻�
    IF (V_ATTEND_DIV + V_PRAC_DIV + V_WRITE_DIV != 100)
        THEN RAISE DIV_SUM_ERROR;
    END IF;

    -- ������ȣ ����(������ Ȱ���� ���� �ڵ� �����ǰ� ����)
    V_SLI_NO := ('SLI-' || TO_CHAR(SEQ_SUB_LIST.NEXTVAL));
    
    -- INSERT ���� �ۼ�
    INSERT INTO SUB_LIST(LIST_NO, CUR_NO, SUB_NO, SUB_STARTDATE, SUB_ENDDATE, PRO_ID, ATTEND_DIV, PRAC_DIV, WRITE_DIV)
    VALUES(V_SLI_NO, V_CUR_NO, V_SUB_NO, V_SUB_STARTDATE, V_SUB_ENDDATE, V_PRO_ID, V_ATTEND_DIV, V_PRAC_DIV, V_WRITE_DIV);
    
    COMMIT;
    
    -- ���� ó��
    EXCEPTION 
        WHEN SUB_NO_ERROR
            THEN RAISE_APPLICATION_ERROR(-20022, '�̹� ��ϵ� �����Դϴ�.'); 
            ROLLBACK;
        WHEN DATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '�������� ������ ���� ��¥�� �����ؾ� �մϴ�.');
            ROLLBACK;
        WHEN DIV_ERROR
            THEN RAISE_APPLICATION_ERROR(-20024, '������ [0] �̻� �Է� �����մϴ�.');
            ROLLBACK;
        WHEN DIV_SUM_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008, '������ ������ 100���̾�� �մϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SLI_INSERT��(��) �����ϵǾ����ϴ�.


-- +) SEQ_SUB_LIST ������ ���� ����
CREATE SEQUENCE SEQ_SUB_LIST   -- ������ ���� �⺻ ����
START WITH 1                   -- ���۰�
INCREMENT BY 1                 -- ������
NOMAXVALUE                     -- �ִ밪 ���� �ȵ�
NOCACHE; 
--==>> Sequence SEQ_SUB_LIST��(��) �����Ǿ����ϴ�.


-- 2) ���񰳼� ���� ���ν��� 
CREATE OR REPLACE PROCEDURE PRC_SLI_DELETE
( V_LIST_NO     SUB_LIST.LIST_NO%TYPE
)
IS
    TEMP_NUM        NUMBER;
    SUB_NO_ERROR    EXCEPTION; -- �����ȣ�� �������� ���� �� �߻��ϴ� ����
BEGIN

    -- �����ȣ�� �������� ���� �� ���� �߻�
    SELECT COUNT(*) INTO TEMP_NUM
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    IF (TEMP_NUM = 0)
        THEN RAISE SUB_NO_ERROR;
    END IF;
    
    -- DELETE ���� �ۼ�
    DELETE
    FROM SUB_LIST
    WHERE LIST_NO = V_LIST_NO;
    
    COMMIT;
    
    -- ���� ó��
    EXCEPTION
        WHEN SUB_NO_ERROR
            THEN RAISE_APPLICATION_ERROR(-20023, '�Է��� ������ �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SLI_DELETE��(��) �����ϵǾ����ϴ�.



-- <<DROP_RES>> �ߵ�Ż������ ���̺�

-- 1) �ߵ�Ż������ �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_DRP_INSERT
( V_REASON        DROP_RES.REASON%TYPE
)
IS
    V_DRP_NO        DROP_RES.REASON_NO%TYPE;  -- ������ ������ �ʿ��� ����
    TEMP_NUM        NUMBER;                   -- Ż��������ȣ ���翩�� Ȯ�ο� �ʿ��� ����
    
    REASON_ERROR    EXCEPTION; -- ���� Ż�������� �̹� ������ �� �߻��ϴ� ����
BEGIN
    -- ���� Ż�������� �̹� ������ �� ���� �߻�(UNIQUE)
    SELECT COUNT(*) INTO TEMP_NUM
    FROM DROP_RES
    WHERE REASON = V_REASON;
    
    IF (TEMP_NUM != 0)
        THEN RAISE REASON_ERROR;
    END IF;
    
    -- Ż��������ȣ ����(������ Ȱ���� ���� �ڵ� �����ǰ� ����)
    V_DRP_NO := ('DRP-' || TO_CHAR(SEQ_DROP_RES.NEXTVAL));
    
    -- INSERT ���� �ۼ�
    INSERT INTO DROP_RES(REASON_NO, REASON)
    VALUES(V_DRP_NO, V_REASON);
    
    COMMIT;
    
    -- ���� ó��
    EXCEPTION 
        WHEN REASON_ERROR
            THEN RAISE_APPLICATION_ERROR(-20030, '�̹� ��ϵ� Ż�������Դϴ�.'); 
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_DRP_INSERT��(��) �����ϵǾ����ϴ�.

-- +) SEQ_DROP_RES ������ ���� ����
CREATE SEQUENCE SEQ_DROP_RES   -- ������ ���� �⺻ ����
START WITH 1                   -- ���۰�
INCREMENT BY 1                 -- ������
NOMAXVALUE                     -- �ִ밪 ���� �ȵ�
NOCACHE; 
--==>> Sequence SEQ_DROP_RES��(��) �����Ǿ����ϴ�.


