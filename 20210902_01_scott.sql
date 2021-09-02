SELECT FILENO "파일번호", FILENAME "파일명"
FROM TBL_FILES;
--==>>
/*
파일번호 파일명
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
--○ TBL_FILES 테이블을 대상으로 위와 같이 조회될 수 있도록
--   쿼리문을 구성한다.
/*
--◈ 내가 작성한 코드
SELECT FILENO "파일번호", FILENAME "파일명" - 각 파일 이름.확장자만;
FROM TBL_FILES

SELECT FILENO "파일번호", INSTR(FILENAME, '\', 20, 1) "2"
FROM TBL_FILES
*/

SELECT FILENO "파일번호", FILENAME "경로포함파일명", SUBSTR(FILENAME, 16, 9) "파일명"
FROM TBL_FILES
WHERE FILENO=1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC	SALES.DOC

SELECT FILENO "파일번호", FILENAME "경로포함파일명", SUBSTR(FILENAME, 16, 9) "파일명"
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


SELECT FILENO "파일번호", FILENAME "경로포함파일명", REVERSE(FILENAME) "거꾸로"
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
--◈ 내가 작성한 코드
SELECT FILENO "파일번호", FILENAME "경로포함파일명", REVERSE(FILENAME) "거꾸로"
FROM TBL_FILES;

SELECT FILENO "파일번호", FILENAME "경로포함파일명", INSTR(REVERSE(FILENAME), '\') "거꾸로"
FROM TBL_FILES;

SELECT FILENO "파일번호", FILENAME "경로포함파일명", REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\')-1)) "파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호", SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\')-1) "파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호", REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\')-1)) "파일명"
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

SELECT FILENO "파일번호", FILENAME "경로포함파일명"
     ,  SUBSTR(REVERSE(FILENAME), 1, 최초 '\'가 등장하는 위치 - 1) "거꾸로된파일명"
FROM TBL_FILES;


-- 최초 '\'가 등장하는 위치 
INSTR(REVERSE(FILENAME), '\', 1)        -- 마지막 매개변수 1 생략


SELECT FILENO "파일번호", FILENAME "경로포함파일명"
     ,  SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1) "거꾸로된파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호", FILENAME "경로포함파일명"
     ,  SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1) "거꾸로된파일명"
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

SELECT FILENO "파일번호"--, FILENAME "경로포함파일명"
     ,  REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1)) "파일명"
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


--○ LPAD()
--> Byte 공간을 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수
--@ 얘는 항상 두번째 파라미터부터 보기!
SELECT 'ORACLE' "1"
     , LPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	****ORACLE
--> ① 10Byte 공간을 확보한다.                    → 두 번째 파라미터 값에 의해...
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.    → 첫 번째 파라미터 값에 의해....
--  ③ 남아있는 Byte 공간을 왼쪽부터 세 번째 파라미터 값으로 채운다.
--  ④ 이렇게 구성된 최종 결과값을 반환한다.

--○ RPLAD()
--> Byte 공간을 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "1"
     , LPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	****ORACLE
--> ① 10Byte 공간을 확보한다.                    → 두 번째 파라미터 값에 의해...
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.    → 첫 번째 파라미터 값에 의해....
--  ③ 남아있는 Byte 공간을 오른쪽부터 세 번째 파라미터 값으로 채운다.
--  ④ 이렇게 구성된 최종 결과값을 반환한다.



--○ LTRIM()
--@ 가공한걸 버리고, 남는걸 취함. --> 손톱깎이
--@ 하나씩 또각또각 자름... 완성형으로 한번에 자르지 X, LIKE 손톱깎이
SELECT 'ORAORAORACLEORACLE' "1"     -- 오라 오라 오라클 오라클
     , LTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , LTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"    --@ 완성형으로 한번에 자르지 X
     , LTRIM('ORAoRAORACLEORACLE', 'ORA') "4"       --@ 대소문자 구별 O
     , LTRIM('ORA ORAORACLEORACLE', 'ORA') "5"      --@ 공백 구별 O
     , LTRIM('          ORAORAORACLEORACLE', ' ') "6"
     , LTRIM('                      ORACLE') "7"    -- 왼쪽 공백 제거 함수로 활용(두 번째 파라미터 생략)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	CLEORACLE	CLEORACLE	oRAORACLEORACLE	 ORAORACLEORACLE	ORAORAORACLEORACLE	ORACLE
*/
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  왼쪽부터 연속적으로 두 번째 파라미터 값에서 지정한 글자와 같은 글자가 등장할 경우
--  이를 제거한 결과값을 반환한다.
--  단, 완성형으로 처리되지 않는다.

SELECT LTRIM('이김신이김신이이신신김이신신이이김김이신박이김신', '이김신') "TEST"
FROM DUAL;
--==> 박이김신

--○ RTRIM()
SELECT 'ORAORAORACLEORACLE' "1"     -- 오라 오라 오라클 오라클
     , RTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , RTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"    --@ 완성형으로 한번에 자르지 X
     , RTRIM('ORAoRAORACLEORACLE', 'ORA') "4"       --@ 대소문자 구별 O
     , RTRIM('ORA ORAORACLEORACLE', 'ORA') "5"      --@ 공백 구별 O
     , RTRIM('          ORAORAORACLEORACLE', ' ') "6"
     , RTRIM('ORACLE                      ') "7"    -- 오른쪽 공백 제거 함수로 활용(두 번째 파라미터 생략)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	ORAORAORACLEORACLE	AAAORAORAORACLEORACLE	ORAoRAORACLEORACLE	ORA ORAORACLEORACLE	          ORAORAORACLEORACLE	ORACLE
*/
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  오른쪽부터 연속적으로 두 번째 파라미터 값에서 지정한 글자와 같은 글자가 등장할 경우
--  이를 제거한 결과값을 반환한다.
--  단, 완성형으로 처리되지 않는다.


--○ TRANSLATE()
--> 1:1 로 바꾸어준다.
--@ 첫번째 문자를 두번째 파라미터에서 찾고, 두번째 파라미터와 1대1 매칭되는 세번째에서 찾아서 그대로 바꿈. 
--@ 만약 두번째 파라미터에 없다면? 바꾸지 않고 그대로 출력
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTYVWXYZ'
                , 'abcdefghijklmnopqrstyvwxyz') "RESULT"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-8743-7042'
                , '0123456789'
                , '공일이삼사오육칠팔구') "RESULT"
FROM DUAL;
--==>> 공일공-팔칠사삼-칠공사이


--○ REPLACE()
SELECT REPLACE('MY ORACLE ORAHOME', 'ORA', '오라')
FROM DUAL;
--==>> MY 오라CLE 오라HOME


--------------------------------------------------------------------------------


--○ ROUND() 반올림을 처리해주는 함수
SELECT 48.678 "1"
     , ROUND(48.678, 2) "2"     -- 소수점 이하 둘째자리까지 표현 (→셋째 자리에서 반올림)
     , ROUND(48.674, 2) "3"
     , ROUND(48.674, 1) "4"
     , ROUND(48.674, 0) "5"     --@ 정수로 표현
     , ROUND(48.674) "5"        -- 두 번째 파라미터 값이 0일 경우 생략 가능
     , ROUND(48.674, -1) "7"    --@ 10의 자리까지 표현 (→1의 자리에서 반올림)
     , ROUND(48.674, -2) "8"    --@ 100의 자리까지 표현 (→10의 자리에서 반올림)
     , ROUND(48.674, -3) "9"
FROM DUAL;
--==>> 48.678	48.68	48.67	48.7	49	49	50	0	0


--○ TRUNC() 절삭을 처리해주는 함수
SELECT 48.678 "1"
     , TRUNC(48.678, 2) "2"     -- 소수점 이하 둘째자리까지 표현 --@ 나머지는 다 없애라!
     , TRUNC(48.674, 2) "3"
     , TRUNC(48.674, 1) "4"
     , TRUNC(48.674, 0) "5"     --@ 정수로 표현
     , TRUNC(48.674) "5"        -- 두 번째 파라미터 값이 0일 경우 생략 가능
     , TRUNC(48.674, -1) "7"    --@ 10의 자리까지 표현 
     , TRUNC(48.674, -2) "8"    --@ 100의 자리까지 표현 
     , TRUNC(48.674, -3) "9"
FROM DUAL;
--==>> 48.678	48.67	48.67	48.6	48	48	40	0	0


--○ MOD() 나머지를 반환하는 함수
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
--> 5를 2로 나눈 나머지 결과값 반환


--○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
--> 5의 3승을 결과값으로 반환


--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2)
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> 루트 2 에 대한 결과값 반환


--○ LOG() 로그 함수
--  (※ 오라클은 상용로그만 지원하는 반면, MSSQL 은 상용로그, 자연로그 모두 지원한다.)
SELECT LOG(10, 100), LOG(10, 20)
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


--○ 삼각 함수
--   싸인, 코싸인, 탄젠트 결과값을 반환한다.
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/


--○ 삼각함수의 역함수 (범위 : -1 ~ 1)
--   어싸인, 어코싸인, 어탄젠트 결과값을 반환한다.
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/


--○ SIGN()      서명, 부호, 특징
--> 연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1 을 반환한다.
SELECT SIGN(5-2), SIGN(5-5), SIGN(5-8)
FROM DUAL;
--==>> 1	0	-1
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 주로 사용한다.


--○ ASCII(), CHR() → 서로 상응하는 개념의 함수
SELECT ASCII('A') "RESULT1", CHR(65) "RESULT2"
FROM DUAL;
--==>> 65	A
--> ASCII() : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
--  CHR()   : 매개변수로 넘겨받은 숫자를 아스키코드 값으로 취하는 문자를 반환한다.



--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--※ 날짜 연산의 기본 단위는 DAY(일수)이다~!!!  CHECK~!!!

SELECT SYSDATE "1", SYSDATE+1 "2", SYSDATE-2 "3", SYSDATE+3 "4" 
FROM DUAL;
--==>> 2021-09-02 10:35:34	    -- 현재
--     2021-09-03 10:35:34	    -- 1일 후
--     2021-08-31 10:35:34	    -- 2일 전
--     2021-09-05 10:35:34      -- 3일 후


--○ 시간 단위 연산
SELECT SYSDATE "1", SYSDATE + 1/24 "2", SYSDATE - 2/24 "3"
FROM DUAL;
--==>> 2021-09-02 10:37:57	    -- 현재
--     2021-09-02 11:37:57	    -- 1시간 후
--     2021-09-02 08:37:57      -- 2시간 전


--○ 현재 시간과...  현재 시간 기준 1일 2시간 3분 4초 후를 조회한다.
/*
-------------------------------------------------------------------------
             현재 시간                  연산 후 시간
-------------------------------------------------------------------------
        2021-09-02 10:40:13           2021-09-03 12:43:17
-------------------------------------------------------------------------
*/
/*
--◈ 내가 작성한 코드
SELECT 현재 시간, 현재 시간 기준 1일 2시간 3분 4초 후
FROM DUAL;

SELECT SYSDATE "현재 시간", SYSDATE 기준 1일 2시간 3분 4초 후 "연산 후 시간"
FROM DUAL;

SELECT SYSDATE "현재 시간", SYSDATE + 1 + 2/24 + 3/1440 + 4/86400 "연산 후 시간"
FROM DUAL;
--==>> 2021-09-02 10:43:10	2021-09-03 12:46:14
*/

-- 방법 1.
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;
--==>>
/*
2021-09-02 11:04:00	
2021-09-03 13:07:04
*/

-- 방법 2.
SELECT SYSDATE "현재 시간"
     , SYSDATE + ((24*60*60) + (2*60*60) + (3*60) + 4 ) / (24*60*60) "연산 후 시간"
     --              1일         2시간      3분
FROM DUAL;
--==>>
/*
2021-09-02 11:06:48	
2021-09-03 13:09:52
*/

--○ 날짜 - 날짜 = 일수
-- ex) (2021-12-28) - (2021-09-02)
--        수료일         현재일

SELECT TO_DATE('2021-12-28', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 117

--○ 데이터 타입의 변환
SELECT TO_DATE('2021-09-02', 'YYYY-MM-DD') "결과"     -- 날짜 형식으로 변환
FROM DUAL;
--==>> 2021-09-02 00:00:00

SELECT TO_DATE('2021-13-02', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-09-31', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-02-29', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2020-02-29', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 2020-02-29 00:00:00

--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 진행할 때
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다~!!!


--○ ADD_MONTHS()     개월 수를 더해주는 함수
SELECT SYSDATE "1"
     , ADD_MONTHS(SYSDATE, 2) "2"
     , ADD_MONTHS(SYSDATE, 3) "3"
     , ADD_MONTHS(SYSDATE, -2) "4"
     , ADD_MONTHS(SYSDATE, -3) "5"
FROM DUAL;
--==>>
/*
2021-09-02 11:19:12	    → 현재
2021-11-02 11:19:12	    → 2개월 후
2021-12-02 11:19:12	    → 3개월 후	
2021-07-02 11:19:12	    → 2개월 전	
2021-06-02 11:19:12	    → 3개월 전
*/
--> 월을 더하고 빼기


--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ MONTHS_BETWEEN()
-- 첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "결과확인"
FROM DUAL;
--==>> 231.079811081242532855436081242532855436

--> 개월 수의 차이를 반환하는 함수
--※ 결과값의 부호가 『-』로 반환되었을 경우에는
--   첫 번째 인자값에 해당하는 날짜보다
--   두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 확인할 수 있다.

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-12-28', 'YYYY-MM-DD')) "결과확인"
FROM DUAL;
--==>> -3.82334677419354838709677419354838709677
--> 수료일이 현재일보다 미래


--○ NEXT_DAY()
-- 첫 번째 인자값을 기준 날짜로 돌아오는 가장 빠른 요일 반환
SELECT NEXT_DAY(SYSDATE, '토') "결과1", NEXT_DAY(SYSDATE, '월') "결과2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--○ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

--○ 세션 설정을 변경한 후 위의 쿼리문을 다시 한 번 조회
SELECT NEXT_DAY(SYSDATE, '토') "결과1", NEXT_DAY(SYSDATE, '월') "결과2"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01846: not a valid day of the week
01846. 00000 -  "not a valid day of the week"
*Cause:    
*Action:
*/

SELECT NEXT_DAY(SYSDATE, 'SAT') "결과1", NEXT_DAY(SYSDATE, 'MON') "결과2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--○ 추가 세션 설정 다시 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.


--○ LAST_DAT()
-- 해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
SELECT LAST_DAY(SYSDATE) "결과확인"
FROM DUAL;
--==>> 2021-09-30

SELECT LAST_DAY(TO_DATE('2020-02-05', 'YYYY-MM-DD')) "결과 확인"
FROM DUAL;
--==>> 2020-02-29

SELECT LAST_DAY(TO_DATE('2021-02-05', 'YYYY-MM-DD')) "결과 확인"
FROM DUAL;
--==>> 2021-02-28


--○ 오늘부로.... 이중호 님이... 군대에 또 끌려(?)간다.
--   복무 기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.

-- 2. 하루 꼬박꼬박 3끼 식사를 해야 하다고 가정하면
--    중호가 몇 끼를 먹어야 집에 보내줄까.

--◈내가 작성한 코드
/*
--1.
SELECT SYSDATE "현재 날짜"
     , ADD_MONTHS(SYSDATE, 22) "전역 일자"
FROM DUAL;
--==>> 2021-09-02	2023-07-02

--2.
--SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "결과확인"
--FROM DUAL;
SELECT MONTHS_BETWEEN(TO_DATE('2023-07-02', 'YYYY-MM-DD'), TO_DATE('2021-09-02', 'YYYY-MM-DD')) "복무 개월수"
FROM DUAL;

SELECT MONTHS_BETWEEN(TO_DATE('2023-07-02', 'YYYY-MM-DD'), TO_DATE('2021-09-02', 'YYYY-MM-DD')  "복무 개월마다 끼니수"
FROM DUAL;

--LAST_DAY(SYSDATE)
-- 복무 개월의 각 복무 월마다 각 달의 마지막날짜를 구한 후 해당 날짜 *3 해서 총 더하면 끼니 수...!
-- 앗 바보짓함 ..ㅎㅎㅎ

SELECT TO_DATE('2023-07-02', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') "복무 일수"
FROM DUAL;

SELECT ( TO_DATE('2023-07-02', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') )*3 "복무 중 총 끼니 수"
FROM DUAL;
--==>> 2004
*/

--1.
SELECT ADD_MONTHS(SYSDATE, 22) "결과 확인"
FROM DUAL;
--==>> 2023-07-02

--2. 
--    복무기간 * 3
--    --------
--   (전역일자 - 현재일자)

--   --   (전역일자 - 현재일자)

SELECT (전역일자 - 현재일자)
FROM DUAL;

SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3
FROM DUAL;
--==>> 2004


--○ 현재 날짜 및 시각으로부터... 수료일(2021-12-28 18:00:00) 까지
--   남은 기간을... 다음과 같은 형태로 조회할 수 있도록 한다.
/*
--------------------------------------------------------------------------------
현재시각             | 수료일              |  일  | 시간 | 분 | 초 
--------------------------------------------------------------------------------
2021-09-02 12:08:23  | 2021-12-28 18:00:00 | 115  |  4   | 42 | 37
--------------------------------------------------------------------------------
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.
--@ SQL DEVELOPER 무거움... 믿지말고 <저장> 자주자주 해줘야함! 
--@ 응답 대기상태.. 문제 해결된경우 거의 없음. 빨리 프로그램 종료하고 새로시작하거나 재부팅 하기

--◈내가 작성한 코드
/*
SELECT 현재시각, 수료일, 일, 시간, 분, 초
FROM DUAL;

SELECT SYSDATE "현재시각"
, TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
, TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0) "일"

, 시간
, 분
, 초

FROM DUAL;

SELECT SYSDATE "현재시각"
, TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
, TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0) "일"
, ((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24 "시간"
-- 수료 시간까지 전체 시간 - 그중 일자까지 뺌, 즉 지금 0.23일 남은 거....
-- 일을 시간으로 만드려면...X24?

, "분"
, "초"

FROM DUAL;

SELECT SYSDATE "현재시각"
, TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
, TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0) "일"
, TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0) "시간"
-- 수료 시간까지 전체 시간 - 그중 일자까지 뺌, 즉 지금 0.23일 남은 거....
-- 일을 시간으로 만드려면...X24? 해서 절삭

-- (수료일 - 수료까지 일 - 수료까지 시간(/24))(날 기준 남은 시간들) * 24 * 60
, TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE            -- 남은 전체 일수
- TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0))*24      -- 남은 일수 빼기
- TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0)) -- 남은 시간도 뺀것... 일수 기준
* 60,0)
"분"

, TRUNC((((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE            -- 남은 전체 일수
- TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0))*24      -- 남은 일수 빼기
- TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0)) -- 남은 시간도 뺀것... 일수 기준
* 60 )* 60
- (TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE            
- TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0))*24      
- TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')- SYSDATE) -  TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE, 0)) *24,0)) -- 남은 시간도 뺀것... 일수 기준
* 60,0))*60,0)
"초"

FROM DUAL;
*/

-- 『1일 2시간 3분 4초』 를... 『초』로 환산하면...
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- 61초 → 1분 1초
SELECT MOD(61, 60)
FROM DUAL;


-- 『93784』초를 다시 일, 시간, 분, 초로 환산하면...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24)  --@ TRUNC : 26시간 대한 몫을 가지겠다....
     , MOD (TRUNC(TRUNC(93784/60)/60), 24) --@ MOD : 26시간 대한 나머지만 내가 가지겠다.. 시간
     , MOD(TRUNC(93784/60), 60) --@ TRUNC : 몫을 취함 + MOD : 분으로 보여줌
     , MOD(93784, 60)  --@ MOD : 나머지를 취함
FROM DUAL;
--==>> 1	2	3	4


-- 수료일까지 남은 기간 확인(날짜 기준) → 단위 : 일수
SELECT 수료일자 - 현재일자
FROM DUAL;

-- 수료일자
SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 2021-12-28 18:00:00 → 날짜 형식

-- 현재일자
SELECT SYSDATE
FROM DUAL;
--==>> 2021-09-02 15:19:41 → 날짜 형식

SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 117.110393518518518518518518518518518519 → 단위 : 일수   → 숫자 형식
--> 수료일까지 남은 일수


-- 수료일까지 남은 기간 확인(날짜 기준) → 단위 : 초
SELECT (수료일까지 남은 일수) * (하루를 구성하는 전체 초)
FROM DUAL;

SELECT (수료일까지 남은 일수) * (24*60*60)
FROM DUAL;

SELECT (TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 10118165.00000000000000000000000000000003    → 단위 : 초 → 숫자 형식
--> 수료일까지 남은 초

/*
-- 『93784』초를 다시 일, 시간, 분, 초로 환산하면...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24)  --@ TRUNC : 26시간 대한 몫을 가지겠다....
     , MOD (TRUNC(TRUNC(93784/60)/60), 24) --@ MOD : 26시간 대한 나머지만 내가 가지겠다.. 시간
     , MOD(TRUNC(93784/60), 60) --@ TRUNC : 몫을 취함 + MOD : 분으로 보여줌
     , MOD(93784, 60)  --@ MOD : 나머지를 취함
FROM DUAL;
이거 가져와서 하단에 사용! 같은 논리. 93784 -> (TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60) 로만 바꾼 것
*/

SELECT TRUNC(TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24)  "일"
     , MOD (TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "시간"
     , MOD(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "분"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "초" --@ 앞에 TRUNC 추가: 절삭
FROM DUAL;

SELECT  SYSDATE "현재시각"
     , TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일자"
     , TRUNC(TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24)  "일"
     , MOD (TRUNC(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "시간"
     , MOD(TRUNC((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "분"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "초"
FROM DUAL;
--==>> 
/*
현재시각                수료일자           일         시간          분        초
------------------- ------------------- ---------- ---------- ---------- ----------
2021-09-02 15:31:38 2021-12-28 18:00:00        117          2         28       21
*/

--○ 문제
-- 본인이 태어나서 현재까지...
-- 얼마만큼의 일, 시간, 분, 초를 살았는지... (살고있는지...)
-- 조회하는 쿼리문을 구성한다.
/*
--------------------------------------------------------------------------------
현재 시각              |  태어난 시각          |  일   | 시간 |  분 | 초
--------------------------------------------------------------------------------
2021-09-02 15:33:20    | 1991-05-06 12:00:00   | XXXXX |  XX  |  XX | XX
--------------------------------------------------------------------------------
*/

SELECT SYSDATE
FROM DUAL;

SELECT SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 9442.151284722222222222222222222222222222 (→ 일자 기준 살아온 시간)

-- 살아온 기간 초 단위로 환산 → 단위 : 초

SELECT ((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)
FROM DUAL;
--==>> 815801953 (→ 초 기준 살아온 시간)

SELECT TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60)/24) "일"
     , MOD (TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60), 24) "시간"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60), 60) "분"
     , MOD(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60), 60) "초" 
FROM DUAL;

SELECT TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60)/24) "일"
     , MOD (TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60), 24) "시간"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60), 60) "분"
     , TRUNC(MOD(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60), 60)) "초" -- 초는 한번더 절삭!
FROM DUAL;

SELECT SYSDATE "현재 시각"
     , TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "태어난 시각"
     , TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60)/24) "일"
     , MOD (TRUNC(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60)/60), 24) "시간"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60)/60), 60) "분"
     , TRUNC(MOD(((SYSDATE - TO_DATE('1995-10-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60), 60)) "초" -- 초는 한번더 절삭!
FROM DUAL;
--==>>
/*
     현재 시각           태어난 시각        일         시간        분        초
------------------- ------------------- ---------- ---------- ---------- ----------
2021-09-02 15:43:32 1995-10-27 12:00:00    9442         3         43        32
*/ 


--○ 날짜 형식 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--※ 날짜 데이터를 대상으로 반올림, 절삭을 수행할 수 있다.

--○ 날짜 반올림
SELECT SYSDATE "1"                      -- 2021-09-02   → 기본 현재 날짜
       , ROUND(SYSDATE, 'YEAR') "2"     -- 2022-01-01   → 년도까지 유효한 데이터(상반기, 하반기 기준)
       , ROUND(SYSDATE, 'MONTH') "3"    -- 2021-09-01   → 월까지 유효한 데이터(15일 기준)
       , ROUND(SYSDATE, 'DD') "4"       -- 2021-09-03   → 날짜까지 유효한 데이터(정오 기준)
       , ROUND(SYSDATE, 'DAY') "5"      -- 2021-09-05   → 날짜까지 유효한 데이터(수요일 기준)
FROM DUAL;

--○ 날짜 절삭
SELECT SYSDATE "1"                      -- 2021-09-02   → 기본 현재 날짜
       , TRUNC(SYSDATE, 'YEAR') "2"     -- 2021-01-01   → 년도까지 유효한 데이터
       , TRUNC(SYSDATE, 'MONTH') "3"    -- 2021-09-01   → 월까지 유효한 데이터
       , TRUNC(SYSDATE, 'DD') "4"       -- 2021-09-02   → 날짜까지 유효한 데이터
       , TRUNC(SYSDATE, 'DAY') "5"      -- 2021-08-29   → 날짜까지 유효한 데이터(전 주 일요일)
FROM DUAL;
--@ TRUN 사용시에는 올림이 절대 발생하지 않음!


--------------------------------------------------------------------------------

--■■■ 변환 함수 ■■■--

-- TO_CHAR()    : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
-- TO_DATE()    : 문자 데이터(날짜 형식)를 날짜 타입으로 변환시켜주는 함수
-- TO_NUMBER()  : 문자 데이터(숫자 형식)를 숫자 타입으로 변환시켜주는 함수


--※ 날짜나 통화 형식이 맞지 않을 경우
--   세션 설정값을 통해 설정을 변경할 수 있다.

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_CURRENCY = '\';   -- 원(￦)
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   -- 2021-09-02
     , TO_CHAR(SYSDATE, 'YYYY')         -- 2021
     , TO_CHAR(SYSDATE, 'YEAR')         -- TWENTY TWENTY-ONE    --@ 시스템언어 한글로 바꾸어도 바뀌지 X
     , TO_CHAR(SYSDATE, 'MM')           -- 09
     , TO_CHAR(SYSDATE, 'MONTH')        -- 9월 	
     , TO_CHAR(SYSDATE, 'MON')          -- 9월 	
     , TO_CHAR(SYSDATE, 'DD')           -- 02	
     , TO_CHAR(SYSDATE, 'DAY')          -- 목요일	
     , TO_CHAR(SYSDATE, 'DY')           -- 목	
     , TO_CHAR(SYSDATE, 'HH24')         -- 16	        --@ 24시간 기준
     , TO_CHAR(SYSDATE, 'HH')           -- 04	
     , TO_CHAR(SYSDATE, 'HH AM')        -- 04 오후	    --@ AM을 쓰든, PM을 쓰든 현재가 오후니까 오후 출력됨
     , TO_CHAR(SYSDATE, 'HH PM')        -- 04 오후	
     , TO_CHAR(SYSDATE, 'MI')           -- 22	
     , TO_CHAR(SYSDATE, 'SS')           -- 46	
     , TO_CHAR(SYSDATE, 'SSSSS')        -- 58966	    → 금일 흘러온 전체 초
     , TO_CHAR(SYSDATE, 'Q')            -- 3            → 분기
FROM DUAL;
--@ 문자 타입으로 반환함!(결과창 왼쪽으로 붙음. 숫자는 오른쪽으로 붙음)

SELECT 2021 "1", '2021' "2"
FROM DUAL;

SELECT '23' "1", TO_NUMBER('23') "2"
FROM DUAL;


--○ EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "1"     -- 2021 → 연도를 추출하여 문자 타입으로...
     , TO_CHAR(SYSDATE, 'MM') "2"       -- 09   → 월을 추출하여 문자 타입으로...
     , TO_CHAR(SYSDATE, 'DD') "3"       -- 02	→ 일을 추출하여 문자 타입으로...
     , EXTRACT(YEAR FROM SYSDATE) "4"   -- 2021	→ 연도를 추출하여 숫자 타입으로... --@ 날짜로부터 연도를 얻어온다...
     , EXTRACT(YEAR FROM SYSDATE) "5"   -- 2021	→ 월을 추출하여 숫자 타입으로...   --@ 꼭 SYSDATE 아니어도 날짜타입이면 됨
     , EXTRACT(DAY FROM SYSDATE) "6"    -- 2    → 일을 추출하여 숫자 타입으로...
FROM DUAL;
--@ TO_CHAR : 문자로 반환.. EXTRACT : 숫자로 반환....
--> 연, 월, 일 이하 다른 것은 불가



--○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환
SELECT 60000 "1"
     , TO_CHAR(60000) "2"
     , TO_CHAR(60000, '99,999') "3"
     , TO_CHAR(60000, '$99,999') "4"
     , TO_CHAR(60000, 'L99,999') "5" --@ 좌측 정렬인데 통화기호 매우 다양... 통화기호 한글자 아닌나라도 있으므로
                                     --@ 통화로 표현할수 있는 공간 확보해놓아서 빈 공간이 생김
     , LTRIM(TO_CHAR(60000, 'L99,999')) "6" --@ -> 그래서 일반적으로 이렇게 함께 사용
FROM DUAL;
--==>> 60000	60000	 60,000	 $60,000	          \60,000	\60,000

--○ 날짜 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다.
--◈내가 작성한 코드
/*
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;
*/
SELECT SYSDATE "현재 시간"
    , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))  "1일2시간3분4초후"
FROM DUAL;
--==>>
/*
2021-09-02 17:01:58	
2021-09-03 19:05:02
*/

--○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회한다.
--   TO_YMINTERVAL(), TO_DSiNTERVAL()

SELECT SYSDATE "현재 시간"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "연산 결과"
               --@ 1년 2개월 더해짐                   3일 4시간 5분 6초 더해짐
FROM DUAL;  
--==>>
/*
2021-09-02 17:05:35	
2022-11-05 21:10:41
*/

--------------------------------------------------------------------------------

--○ CASE 구문(조건문, 분기문)
/*
CASE
WHEN
THEN
ELSE
END
*/
--@ CASE구문으로 뭉뚱그리지말고 각각 구문 이름으로 부르면서 기억하기! 그래야 나중에 필요할때 쓰기 가능
--@  CASE WHEN THEN ELSE END 구문...

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2는 몰라요' END "결과 확인"
FROM DUAL;
--==>> 5+2=7

SELECT CASE 5+2 WHEN 9 THEN '5+2=7' ELSE '5+2는 몰라요' END "결과 확인"
FROM DUAL;
--==>> 5+2는 몰라요

--@Cntl + enter : 한컴 입력기 바꾸기

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '몰라요'
       END "결과 확인"
FROM DUAL;
--==>> 1+1=2


--○ DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-2는 몰라요') "결과 확인"
FROM DUAL;
--==>> 5-2=3


SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '비교 불가'
            END "결과 확인"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 THEN '범석만세'
            WHEN 5>2 OR 2=3 THEN '지윤만세'
            ELSE '현정 만세'
       END "결과 확인"
FROM DUAL;
--==>> 범석만세
/*
SELECT CASE WHEN T THEN '범석만세'
            WHEN T THEN '지윤만세'
            ELSE '현정 만세'
       END "결과 확인"
FROM DUAL;
*/
--@ 맨 앞의 것이 TRUE면 뒤 연산 수행하지 않음

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '해덕만세' 
            WHEN 5<2 AND 2=3 THEN '지영만세'
            ELSE '진하만세'
       END "결과 확인"
FROM DUAL;
--==>> 해덕만세
/*
SELECT CASE WHEN T THEN '해덕만세' 
            WHEN 5<2 AND 2=3 THEN '지영만세'
            ELSE '진하만세'
       END "결과 확인"
FROM DUAL;
*/


SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '해덕만세' 
            WHEN 5<2 AND 2=3 THEN '지영만세'
            ELSE '진하만세'
       END "결과 확인"
FROM DUAL;
--==>> 진하만세
/*
SELECT CASE WHEN F THEN '해덕만세' 
            WHEN F THEN '지영만세'
            ELSE '진하만세' --@※ ELSE 다음에는 THEN 붙지 않음 주의!
       END "결과 확인"
FROM DUAL;
*/


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT *
FROM TBL_SAWON;

--○ 문제
-- TBL_SWAON 테이블을 활용하여 다음과 같은 항목들을 조회한다.
-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 단, 현재나이는 한국나이 계산법에 따라 연산을 수행한다. (태어나면 기본 한 살 먹음)
-- 또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해(연도)의
-- 그 직원의 입사 월, 일로 연산을 수행한다.
-- 그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은
-- 그 사원의 원래 급여 기준 30% 지급,
-- 2000일 이상 근무한 사원은
-- 그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.

--@ 정년퇴직일 : 김 사원이 60세가 되는 해가 2050년... 2050-01-03일로 퇴사일 하기. 
--@ 남은일수는 퇴사일까지 며칠 남았는지... 보너스는 근무일수에 따라서.
--@ 길 것이다..... 길다......

SELECT *
FROM TBL_SAWON;

SELECT 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 정년퇴직일, 근무일수, 남은일수, 급여, 보너스
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명" , JUBUN "주민번호" 
        , 성별, 현재나이, HIREDATE "입사일", 정년퇴직일, 근무일수, 남은일수, SAL "급여", 보너스
FROM TBL_SAWON;

--◈ 성별 : 주민번호 7번째 자리가 2,4 면 여성, 1,3 이라면 남성
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '여성' 
            WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '남성'
            ELSE '성별미상'
            END "성별"
--FROM TBL_SAWON;

--◈ 현재 나이 : 현재 년도 - 주민등록번호 맨 앞자리 두 글자 이용한 태어난 년도 빼기
-- 주번 맨 앞자리 수가 0이면 20XX... 나머지 경우에는 19XX...

--현재 년도
--TO_CHAR(SYSDATE, 'YYYY')
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;

SELECT CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000+(주민번호 앞자리 두개))
            ELSE 현재 년도 - (1900+(주민번호 앞자리 두개))
            END "나이"

SELECT CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000+(주민번호 앞자리 두개))
            ELSE 현재 년도 - (1900+(주민번호 앞자리 두개))
            END "나이"








