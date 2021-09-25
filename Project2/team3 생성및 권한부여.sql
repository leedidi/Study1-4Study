CREATE TABLESPACE TBS_TEAM3                -- CREATE ���� ��ü�� �� ����
DATAFILE 'C:\TESTORADATA\TBS_TEAM3.DBF'    -- ���������� ����Ǵ� ������ ����
SIZE 4M                                     -- ������ ������ ������ �뷮
EXTENT MANAGEMENT LOCAL                     -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;    

--==>> TABLESPACE TBS_TEAM3��(��) �����Ǿ����ϴ�.

SELECT *                -- ��� �׸� ��ȸ
FROM DBA_TABLESPACES;

CREATE USER team3 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM3;
--==>> User TEAM3��(��) �����Ǿ����ϴ�.

GRANT CREATE SESSION TO team3;
--==>> Grant��(��) �����߽��ϴ�.

GRANT CREATE TABLE TO team3;
--==>> Grant��(��) �����߽��ϴ�.

ALTER USER team3
QUOTA UNLIMITED ON TBS_TEAM3;
--==>> User TEAM3��(��) ����Ǿ����ϴ�.

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO team3;
--==>> Grant��(��) �����߽��ϴ�.

GRANT CREATE VIEW TO team3;
--==>> Grant��(��) �����߽��ϴ�.
