SELECT USER
FROM DUAL;
--==>> HR

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.
--�� EMPLOYEES ���̺��� SALARY ��
--  �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--  Finace �� 10%
--  Executive �� 15%
--  Accounting �� 20%
--  (������ ���� �� ��� Ȯ�� �� ROLLBACK)

-- ������ �� 0%(������ ����)

SELECT *
FROM DEPARTMENTS;
--�³��� �ۼ��� �ڵ�
/*
--SET
SELECT Finace�� SALARY*1.10, Executive�� SALARY*1.15, Accounting�� ������*1.20
FROM EMPLOYEES
WHERE �� �μ� �̸��� Finace, Executive, Accounting;

SELECT Finace�� SALARY*1.10, Executive�� SALARY*1.15, Accounting�� ������*1.20
FROM EMPLOYEES
WHERE �� �μ� �̸��� Finace, Executive, Accounting;

SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;
-- EMPLOYEES�� DEAPRTMENT ��ġ�� �÷� : DEPARTMENT_ID

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME IN ('Finace', 'Executive', 'Accounting'); );


SELECT (DEPARTMENT_ID * 1.1
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME IN ('Finace', 'Executive', 'Accounting') )
FROM EMPLOYEES; 

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE='Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE='Sales Manager')
      AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006; --@ �����̴ϱ� AND/OR ���!

--Finace�� SALARY*1.10, Executive�� SALARY*1.15, Accounting�� ������*1.20
UPDATE EMPLOYEES
SET SALARY =  (SELECT SALARY * 1.1
              FROM DEPARTMENTS
              WHERE JOB_TITLE='Sales Manager'
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME IN ('Finace', 'Executive', 'Accounting');
*/


SELECT *
FROM EMPLOYEES;
SELECT *
FROM DEPARTMENTS;


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finace'�� �μ����̵�)
                                THEN SALARY * 1.1
                                WHEN ('Executive'�� �μ����̵�)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'�� �μ����̵�)
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END
WHERE DEPARTMENT_ID IN ('Finace'�� �μ����̵�, 'Exceutive'�� �μ����̵�, 'Accounting'�� �μ����̵�)


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finace'�� �μ����̵�)
                                THEN SALARY * 1.1
                                WHEN ('Executive'�� �μ����̵�)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'�� �μ����̵�)
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END;
--@ WHERE �������� ��� �̹� SET������ ���� ��! �Ѵ� ���� ����.. ���
--@ WHER ���� �޸𸮿� �ۿø��� ������ �� ������ �޸� ���� �Ƴ����� ����


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finace'�� �μ����̵�)
                                THEN SALARY * 1.1
                                WHEN ('Executive'�� �μ����̵�)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'�� �μ����̵�)
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END;

-- ('Finace'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME='Finance'; --@ ��ҹ��� ������ ���� ����!
--==>> 100

-- ('Executive'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME='Executive';
--==>> 90

-- ('Accounting'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME='Accounting';
--==>> 110



UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END
WHERE DEPARTMENT_ID IN ((SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='Finance')
                        , (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='Executive')
                        , (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='Accounting'));
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
--@ ���������� ����Ǵ� ���� ���� ������Ʈ �Ǿ�� �ϱ� ������ ��ȣ�� �ѹ��� ������!

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (90, 100, 110);
--==>> 
/*
Steven	King	SKING	515.123.4567	2003-06-17	AD_PRES	27600			90
101	Neena	Kochhar	NKOCHHAR	515.123.4568	2005-09-21	AD_VP	19550		100	90
102	Lex	De Haan	LDEHAAN	515.123.4569	2001-01-13	AD_VP	19550		100	90
108	Nancy	Greenberg	NGREENBE	515.124.4569	2002-08-17	FI_MGR	13208.8		101	100
109	Daniel	Faviet	DFAVIET	515.124.4169	2002-08-16	FI_ACCOUNT	9900		108	100
110	John	Chen	JCHEN	515.124.4269	2005-09-28	FI_ACCOUNT	9020		108	100
111	Ismael	Sciarra	ISCIARRA	515.124.4369	2005-09-30	FI_ACCOUNT	8470		108	100
112	Jose Manuel	Urman	JMURMAN	515.124.4469	2006-03-07	FI_ACCOUNT	8580		108	100
113	Luis	Popp	LPOPP	515.124.4567	2007-12-07	FI_ACCOUNT	7590		108	100
205	Shelley	Higgins	SHIGGINS	515.123.8080	2002-06-07	AC_MGR	14409.6		101	110
206	William	Gietz	WGIETZ	515.123.8181	2002-06-07	AC_ACCOUNT	9960		205	110
*/

ROLLBACK;
--==>> �ѹ� �Ϸ�.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END;
--==>> 107�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (90, 100, 110);
--==>>
/*
100	Steven	King	SKING	515.123.4567	2003-06-17	AD_PRES	27600			90
101	Neena	Kochhar	NKOCHHAR	515.123.4568	2005-09-21	AD_VP	19550		100	90
102	Lex	De Haan	LDEHAAN	515.123.4569	2001-01-13	AD_VP	19550		100	90
108	Nancy	Greenberg	NGREENBE	515.124.4569	2002-08-17	FI_MGR	13208.8		101	100
109	Daniel	Faviet	DFAVIET	515.124.4169	2002-08-16	FI_ACCOUNT	9900		108	100
110	John	Chen	JCHEN	515.124.4269	2005-09-28	FI_ACCOUNT	9020		108	100
111	Ismael	Sciarra	ISCIARRA	515.124.4369	2005-09-30	FI_ACCOUNT	8470		108	100
112	Jose Manuel	Urman	JMURMAN	515.124.4469	2006-03-07	FI_ACCOUNT	8580		108	100
113	Luis	Popp	LPOPP	515.124.4567	2007-12-07	FI_ACCOUNT	7590		108	100
205	Shelley	Higgins	SHIGGINS	515.123.8080	2002-06-07	AC_MGR	14409.6		101	110
206	William	Gietz	WGIETZ	515.123.8181	2002-06-07	AC_ACCOUNT	9960		205	110
*/

SELECT *
FROM EMPLOYEES;


ROLLBACK;
--==>> �ѹ� �Ϸ�.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
             END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN('Finance', 'Executive', 'Accounting'));
                        --@ CASE WHEN THEN ELSE... �� �̷��� ���� �� ������ WHERE���� �̷��� ���� �� ����
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


ROLLBACK;
--==>> �ѹ� �Ϸ�.


--���� DELETE ����--

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴ� �� ����ϴ� ����.

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];

--@ ������ �� �ΰ���!
--@ 1. DELETE���� FROM�� �־ ��� ������... �츮�� ����� ��! SELECT ���� ���� Ȯ���ϰ� ���� �ű� ����
--@ 2. WHERE�� ��� ������... �ϴ� ���� ���� ������ ������ �� �ʿ��ϸ� �׶� ������ ��

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;
--==>> �ѹ� �Ϸ�.


--�� EMPLOYEES ���̺��� �������� ������ �����Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.

--�� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ���)
--   �ٸ� ���̺�(Ȥ�� �ڱ� �ڽ� ���̺�)�� ���� �������ϴ� ���
--   �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--   �׿� ���� ������ �˾ƾ� �Ѵ�.

/*
--�� ���� �ۼ��� �ڵ�
SELECT *
FROM EMPLOYEES
WHERE �μ����� IT;

--DEPARTMENT_ID...
SELECT *
FROM EMPLOYEES
WHERE �μ� ���̵� IT�� �μ����̵�(DEPARTMENT_ID);

SELECT *
FROM DEPARTMENTS;

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');

--==>>
--103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03	IT_PROG	9000		102	60
--104	Bruce	Ernst	BERNST	590.423.4568	2007-05-21	IT_PROG	6000		103	60
--105	David	Austin	DAUSTIN	590.423.4569	2005-06-25	IT_PROG	4800		103	60
--106	Valli	Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
--107	Diana	Lorentz	DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� �߻�
--����� 309 �࿡�� �����ϴ� �� ���� �߻� -
--DELETE
--FROM EMPLOYEES
--WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
--                       FROM DEPARTMENTS
--                       WHERE DEPARTMENT_NAME = 'IT')
--���� ���� -
--ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT' �� �μ���ȣ);


--('IT' �� �μ���ȣ)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*  
103	Alexander	Hunold	    AHUNOLD	    590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	    Ernst	    BERNST	    590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	    Austin	    DAUSTIN	    590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	    Lorentz	    DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


--���� ��(VIEW) ����--

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵���
--    ��ȭ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸 ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

--    ������ ���̺��̶� �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ�
--    �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̸�
--    �� ������ �����س��� SQL �����̶�� �� �� �ִٴ� ���̴�.
--@   ������ ���̺��� ��������°� �ƴ϶�, �� ����� �������� ����Ǿ �� ����� �������� �ٽ� ����Ǵ� ��!

-- 2. ���� �� ����
-- CREATE [OR REPLCAE] VIEW ���̸�
-- [(ALIAS[, ALIAS, ...])] --@ ��Ī
-- AS
-- ��������(SUBQUERY)
-- [WITH CHECK OPRION]
-- [WITH READ ONLY];

-- �� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.

--�� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_EMPLOYEES;

--�� ��(VIEW) ���� Ȯ��
DESC VIEW_EMPLOYEES;
--==>>
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25)
*/

--@�� ������ ��!
-- �� ��(VIEW) �ҽ� Ȯ��                  -- CHECK~!!!
SELECT VIEW_NAME, TEXT                    -- TEXT
FROM USER_VIEWS                           -- USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>> 
/*
VIEW_EMPLOYEES	"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
*/
--@ �並 ������� ������ �״�� ������! �並 ����� � ������ ���ư����� Ȯ���غ��� �ʹٸ� ��ҽ��� �� �ڵ� ���!


--@ SQL ��Ʈ ��!










