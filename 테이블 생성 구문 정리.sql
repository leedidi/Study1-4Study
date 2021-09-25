    
-- �� ���̺� ���� ���� �ۼ�

--> ���̺� �������� �ȿ��� �ۼ��Ϸ���... �̷���!
CREATE TABLE JOB_HISTORY03 
(...
, CONSTRAINT JHIST03_EMP_ID_ST_DATE_PK PRIMARY KEY(EMPLOYEE_ID, START_DATE)
, CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );


--1. PRIMARY KEY ���� ���� �ۼ� ���� (P.K)
ALTER TABLE �ش����̺��
ADD CONSTRAINT TBL�� �ش����̺��_�ش��÷���_PK PRIMARY KEY(�ش��÷���);
-----------------------------------------------------------------------
--ex1> �÷� ������ ����
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TSET4_COL1_PK PRIMARY KEY(COL1);
--ex2> ���̺� ������ ����
CREATE TABLE JOB_HISTORY03 
(...
, CONSTRAINT JHIST03_EMP_ID_ST_DATE_PK PRIMARY KEY(EMPLOYEE_ID, START_DATE));


--2. FORIGN KEY ���� ���� �ۼ� ���� (F.K)
ALTER TABLE ����޴����̺��
ADD CONSTRAINT TBL�� ����޴����̺��_�ش��÷���_FK FOREIGN KEY(�ش��÷���)
               REFERENCES ���������̺����ü(�ش��÷���); -- TBL���Ŵ� ����.... CONSTRINT �� FOREIGN ���̴� Ű�̸�.
                                                           -- ���� ���Ƿ� ���� ����!
-------------------------------------------------------------------------------
--ex1> �÷� ������ ����
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID);
--ex2> ���̺� ������ ����
CREATE TABLE TBL_EMP3
(...
, CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID));
                 
--3. CHECK KEY ���� ���� �ۼ� ���� 
ALTER TABLE �ش����̺��
ADD CONSTRAINT TBL���ش����̺��_�ش��÷���_CK CHECK(����);
--------------------------------------------------------------------------------
--ex1> �÷� ������ ����
ALTER TABLE TBL_TEST10
ADD CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--ex2> ���̺� ������ ����
CREATE TABLE TBL_TEST10
(...
, CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));

--4. NOT NULL ���� (NOT NULL ������ C�� ��..!)
ALTER TABLE �ش����̺��
MODIFY �ش��÷��� NOT NULL;

ALTER TABLE �ش����̺��
ADD CONSTRAINT TBL���ش����̺��_�ش��÷���_NN CHECK("�ش��÷���" IS NOT NULL);  -- " "�� ���Ƿ� �ְ� ���� ����..
-- ������ �����Ǿ� �ִ� ���̺� NOT NULL ���������� �߰��� ���
-- ADD ���� MODIFY ���� �� ���� ���ȴ�.
--@�� ADD ������ MODIFY �� �����ϱ⸦ ����!

CREATE TABLE EMPLOYEES03
( EMPLOYEE_ID       NUMBER(6)
, FIRST_NAME        VARCHAR2(20)
, LAST_NAME         VARCHAR2(25)    CONSTRAINT EMP03_LAST_NAME_NN NOT NULL
, EMAIL             VARCHAR2(25)    CONSTRAINT EMP03_EMAIL_NN NOT NULL
, PHONE_NUMBER      VARCHAR2(20)
, HIRE_DATE         DATE            CONSTRAINT EMP03_HIRE_DATE_NN NOT NULL
, JOB_ID            VARCHAR2(10)    CONSTRAINT EMP03_JOB_NN NOT NULL
, SALARY            NUMBER(8,2)
); --�䷱ ������ ���� �������� �ִ� ��!
--------------------------------------------------------------------------------
--ex1> �÷� ������ ����
--ex1-1> MODIFY �� NOT NULL �������Ǹ� �ܵ����� ���� ����
ALTER TABLE TBL_TEST14
MODIFY COL2 NOT NULL;
--ex1-2> ADD
ALTER TABLE TBL_TEST14
ADD CONSTRAINT TEST14_COL2_NN CHECK("COL2" IS NOT NULL);.
--ex2> ���̺� ������ ����
CREATE TABLE TBL_TEST14
(...
, CONSTRAINT TEST14_COL2_NN CHECK("COL2" IS NOT NULL));

CREATE TABLE EMPLOYEES03
( EMPLOYEE_ID       NUMBER(6)
, FIRST_NAME        VARCHAR2(20)
, LAST_NAME         VARCHAR2(25)    CONSTRAINT EMP03_LAST_NAME_NN NOT NULL
);
-- �Ѵ� ������ ��... �ٵ� �ϴ� �ʱ⿡�� ù��° ������� ��������(, CONSTRAINT...)
