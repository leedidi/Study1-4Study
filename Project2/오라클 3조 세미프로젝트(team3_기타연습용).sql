

-- �� �������� Ȯ�ο� ���� ��(VIEW) ����
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
-->> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.

--�� ������ ��(VIEW)�� ���� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST4';
--==>> HR	TSET4_COL1_PK	TBL_TEST4	P	COL1	

--�� �� �� �̻��� ���̺� ����(JOIN)

-- ����1(SQL 1992 CODE)
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
  AND ���̺��2.�÷���2 = ���̺��3.�÷���2;

-- ����2(SQL 1999 CODE)
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���1
               JOIN ���̺��3
               ON ���̺��2.�÷���2 = ���̺��3.�÷���2;

������ ��, ������ �����, ���� �Ⱓ(���� ������, �� ������), ���� ��, ���ǽ�, 
 ���� ���� ����(���� ����, ���� ��, ���� ����)��
 
 
 --���� ���ν��� �������� ���� ó�� ���� --

--�� TBL_MEMBER ���̺��� �����͸� �Է��ϴ� ���ν��� �ۼ�
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����', '��õ', '���' �� �Է��� �����ϵ��� �����Ѵ�.
--   ���� ���� ���� ������ ���ν��� ȣ���� ���� �Է��Ϸ��� �ϴ� ���
--   ���� ó���� �Ϸ��� �Ѵ�.
--   ���ν��� �� : PRC_MEMBER_INSERT(�̸�, ��ȭ��ȣ, ����)

-- ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS

    V_NUM   TBL_MEMBER.NUM%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN

    IF (V_CITY NOT IN ('����', '��õ', '���'))
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    SELECT NVL(MAX(NUM), 0) INTO V_NUM    
    FROM TBL_MEMBER;

    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    COMMIT;

    EXCEPTION  
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����,��õ,��⸸ �Է��� �����մϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.




CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
(V_NAME     IN TBL_ADMIN.NAME%TYPE				-- �̸�
,V_SIGNDATE IN TBL_ADMIN.SIGNDATE%TYPE			-- �����
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
