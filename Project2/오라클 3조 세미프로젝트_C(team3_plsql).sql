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


-----------------------------------------------
-- ������ ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
( V_ID   IN ADMIN.AD_ID%TYPE
, V_PW   IN ADMIN.AD_PW%TYPE
)
IS

BEGIN

    INSERT INTO ADMIN(AD_ID, AD_PW)
    VALUES(V_ID, V_PW);
    
END;

-----------------------------------------------
-- ������ ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_UPDATE
( V_ID          IN ADMIN.AD_ID%TYPE
, V_BEFORE_PW   IN ADMIN.AD_PW%TYPE
, V_AFTER_PW    IN ADMIN.AD_PW%TYPE
)
IS

BEGIN

    UPDATE ADMIN
    SET AD_PW = V_AFTER_PW
    WHERE AD_ID = V_ID
      AND AD_PW = V_BEFORE_PW;
    
END;

-----------------------------------------------
-- ������ ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_DELETE
( V_ID   IN ADMIN.AD_ID%TYPE
, V_PW   IN ADMIN.AD_PW%TYPE
)
IS

BEGIN

    DELETE
    FROM ADMIN
    WHERE AD_ID = V_ID
      AND AD_PW = V_PW;
    
END;

-----------------------------------------------
-- ������ �α��� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_LOGIN
( V_ID   IN ADMIN.AD_ID%TYPE
, V_PW   IN ADMIN.AD_PW%TYPE
)
IS
    TEMP_PW ADMIN.AD_PW%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT AD_PW INTO TEMP_PW
    FROM ADMIN
    WHERE AD_ID = V_ID;
    
    IF (TEMP_PW != V_PW)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '���̵� �� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');

END;
--==>> Procedure PRC_ADMIN_LOGIN��(��) �����ϵǾ����ϴ�.

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
--==>> Procedure PRC_PRO_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-- ������ ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_PRO_UPDATE
( V_ID          IN PROFESSOR.PRO_ID%TYPE
, V_FIRSTSSN    IN PROFESSOR.PRO_FIRSTSSN%TYPE
, V_LASTSSN     IN PROFESSOR.PRO_LASTSSN%TYPE
, V_PW          IN PROFESSOR.PRO_PW%TYPE
)
IS
    TEMP_SSN    CHAR(13);
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    SELECT CONCAT(PRO_FIRSTSSN, PRO_LASTSSN) INTO TEMP_SSN
    FROM PROFESSOR
    WHERE PRO_ID = V_ID;

    IF (TEMP_SSN != (V_FIRSTSSN || V_LASTSSN))
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE PROFESSOR
    SET PRO_PW = V_PW
    WHERE PRO_ID = V_ID
      AND PRO_FIRSTSSN = V_FIRSTSSN
      AND PRO_LASTSSN = V_LASTSSN;
      
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '�Է��� �ֹι�ȣ�� ��ġ���� �ʽ��ϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_PRO_UPDATE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-- ������ ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRO_PROFESSOR_DELETE
( V_ID IN PROFESSOR.PRO_ID%TYPE
, V_PW IN PROFESSOR.PRO_PW%TYPE
)
IS
    TEMP_PW PROFESSOR.PRO_PW%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT PRO_PW INTO TEMP_PW
    FROM PROFESSOR
    WHERE PRO_ID = V_ID;

    IF (TEMP_PW != V_PW)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DELETE
    FROM PROFESSOR
    WHERE PRO_ID = V_ID
      AND PRO_PW = V_PW;
    
   COMMIT;
   
   EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20001, '���̵� �� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');
   
END;
--==>> Procedure PRO_PROFESSOR_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-- ������ �α��� ���ν���
CREATE OR REPLACE PROCEDURE PRC_PRO_LOGIN
( V_ID   IN PROFESSOR.PRO_ID%TYPE
, V_PW   IN PROFESSOR.PRO_PW%TYPE
)
IS
    TEMP_PW PROFESSOR.PRO_PW%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT PRO_PW INTO TEMP_PW
    FROM PROFESSOR
    WHERE PRO_ID = V_ID;
    
    IF (TEMP_PW != V_PW)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '���̵� �� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');

END;
--==>> Procedure PRC_PRO_LOGIN��(��) �����ϵǾ����ϴ�.
















