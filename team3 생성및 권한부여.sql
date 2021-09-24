CREATE TABLESPACE TBS_TEAM3                -- CREATE 유형 개체명 → 생성
DATAFILE 'C:\TESTORADATA\TBS_TEAM3.DBF'    -- 물리적으로 연결되는 데이터 파일
SIZE 4M                                     -- 물리적 데이터 파일의 용량
EXTENT MANAGEMENT LOCAL                     -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;    

--==>> TABLESPACE TBS_TEAM3이(가) 생성되었습니다.

SELECT *                -- 모든 항목 조회
FROM DBA_TABLESPACES;

CREATE USER team3 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM3;
--==>> User TEAM3이(가) 생성되었습니다.

GRANT CREATE SESSION TO team3;
--==>> Grant을(를) 성공했습니다.

GRANT CREATE TABLE TO team3;
--==>> Grant을(를) 성공했습니다.

ALTER USER team3
QUOTA UNLIMITED ON TBS_TEAM3;
--==>> User TEAM3이(가) 변경되었습니다.

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO team3;
--==>> Grant을(를) 성공했습니다.

GRANT CREATE VIEW TO team3;
--==>> Grant을(를) 성공했습니다.
