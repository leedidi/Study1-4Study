SELECT USER
FROM DUAL;
--==>> HR


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

-- HR ���� ���� ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--   �������� ������ FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
--   �׸��� ��ȸ�Ѵ�.

--�� ���� �ۼ��� �ڵ�
--1. 92 �ڵ�
--1.
SELECT *
FROM HR.JOBS;
--2.
SELECT *
FROM HR.EMPLOYEES;
--3.
SELECT *
FROM HR.DEPARTMENTS;

--1, 2 ����Į�� : JOB_ID
--2, 3 ����Į�� : DEPARTMENT_ID

SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
  AND ���̺��2.�÷���2 = ���̺��3.�÷���2;
  
SELECT HR.EMPLOYEES.FIRST_NAME, HR.JOBS.JOB_TITLE, HR.DEPARTMENTS.DEPARTMENT_NAME
FROM  HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS
WHERE HR.JOBS.JOB_ID = HR.EMPLOYEES.JOB_ID
  AND HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID(+);

--2. 99 �ڵ�
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���1
               JOIN ���̺��3
               ON ���̺��2.�÷���2 = ���̺��3.�÷���2;
               
SELECT HR.EMPLOYEES.FIRST_NAME, HR.JOBS.JOB_TITLE, HR.DEPARTMENTS.DEPARTMENT_NAME
FROM HR.EMPLOYEES JOIN HR.JOBS
                  ON HR.JOBS.JOB_ID = HR.EMPLOYEES.JOB_ID 
                  LEFT JOIN HR.DEPARTMENTS
                  ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID;
                  
-- (+), (LEFT JOIN) ��� 107�� ����!

SELECT COUNT(*)
FROM EMPLOYEES;
--==>> 107

SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 106



-- EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
-- �������� ������ ������ ���� ��ȸ�Ѵ�.
-- FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
-- (~12:28)

--�� ���� �ۼ��� �ڵ�
-- ��� ���̺� ��ȸ
--1
SELECT *
FROM EMPLOYEES;

--2
SELECT *
FROM DEPARTMENTS;

--3
SELECT *
FROM JOBS;

--4
SELECT *
FROM LOCATIONS;

--5
SELECT *
FROM COUNTRIES;

--6
SELECT *
FROM REGIONS;

--
/*
1-2 : DEARTMENT_ID
1-3 : JOB_ID
1-4 : ��ġ�°� ����.. 2-4: LOCATION_ID
1-5 : ��ġ�°� ����.. 4-5: COUNTRY_ID
1-6 : ��ġ�°� ����...5-7: REGION_ID
*/

-- EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
-- �������� ������ ������ ���� ��ȸ�Ѵ�.
-- FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
-- (~12:28)
--1. 92�ڵ� ���
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
  AND ���̺��2.�÷���2 = ���̺��3.�÷���2;
  
SELECT *
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND E.MANAGER_ID = D.MANAGER_ID(+)
  AND E.JOB_ID = J.JOB_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
-- + �ٿ��� 107�� ����!
  
--2. 99�ڵ� ���
--@ ���� ����� �������� �ϸ� �� ��...