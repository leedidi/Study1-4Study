SELECT USER
FROM DUAL;
--==>> SCOTT


--���� BEFORE ROW TRIGGER �� ���� ��Ȳ �ǽ� ����--
--�� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

--�� TRIGGER �ۼ�(TRG_TEST2_DELETE)
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
        BEFORE
        DELETE ON TBL_TEST2
        --@ ������� ���� STATEMENT Ʈ����
        FOR EACH ROW
        --@ ������ ��.. ������� ���� ROW Ʈ����! ROW Ʈ���Ŵ� �̰� �־����~!
        -->> Ÿ���� ����....! ���⸦ ������ �ϴ� ��
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE=:OLD.CODE; --@ �ð��� ���缭 �� �ð� �������� ���� :OLD, :NEW��� �����ϱ�!
                          --@ �����Ǳ� ������ �ڵ�!
END;
--==>> Trigger TRG_TEST2_DELETE��(��) �����ϵǾ����ϴ�.

--�� ��:OLD��
--  ���� �� ���� ��
--  (INSERT : �Է��ϱ� ���� �ڷ�, DELETE : �����ϱ� ���� �ڷ�, ������ �ڷ�)
--@ EX> ���� INSERT�� �ϰ� ������ �̰� INSERT �ϱ� ������ ���� ���°��� ����ؼ� �� �ϰ� ����... �ϸ� :OLD ���� ��!

--�� UPDATE �� DELETE �׸��� INSERT �� ���յ� ����
--             �� �������� UPDATE �ϱ� ������ �ڷ�� :OLD
--             �� �������� UPDATE �� ���� �ڷ�� :NEW



--���� AFTER ROW TRIGGER �� ���� ��Ȳ �ǽ� ����--
--�� ���� ���̺� ���� Ʈ����� ó��

-- TBL_��ǰ, TBL_�԰�, TBL_���

--�� TBL_�԰� ���̺��� ������ �Է� ��(�԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�(TRG_IBGO)

--�� ���� �ۼ��� �ڵ�
--@ TRG_IBGO(��ǰ�ڵ�, �԰����) ���� �������ϳ�,,,,,? �̰� Ʈ������̰� ����� Ʈ����,,,
--@ Ʈ����ǰ� Ʈ����,,,,,,,
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        UPDATE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    SELECT ��ǰ�ڵ� INTO V.��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰���� = �Էµ� �԰����;

    --SET �Էµ� TBL.�԰��� ��ǰ�ڵ�� ���� TBL.��ǰ�� ������ 
    UPDATE TBL_��ǰ
    SET ������ = �Էµ� �԰����
    WHERE SELECT ��ǰ�ڵ� = V.��ǰ�ڵ�;
END;
*/
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_�԰�
        FOR EACH ROW
        --@ ������ �� Ȯ���ؼ� ��� �԰�Ǿ����� Ȯ���ؾ���...
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + �����԰�Ǵ� �԰����
             WHERE ��ǰ�ڵ� = �����԰�Ǵ� ��ǰ�ڵ�;
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_�԰�
        FOR EACH ROW
        --@ ������ �� Ȯ���ؼ� ��� �԰�Ǿ����� Ȯ���ؾ���...
BEGIN
    IF (INSERTING) --@ ���⼱ IF�� ��� ũ�� �ʿ� ���µ� ���߿� �����ؼ� ����Ҷ� Ʋ �����϶�� IF�� ����� ��...
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.


--�� TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
--   �԰����, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--   TRG_IBGO Ʈ���Ÿ� �籸���Ѵ�.
--@ UPDATE, DELETE ���� ���� Ʈ������Ҽ� �ֵ���....

--�� TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
--   ������, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--   TRG_CHULGO Ʈ���Ÿ� �ۼ��Ѵ�.

--------------------------------------------------------------------------------
--@ ��������... AND ���� �������� ī�信 �ø��� ����
--@ ����Ǯ�� �ƴ�! ���� ���� ������ ���� ����

--��1. TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
--     �԰����, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--     TRG_IBGO Ʈ���Ÿ� �籸���Ѵ�.

-- ���� �ۼ��� �ڵ�
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_�԰� OR TBL_���
        FOR EACH ROW
BEGIN
    --IF (INSERTING) 
    IF (INSERTING)-- ON TBL_�԰�
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (INSERTING)-- ON TBL_���
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;  
    END IF;
END;
*/
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING) 
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�; --�̰�Ʋ���Ű�����,,,,! ���ο� �԰������ ��ǰ�ڵ�?
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰����
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
*/
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.
-- ����ó��...!!

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_�԰� --@ ����!
        FOR EACH ROW
DECLARE
     V_������     TBL_��ǰ.������%TYPE;
     
     USER_DEFINE_ERROR  EXCEPTION;
     
BEGIN
   IF (INSERTING) 
       THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
   ELSIF (UPDATING)
          THEN SELECT ������ INTO V_������
                FROM TBL_��ǰ
                WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
            
            IF (V_������ - :OLD.�԰���� + :NEW.�԰���� <0)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
            UPDATE TBL_��ǰ
            SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
            WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
            
  ELSIF (DELETING)
         THEN SELECT ������ INTO V_������
                FROM TBL_��ǰ
                WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
            
            IF (V_������ - :OLD.�԰���� <0)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
            UPDATE TBL_��ǰ
            SET ������ = ������ - :OLD.�԰����
            WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
            
  END IF;
  
  -- ���� ó��
  EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!');
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.



--�� 2. TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
--      ������, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--      TRG_CHULGO Ʈ���Ÿ� �ۼ��Ѵ�.

CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_���
        FOR EACH ROW
DECLARE
     V_������     TBL_��ǰ.������%TYPE;
     
     USER_DEFINE_ERROR  EXCEPTION;        
     
BEGIN
    IF (INSERTING) 
        THEN SELECT ������ INTO V_������
             FROM TBL_��ǰ
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
        IF V_������ - :NEW.������ < 0
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
    
        UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
    ELSIF (UPDATING)
        THEN SELECT ������ INTO V_������
                 FROM TBL_��ǰ
                 WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
                 
            IF V_������ + :OLD.������ - :NEW.������ < 0
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
           UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
    ELSIF (DELETING)
          THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
    
    --INSERT �� DELETE �õ�...
    
    -- ���� ó��
    EXCEPTION
     WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!');
END;
--==>> Trigger TRG_CHULGO��(��) �����ϵǾ����ϴ�.

--@ INSERT, UPDATE�� ���� ó��...

--@ Ʈ���ſ����� ����ó�� �� �ʿ� ����....!! --> ������

-- �� TBL_��ǰ, TBL_�԰�, TBL_����� ���迡��
--    �԰����, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--    TRG_IBGO Ʈ���Ÿ� �籸���Ѵ�.

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰����
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
    
END;

-- �� TBL_��ǰ, TBL_�԰�, TBL_����� ���迡��
--    ������, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--    TRG_CHULGO Ʈ���Ÿ� �ۼ��Ѵ�.

CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_���
        FOR EACH ROW
BEGIN    
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;

END;

--------------------------------------------------------------------------------

--���� PACKAGE(��Ű��) ����--

-- 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü,
--    ���� ���α׷�(PROCEDURE, FUNCTION ��)�� �������� ������� ������
--    ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT�� �̴�.
--@ �������� ���� ó���� ���� ���� �ٽ�!
--@ ����� ���,���� ������ ���Ǵ� �ֵ��̾�~! ���� ���� EX> UTIL, IO��Ű�� ���...

-- 2. ��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ���
--    �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ�
--    ��ü ���α׷��� ���ȭ �� �� �ִ� ������ �ִ�.

-- 3. ��Ű���� ����(PACKAGE SPECIFICATION)DHK
--    ��ü��(PACKAGE BODY)�� �����Ǿ� ������,
--    �� �κп��� TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR,
--    SUBPROGRAM �� ����ǰ�
--    ��ü �κп��� �̵��� ���� ������ �����ϰ� �ȴ�.
--    �׸��� ȣ���� ������ ����Ű����.���ν����� ������ ������ �̿��ؾ� �Ѵ�.

-- 4. ���� �� ������(����)
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
        :
END ��Ű����;
*/
--@ ��Ű�� �ȿ� �̷��� �ֱ���..��ɷ� �����Ǿ� �ֱ���.. �˰� ���ִ� ����
--@ 4,5���� ���� ������ ��� �־�� ��!

-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[(�μ�, ...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�, ...)]
    IS
        ���� ����;
    BEGIN
        ���ν��� ��ü ���� �ڵ�;
    END;

END ��Ű����;
*/


--�� �ֹι�ȣ �Է� �� ������ ��ȯ�ϴ� �Լ�
--   �� �Լ��� ������ҷ� �ϴ� ��Ű�� �ۼ�

--@ �� �Լ���ü�� ���� ������ �� ��! �����ִ� �Լ������� ��Ű�� ���� �� ����
-- �Լ� �غ�
CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)
RETURN VARCHAR2
IS
    V_RESULT VARCHAR2(20);
BEGIN
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '����';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := 'Ȯ�κҰ�';
    END IF;
    
    RETURN V_RESULT;
    --@ �̷��� ������� �Լ��� V_RESULT�� ��ȯ�Ѵ�.
    
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.


-- ��Ű�� ���
-- 1. ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK; --@ ����, �Ʒ� ��Ű������ ��Ȯ�� ���ƾ� ��
--==>> Package INSA_PACK��(��) �����ϵǾ����ϴ�.


-- 2. ��ü�� �ۼ�
CREATE OR REPLACE PACKAGE BODY INSA_PACK --@ ��⿡ �ٵ� �߰�!
IS
    -- �� �Լ��غ񿡼� ����... CREATE OR REPLACE �� ����
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
            THEN V_RESULT := '����';
        ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := 'Ȯ�κҰ�';
        END IF;
        
        RETURN V_RESULT;
        --@ �̷��� ������� �Լ��� V_RESULT�� ��ȯ�Ѵ�.
    
    END;

END INSA_PACK;
--==>> Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.

-- ����Ŭ ��!





