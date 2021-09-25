SELECT USER
FROM DUAL;
--==>> SCOTT

--@ PLSQL ��.. ������ �������� ��ũ��Ʈ �� ��(���� �Ĵܿ� (plsql)�̶�� �ۼ��� ��)
--@ �ǽ� ���ǻ�.. ����� PLSQL�� �� ��Ƽ� �����ؾ� �ϱ� ����! / sql�� �׳� Ŀ�� �ش� ������ �ΰ� ��������!


--���� PL/SQL ����--

-- 1. PL/SQL(Procedural Language extension to SQL) ��
--    ���α׷��� ����� Ư���� ������ SQL �� Ȯ���̸�,
--    ������ ���۰� ���� ������ PL/SQL �� ������ �ڵ� �ȿ� ���Եȴ�.
--    ���� PL/SQL�� ����ϸ� SQL �� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⿡�� �����������̶�� �ܾ ������ �ǹ̴�
--    � ���� � ������ ���� ��� �Ϸ�Ǵ���
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�.

-- 2. PL/SQL �� ���������� ǥ���ϱ� ����
--    ������ ������ �� �ִ� ���,
--    ���� ������ ������ �� �ִ� ���,
--    ���� �帧�� ��Ʈ���� �� �ִ� ��� ���� �����Ѵ�.

-- 3. PL/SQL �� �� ������ �Ǿ� ������
--    ���� ���� �κ�, ���� �κ�, ���� ó�� �κ���
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����.

-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(declarations)
BEGIN
    -- ���๮(statements)
    
    [EXCEPTION]
        -- ���� ó����(exception handlers)
END;
*/
--@ ����Ŭ�� ���� ������...
--@ �߼� ���� ���� �ڹ� �鿩�ٺ���,, �����ϱ�!
--@ �츮���� 2021�� �߼��� ����! ������ ���⼳, ������ ���� �߼����� ��������� ��,,,,,,!
--@ ����Ŭ ������� ��Ŭ���� ����� ��!
--@ ����Ŭ ������ �ڹٿ� ����Ŭ ��ĥ ��,,,!!

-- 5. ���� ����
/*
DECLARE
    --�ڷ��� ������;    int num; �� ��          int num = 10;
    ������ �ڷ���;      COL1 NUMBER(3); �� ��   COL1 NUMBER(3) := 10;
    --@ ����Ŭ���� '='�� ����.. ���� ������. �׷��Ƿ� �����Ҷ��� ':=' �����!
    ������ �ڷ��� := �ʱⰪ;
    --@ <= ������� �����Ѵٰ� �����ϸ� ����!
BEGIN
    PL/SQL ����;
END;
*/

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.
-- ��DBMS_OUTPUT.PUT.LINE()�� �� ����
-- ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�

DECLARE
    -- �����
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(20) := 'Oracle';
BEGIN
   -- �����
   --SYSTEM.OUT.PRINTLN(V1);
   DBMS_OUTPUT.PUT_LINE(V1);
   DBMS_OUTPUT.PUT_LINE(V2);
   DBMS_OUTPUT.PUT_LINE(V3);
   --@ ����ó����
END;
--==>> 
/*
10
HELLO
Oracle

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--@ STATEMENT ���� ������ ';' ���.. 
--@ �׷��� �� ��Ƽ� �����ؾ� ��! Ŀ���� �ΰ� CNTL+ENTER �ϸ� �� ��!
--@ �� ��� CNTL+ENTER Ȥ�� F5 ������


--�� ������ ������ ���� �����ϰ� ����ϴ� PL/SQL ���� �ۼ�
DECLARE
    -- �����
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';

BEGIN
    -- �����
    V1 := V1 * 10;          -- V1 *= 10;
    V2 := V2 || ' ����';    -- V2 += "����";
    V3 := V3 || ' World';
    
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>>
/*
100
HELLO ����
Oracle World


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� IF��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*@
IF
END IF;
*/
--@ IF �����ߴ� IF ������! ���� �Է��ϱ�~!!! �׷��� END �� ������

/*
IF ����
    THEN ó������;
ELSIF ����
    THEN ó������;
ELSIF ����
    THEN ó������;
ELSE
    ó������;
END IF;
*/
--@ IF�� THEN�� �ִµ� ELSE�� THEN�� ����!
--@ ELSE IF�� �ƴ϶� ELSIF�� �ۼ�! ���α׷��� ���� �ν��ϱ� ���� ����Ŭ�� �̷��� ���...


--�� ������ ����ִ� ���� ����...
--   Excellent, Good, Fail �� �����Ͽ�
--   ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
DECLARE
    GRADE CHAR; --@ 1���� ���ڸ� ���� �� ����
BEGIN
    GRADE := 'C';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ElSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>>
/*
Fail


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�
*/


DECLARE
    GRADE CHAR; --@ 1���� ���ڸ� ���� �� ����
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ElSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>>
/*
Good


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
    GRADE CHAR; --@ 1���� ���ڸ� ���� �� ����
BEGIN
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ElSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>>
/*
Excellent


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� CASE�� (���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1
        THEN ���๮;
    WHEN ��2
        THEN ���๮;
    ELSE 
        ���๮;
END CASE;
*/




--�� ������ ����ִ� ���� ����...
--   Excellent, Good, Fail �� �����Ͽ� 
--   ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, CASE ������ Ȱ���Ͽ� �ۼ��Ѵ�.

-- �³��� �ۼ��� �ڵ�
/*
DECLARE
    GRADE CHAR; --@ 1���� ���ڸ� ���� �� ����
BEGIN
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ElSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;

CASE ����
    WHEN ��1
        THEN ���๮;
    WHEN ��2
        THEN ���๮;
    ELSE 
        ���๮;
END CASE;

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    CASE GRADE
    WHEN 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    WHEN 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Fail');
END CASE;
END;
--==>>
--Excellent

--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    CASE GRADE
        WHEN 'A'   
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
        END CASE;
END;
--==>>
/*
Excellent


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    CASE GRADE
        WHEN 'A'   
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
        END CASE;
END;
--==>>
/*
Good


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'C';
    
    CASE GRADE
        WHEN 'A'   
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
        END CASE;
END;
--==>>
/*
Fail


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� �ܺ� �Է� ó��

-- ACCEPT ��
-- ACCEPT ������ PROMPT '�޼���';
-- �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- ��&�ܺκ����� ���·� �����ϰ� �ȴ�.


--�� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

ACCEPT N1 PROMPT 'ù ��° ������ �Է��ϼ���';
ACCEPT N2 PROMPT '�� ��° ������ �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ���� �� �ʱ�ȭ
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
    TOTAL   NUMBER := 0;
BEGIN
    -- ���� �� ó��
    TOTAL := NUM1 + NUM2;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);

END;
--==>>
/*
10 + 20 = 30


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : [      890 ]

�Է¹��� �ݾ� �Ѿ� : 890��
ȭ����� : ����� 1, ��� 3, ���ʿ� 1, �ʿ� 4
*/
/*
--�� ���� �ۼ��� �ڵ�
ACCEPT INPUTM PROMPT '�ݾ� �Է� :';

DECLARE
    -- �ֿ� ���� ���� �� �ʱ�ȭ
    INPUTMONEY  NUMBER := &INPUTM;
    OBAK        NUMBER := 0;
    BAK         NUMBER := 0;
    OSIB        NUMBER := 0;
    SIB         NUMBER := 0;
    
BEGIN
    -- ���� �� ó��
    IF INPUTMONEY / 500 != 0
        THEN OBAKC = INPUTMONEY / 500 != 0
          IF INPUTMONEY - 500*
    ELSIF
    ELSE
    END;
    
    -- ��� ���
    -- DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || INPUTMONEY ||'��');
    -- ȭ����� : ����� 1, ��� 3, ���ʿ� 1, �ʿ� 4
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || OBAK || ', ��� ' || BAK || ', ���ʿ� ' || OSIB || ', �ʿ� ' || SIB);
END; 
*/

ACCEPT INPUT PROMPT '�ݾ� �Է�';

DECLARE
    --�� �ֿ� ���� ���� �� �ʱ�ȭ
    MONEY   NUMBER := &INPUT;     -- ������ ���� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;     -- ����� ���� ��Ƶ� ����(���� �������� ���� ���ϱ� ������...)
    M500    NUMBER;               -- 500�� ¥�� ������ ��Ƶ� ����
    M100    NUMBER;               -- 100�� ¥�� ������ ��Ƶ� ����
    M50     NUMBER;               --  50�� ¥�� ������ ��Ƶ� ����
    M10     NUMBER;               --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    -- �� ���� �� ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������.   �� 500���� ����
    M500 := TRUNC(MONEY/500);
    
    -- MONEY �� 500���� ������ ���� ������ �������� ���Ѵ���
    -- �� ����� �ٽ� MONEY�� ��Ƴ���.
    MONEY := MOD(MONEY, 500); 
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������.   �� 100���� ����
    M100 := TRUNC(MONEY/100);
    
    -- MONEY �� 100���� ������ ���� ������ �������� ���Ѵ���
    -- �� ����� �ٽ� MONEY�� ��Ƴ���.
    MONEY := MOD(MONEY, 100); 
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������.    �� 50���� ����
    M50 := TRUNC(MONEY/50);
    
    -- MONEY �� 100���� ������ ���� ������ �������� ���Ѵ���
    -- �� ����� �ٽ� MONEY�� ��Ƴ���.
    MONEY := MOD(MONEY, 50);
    
    -- MONEY �� 10���� ������ ���� ���ϰ� �������� ������.    �� 10���� ����
    M10 := TRUNC(MONEY/10);
    
    -- �� ��� ���
    --DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    --DBMS_OUTPUT.PUT_LINE('ȭ����� : �����' || M500 || ', ��� '|| M100 ||
    --                    ', ���ʿ� ' || M50 ||', �ʿ� ' || M10);
    --@ ���� ���� �𸣰����� ���� ������..... �ǵ� �ʿ��� || ��������!

    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 ||'��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || M500 || ', ��� ' || M100 || 
                        ', ���ʿ� ' || M50 || ', �ʿ� ' || M10);

END;
--> ���ε� ���� �Է� ��ȭâ�� 870 �Է�
--==>>
/*
�Է¹��� �ݾ� �Ѿ� : 870��
ȭ����� : ����� 1, ��� 3, ���ʿ� 1, �ʿ� 2

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ������ ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮;
    
    [EXIT WHEN ����;]     -- ������ ���� ��� �ݺ����� ����������.
    
END LOOP;
*/


--�� 1 ���� 10 ������ �� ��� (LOOP Ȱ��)
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
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����ϰ� �ȴ�.
--    ������ �ݺ��� ���۵� �� üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ���� �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE LOOP      -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/


--�� 1 ���� 10 ������ �� ��� (WHILE LOOP Ȱ��)
-- �� ���� �ۼ��� �ڵ�
/*
DECLARE
    N NUMBER;
BEGIN
    N := 1;
    WHILE LOOP
        N<=10;
        DBMS_OUTPUT.PUT_LINE(N);
        N = N + 1;
    END LOOP;
END;
*/

DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� FOR �ݺ���
-- FOR LOOP ~  END LOOP;
--@ �츮�� �ƴ� �ڹ� FOR ������ �� �ٸ�!
--@ ������ �ڹ� FOR EACH ������ ���!

-- 1. ������ �������� 1�� �����Ͽ�
--    ������ ������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� in [REVERSE] ���ۼ� .. ������ LOOP --@ . ��ü�� ����!
    -- ���๮;
END LOOP;
*/

--@like �ڹ�
/*@
FOR (int n : temp)
{

}
*/

-- �� 1 ���� 10 ������ �� ��� (FOR LOOP Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : [    2 ]

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/

--�� ���� �ۼ��� �ڵ�
/*
-- 1. LOOP ���� ���

ACCEPT INPUT PROMPT '���� �Է��ϼ���';

DECLARE
    INPUTN   NUMBER := &INPUT;
    N       NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(INPUTN || ' * ' || N ||' = '|| INPUTN*N);
        EXIT WHEN N>=9;
        N := N + 1;                
    END LOOP;
END;

-- 2. WHILE LOOP ���� ���
--
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;

ACCEPT INPUT PROMPT '���� �Է��ϼ��� : ';

DECLARE
    INPUTN  NUMBER := &INPUT;
    N       NUMBER;
BEGIN
    N := 1;
    WHILE N<9 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(INPUTN || ' * ' || N || ' = ' || INPUTN*N);
    END LOOP;
END;

-- 3. FOR LOOP ���� ���
--
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;

ACCEPT INPUT PROMPT '���� �Է��ϼ��� : ';
DECLARE
    INPUTN  NUMBER := &INPUT;
    N       NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(INPUTN || ' * ' || N || ' = ' || INPUTN*N);
    END LOOP;
END;
*/
-- �Բ� �ۼ��� �ڵ�
-- 1. LOOP ���� ���
ACCEPT NUM PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER := &NUM;
    N   NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N ||' = '|| (DAN*N));
        EXIT WHEN N>=9; --@ ��±����� ���� ����, �̹� 9�� ���� ���! 1-9���� ���
        N := N + 1;                
    END LOOP;
END;
--==>>
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- 2. WHILE LOOP ���� ���
ACCEPT NUM PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER := &NUM;
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<9 LOOP
        N := N +1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN*N));
    END LOOP;
END;
--==>>
/*
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- 3. FOR LOOP ���� ���
ACCEPT NUM PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER := &NUM;
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN*N));
    END LOOP;
END;
--==>>
/*
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/













