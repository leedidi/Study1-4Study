SELECT USER
FROM DUAL;
--==>> SCOTT

--���� FUNCTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[(
    �Ű�����1 �ڷ���
  , �Ű�����2 �ڷ���
)]
RETURN ������Ÿ��        --@ (��)�� � ������Ÿ��, � ������ ��ȯ�Ѵٴ°� �̸� ������
IS
    -- �ֿ� ���� ����(���� ����)
BEGIN
    -- ���๮
    ...
    RETURN (��);
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

 
--�� TBL_INSA ���̺���
--   �ֹε�Ϲ�ȣ�� ������ ������ ��ȸ�Ѵ�.

SELECT *
FROM TBL_INSA;
 
SELECT NAME, SSN, DECODE( SUBSTR(SSN,8,1), '1', '����', '2', '����', 'Ȯ�κҰ�' )"����"
FROM TBL_INSA;

/*
         �� �ֹε�Ϲ�ȣ
        \   /
     ----   --------------
     |                   |
     ----------------   --
                     /  \
                      �� ����
*/
 
--�� FUNCTION ����
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER
( VSSN  VARCHAR2    -- �Ű����� : �ڸ���(����) ���� ����
)--@ �Ű����� �Ѱ��� �� ���
RETURN VARCHAR2     -- ��ȯ �ڷ��� : �ڸ���(���� ���� ����) -@ ����Ұ� 1. RETURN ���! 2. �������� X
    --@������� �����
IS
    -- �ֿ� ���� ����
    VRESULT VARCHAR2(20);
BEGIN
    -- ���� �� ó��
    IF ( SUBSTR(VSSN, 8, 1) IN ('1', '3') )
        THEN VRESULT := '����';
    ELSIF ( SUBSTR(VSSN, 8, 1) IN ('2', '4') )
        THEN VRESULT := '����';
    ELSE
        VRESULT := '����Ȯ�κҰ�';
    END IF; --@ IF �����ߴ� IF ������!
    
    -- ���� ����� ��ȯ
    RETURN VRESULT;
    
END;
--@ ������� ��ü
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.
 

--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾�
--   A�� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   �Լ��� : FN_POW()
/*
��� ��)
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
--�� ���� �ۼ��� �ڵ�
CREATE OR REPLACE FUNCTION FN_POW
( N1    NUMBER
, N2    NUMBER
)
RETURN NUMBER
IS
    VRESULT NUMBER := 1;
    N       NUMBER := N2;
BEGIN
    --POWER ���X
    --�ݺ���.......
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

CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER) -- �Ű�����
RETURN NUMBER
IS
    V_RESULT    NUMBER := 1;        -- ���� ��
    V_NUM       NUMBER;
BEGIN

    FOR V_NUM IN 1 ..  B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    -- CHECK~!!!
    RETURN V_RESULT;
END;
-- @ ����...! ���� ���߿� Ȯ�� --> ���� �ذ� �Ϸ�!
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.




--* ����
--@ ī�信 �ø���! Ǯ�ٰ� ������ �� �ذ��ϰ����� ī�� �ٸ� �ı��� �ڵ� �����ص� ��....


SELECT *
FROM TBL_INSA;

--�� ���� 1
-- TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
-- �޿��� ��(�⺻��*12)+���硻 �� ������� ������ �����Ѵ�.
-- �Լ��� : FN_PAY(�⺻��, ����)

CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER, SUDANG NUMBER) -- �Ű�����
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    V_YEARPAY     NUMBER;
BEGIN
    -- ���� �� ó��
    V_YEARPAY := (BASICPAY * 12) + SUDANG;
    
    -- ���� ����� ��ȯ
    RETURN V_YEARPAY;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.


--�� ���� 2
-- TBL_INSA ���̺��� �Ի����� ��������
-- ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
-- ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
-- �Լ��� : FN_WORKYEAR(�Ի���)

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    -- ��������� �ٹ����(�Ҽ��� ���� ���ڸ�����)
    V_WORKYEAR    NUMBER;
BEGIN
    -- ���� �� ó��
    V_WORKYEAR := TRUNC((SYSDATE - IBSADATE)/365, 1);
    
    -- ���� ����� ��ȯ
    RETURN V_WORKYEAR;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- ���� PL/SQL�� �� DML��, TCL���� ��� �����ϴ�.             --@ ��Ȳ�� ���� ������ �ʴ�...
-- ���� PL/SQL�� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�. --@ ��Ȳ�� ���� ���ϴ�...

--@ ���� INSERT �� ����ϰ� �Ʒ��� CREATE, GRANT �� ����ϸ�... INSERT�� Ŀ�ԵǾ����! �ѹ��ص� �μ�Ʈ ��ҵ��� X

--------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����--

--@ �����Ϳ����� �Լ����� ���� ���ɼ���... '������'! <- �ٽ� �ܾ���

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[(
    �Ű����� IN ������Ÿ��
  , �Ű����� OUT ������Ÿ��
  , �Ű����� INOUT ������Ÿ��
)]
IS
    -- �ֿ� ���� ����
BEGIN
    -- ���� ����
    ...
    [EXCEPTION]
        -- ���� ó�� ����
END;
*/

--@ �߿��� ��!
--@ 1. RETURN ���� ����
--@ 2. IN, OUT, INOUT �� ����.. ���� ����� IN �Ķ���Ͱ� ������

--�� FUNCTION �� ������ ��...
--  ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--  ��RETURN���� ��ü�� �������� ������,
--  ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--  IN, OUT, INOUT ���� ���еȴ�.
--@ IN, OUT, INOUT �� �ֱ� ������... �Է� �Ű����� ���� �� IN �� ��� ��!

-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
-@ [] : ���� ����!
*/


--�� INSERT ���� ������ ���ν����� �ۼ� ( �� INSERT ���ν���)
--@ ���� ��...! 
--@ �׳� ���ظ� ��Ű�� ���� ������! �����δ� �̷��� ���� ����.. �̷��� �϶�� ��� X

-- �ǽ� ���̺� ����(TBL_STUDENTS)
/*
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(20)
, ADDR  VARCHAR2(100)
);
*/ 
--20210915_02_scott���� �Űܼ� �ۼ� �Ϸ�!

-- ���ν��� ����(�ۼ�)
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
--, V_ADDR    IN TBL_STUDNETS.ADDR%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- �ֿ� ���� ����
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    --Ŀ��
    COMMIT;
END;
-- ����,,,!^^��
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�. (���� �ذ�)


--�� TBL_SUNGJUK ���̺� ������ �Է� ��
--   Ư�� �׸��� ������(�й�, �̸�, ��������, ��������, ��������)�� �Է��ϸ�
--   ���������� ����, ���, ��� �׸��� �Բ� �Է� ó���� �� �ֵ��� �ϴ�
--   ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '������', 90, 80, 70);

���ν��� ȣ��� ó���� ���)
�й�    �̸�    ��������    ��������    ��������    ����   ���   ���
 1     ������     90           80          70       240     80     B  
*/

--�� ���� �ۼ��� �ڵ�
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
    -- �ֿ� ���� ����
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
�̸�     ��?       ����           
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
--@ �Է� �Ű�����: ���������� �̰� �ǳ��� �״ϱ� �̰� ������ �����!
--@ ��� �Ű�����: ���� �׸� �ٰ�.. �װ� ó���� ���� �̰� �� �׸��� ��Ƽ� �������!
--@ �̿����̳���... ���� ������ȯ. ���� ��α� �׸���Ƽ� �ٰ� �װ� ��ġ �׸���Ƽ� ��!
IS
    -- �Ʒ��� INSERT �������� �����ϴµ� �ʿ��� �ֿ� ���� ����
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
--@ �̰� ���ο��� ����ϴ� ��������.. IN, OUT �� ����� �ʿ� ����!
--@ ���� ; ���� ����...(, �� ����) �Ʒ� ����δ� ; ����. ���� ���������� ������ ��� ��

BEGIN
    -- �Ʒ��� INSERT �������� �����ϱ� ���ؼ���
    -- ������ ������ �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF (V_AVG >= 90)
    --@ �ǹ��� ��...! IF �ڿ��� () �ٿ��ִ°� ����!
    --@ ������ �ʼ� ��Ҵ� �ƴ�����, �ǹ������� ����Ҷ��� ������ �ٿ��ֱ⸦ ����
    --@ () �������� �ν�!
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
    
    -- ���� �Ϸ��� ����(line 373 ~ 386)�� ���� ��Ƴ� �����
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
                                                  ----------------------
                                                  
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_SUNGJUK ���̺���
--   Ư�� �л��� ����(�й�, ����, ����, ����)
--   ������ ���� �� ����, ���, ��ޱ��� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_UPDATE()
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2, 100, 100, 100);

���ν��� ȣ��� ó���� ���)
�й�    �̸�    ��������    ��������    ��������    ����   ���   ���
 2     ��ҿ�     100          100         100       300    100    A  
*/

--�� ���� �ۼ��� �ڵ�
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
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.
--==>> @ ���� �ƴ�........�Ф�
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- UPDATE ���� �� �ʿ��� �����͸� ��Ƴ� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �Ʒ� UPDATE ������ ������ ����
    -- ������ ������ �����鿡 ���� ��Ƴ���
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
    
    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR=V_KOR, ENG=V_ENG, MAT=V_MAT, TOT=V_TOT, AVG=V_AVG, GRADE=V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- COMMIT
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUDENTS ���̺���
--   ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) ���ν����� �ۼ��Ѵ�.
--   ��, ID �� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� �Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '��õ');

���ν��� ȣ��� ó���� ���
superman    �չ��� 010-9999-9999   ��õ
*/

--�� ���� �ۼ��� �ڵ�
/*
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_STUDENTS.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
-- ���� ���� �ʿ� ����
BEGIN
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    --WHERE ID = V_ID, V_PW= TBL_IDPW�� PW; (java006$)
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
--@ ���� IN ��� ���ϸ� INOUT���� �����µ�?
IS
BEGIN
    -- UPDATE ������ ����
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
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--  NUM NAME SSN CITY TEL BUSEO JIKWI BASICPAY SUDANG 
--  ������ ���� �ִ� ��� ���̺� ������ �Է� ��
--  NUM �÷�(�����ȣ)�� ����
--  ���� �ο��� �����ȣ ������ ��ȣ�� �� ���� ��ȣ�� �ڵ�����
--  �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
--  ���ν����� : PRC_INSA_INSERT(NUM, SSN, IBSADATE, CITY, TEL, BUSEO ,JIKWI, BASICPAY, SUDANG);

/*
���� ��)
EXEC PRC_INSA_INSERT('�̴ٿ�', '951027-2234567', SYSDATE, '����', '010-4113-2353', '������', '�븮', 10000000, 2000000); -- õ��, �̹鸸

���ν��� ȣ��� ó���� ���)
1061 �̴ٿ� 951027-2234567 SYSDATE ���� 010-4113-2353 ������ �븮 10000000, 2000000
*/
-- ���� �ۼ��� �ڵ�
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
( '�̴ٿ�' 
, '951027-2234567'
, SYSDATE 
, '����' 
, '010-4113-2353' 
, '������'
, '�븮' 
, 10000000
, 2000000
)
IS
BEGIN
END;


















