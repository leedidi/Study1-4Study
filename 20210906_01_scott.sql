SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750        -- �μ���ȣ�� 10���� ������� �޿���
20	    10875       -- �μ���ȣ�� 20���� ������� �޿���
30	    9400        -- �μ���ȣ�� 30���� ������� �޿���
(null)  8000        -- �μ���ȣ�� �������� �ʴ� �����(NULL)�� �޿���
(null)	37025       -- ��� �μ��� ������� �޿���
*/


-- ������ ��ȸ�� ������
/*
10	         8750        -- �μ���ȣ�� 10���� ������� �޿���
20	        10875        -- �μ���ȣ�� 20���� ������� �޿���
30	         9400        -- �μ���ȣ�� 30���� ������� �޿���
����         8000        -- �μ���ȣ�� �������� �ʴ� �����(NULL)�� �޿���
���μ�	37025        -- ��� �μ��� ������� �޿���
*/
-- �̿� ���� ��ȸ�ϰ��� �Ѵ�.

SELECT CASE DEPTNO WHEN NULL 
                   THEN '����'
                   ELSE DEPTNO
       END "�μ���ȣ"
FROM TBL_EMP;
--==>> ���� �߻�
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
31��, 29������ ���� �߻�
*/
--@ THEN �ڿ� ELSE ���� �ڷ����� ���� �ʱ� ������ ���� �߻���

SELECT CASE DEPTNO WHEN NULL
                   THEN '����'
                   ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
(null)
(null)
(null)
(null)
(null)
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '����'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
����
����
����
����
����
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '����'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
       , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
����	8000
����	37025
*/


--�� GROUPING()

--==>>
/*
30	    9400	0
(null)	8000	0
20	    10875	0
10  	8750	0
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750	0
20	    10875	0
30	     9400	0
(null)	 8000	0
(null)	37025	1
*/

/*
10	         8750        -- �μ���ȣ�� 10���� ������� �޿���
20	        10875        -- �μ���ȣ�� 20���� ������� �޿���
30	         9400        -- �μ���ȣ�� 30���� ������� �޿���
����         8000        -- �μ���ȣ�� �������� �ʴ� �����(NULL)�� �޿���
���μ�	37025        -- ��� �μ��� ������� �޿���
*/

--�� ���� �ۼ��� �ڵ�
/*
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 0
            THEN '����'
            WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 1
            THEN '���μ�'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
       , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
*/

SELECT CASE WHEN THEN ELSE END "�μ���ȣ"
       , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '���μ�' END "�μ���ȣ"
       , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
(null)	     8000
���μ�	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '���μ�' END "�μ���ȣ"
       , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	     8000
���μ�	37025
*/


--�� TBL_SWAON ���̺��� ������ ���� ��ȸ�� �� �ֵ���
--   �������� �����Ѵ�.
/*
------------------------------
     ����      �޿���
------------------------------
      ��       XXXX
      ��       XXXX
      ����� XXXXX
------------------------------
*/

--�� ���� �ۼ��� �ڵ�
/*
SELECT *
FROM TBL_SAWON;

SELECT ����, �޿���
FROM TBL_SWAON;

SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
       WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
       ELSE 'Ȯ�κҰ�'
       END "����"
FROM TBL_SAWON;


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
       WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
       ELSE 'Ȯ�κҰ�'
       END "����"
       , GROUPING(����) WHEN 1 THEN '�����'
         ELSE ����
         END "����2"
FROM TBL_SAWON
GROUP BY ROLLUP(����);

SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
       WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
       ELSE 'Ȯ�κҰ�'
       END "����"
       , GROUPING(JUBUN) WHEN WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                         WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
         ELSE ����
         END "����2"
FROM TBL_SAWON
GROUP BY ROLLUP(����);
*/

SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
            ELSE '�����'
        END "����"
        , SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
           WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
           ELSE 'Ȯ�κҰ�'
           END "����"
           , SAL "�޿�"
           FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);



-- �� TBL_SWAON ���̺��� ������ ���� ���ɴ뺰 �ο��� ���·�
--    ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------------------
     ���ɴ�         �ο���
--------------------------------
      10              X
      20              X
      30              X
      40              X
      50              X
    ��ü             XX
--------------------------------
*/

--�� ���� �ۼ��� �ڵ�
/*
SELECT CASE WHEN T.���糪�� <20 THEN '10' 
            WHEN T.���糪�� <30 THEN '20'
            WHEN T.���糪�� <40 THEN '30'
            WHEN T.���糪�� <50 THEN '40'
            WHEN T.���糪�� <60 THEN '50'
            ELSE 'Ȯ�κҰ�' 
            END "���ɴ�"
FROM                  
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1
    END "���糪��" 
FROM TBL_SAWON
) T;

SELECT CASE WHEN T.���糪�� <20 THEN '10' 
            WHEN T.���糪�� <30 THEN '20'
            WHEN T.���糪�� <40 THEN '30'
            WHEN T.���糪�� <50 THEN '40'
            WHEN T.���糪�� <60 THEN '50'
            ELSE 'Ȯ�κҰ�' 
            END "���ɴ�"
FROM                  
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1
    END "���糪��" 
FROM TBL_SAWON
) T;



SELECT CASE WHEN T.���糪�� <20 THEN '10' 
            WHEN T.���糪�� <30 THEN '20'
            WHEN T.���糪�� <40 THEN '30'
            WHEN T.���糪�� <50 THEN '40'
            WHEN T.���糪�� <60 THEN '50'
            ELSE 'Ȯ�κҰ�' 
            END "���ڿ��ɴ�"
FROM                  
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1
    END "���糪��" 
FROM TBL_SAWON
) T
GROUP BY "���ڿ��ɴ�";


SELECT
FROM
(
    SELECT CASE WHEN T.���糪�� <20 THEN '10' 
                WHEN T.���糪�� <30 THEN '20'
                WHEN T.���糪�� <40 THEN '30'
                WHEN T.���糪�� <50 THEN '40'
                WHEN T.���糪�� <60 THEN '50'
                ELSE 'Ȯ�κҰ�' 
                END "���ڿ��ɴ�"
    FROM                  
    (
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1
        END "���糪��" 
    FROM TBL_SAWON
    ) T
) T2
GROUP BY(T2.���ڿ��ɴ�);
*/

-- ��� 1. (INLINE VIEW �� �� �� ��ø~!!!)

-- ���ɴ뺰 �ο���
SELECT CASE GROUPING(Q.���ɴ�) WHEN 0 THEN TO_CHAR(Q.���ɴ�)
            ELSE '��ü'
        END "���ɴ�"
     , COUNT(Q.���ɴ�) "�ο���"
FROM
(
    -- ���ɴ�
    SELECT CASE WHEN T.���� >= 50 THEN 50
                WHEN T.���� >= 40 THEN 40
                WHEN T.���� >= 30 THEN 30
                WHEN T.���� >= 20 THEN 20
                WHEN T.���� >= 10 THEN 10
                ELSE 0
           END "���ɴ�"
    FROM 
    (
    -- ����
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) -- 2000 - 1!
                ELSE 0
                END "����"
    FROM TBL_SAWON
    ) T
) Q
GROUP BY ROLLUP(Q.���ɴ�);
--==>>
/*
10	     2
20	     5
30	     2
40	     4
50  	 2
��ü	15
*/

-- ��� 2. (INLINE VIEW �� �� ���� ���~!!!)

--SELECT TRUNC(����, -1)
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0 END, -1) "���ɴ�"
           --@ ����Ŭ���� ������ �ѹ��� Ǯ���� ���� ����.. �ȿ� �ִ� �ֵ� ���� ���� �� ���� ġȯ�ؾ� Ǯ �� ����
FROM TBL_SAWON;

SELECT TRUNC(23, -1) "Ȯ��"
FROM DUAL;
--==>> 20 �� 23���� ���ɴ�

-- �ζ��� �� ����ؼ� ���� ��� �ۼ��غ���! ���� ��... --@ ���� �Ϸ�!

SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
            ELSE '��ü'
        END "���ɴ�"
     , COUNT(T.���ɴ�) "�ο���"
    
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE 0 END, -1) "���ɴ�"
               --@ ����Ŭ���� ������ �ѹ��� Ǯ���� ���� ����.. �ȿ� �ִ� �ֵ� ���� ���� �� ���� ġȯ�ؾ� Ǯ �� ����
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);


--�� ROLLUP Ȱ�� �� CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)  	8750        -- 10�� �μ� ��� ������ �޿���
20	    ANALYST	    6000    
20	    CLERK   	1900
20	    MANAGER	    2975
20	    (null)  	10875       -- 20�� �μ� ��� ������ �޿���
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600    
30	    (null)  	9400        -- 30�� �μ� ��� ������ �޿���
(null)  (null)		29025       -- ��� �μ� ��� ������ �޿���
*/


--�� CUBE() �� ROLLUP() ���� �ڼ��� ����� ��ȯ���� �� �ִ�.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10		(null)       8750       -- 10�� �μ� ��� ������ �޿���
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20		(null)      10875       -- 20�� �μ� ��� ������ �޿���
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30		(null)       9400       -- 30�� �μ� ��� ������ �޿���
(null)	ANALYST	     6000       -- ��� �μ� ANALYST ������ �޿���
(null)	CLERK	     4150       -- ��� �μ� CLERK ������ �޿���
(null)	MANAGER 	 8275       -- ��� �μ� MANAGER ������ �޿���
(null)	PRESIDENT	 5000       -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	 5600       -- ��� �μ� SALESMAN ������ �޿���
(null)  (null)		29025       -- ��� �μ� ��� ������ �޿���
*/


-- �� ROLLUP() �� CUBE() ��
--    �׷��� �����ִ� ����� �ٸ���. -- ����

-- ROLLUP(A, B, C)
-- �� (A, B, C) / (A, B) / (A) / ()

--   CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ���� ó�� ������ �ʹ� ���� ������� ��µǱ� ������
--     ������ ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������  ��ȸ�ϰ��� �ϴ� �׷츸 ��GROUPING SETS����
--     �̿��Ͽ� �����ִ� ����̴�.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
            END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
�μ���ȣ                                    ����     �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           2500
����                                     SALESMAN        5500
����                                     ��ü����        8000
��ü�μ�                                 ��ü����       37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
            END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
�μ���ȣ                                    ����      �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           2500
����                                     SALESMAN        5500
����                                     ��ü����        8000
��ü�μ�                                 ANALYST         6000
��ü�μ�                                 CLERK           6650
��ü�μ�                                 MANAGER         8275
��ü�μ�                                 PRESIDENT       5000
��ü�μ�                                 SALESMAN       11100
��ü�μ�                                 ��ü����       37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
            END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB))
ORDER BY 1, 2;
--==>>
/*
�μ���ȣ                                   ����       �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           2500
����                                     SALESMAN        5500
����                                     ��ü����        8000
��ü�μ�                                 ANALYST         6000
��ü�μ�                                 CLERK           6650
��ü�μ�                                 MANAGER         8275
��ü�μ�                                 PRESIDENT       5000
��ü�μ�                                 SALESMAN       11100
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
            END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())     -- ROLLUP() �� ���� ���
ORDER BY 1, 2;
--==>>
/*
�μ���ȣ                                   ����       �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           2500
����                                     SALESMAN        5500
����                                     ��ü����        8000
��ü�μ�                                 ��ü����       37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
            END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (JOB), ())     -- CUBE() �� ���� ���
ORDER BY 1, 2;
--==>>
/*
�μ���ȣ                                   ����      �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
����                                     CLERK           2500
����                                     SALESMAN        5500
��ü�μ�                                 ANALYST         6000
��ü�μ�                                 CLERK           6650
��ü�μ�                                 MANAGER         8275
��ü�μ�                                 PRESIDENT       5000
��ü�μ�                                 SALESMAN       11100
��ü�μ�                                 ��ü����       37025
*/


--�� TBL_EMP ���̺��� �Ի�⵵�� �ο����� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

/*
-----------------------
   �Ի�⵵    �ο���
-----------------------
   1980          1 
   1981         10
   1982          1
   1987          2
   2021          5
   ��ü         19
------------------------
*/
-- �³��� �ۼ��� �ڵ�
/*
--GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
       
SELECT CASE GROUPING(HIREDATE) WHEN 0 THEN SUBSTR(TO_CHAR(HIREDATE), 1, 4)
                               ELSE '��ü' END "�Ի�⵵"
     --, COUNT(�Ի�⵵) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(HIREDATE);

SELECT SUBSTR(TO_CHAR(HIREDATE), 1, 4) "�Ի�⵵"
FROM TBL_EMP;

-- �ƴ� �Ф�!!
SELECT CASE GROUPING(T.�Ի�⵵) WHEN 0 THEN TO_CHAR(T.�Ի�⵵)
                               ELSE '��ü' END "�Ի�⵵"       
       , COUNT(T.�Ի�⵵) "�ο���"
FROM
(
SELECT SUBSTR(TO_CHAR(HIREDATE), 1, 4) "�Ի�⵵"
FROM TBL_EMP
) T
GROUP BY ROLLUP(T.�Ի�⵵);
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987 	 2
2021 	 5
(null)	19
*/


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2021	 5
(null)	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY GROUPING SETS(EXTRACT(YEAR FROM HIREDATE), ()) --@ �⵵���� �ѹ�, ��ü�� �ѹ� �������
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2021	 5
(null)	19
*/


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
770��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
784��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
798��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
812��, 26������ ���� �߻�
*/
--@ ��÷ SELECT HIREDATE�� GROUP BY ������Ÿ���� �ٸ��� ������ ���� �߻��ϱ�? �ܼ��� �װ� �ƴ�


SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2021	 5
*/


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--@ SELECT�� '�Ľ� Ÿ��' ����.... �ܼ��� ���ڿ� Ÿ�Ը� �ٸ��� �������� �ƴ�! --�� �߿�!
--@ GROUP BY �Ȱ� ������ SELECT ������ �÷��� ó���ؾ� ��...!
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
843��, 26������ ���� �߻�
*/

SELECT TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY')) "�Ի�⵵"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2021	 5
*/

--------------------------------------------------------------------------------

--���� HAVING ����--

-- �� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� �������
--    �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.

--@ HAVING�� ������� �ʰ� �� ���� �ذ��� ����! �ذẸ�ٴ� � ������ �߻��ϴ��� Ȯ���غ���.
--�� ���� �ۼ��� �ڵ�
/*
SELECT *
FROM TBL_EMP;

SELECT �μ��� �� �޿��� 10000���� ���� ��츸 �μ��� �� �޿�
FROM TBL_EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;

-- �μ��� �� �޿�
SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
GROUP BY GROUPING SETS(DEPTNO)
ORDER BY 1;
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
--@ ���� ����

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--@ ���� �߻�

/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
906��, 7������ ���� �߻�
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
HAVING SUM(SAL) < 10000;
--@ �Ʒ��������� �� ������ �� ����! �μ���ȣ�� 20, 30�� �޸𸮿� �÷����� ó��! -> ���ҽ� �Ҹ� �� ŭ
--==>>
/*
30  9400
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20, 30)
   AND SUM(SAL) < 10000;
-- �μ���ȣ ��� �޸𸮿� �÷����� ó��! -> ���ҽ� �Ҹ� �� ŭ
--==>>
/*
30	9400
*/


--------------------------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ� ����--

-- �׷� �Լ� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- �̸�����... MSSQL �� �Ұ����ϴ�.
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
 9400
10875
 8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
-->> 10875
--@ ����! 2���������� ��ø ����


-- RANK()
-- DENSE_RANK()
--> ORACLE 9i ���� ����... MSSQL 2005 ���� ����...

--�� ���� ���������� RANK() �� DENSE_RANK() �� ����� �� ���� ������
--   �̸� ��ü�Ͽ� ������ ������ �� �ִ� ����� �����ؾ� �Ѵ�.

-- ���� ���, �޿��� ������ ���ϰ��� �Ѵٸ�...
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- Ȯ���� ���ڿ� +1 �� �߰� �������ָ� �װ��� �� ����� �ȴ�.

-- 80 90 10 50 �� 3
--          --

SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--==>> 14 �� SMITH �� �޿� ���

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;
--==>> 7 �� ALLER �� �޿� ���

SELECT ENAME, SAL, RANK() OVER(ORDER BY SAL DESC)
FROM EMP;


-- �� ���� ��� ���� (��� ���� ����)
--    ���� ������ �ִ� ���̺��� �÷���
--    ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
--    �츮�� �� �������� ���� ��� ���� ��� �θ���.

SELECT ENAME "�����", SAL "�޿�", 1 "�޿����"
FROM EMP;

SELECT E1.ENAME "�����", E1.SAL "�޿�", (SELECT COUNT(*) + 1
                                          FROM EMP E2
                                          WHERE E2.SAL > E1.SAL) "�޿����" --@ Ư�� ������ �ȿ� ���..
FROM EMP E1;
--==>>
/*
SMITH	800	    14
ALLEN	1600	 7
WARD	1250	10
JONES	2975	 4
MARTIN	1250	10
BLAKE	2850	 5
CLARK	2450	 6
SCOTT	3000	 2
KING	5000	 1
TURNER	1500	 8
ADAMS	1100	12
JAMES	 950	13
FORD	3000	 2
MILLER	1300	 9
*/

-- �� EMP ���̺��� �������
--    �����, �޿�, �μ���ȣ, �μ��޿������, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--    ��, RANK() �Լ��� ������� �ʰ�, ��� ���� ������ Ȱ���� �� �ֵ��� �Ѵ�.

--�� ���� �ۼ��� �ڵ�
/*
SELECT *
FROM EMP;

SELECT ENAME "�����", SAL "�޿�", �μ���ȣ "DEPTNO"
     , �μ����޿������
     , ��ü�޿����
FROM EMP;

SELECT E1.ENAME "�����", E1.SAL "�޿�", E1.DEPTNO "�μ���ȣ" 
     --,"�μ����޿������"
     , (SELECT COUNT(*) + 1 "��ü�޿����"
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "��ü�޿����"
FROM EMP E1;

SELECT E1.ENAME "�����", E1.SAL "�޿�", E1.DEPTNO "�μ���ȣ" 
     --,"�μ����޿������"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "��ü�޿����"
    ,   (SELECT COUNT(*) + 1 
        FROM EMP E3
        WHERE E3.DEPTNO = E1.DEPTNO AND E3.SAL > E1.SAL) "�μ����޿����"
FROM EMP E1
ORDER BY DEPTNO;
*/

SELECT ENAME "�����", SAL "�޿�", DEPTNO "�μ���ȣ"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL AND E2.DEPTNO = E1.DEPTNO) "�μ����޿����"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "��ü�޿����"
FROM EMP E1
ORDER BY E1.DEPTNO, E1.SAL DESC;



SELECT COUNT(*) + 1
FROM EMP E2
WHERE SAL > 1600 AND DEPTNO = 30
ORDER BY DEPTNO;

SELECT ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO;

SELECT *
FROM EMP
ORDER BY DEPTNO;

-- �� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------------------------------------------------------
   �����   �μ���ȣ   �Ի���      �޿�      �μ����Ի纰�޿�����
--------------------------------------------------------------------
   CLERK       10     1981-06-09   2450        2450  
   KING        10     1981-11-17   5000        7450
   MILLER      10     1982-01-23   1300        8750
   SMITH       20     1980-12-17    800         800
                          :  
*/

/*
SELECT �����, �μ���ȣ, �Ի���, �޿�, �μ����Ի纰�޿�����
FROM EMP;

SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , "�μ����Ի纰�޿�����"
FROM EMP;

-
, (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL AND E2.DEPTNO = E1.DEPTNO) "�μ����޿����"
-

SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO AND E1.HIREDATE >= E2.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY E1.DEPTNO, E1.HIREDATE;
*/

SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , (1)"�μ����Ի纰�޿�����"
FROM EMP
ORDER BY 2, 3;


SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , (SELECT SUM(SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	81/06/09	2450	 2450
KING	10	81/11/17	5000	 7450
MILLER	10	82/01/23	1300	 8750
SMITH	20	80/12/17	800	      800
JONES	20	81/04/02	2975 	 3775
FORD	20	81/12/03	3000	 6775
SCOTT	20	87/07/13	3000	10875
ADAMS	20	87/07/13	1100	10875
ALLEN	30	81/02/20	1600	 1600
WARD	30	81/02/22	1250	 2850
BLAKE	30	81/05/01	2850	 5700
TURNER	30	81/09/08	1500	 7200
MARTIN	30	81/09/28	1250	 8450
JAMES	30	81/12/03	950	     9400
*/


--�� TBL_EMP ���̺��� �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ִ� �������� �����Ѵ�.
/*
--------------------------------------
    �Ի���             �ο���
--------------------------------------
    XXXX-XX                 X
--------------------------------------
*/

/*
SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , (SELECT SUM(SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;
*/

SELECT ENAME, HIREDATE
FROM TBL_EMP
ORDER BY 2;

/*
--------------------------------------
    �Ի���             �ο���
--------------------------------------
     2021-09                5
--------------------------------------
*/

-- ���� �ۼ��� �ڵ�
/*
SELECT ENAME, HIREDATE
     , (SELECT HIREDATE
        FROM TBL_EMP E2 
        WHERE �Ի��� ��� ���� ���� ������ ��) "�Ի���"
     , (SELECT COUNT(*)
        FROM TBL_EMP E2 
        WHERE E1.HIREDATE = E2.HIREDATE) "�ο���"
FROM TBL_EMP E1
ORDER BY 2;
*/

SELECT TO_CHAR(HIREDATE,'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
     FROM TBL_EMP
     GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
2021-09	5
1981-05	1
1981-12	2
1982-01	1
1981-09	2
1981-02	2
1981-11	1
1980-12	1
1981-04	1
1987-07	2
1981-06	1
*/

SELECT TO_CHAR(HIREDATE,'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (5);
--=>> 2021-09	5


SELECT MAX(COUNT(*))
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 5

--@ 5 ���� �� ���� �������!
SELECT TO_CHAR(HIREDATE,'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM TBL_EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>> 2021-09	5


--------------------------------------------------------------------------------

--���� ROW_NUMBER() ����--
--@ ��ũ��Ʈ ��½� ���� ���ʿ� �ִ� ���ڿ��� ����

SELECT ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC)"�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;


--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴� ���� ���鿡����... �̰����� ���鿡����... �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE�� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� ����.


--�� ����
CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(30)
, GRADE     CHAR(10)
);
--==>> Table TBL_AAA��(��) �����Ǿ����ϴ�.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '�չ���', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '���ش�', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '�ּ���', 'D');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '���±�', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '����ȭ', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '�չ���', 'A');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7


SELECT *
FROM TBL_AAA;
--==>>
/*
1	�չ���	A         
2	���ش�	B         
3	������	A         
4	�ּ���	D         
5	���±�	A         
6	����ȭ	A         
7	�չ���	A         
*/


COMMIT;
--==>> Ŀ�� �Ϸ�.


UPDATE TBL_AAA
SET GRADE='A'
WHERE NAME='�ּ���';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_AAA;


UPDATE TBL_AAA
SET NAME = '���ش�'
WHERE GRADE = 'A';

UPDATE TBL NAME = '�չ���'
SET GRADE = B
WHERE NAME = '�չ���';


--�� SEQUENCE (������ : �ֹ���ȣ) ����
--   �� �������� �ǹ� : 1.(�Ϸ���) �������� ��ǵ�  2.(���, �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD   -- ������ ���� �⺻ ����(MSSQL �� IDENTITY �� ������ ����)
START WITH 1                -- ���۰�
INCREMENT BY 1              -- ������
NOMAXVALUE                  -- �ִ밪 ���� ����
NOCACHE;                    -- ĳ�� ��� ����(����) 
--@ NOCACHE ĳ�� : ���࿡ ������ ����.. ��ȣǥ ��������. ��ȣǥ �տ� �� ����... û�������� ���� ��ȣǥ �� �̾Ƴ���
--@ �ð� ���� ����, BUT �������� ���������� ����. �̿���� �ʾҴµ� ��ȣ�� ���� �پ������ ������ ����� ����....
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� ���̺� ����(TBL_BOARD)
CREATE TABLE TBL_BOARD              -- TBL_BOARD �̸��� ���̺� ���� �� �Խ���           
( NO        NUMBER                  -- �Խù� ��ȣ       -- �� --@ ����ڰ� �ۼ� ��
, TITLE     VARCHAR2(50)            -- �Խù� ����       -- �� --@ ����ڰ� �ۼ� ��
, CONTENTS  VARCHAR2(2000)          -- �Խù� ����       -- ��
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���     -- �� --@ �Խ��� ������ ���� ����ڰ� ��������/�ƴҼ���..
, PW        VARCHAR2(20)            -- �Խù� �н�����   -- ��
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���     -- ��
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� ������ �Է� �� �Խ��ǿ� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ѽ�~1��', '���� 1��������', '����ȣ', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ǰ�����', '�ٵ� �ǰ� ì��ô�', '������', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� �� ����', '�մ���', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���ڱ� �񰡿���', '������', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ϰ������', '�ڲ� ������', '��ȿ��', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����', '������� ��� �ϳ���', '������', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����', '������ �����', '��ȿ��', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	    ���� 1��������	        ����ȣ	JAVA006$	21/09/06
2	�ǰ�����	    �ٵ� �ǰ� ì��ô�	    ������	JAVA006$	21/09/06
3	������	        ���� �� ����	        �մ���	JAVA006$	21/09/06
4	������	        ���ڱ� �񰡿���	        ������	JAVA006$	21/09/06
5	�����ϰ������	�ڲ� ������	            ��ȿ��	JAVA006$	21/09/06
6	����	        ������� ��� �ϳ���	������	JAVA006$	21/09/06
7	����	        ������ �����	    ��ȿ��	JAVA006$	21/09/06
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=5;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '�� �׳� �߷���', '������', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	���� 1��������	        ����ȣ	JAVA006$	21/09/06
3	������	    ���� �� ����	        �մ���	JAVA006$	21/09/06
4	������	    ���ڱ� �񰡿���	        ������	JAVA006$	21/09/06
6	����	    ������� ��� �ϳ���	������	JAVA006$	21/09/06
7	����	    ������ �����	    ��ȿ��	JAVA006$	21/09/06
8	������	    �� �׳� �߷���	        ������	JAVA006$	21/09/06
*/

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=7;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	���� 1��������	        ����ȣ	JAVA006$	21/09/06
3	������	    ���� �� ����	        �մ���	JAVA006$	21/09/06
4	������	    ���ڱ� �񰡿���	        ������	JAVA006$	21/09/06
6	����	    ������� ��� �ϳ���	������	JAVA006$	21/09/06
*/

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���¿�', '�� ������ �־��', '������', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>
/*
1	�ѽ�~1��	���� 1��������	        ����ȣ	JAVA006$	21/09/06
3	������	    ���� �� ����	        �մ���	JAVA006$	21/09/06
4	������	    ���ڱ� �񰡿���	        ������	JAVA006$	21/09/06
6	����	    ������� ��� �ϳ���	������	JAVA006$	21/09/06
9	���¿�	    �� ������ �־��	    ������	JAVA006$	21/09/06
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	���¿�	    ������	21/09/06
4	����	    ������	21/09/06
3	������	    ������	21/09/06
2	������	    �մ���	21/09/06
1	�ѽ�~1��	����ȣ	21/09/06
*/


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� ����', '����ȣ', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*  
6	������	    ����ȣ	21/09/06
5	���¿�     	������	21/09/06
4	����	    ������	21/09/06
3	������	    ������	21/09/06
2	������	    �մ���	21/09/06
1	�ѽ�~1��	����ȣ	21/09/06
*/

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	������	    ����ȣ	21/09/06
4	���¿�	    ������	21/09/06
3	����	    ������	21/09/06
2	������	    ������	21/09/06
1	�ѽ�~1��   	����ȣ	21/09/06
*/


