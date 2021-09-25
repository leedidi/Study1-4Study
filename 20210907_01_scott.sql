SELECT USER
FROM DUAL;
--==>> SCOTT

--���� JOIN(����) ����--

-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(Catersian Product)
--  �� ���̺��� ��ģ(������) ��� ����� ��
--@ �������ؼ� �� �Ⱦ�....

SELECT COUNT(*)
FROM EMP, DEPT;
--==>> 56

-- Equi Join : ���� ��Ȯ�� ��ġ�ϴ� �����͵鳢�� �����Ű�� ����
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
--==>>
/*
7782	CLARK	MANAGER	    7839	81/06/09	2450		10	    10	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		    81/11/17	5000		10	    10	ACCOUNTING	NEW YORK
7934	MILLER	CLERK	    7782	82/01/23	1300		10	    10	ACCOUNTING	NEW YORK
7566	JONES	MANAGER	    7839	81/04/02	2975		20	    20	RESEARCH	DALLAS
7902	FORD	ANALYST	    7566	81/12/03	3000		20	    20	RESEARCH	DALLAS
7876	ADAMS	CLERK	    7788	87/07/13	1100		20	    20	RESEARCH	DALLAS
7369	SMITH	CLERK	    7902	80/12/17	800		    20	    20	RESEARCH	DALLAS
7788	SCOTT	ANALYST	    7566	87/07/13	3000		20	    20	RESEARCH	DALLAS
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30	    30	SALES	    CHICAGO
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30	    30	SALES	    CHICAGO
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30	    30	SALES	    CHICAGO
7900	JAMES	CLERK	    7698	81/12/03	950		30	30	    S   ALES	    CHICAGO
7698	BLAKE	MANAGER	    7839	81/05/01	2850		30	    30	SALES	    CHICAGO
7654	MARTIN	SALESMAN	7698	81/09/28	1250   1400 30	    30	SALES	    CHICAGO
*/

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>
/*
7782	CLARK	MANAGER	    7839	81/06/09	2450		10	10	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		    81/11/17	5000		10	10	ACCOUNTING	NEW YORK
7934	MILLER	CLERK	    7782	82/01/23	1300		10	10	ACCOUNTING	NEW YORK
7566	JONES	MANAGER	    7839	81/04/02	2975		20	20	RESEARCH	DALLAS
7902	FORD	ANALYST	    7566	81/12/03	3000		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	    7788	87/07/13	1100		20	20	RESEARCH	DALLAS
7369	SMITH	CLERK	    7902	80/12/17	800		    20	20	RESEARCH	DALLAS
7788	SCOTT	ANALYST	    7566	87/07/13	3000		20	20	RESEARCH	DALLAS
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30	30	SALES	CHICAGO
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30	30	SALES	CHICAGO
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30	30	SALES	CHICAGO
7900	JAMES	CLERK	    7698	81/12/03	950		    30	30	SALES	CHICAGO
7698	BLAKE	MANAGER	    7839	81/05/01	2850		30	30	SALES	CHICAGO
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30	30	SALES	CHICAGO
*/

-- Non Equi Join : ���� �ȿ� ������ �����͵鳢�� �����Ű�� ����
SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- Equi Join �� ��(+)�� �� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5)�� ��� ����~!!!

SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� ����鵵 ��� ��ȸ�� ��Ȳ
--@ (+) : �߰� �ɼ� ����. �����ʿ� (+) ���̸�, ������ �� ������ �������� �ŵ�� ��
--@ (+) �ִ��ʿ� �ü��� ������... (+)�� ���� ���� ���ΰ�! �������� �� �����ش��� (+) ���� ���� ������� ÷������!
--@ (+) ���� ���� �޸𸮿� �� �÷��ְ�, �״��� (+) ���� ���� �߰�����!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ��� �Ҽӵ� ����� �ƹ��� ���� �μ��� ��� ��ȸ�� ��Ȳ


-- �� (+)�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ �� 
--    (+)�� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--    JOIN �� �̷������.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> ���� ���� ������... �̷��� ������ JOIN ������ �������� �ʴ´�.



-- 2. SQL 1999 CODE �� ��JOIN�� Ű���� ���� �� JOIN ���� ���
--                      ���� ������ ��WHERE�� ��� ��ON�� ���


-- CROSS JOIN
--@ �� X �� �̷��� ���εǱ� ������.... ũ�ν� ����
--  ��   ��
--@ , �� ũ�ν��� �ٲ� ��
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN 
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--�� INNSER JOIN �� INNER �� ���� ����
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--ON E.DETPNO = D.DEPTNO;- ��ֿ���������...?

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- OUTER JOIN 
--@ (+) ��򸮴ϱ� �ٲ㺸��! �ؼ� ����
--@ (+) �� �̰ɷ� �ذ�.... ���⼺�� LEFT/OUTER�� �ٲ�. LEFT : ������ ���ΰ�/ RIGHT : �������� ���ΰ�
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--@ ������ ���ΰ�

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--@ �������� ���ΰ�

--�� ������ ������ �� ���̺�(�� LEFT/ RIGHT) �� �����͸� ��� �޸𸮿� ������ ��
--   ������ �������� ���� �� ���̺���� �����͸� ���� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN �� �̷������.
/*
SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
*/ -- @ �� �� ��������.....?????

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--@ ���� ��!


--�� OUTER JOIN ���� OUTER �� ���� ����
SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D    -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D          -- INNER JOIN
ON E.DEPTNO = D.DEPTNO;


--------------------------------------------------------------------------------
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- �� �������... ������ CLERK �� ����鸸 ��ȸ...

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- �̷��� �������� �����ص� ��ȸ�ϴ� ���� ������ ����.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--@ ������ ������ �����̱� ������.. ON ���� ������ �̰� �ƴϴϱ�!
-- ������, �̿� ���� �����Ͽ� ��ȸ�� �� �ֵ��� �����Ѵ�.

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND JOB = 'CLERK';

--------------------------------------------------------------------------------

-- �� EMP ���̺�� DEPT ���̺��� �������
--    ������ MANAGER �� CLERK �� ����鸸
--    �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.

--�� ���� �ۼ��� �ڵ�
/*
SELECT DEPTNO "�μ���ȣ", DNAME "�μ���", ENAME "�����", JOB "������", SAL "�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
WHERE JOB IN ('MANAGER', 'CLERK')
*/

-- �� EMP ���̺�� DEPT ���̺��� �������
--    ������ MANAGER �� CLERK �� ����鸸
--    �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
--    --------  ------  ------  ------  ----
--     DEPTNO    DNAME   ENAME   JOB    SAL
--    --------  ------  ------- ------- -----
--      E,D       D        E      E      E

--@ ���� ���� �ľ� �ʿ�! � Į���� �ְ�... ������� ����////
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �߻�
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
241��, 8������ ���� �߻�
*/
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺���
--  �������(����� ���) �Ѵ�.

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��Ǵ� �÷��� �������� �ʴ� ��ȸ ������
--  ���� �߻����� �ʴ´�.
--==>>
/*
ACCOUNTING	CLARK	MANAGER	    2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	    1300
RESEARCH	JONES	MANAGER	    2975
RESEARCH	FORD	ANALYST 	3000
RESEARCH	ADAMS	CLERK	    1100
RESEARCH	SMITH	CLERK	    800
RESEARCH	SCOTT	ANALYST	    3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	    950
SALES	    BLAKE	MANAGER	    2850
SALES	    MARTIN	SALESMAN	1250
*/

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--  �μ�(DEPT), ���(EMP) �� � ���̺��� �����ص�
--  ������ ���࿡ ���� ��� ��ȯ�� ������ ����.

-- �� ������...
--    �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--    �θ� ���̺��� �÷��� ������ �� �ֵ��� �ؾ� �Ѵ�.

--@ ����� �÷����� ã��...!! -> 'DEPTNO'
--@ �θ��ڽ� ����? ����� Į������ �ϳ�/������ ����ִ°� �Ǵ�
--@ 10, 20, 30,,, �̰� �� �ϳ��� �ִ� ���̺��� �θ�! �׷��� �ߺ����� ����
--@ 10, 10, 20, 20,,,, �� �� �ټ� ���̺��� �ڽ� ���̺�!

SELECT *
FROM EMP;   -- �θ� ���̺�
SELECT *
FROM DEPT;  -- �ڽ� ���̺�

--�� �θ� �ڽ� ���̺� ���踦 ��Ȯ�� ������ �� �ֵ��� �Ѵ�.

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--@ ����� �÷� �ƴϾ �տ� ��ġ ������ִ°� ����.. �� ����ϸ� ���� �� �ѷ����� ����. ���ҽ� �Ҹ�!
--@ 10�� ����(���ҽ� �Ҹ� ��)

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--@ 5�� ����(���ҽ� �Ҹ� ��)
--> �� ���̺� �� �ߺ��� �÷�(���� �÷�)�� �ƴϴ���...
--  �Ҽ� ���̺��� ����� �� �ֵ��� �����Ѵ�.
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E LEFT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E LEFT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;
--
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;
-- ���� �Ϸ�...
-- �� ��/ �Ʒ� �� ����? �ڽ� ���̺� ������ ������ �� OPERATION(�μ�)�� �߰�!

--�� SELF JOIN (�ڱ� ����)
-- EMP ���̺��� ������ ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�. (~11:28)
/*
   E       E      E      E           E         E
 EMPNO   ENAME   JOB    MGR
                        EMPNO      ENAME      JOB
----------------------------------------------------------
�����ȣ ����� ������ �����ڹ�ȣ �����ڸ� ������������
-----------------------------------------------------------
  7369   SMITH  CLERK    7902      FORD      ANALYST
  EMP     EMP    EMP     EMP
  --------------------------- ��
                         EMP        EMP        EMP
                        ---------------------------- ��
*/
-- ���� �ۼ��� �ڵ�
/*
SELECT *
FROM EMP;

SELECT *
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT EMPNO "�����ȣ", ENAME "�����", JOB "������", MGR "�����ڹ�ȣ", �����ڸ�, �Ǹ���������
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E1.MGR "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB"�Ǹ���������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
*/

 EMPNO   ENAME   JOB    MGR
                        EMPNO      ENAME      JOB

SELECT EMPNO, ENAME, JOB, MGR, ENAME, JOB
FROM EMP;

SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB"������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--@ ���� �ϸ� KING�� ������ ����
--==>> KING ����

SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB"������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--@ �ϸ� �Ŵ��� ���� ŷ�� ����!
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER 	7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT			
*/

