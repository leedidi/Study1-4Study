SELECT FILENO "���Ϲ�ȣ", FILENAME "���ϸ�"
FROM TBL_FILES;
--==>>
/*
���Ϲ�ȣ ���ϸ�
------- -------------------------------------
    1	SALES.DOC
    2	PANMAE.XXLS
    3	RESEARCH.PPT
    4	STUDY.HWP
    5	SQL.TXT
    6	TEST.PNG
    7	SPRING.JPG
    8	20210901_01_SCOTT.SQL
*/
--�� TBL_FILES ���̺��� ������� ���� ���� ��ȸ�� �� �ֵ���
--   �������� �����Ѵ�.
/*
--�� ���� �ۼ��� �ڵ�
SELECT FILENO "���Ϲ�ȣ", FILENAME "���ϸ�" - �� ���� �̸�.Ȯ���ڸ�;
FROM TBL_FILES

SELECT FILENO "���Ϲ�ȣ", INSTR(FILENAME, '\', 20, 1) "2"
FROM TBL_FILES
*/

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�", SUBSTR(FILENAME, 16, 9) "���ϸ�"
FROM TBL_FILES
WHERE FILENO=1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC	SALES.DOC

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�", SUBSTR(FILENAME, 16, 9) "���ϸ�"
FROM TBL_FILES
--==>> 
/*
1	C:\AAA\BBB\CCC\SALES.DOC	                SALES.DOC
2	C:\AAA\PANMAE.XXLS	                        XLS
3	D:\RESEARCH.PPT	
4	C:\DOCUMENTS\STUDY.HWP      	            UDY.HWP
5	C:\DOCUMENTS\TEMP\SQL.TXT	                MP\SQL.TX
6	D:\SHARE\F\TEST.PNG	                        .PNG
7	C:\USER\GUILDONG\PICTURE\PHOTO\SPRING.JPG	G\PICTURE
8	C:\ORACLESTUDY\20210901_01_SCOTT.SQL	    20210901_
*/


/*
1	C:\AAA\BBB\CCC\SALES.DOC	                
2	C:\AAA\PANMAE.XXLS	                   
3	D:\RESEARCH.PPT	
4	C:\DOCUMENTS\STUDY.HWP      	      
5	C:\DOCUMENTS\TEMP\SQL.TXT	              
6	D:\SHARE\F\TEST.PNG	                       
7	C:\USER\GUILDONG\PICTURE\PHOTO\SPRING.JPG	
8	C:\ORACLESTUDY\20210901_01_SCOTT.SQL	    
*/


SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�", REVERSE(FILENAME) "�Ųٷ�"
FROM TBL_FILES;
/*
COD.SELAS               \CCC\BBB\AAA\:C
SLXX.EAMNAP             \AAA\:C
TPP.HCRAESER            \:D
PWH.YDUTS               \STNEMUCOD\:C
TXT.LQS                 \PMET\STNEMUCOD\:C
GNP.TSET                \F\ERAHS\:D
GPJ.GNIRPS              \OTOHP\ERUTCIP\GNODLIUG\RESU\:C
LQS.TTOCS_10_10901202   \YDUTSELCARO\:C
*/

/*
--�� ���� �ۼ��� �ڵ�
SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�", REVERSE(FILENAME) "�Ųٷ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�", INSTR(REVERSE(FILENAME), '\') "�Ųٷ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�", REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\')-1)) "���ϸ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ", SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\')-1) "���ϸ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ", REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\')-1)) "���ϸ�"
FROM TBL_FILES;
*/
--==>> 
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESEARCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	TEST.PNG
7	SPRING.JPG
8	20210901_01_SCOTT.SQL
*/

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�"
     ,  SUBSTR(REVERSE(FILENAME), 1, ���� '\'�� �����ϴ� ��ġ - 1) "�Ųٷε����ϸ�"
FROM TBL_FILES;


-- ���� '\'�� �����ϴ� ��ġ 
INSTR(REVERSE(FILENAME), '\', 1)        -- ������ �Ű����� 1 ����


SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�"
     ,  SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1) "�Ųٷε����ϸ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�"
     ,  SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1) "�Ųٷε����ϸ�"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	                COD.SELAS
2	C:\AAA\PANMAE.XXLS	                        SLXX.EAMNAP
3	D:\RESEARCH.PPT	TPP.                        HCRAESER
4	C:\DOCUMENTS\STUDY.HWP	                    PWH.YDUTS
5	C:\DOCUMENTS\TEMP\SQL.TXT	                TXT.LQS
6	D:\SHARE\F\TEST.PNG	                        GNP.TSET
7	C:\USER\GUILDONG\PICTURE\PHOTO\SPRING.JPG	GPJ.GNIRPS
8	C:\ORACLESTUDY\20210901_01_SCOTT.SQL	    LQS.TTOCS_10_10901202
*/

SELECT FILENO "���Ϲ�ȣ"--, FILENAME "����������ϸ�"
     ,  REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1)) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESEARCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	TEST.PNG
7	SPRING.JPG
8	20210901_01_SCOTT.SQL
*/


--�� LPAD()
--> Byte ������ Ȯ���Ͽ� ���ʺ��� ���ڷ� ä��� ����� ���� �Լ�
--@ ��� �׻� �ι�° �Ķ���ͺ��� ����!
SELECT 'ORACLE' "1"
     , LPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	****ORACLE
--> �� 10Byte ������ Ȯ���Ѵ�.                    �� �� ��° �Ķ���� ���� ����...
--  �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.    �� ù ��° �Ķ���� ���� ����....
--  �� �����ִ� Byte ������ ���ʺ��� �� ��° �Ķ���� ������ ä���.
--  �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.

--�� RPLAD()
--> Byte ������ Ȯ���Ͽ� �����ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "1"
     , LPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	****ORACLE
--> �� 10Byte ������ Ȯ���Ѵ�.                    �� �� ��° �Ķ���� ���� ����...
--  �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.    �� ù ��° �Ķ���� ���� ����....
--  �� �����ִ� Byte ������ �����ʺ��� �� ��° �Ķ���� ������ ä���.
--  �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.



--�� LTRIM()
--@ �����Ѱ� ������, ���°� ����. --> �������
--@ �ϳ��� �ǰ��ǰ� �ڸ�... �ϼ������� �ѹ��� �ڸ��� X, LIKE �������
SELECT 'ORAORAORACLEORACLE' "1"     -- ���� ���� ����Ŭ ����Ŭ
     , LTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , LTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"    --@ �ϼ������� �ѹ��� �ڸ��� X
     , LTRIM('ORAoRAORACLEORACLE', 'ORA') "4"       --@ ��ҹ��� ���� O
     , LTRIM('ORA ORAORACLEORACLE', 'ORA') "5"      --@ ���� ���� O
     , LTRIM('          ORAORAORACLEORACLE', ' ') "6"
     , LTRIM('                      ORACLE') "7"    -- ���� ���� ���� �Լ��� Ȱ��(�� ��° �Ķ���� ����)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	CLEORACLE	CLEORACLE	oRAORACLEORACLE	 ORAORACLEORACLE	ORAORAORACLEORACLE	ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  ���ʺ��� ���������� �� ��° �Ķ���� ������ ������ ���ڿ� ���� ���ڰ� ������ ���
--  �̸� ������ ������� ��ȯ�Ѵ�.
--  ��, �ϼ������� ó������ �ʴ´�.

SELECT LTRIM('�̱���̱�����̽Žű��̽Ž����̱���̽Ź��̱��', '�̱��') "TEST"
FROM DUAL;
--==> ���̱��

--�� RTRIM()
SELECT 'ORAORAORACLEORACLE' "1"     -- ���� ���� ����Ŭ ����Ŭ
     , RTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , RTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"    --@ �ϼ������� �ѹ��� �ڸ��� X
     , RTRIM('ORAoRAORACLEORACLE', 'ORA') "4"       --@ ��ҹ��� ���� O
     , RTRIM('ORA ORAORACLEORACLE', 'ORA') "5"      --@ ���� ���� O
     , RTRIM('          ORAORAORACLEORACLE', ' ') "6"
     , RTRIM('ORACLE                      ') "7"    -- ������ ���� ���� �Լ��� Ȱ��(�� ��° �Ķ���� ����)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	ORAORAORACLEORACLE	AAAORAORAORACLEORACLE	ORAoRAORACLEORACLE	ORA ORAORACLEORACLE	          ORAORAORACLEORACLE	ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  �����ʺ��� ���������� �� ��° �Ķ���� ������ ������ ���ڿ� ���� ���ڰ� ������ ���
--  �̸� ������ ������� ��ȯ�Ѵ�.
--  ��, �ϼ������� ó������ �ʴ´�.


--�� TRANSLATE()
--> 1:1 �� �ٲپ��ش�.
--@ ù��° ���ڸ� �ι�° �Ķ���Ϳ��� ã��, �ι�° �Ķ���Ϳ� 1��1 ��Ī�Ǵ� ����°���� ã�Ƽ� �״�� �ٲ�. 
--@ ���� �ι�° �Ķ���Ϳ� ���ٸ�? �ٲ��� �ʰ� �״�� ���
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTYVWXYZ'
                , 'abcdefghijklmnopqrstyvwxyz') "RESULT"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-8743-7042'
                , '0123456789'
                , '�����̻�����ĥ�ȱ�') "RESULT"
FROM DUAL;
--==>> ���ϰ�-��ĥ���-ĥ������


--�� REPLACE()
SELECT REPLACE('MY ORACLE ORAHOME', 'ORA', '����')
FROM DUAL;
--==>> MY ����CLE ����HOME


--------------------------------------------------------------------------------


--�� ROUND() �ݿø��� ó�����ִ� �Լ�
SELECT 48.678 "1"
     , ROUND(48.678, 2) "2"     -- �Ҽ��� ���� ��°�ڸ����� ǥ�� (���° �ڸ����� �ݿø�)
     , ROUND(48.674, 2) "3"
     , ROUND(48.674, 1) "4"
     , ROUND(48.674, 0) "5"     --@ ������ ǥ��
     , ROUND(48.674) "5"        -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
     , ROUND(48.674, -1) "7"    --@ 10�� �ڸ����� ǥ�� (��1�� �ڸ����� �ݿø�)
     , ROUND(48.674, -2) "8"    --@ 100�� �ڸ����� ǥ�� (��10�� �ڸ����� �ݿø�)
     , ROUND(48.674, -3) "9"
FROM DUAL;
--==>> 48.678	48.68	48.67	48.7	49	49	50	0	0


--�� TRUNC() ������ ó�����ִ� �Լ�
SELECT 48.678 "1"
     , TRUNC(48.678, 2) "2"     -- �Ҽ��� ���� ��°�ڸ����� ǥ�� --@ �������� �� ���ֶ�!
     , TRUNC(48.674, 2) "3"
     , TRUNC(48.674, 1) "4"
     , TRUNC(48.674, 0) "5"     --@ ������ ǥ��
     , TRUNC(48.674) "5"        -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
     , TRUNC(48.674, -1) "7"    --@ 10�� �ڸ����� ǥ�� 
     , TRUNC(48.674, -2) "8"    --@ 100�� �ڸ����� ǥ�� 
     , TRUNC(48.674, -3) "9"
FROM DUAL;
--==>> 48.678	48.67	48.67	48.6	48	48	40	0	0


--�� MOD() �������� ��ȯ�ϴ� �Լ�
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
--> 5�� 2�� ���� ������ ����� ��ȯ


--�� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
--> 5�� 3���� ��������� ��ȯ


--�� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2)
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> ��Ʈ 2 �� ���� ����� ��ȯ


--�� LOG() �α� �Լ�
--  (�� ����Ŭ�� ���α׸� �����ϴ� �ݸ�, MSSQL �� ���α�, �ڿ��α� ��� �����Ѵ�.)
SELECT LOG(10, 100), LOG(10, 20)
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


--�� �ﰢ �Լ�
--   ����, �ڽ���, ź��Ʈ ������� ��ȯ�Ѵ�.
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/


--�� �ﰢ�Լ��� ���Լ� (���� : -1 ~ 1)
--   �����, ���ڽ���, ��ź��Ʈ ������� ��ȯ�Ѵ�.
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/


--�� SIGN()      ����, ��ȣ, Ư¡
--> ���� ������� ����̸� 1, 0�̸� 0, �����̸� -1 �� ��ȯ�Ѵ�.
SELECT SIGN(5-2), SIGN(5-5), SIGN(5-8)
FROM DUAL;
--==>> 1	0	-1
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ�� �� �ַ� ����Ѵ�.


--�� ASCII(), CHR() �� ���� �����ϴ� ������ �Լ�
SELECT ASCII('A') "RESULT1", CHR(65) "RESULT2"
FROM DUAL;
--==>> 65	A
--> ASCII() : �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�.
--  CHR()   : �Ű������� �Ѱܹ��� ���ڸ� �ƽ�Ű�ڵ� ������ ���ϴ� ���ڸ� ��ȯ�Ѵ�.



--------------------------------------------------------------------------------

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ��¥ ������ �⺻ ������ DAY(�ϼ�)�̴�~!!!  CHECK~!!!

SELECT SYSDATE "1", SYSDATE+1 "2", SYSDATE-2 "3", SYSDATE+3 "4" 
FROM DUAL;
--==>> 2021-09-02 10:35:34	    -- ����
--     2021-09-03 10:35:34	    -- 1�� ��
--     2021-08-31 10:35:34	    -- 2�� ��
--     2021-09-05 10:35:34      -- 3�� ��


--�� �ð� ���� ����
SELECT SYSDATE "1", SYSDATE + 1/24 "2", SYSDATE - 2/24 "3"
FROM DUAL;
--==>> 2021-09-02 10:37:57	    -- ����
--     2021-09-02 11:37:57	    -- 1�ð� ��
--     2021-09-02 08:37:57      -- 2�ð� ��


--�� ���� �ð���...  ���� �ð� ���� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
/*
-------------------------------------------------------------------------
             ���� �ð�                  ���� �� �ð�
-------------------------------------------------------------------------
        2021-09-02 10:40:13           2021-09-03 12:43:17
-------------------------------------------------------------------------
*/
/*
--�� ���� �ۼ��� �ڵ�
SELECT ���� �ð�, ���� �ð� ���� 1�� 2�ð� 3�� 4�� ��
FROM DUAL;

SELECT SYSDATE "���� �ð�", SYSDATE ���� 1�� 2�ð� 3�� 4�� �� "���� �� �ð�"
FROM DUAL;

SELECT SYSDATE "���� �ð�", SYSDATE + 1 + 2/24 + 3/1440 + 4/86400 "���� �� �ð�"
FROM DUAL;
--==>> 2021-09-02 10:43:10	2021-09-03 12:46:14
*/

-- ��� 1.
SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "���� �� �ð�"
FROM DUAL;
--==>>
/*
2021-09-02 11:04:00	
2021-09-03 13:07:04
*/

-- ��� 2.
SELECT SYSDATE "���� �ð�"
     , SYSDATE + ((24*60*60) + (2*60*60) + (3*60) + 4 ) / (24*60*60) "���� �� �ð�"
     --              1��         2�ð�      3��
FROM DUAL;
--==>>
/*
2021-09-02 11:06:48	
2021-09-03 13:09:52
*/

--�� ��¥ - ��¥ = �ϼ�
-- ex) (2021-12-28) - (2021-09-02)
--        ������         ������

SELECT TO_DATE('2021-12-28', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 117

--�� ������ Ÿ���� ��ȯ
SELECT TO_DATE('2021-09-02', 'YYYY-MM-DD') "���"     -- ��¥ �������� ��ȯ
FROM DUAL;
--==>> 2021-09-02 00:00:00

SELECT TO_DATE('2021-13-02', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-09-31', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-02-29', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2020-02-29', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> 2020-02-29 00:00:00

--�� TO_DATE() �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� ������ ��
--   ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������~!!!


--�� ADD_MONTHS()     ���� ���� �����ִ� �Լ�
SELECT SYSDATE "1"
     , ADD_MONTHS(SYSDATE, 2) "2"
     , ADD_MONTHS(SYSDATE, 3) "3"
     , ADD_MONTHS(SYSDATE, -2) "4"
     , ADD_MONTHS(SYSDATE, -3) "5"
FROM DUAL;
--==>>
/*
2021-09-02 11:19:12	    �� ����
2021-11-02 11:19:12	    �� 2���� ��
2021-12-02 11:19:12	    �� 3���� ��	
2021-07-02 11:19:12	    �� 2���� ��	
2021-06-02 11:19:12	    �� 3���� ��
*/
--> ���� ���ϰ� ����


--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� MONTHS_BETWEEN()
-- ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "���Ȯ��"
FROM DUAL;
--==>> 231.079811081242532855436081242532855436

--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
--�� ������� ��ȣ�� ��-���� ��ȯ�Ǿ��� ��쿡��
--   ù ��° ���ڰ��� �ش��ϴ� ��¥����
--   �� ��° ���ڰ��� �ش��ϴ� ��¥�� ���̷������ �ǹ̷� Ȯ���� �� �ִ�.

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-12-28', 'YYYY-MM-DD')) "���Ȯ��"
FROM DUAL;
--==>> -3.82334677419354838709677419354838709677
--> �������� �����Ϻ��� �̷�


--�� NEXT_DAY()
-- ù ��° ���ڰ��� ���� ��¥�� ���ƿ��� ���� ���� ���� ��ȯ
SELECT NEXT_DAY(SYSDATE, '��') "���1", NEXT_DAY(SYSDATE, '��') "���2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� ���� ������ ������ �� ���� �������� �ٽ� �� �� ��ȸ
SELECT NEXT_DAY(SYSDATE, '��') "���1", NEXT_DAY(SYSDATE, '��') "���2"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01846: not a valid day of the week
01846. 00000 -  "not a valid day of the week"
*Cause:    
*Action:
*/

SELECT NEXT_DAY(SYSDATE, 'SAT') "���1", NEXT_DAY(SYSDATE, 'MON') "���2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--�� �߰� ���� ���� �ٽ� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� LAST_DAT()
-- �ش� ��¥�� ���ԵǾ� �ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT LAST_DAY(SYSDATE) "���Ȯ��"
FROM DUAL;
--==>> 2021-09-30

SELECT LAST_DAY(TO_DATE('2020-02-05', 'YYYY-MM-DD')) "��� Ȯ��"
FROM DUAL;
--==>> 2020-02-29

SELECT LAST_DAY(TO_DATE('2021-02-05', 'YYYY-MM-DD')) "��� Ȯ��"
FROM DUAL;
--==>> 2021-02-28


--�� ���úη�.... ����ȣ ����... ���뿡 �� ����(?)����.
--   ���� �Ⱓ�� 22������ �Ѵ�.

-- 1. ���� ���ڸ� ���Ѵ�.

-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �ؾ� �ϴٰ� �����ϸ�
--    ��ȣ�� �� ���� �Ծ�� ���� �����ٱ�.

--�³��� �ۼ��� �ڵ�
/*
--1.
SELECT SYSDATE "���� ��¥"
     , ADD_MONTHS(SYSDATE, 22) "���� ����"
FROM DUAL;
--==>> 2021-09-02	2023-07-02

--2.
--SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "���Ȯ��"
--FROM DUAL;
SELECT MONTHS_BETWEEN(TO_DATE('2023-07-02', 'YYYY-MM-DD'), TO_DATE('2021-09-02', 'YYYY-MM-DD')) "���� ������"
FROM DUAL;

SELECT MONTHS_BETWEEN(TO_DATE('2023-07-02', 'YYYY-MM-DD'), TO_DATE('2021-09-02', 'YYYY-MM-DD')  "���� �������� ���ϼ�"
FROM DUAL;

--LAST_DAY(SYSDATE)
-- ���� ������ �� ���� ������ �� ���� ��������¥�� ���� �� �ش� ��¥ *3 �ؼ� �� ���ϸ� ���� ��...!
-- �� �ٺ����� ..������

SELECT TO_DATE('2023-07-02', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') "���� �ϼ�"
FROM DUAL;

SELECT ( TO_DATE('2023-07-02', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') )*3 "���� �� �� ���� ��"
FROM DUAL;
--==>> 2004
*/

--1.
SELECT ADD_MONTHS(SYSDATE, 22) "��� Ȯ��"
FROM DUAL;
--==>> 2023-07-02

--2. 
--    �����Ⱓ * 3
--    --------
--   (�������� - ��������)

--   --   (�������� - ��������)

SELECT (�������� - ��������)
FROM DUAL;

SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3
FROM DUAL;
--==>> 2004


--�� ���� ��¥ �� �ð����κ���... ������(2021-12-28 18:00:00) ����
--   ���� �Ⱓ��... ������ ���� ���·� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
--------------------------------------------------------------------------------
����ð�             | ������              |  ��  | �ð� | �� | �� 
--------------------------------------------------------------------------------
2021-09-02 12:08:23  | 2021-12-28 18:00:00 | 115  |  4   | 42 | 37
--------------------------------------------------------------------------------
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session��(��) ����Ǿ����ϴ�.
--@ SQL DEVELOPER ���ſ�... �������� <����> �������� �������! 
--@ ���� ������.. ���� �ذ�Ȱ�� ���� ����. ���� ���α׷� �����ϰ� ���ν����ϰų� ����� �ϱ�

--�³��� �ۼ��� �ڵ�
/*
SELECT ����ð�, ������, ��, �ð�, ��, ��
FROM DUAL;

SELECT SYSDATE "����ð�"
, TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
, TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0) "��"

, �ð�
, ��
, ��

FROM DUAL;

SELECT SYSDATE "����ð�"
, TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
, TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0) "��"
, ((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24 "�ð�"
-- ���� �ð����� ��ü �ð� - ���� ���ڱ��� ��, �� ���� 0.23�� ���� ��....
-- ���� �ð����� �������...X24?

, "��"
, "��"

FROM DUAL;

SELECT SYSDATE "����ð�"
, TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
, TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0) "��"
, TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0) "�ð�"
-- ���� �ð����� ��ü �ð� - ���� ���ڱ��� ��, �� ���� 0.23�� ���� ��....
-- ���� �ð����� �������...X24? �ؼ� ����

-- (������ - ������� �� - ������� �ð�(/24))(�� ���� ���� �ð���) * 24 * 60
, TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE            -- ���� ��ü �ϼ�
- TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0))*24      -- ���� �ϼ� ����
- TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0)) -- ���� �ð��� ����... �ϼ� ����
* 60,0)
"��"

, TRUNC((((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE            -- ���� ��ü �ϼ�
- TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0))*24      -- ���� �ϼ� ����
- TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0)) -- ���� �ð��� ����... �ϼ� ����
* 60 )* 60
- (TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE            
- TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0))*24      
- TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0)) -- ���� �ð��� ����... �ϼ� ����
* 60,0))*60,0)
"��"

FROM DUAL;
*/

-- ��1�� 2�ð� 3�� 4�ʡ� ��... ���ʡ��� ȯ���ϸ�...
SELECT (1��) + (2�ð�) + (3��) + (4��)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- 61�� �� 1�� 1��
SELECT MOD(61, 60)
FROM DUAL;


-- ��93784���ʸ� �ٽ� ��, �ð�, ��, �ʷ� ȯ���ϸ�...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24)  --@ TRUNC : 26�ð� ���� ���� �����ڴ�....
     , MOD (TRUNC(TRUNC(93784/60)/60), 24) --@ MOD : 26�ð� ���� �������� ���� �����ڴ�.. �ð�
     , MOD(TRUNC(93784/60), 60) --@ TRUNC : ���� ���� + MOD : ������ ������
     , MOD(93784, 60)  --@ MOD : �������� ����
FROM DUAL;
--==>> 1	2	3	4


-- �����ϱ��� ���� �Ⱓ Ȯ��(��¥ ����) �� ���� : �ϼ�
SELECT �������� - ��������
FROM DUAL;

-- ��������
SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 2021-12-28 18:00:00 �� ��¥ ����

-- ��������
SELECT SYSDATE
FROM DUAL;
--==>> 2021-09-02 15:19:41 �� ��¥ ����

SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 117.110393518518518518518518518518518519 �� ���� : �ϼ�   �� ���� ����
--> �����ϱ��� ���� �ϼ�


-- �����ϱ��� ���� �Ⱓ Ȯ��(��¥ ����) �� ���� : ��
SELECT (�����ϱ��� ���� �ϼ�) * (�Ϸ縦 �����ϴ� ��ü ��)
FROM DUAL;

SELECT (�����ϱ��� ���� �ϼ�) * (24*60*60)
FROM DUAL;

SELECT (TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 10118165.00000000000000000000000000000003    �� ���� : �� �� ���� ����
--> �����ϱ��� ���� ��

/*
-- ��93784���ʸ� �ٽ� ��, �ð�, ��, �ʷ� ȯ���ϸ�...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24)  --@ TRUNC : 26�ð� ���� ���� �����ڴ�....
     , MOD (TRUNC(TRUNC(93784/60)/60), 24) --@ MOD : 26�ð� ���� �������� ���� �����ڴ�.. �ð�
     , MOD(TRUNC(93784/60), 60) --@ TRUNC : ���� ���� + MOD : ������ ������
     , MOD(93784, 60)  --@ MOD : �������� ����
FROM DUAL;
�̰� �����ͼ� �ϴܿ� ���! ���� ��. 93784 -> (TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60) �θ� �ٲ� ��
*/

SELECT TRUNC(TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24)  "��"
     , MOD (TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "�ð�"
     , MOD(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "��"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "��" --@ �տ� TRUNC �߰�: ����
FROM DUAL;

SELECT  SYSDATE "����ð�"
     , TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "��������"
     , TRUNC(TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24)  "��"
     , MOD (TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "�ð�"
     , MOD(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "��"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "��"
FROM DUAL;
--==>> 
/*
����ð�                ��������           ��         �ð�          ��        ��
------------------- ------------------- ---------- ---------- ---------- ----------
2021-09-02 15:31:38 2021-12-28 18:00:00        117          2         28       21
*/

--�� ����
-- ������ �¾�� �������...
-- �󸶸�ŭ�� ��, �ð�, ��, �ʸ� ��Ҵ���... (����ִ���...)
-- ��ȸ�ϴ� �������� �����Ѵ�.
/*
--------------------------------------------------------------------------------
���� �ð�              |  �¾ �ð�          |  ��   | �ð� |  �� | ��
--------------------------------------------------------------------------------
2021-09-02 15:33:20    | 1991-05-06 12:00:00   | XXXXX |  XX  |  XX | XX
--------------------------------------------------------------------------------
*/

SELECT SYSDATE
FROM DUAL;

SELECT SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 9442.151284722222222222222222222222222222 (�� ���� ���� ��ƿ� �ð�)

-- ��ƿ� �Ⱓ �� ������ ȯ�� �� ���� : ��

SELECT ((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)
FROM DUAL;
--==>> 815801953 (�� �� ���� ��ƿ� �ð�)

SELECT TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60)/24) "��"
     , MOD (TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60), 24) "�ð�"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60), 60) "��"
     , MOD(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60), 60) "��" 
FROM DUAL;

SELECT TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60)/24) "��"
     , MOD (TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60), 24) "�ð�"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60), 60) "��"
     , TRUNC(MOD(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60), 60)) "��" -- �ʴ� �ѹ��� ����!
FROM DUAL;

SELECT SYSDATE "���� �ð�"
     , TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "�¾ �ð�"
     , TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60)/24) "��"
     , MOD (TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60), 24) "�ð�"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60), 60) "��"
     , TRUNC(MOD(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60), 60)) "��" -- �ʴ� �ѹ��� ����!
FROM DUAL;
--==>>
/*
     ���� �ð�           �¾ �ð�        ��         �ð�        ��        ��
------------------- ------------------- ---------- ---------- ---------- ----------
2021-09-02 15:43:32 1995-10-27 12:00:00    9442         3         43        32
*/ 


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� ��¥ �����͸� ������� �ݿø�, ������ ������ �� �ִ�.

--�� ��¥ �ݿø�
SELECT SYSDATE "1"                      -- 2021-09-02   �� �⺻ ���� ��¥
       , ROUND(SYSDATE, 'YEAR') "2"     -- 2022-01-01   �� �⵵���� ��ȿ�� ������(��ݱ�, �Ϲݱ� ����)
       , ROUND(SYSDATE, 'MONTH') "3"    -- 2021-09-01   �� ������ ��ȿ�� ������(15�� ����)
       , ROUND(SYSDATE, 'DD') "4"       -- 2021-09-03   �� ��¥���� ��ȿ�� ������(���� ����)
       , ROUND(SYSDATE, 'DAY') "5"      -- 2021-09-05   �� ��¥���� ��ȿ�� ������(������ ����)
FROM DUAL;

--�� ��¥ ����
SELECT SYSDATE "1"                      -- 2021-09-02   �� �⺻ ���� ��¥
       , TRUNC(SYSDATE, 'YEAR') "2"     -- 2021-01-01   �� �⵵���� ��ȿ�� ������
       , TRUNC(SYSDATE, 'MONTH') "3"    -- 2021-09-01   �� ������ ��ȿ�� ������
       , TRUNC(SYSDATE, 'DD') "4"       -- 2021-09-02   �� ��¥���� ��ȿ�� ������
       , TRUNC(SYSDATE, 'DAY') "5"      -- 2021-08-29   �� ��¥���� ��ȿ�� ������(�� �� �Ͽ���)
FROM DUAL;
--@ TRUN ���ÿ��� �ø��� ���� �߻����� ����!


--------------------------------------------------------------------------------

--���� ��ȯ �Լ� ����--

-- TO_CHAR()    : ���ڳ� ��¥ �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_DATE()    : ���� ������(��¥ ����)�� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_NUMBER()  : ���� ������(���� ����)�� ���� Ÿ������ ��ȯ�����ִ� �Լ�


--�� ��¥�� ��ȭ ������ ���� ���� ���
--   ���� �������� ���� ������ ������ �� �ִ�.

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_CURRENCY = '\';   -- ��(��)
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   -- 2021-09-02
     , TO_CHAR(SYSDATE, 'YYYY')         -- 2021
     , TO_CHAR(SYSDATE, 'YEAR')         -- TWENTY TWENTY-ONE    --@ �ý��۾�� �ѱ۷� �ٲپ �ٲ��� X
     , TO_CHAR(SYSDATE, 'MM')           -- 09
     , TO_CHAR(SYSDATE, 'MONTH')        -- 9�� 	
     , TO_CHAR(SYSDATE, 'MON')          -- 9�� 	
     , TO_CHAR(SYSDATE, 'DD')           -- 02	
     , TO_CHAR(SYSDATE, 'DAY')          -- �����	
     , TO_CHAR(SYSDATE, 'DY')           -- ��	
     , TO_CHAR(SYSDATE, 'HH24')         -- 16	        --@ 24�ð� ����
     , TO_CHAR(SYSDATE, 'HH')           -- 04	
     , TO_CHAR(SYSDATE, 'HH AM')        -- 04 ����	    --@ AM�� ����, PM�� ���� ���簡 ���Ĵϱ� ���� ��µ�
     , TO_CHAR(SYSDATE, 'HH PM')        -- 04 ����	
     , TO_CHAR(SYSDATE, 'MI')           -- 22	
     , TO_CHAR(SYSDATE, 'SS')           -- 46	
     , TO_CHAR(SYSDATE, 'SSSSS')        -- 58966	    �� ���� �귯�� ��ü ��
     , TO_CHAR(SYSDATE, 'Q')            -- 3            �� �б�
FROM DUAL;
--@ ���� Ÿ������ ��ȯ��!(���â �������� ����. ���ڴ� ���������� ����)

SELECT 2021 "1", '2021' "2"
FROM DUAL;

SELECT '23' "1", TO_NUMBER('23') "2"
FROM DUAL;


--�� EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "1"     -- 2021 �� ������ �����Ͽ� ���� Ÿ������...
     , TO_CHAR(SYSDATE, 'MM') "2"       -- 09   �� ���� �����Ͽ� ���� Ÿ������...
     , TO_CHAR(SYSDATE, 'DD') "3"       -- 02	�� ���� �����Ͽ� ���� Ÿ������...
     , EXTRACT(YEAR FROM SYSDATE) "4"   -- 2021	�� ������ �����Ͽ� ���� Ÿ������... --@ ��¥�κ��� ������ ���´�...
     , EXTRACT(MONTH FROM SYSDATE) "5"  -- 9	�� ���� �����Ͽ� ���� Ÿ������...   --@ �� SYSDATE �ƴϾ ��¥Ÿ���̸� ��
     , EXTRACT(DAY FROM SYSDATE) "6"    -- 2    �� ���� �����Ͽ� ���� Ÿ������...
FROM DUAL;
--@ TO_CHAR : ���ڷ� ��ȯ.. EXTRACT : ���ڷ� ��ȯ....
--> ��, ��, �� ���� �ٸ� ���� �Ұ�



--�� TO_CHAR() Ȱ�� �� ���� ���� ǥ�� ����� ��ȯ
SELECT 60000 "1"
     , TO_CHAR(60000) "2"
     , TO_CHAR(60000, '99,999') "3"
     , TO_CHAR(60000, '$99,999') "4"
     , TO_CHAR(60000, 'L99,999') "5" --@ ���� �����ε� ��ȭ��ȣ �ſ� �پ�... ��ȭ��ȣ �ѱ��� �ƴѳ��� �����Ƿ�
                                     --@ ��ȭ�� ǥ���Ҽ� �ִ� ���� Ȯ���س��Ƽ� �� ������ ����
     , LTRIM(TO_CHAR(60000, 'L99,999')) "6" --@ -> �׷��� �Ϲ������� �̷��� �Բ� ���
FROM DUAL;
--==>> 60000	60000	 60,000	 $60,000	          \60,000	\60,000

--�� ��¥ ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ���� �ð��� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
--�³��� �ۼ��� �ڵ�
/*
SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "���� �� �ð�"
FROM DUAL;
*/
SELECT SYSDATE "���� �ð�"
    , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))  "1��2�ð�3��4����"
FROM DUAL;
--==>>
/*
2021-09-02 17:01:58	
2021-09-03 19:05:02
*/

--�� ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6�� �ĸ� ��ȸ�Ѵ�.
--   TO_YMINTERVAL(), TO_DSiNTERVAL()

SELECT SYSDATE "���� �ð�"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "���� ���"
               --@ 1�� 2���� ������                   3�� 4�ð� 5�� 6�� ������
FROM DUAL;  
--==>>
/*
2021-09-02 17:05:35	
2022-11-05 21:10:41
*/

--------------------------------------------------------------------------------

--�� CASE ����(���ǹ�, �б⹮)
/*
CASE
WHEN
THEN
ELSE
END
*/
--@ CASE�������� ���ױ׸������� ���� ���� �̸����� �θ��鼭 ����ϱ�! �׷��� ���߿� �ʿ��Ҷ� ���� ����
--@  CASE WHEN THEN ELSE END ����...

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2�� �����' END "��� Ȯ��"
FROM DUAL;
--==>> 5+2=7

SELECT CASE 5+2 WHEN 9 THEN '5+2=7' ELSE '5+2�� �����' END "��� Ȯ��"
FROM DUAL;
--==>> 5+2�� �����

--@Cntl + enter : ���� �Է±� �ٲٱ�

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '�����'
       END "��� Ȯ��"
FROM DUAL;
--==>> 1+1=2


--�� DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-2�� �����') "��� Ȯ��"
FROM DUAL;
--==>> 5-2=3


SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '�� �Ұ�'
            END "��� Ȯ��"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE '���� ����'
       END "��� Ȯ��"
FROM DUAL;
--==>> ��������
/*
SELECT CASE WHEN T THEN '��������'
            WHEN T THEN '��������'
            ELSE '���� ����'
       END "��� Ȯ��"
FROM DUAL;
*/
--@ �� ���� ���� TRUE�� �� ���� �������� ����

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '�ش�����' 
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '���ϸ���'
       END "��� Ȯ��"
FROM DUAL;
--==>> �ش�����
/*
SELECT CASE WHEN T THEN '�ش�����' 
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '���ϸ���'
       END "��� Ȯ��"
FROM DUAL;
*/


SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '�ش�����' 
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '���ϸ���'
       END "��� Ȯ��"
FROM DUAL;
--==>> ���ϸ���
/*
SELECT CASE WHEN F THEN '�ش�����' 
            WHEN F THEN '��������'
            ELSE '���ϸ���' --@�� ELSE �������� THEN ���� ���� ����!
       END "��� Ȯ��"
FROM DUAL;
*/


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT *
FROM TBL_SAWON;

--�� ����
-- TBL_SWAON ���̺��� Ȱ���Ͽ� ������ ���� �׸���� ��ȸ�Ѵ�.
-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
-- , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�

-- ��, ���糪�̴� �ѱ����� ������ ���� ������ �����Ѵ�. (�¾�� �⺻ �� �� ����)
-- ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��(����)��
-- �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
-- �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
-- �� ����� ���� �޿� ���� 30% ����,
-- 2000�� �̻� �ٹ��� �����
-- �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.

--@ ���������� : �� ����� 60���� �Ǵ� �ذ� 2050��... 2050-01-03�Ϸ� ����� �ϱ�. 
--@ �����ϼ��� ����ϱ��� ��ĥ ���Ҵ���... ���ʽ��� �ٹ��ϼ��� ����.
--@ �� ���̴�..... ���......

SELECT *
FROM TBL_SAWON;

SELECT �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����" , JUBUN "�ֹι�ȣ" 
        , ����, ���糪��, HIREDATE "�Ի���", ����������, �ٹ��ϼ�, �����ϼ�, SAL "�޿�", ���ʽ�
FROM TBL_SAWON;

--�� ���� : �ֹι�ȣ 7��° �ڸ��� 2,4 �� ����, 1,3 �̶�� ����
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '����'
            ELSE '�����̻�'
            END "����"
--FROM TBL_SAWON;

--�� ���� ���� : ���� �⵵ - �ֹε�Ϲ�ȣ �� ���ڸ� �� ���� �̿��� �¾ �⵵ ����
-- �ֹ� �� ���ڸ� ���� 0�̸� 20XX... ������ ��쿡�� 19XX...

--���� �⵵
--TO_CHAR(SYSDATE, 'YYYY')
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;

SELECT CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000+(�ֹι�ȣ ���ڸ� �ΰ�))
            ELSE ���� �⵵ - (1900+(�ֹι�ȣ ���ڸ� �ΰ�))
            END "���糪��";

SELECT CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            ELSE EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            END "���糪��"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����" , JUBUN "�ֹι�ȣ" 
        , CASE WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '����'
            ELSE '�����̻�'
            END "����"
            
        , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            ELSE EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            END "���糪��"
        , HIREDATE "�Ի���"
            
        /*CASE WHEN ������ 60���� �Ǹ�... THEN HIREDATE�� �ش� �⵵�� ����
            ELSE 
            END "����������"*/
        /*CASE WHEN 60-���糪�� THEN HIREDATE�� �ش� �⵵�� ����
            ELSE 
            END "����������"*/
            
            -- (60 - "���糪��") -> �� �⵵�� HIREDATE �⵵�� ���ϸ� ��....
            -- TO_DATE(HIREDATE, 'YY-MM-DD') HIREDATE 99..11
            /*
        , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN 2021 + 60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            ELSE 2021 + 60 - (EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            END "���������ϳ⵵"
            
        , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN 60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            ELSE 60 - (EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            END "���������ϳ⵵"
            */
            
        , CASE TO_NUMBER(SUBSTR(JUBUN, 7,1))  WHEN 1 THEN TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')
                                         WHEN 2 THEN TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')
                                         ELSE TO_DATE(TO_CHAR(2059 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')
             END "����������"
       
        , TRUNC(SYSDATE - HIREDATE) "�ٹ��ϼ�"
        
        , CASE TO_NUMBER(SUBSTR(JUBUN, 7,1))  WHEN 1 THEN TRUNC(TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')-SYSDATE)
                                          WHEN 2 THEN TRUNC(TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')-SYSDATE)
                                          ELSE TRUNC(TO_DATE(TO_CHAR(2059 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')-SYSDATE)
       END "�����ϼ�"
     
     , SAL "�޿�"
     
     , CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000 THEN SAL * 0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000 THEN SAL * 0.5
            ELSE 0
       END "���ʽ�"
       
FROM TBL_SAWON;

            /*
         , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN ADD_MONTHS(HIREDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)) * 12)
            ELSE 60 - (EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            END "���������ϳ⵵"
            */

/*            
FROM TBL_SAWON;
--TO_DATE('2021-12-28', 'YYYY-MM-DD')
---TO_DATE('XXXX-TO_CHAR(SYSDATE, 'MM')-TO_CHAR(SYSDATE, 'DD')', 'YYYY-MM-DD')
--TO_CHAR(SYSDATE, 'MM')
--TO_CHAR(SYSDATE, 'DD')
*/
-- SYSDATE + TO_YMINTERVAL('01-02')
/*
SELECT SYSDATE "���� �ð�"
     , SYSDATE + TO_YMINTERVAL('10-0') "���� ���"
               --@ 1�� 2���� ������                   3�� 4�ð� 5�� 6�� ������
FROM DUAL;  
--==>>

SELECT TO_DATE('1999-EXTRACT(MONTH FROM SYSDATE)-EXTRACT(DAY FROM SYSDATE)', 'YYYY-MM-DD')
FROM DUAL;

SELECT ADD_MONTHS(HIREDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)) * 12) "��� Ȯ��"
FROM TBL_SAWON;
*/

