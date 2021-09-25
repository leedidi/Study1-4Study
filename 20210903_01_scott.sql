SELECT USER
FROM DUAL;
--==>> SCOTT

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
--◈ 내가 만든 코드 
/*
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
            END "현재나이";

SELECT CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            ELSE EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            END "현재나이"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명" , JUBUN "주민번호" 
        , CASE WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '여성' 
            WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '남성'
            ELSE '성별미상'
            END "성별"
            
        , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            ELSE EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1
            END "현재나이"
            */
        /*CASE WHEN 김사원이 60세가 되면... THEN HIREDATE의 해당 년도로 적용
            ELSE 
            END "정년퇴직일"*/
        /*CASE WHEN 60-현재나이 THEN HIREDATE의 해당 년도로 적용
            ELSE 
            END "정년퇴직일"*/
            
            -- (60 - "현재나이") -> 이 년도를 HIREDATE 년도에 더하면 됨....
            -- TO_DATE(HIREDATE, 'YY-MM-DD') HIREDATE 99..11
            /*
        , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN 2021 + 60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            ELSE 2021 + 60 - (EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            END "정년퇴직일년도"
            
        , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN 60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            ELSE 60 - (EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            END "정년퇴직까지년"
            */
            -- SYSDATE + TO_YMINTERVAL('01-02')
           /*
         , CASE WHEN SUBSTR(JUBUN, 1,1) = '0' THEN ADD_MONTHS(HIREDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)) * 12)
            ELSE 60 - (EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)
            END "정년퇴직일년도"
            */

            /*
        , CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 7,1)) '0'  THEN '0'
                ELSE '0'
                END "정년퇴직일"
           */
           /*
         , HIREDATE "입사일"
         , CASE TO_NUMBER(SUBSTR(JUBUN, 7,1))  WHEN 1 THEN TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')
                                         WHEN 2 THEN TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')
                                         ELSE TO_DATE(TO_CHAR(2059 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')
             END "정년퇴직일"
         
        , TRUNC(SYSDATE - HIREDATE) "근무일수"
        
        , CASE TO_NUMBER(SUBSTR(JUBUN, 7,1))  WHEN 1 THEN TRUNC(TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')-SYSDATE)
                                          WHEN 2 THEN TRUNC(TO_DATE(TO_CHAR(1959 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')-SYSDATE)
                                          ELSE TRUNC(TO_DATE(TO_CHAR(2059 + TO_NUMBER(SUBSTR(JUBUN, 1,2))) || TO_CHAR(HIREDATE, '-MM-DD'), 'YYYY-MM-DD')-SYSDATE)
       END "남은일수"
       
     , SAL "급여"
     
     , CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000 THEN SAL * 0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000 THEN SAL * 0.5
            ELSE 0
       END "보너스"
       
       
FROM TBL_SAWON;

SELECT TO_CHAR( ADD_MONTHS(SYSDATE, (60 - 현재나이) * 12), 'YYYY') "정년연도"
FROM TBL_SAWON;
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2')  
            THEN TO_CHAR( ADD_MONTHS(SYSDATE, (60 - ((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1900)+1))   ) * 12), 'YYYY')
            WHEN SUBSTR(JUBUN,7,1) IN ('3', '4')  
            THEN TO_CHAR( ADD_MONTHS(SYSDATE, (60 - ((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+2000)+1))) * 12), 'YYYY')
            ELSE '잘못된 연도' END "정년연도"
FROM TBL_SAWON;
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2')  
            THEN TO_CHAR( ADD_MONTHS(SYSDATE, (60 - ((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1900)+1))   ) * 12), 'YYYY') || TO_CHAR(HIREDATE, '-MM-DD')
            WHEN SUBSTR(JUBUN,7,1) IN ('3', '4')  
            THEN TO_CHAR( ADD_MONTHS(SYSDATE, (60 - ((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+2000)+1))) * 12), 'YYYY') || TO_CHAR(HIREDATE, '-MM-DD')
            ELSE '잘못된날짜' END "정년퇴직일"
FROM TBL_SAWON;

-- THEN 2개, 


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
SELECT SYSDATE "현재 시간"
     , SYSDATE + TO_YMINTERVAL('10-0') "연산 결과"
               --@ 1년 2개월 더해짐                   3일 4시간 5분 6초 더해짐
FROM DUAL;  
--==>>

SELECT TO_DATE('1999-EXTRACT(MONTH FROM SYSDATE)-EXTRACT(DAY FROM SYSDATE)', 'YYYY-MM-DD')
FROM DUAL;
*/
/*
SELECT ADD_MONTHS(HIREDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (2000 + TO_NUMBER(SUBSTR(JUBUN,1,2))) + 1)) * 12) "결과 확인"
FROM TBL_SAWON;
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


-- TBL_SAWON 테이블에 존재하는 사원들의
-- 입사일(HIREDATE) 컬럼에서 월, 일,만 조회하기
SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM-DD') "월일"
FROM TBL_SAWON;
--==>>
/*
김소연	    2001-01-03	01-03
이다영	    2010-11-05	11-05
이지영	    2012-08-16	08-16
손다정	    1999-02-02	02-02
이하이	    2013-07-15	07-15
이이경	    2011-08-17	08-17
김이나	    1999-11-11	11-11
아이유	    1999-11-11	11-11
선동열	    1995-11-11	11-11
선우용녀	1995-10-10	10-10
선우선	    2001-10-10	10-10
남진	    1998-02-13	02-13
남궁현	    2002-02-13	02-13
남도일	    2002-02-13	02-13
김남길	    2015-01-10	01-10
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM') "월", TO_CHAR(HIREDATE, 'DD') "일"
FROM TBL_SAWON;
--==>>
/*
김소연	    2001-01-03	01	03
이다영	    2010-11-05	11	05
이지영	    2012-08-16	08	16
손다정	    1999-02-02	02	02
이하이	    2013-07-15	07	15
이이경	    2011-08-17	08	17
김이나	    1999-11-11	11	11
아이유	    1999-11-11	11	11
선동열	    1995-11-11	11	11
선우용녀	1995-10-10	10	10
선우선	    2001-10-10	10	10
남진	    1998-02-13	02	13
남궁현	    2002-02-13	02	13
남도일	    2002-02-13	02	13
김남길	    2015-01-10	01	10
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM') || '-' || TO_CHAR(HIREDATE, 'DD') "월일"
FROM TBL_SAWON;
--==>>
/*
김소연	    2001-01-03	01-03
이다영	    2010-11-05	11-05
이지영	    2012-08-16	08-16
손다정	    1999-02-02	02-02
이하이	    2013-07-15	07-15
이이경	    2011-08-17	08-17
김이나	    1999-11-11	11-11
아이유	    1999-11-11	11-11
선동열	    1995-11-11	11-11
선우용녀	1995-10-10	10-10
선우선	    2001-10-10	10-10
남진	    1998-02-13	02-13
남궁현	    2002-02-13	02-13
남도일	    2002-02-13	02-13
김남길	    2015-01-10	01-10
*/

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN 주민번호 7번째자리 1개가 '1' 또는 '3' THEN '남자'
            WHEN 주민번호 7번째자리 1개가 '2' 또는 '4' THEN '여자'
            ELSE '성별확인불가'
            END "성별"
            --@ ELSE에는 기타 오류사항 쓰는게 나음! 왜냠 WHEN 1,3 ELSE.. 해버리면 % 이런거 들어가도 여자가 되어버리니까.
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
            
--=>>
/*
1001	김소연	    9307302234567	여자
1002	이다영	    9510272234567	여자
1003	이지영	    0909014234567	여자
1004	손다정	    9406032234567	여자
1005	이하이	    0406034234567	여자
1006	이이경	    0202023234567	남자
1007	김이나	    8012122234567	여자
1008	아이유	    8105042234567	여자
1009	선동열	    7209301234567	남자
1010	선우용녀	7001022234567	여자
1011	선우선	    9001022234567	여자
1012	남진	    8009011234567	남자
1013	남궁현	    8203051234567	남자
1014	남도일	    9208091234567	남자
1015	김남길	    0202023234567	남자
*/
            
/* --@ 이런 느낌으로 먼저 써보고 그뒤 코드 작성하기...        
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1990년대 생 / 2000년대 생)
    , CASE WHEN 1900년대 생이라면...
           THEN 현재년도 - (주민번호 앞 두자리 + 1899) 
           WHEN 2000년대 생이라면...
           THEN 현재년도 - (주민번호 앞 두자리 + 1999)
           ELSE -1
    END "현재나이" 
*/

, CASE WHEN 주민번호 1번째자리 1개가 '1' 또는 '2'
           THEN 현재년도 - (주민번호 앞 두자리 + 1899) 
           WHEN 주민번호 1번째자리 1개가 '3' 또는 '4'
           THEN 현재년도 - (주민번호 앞 두자리 + 1999)
           ELSE -1
    END "현재나이" 

FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN 주민번호 7번째자리 1개가 '1' 또는 '3' THEN '남자'
            WHEN 주민번호 7번째자리 1개가 '2' 또는 '4' THEN '여자'
            ELSE '성별확인불가'
            END "성별"
            --@ ELSE에는 기타 오류사항 쓰는게 나음! 왜냠 WHEN 1,3 ELSE.. 해버리면 % 이런거 들어가도 여자가 되어버리니까.
FROM TBL_SAWON;


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
            
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1990년대 생 / 2000년대 생)
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 
FROM TBL_SAWON;
--==>>
/*
1001	김소연	    9307302234567	여자	29
1002	이다영	    9510272234567	여자	27
1003	이지영	    0909014234567	여자	13
1004	손다정	    9406032234567	여자	28
1005	이하이	    0406034234567	여자	18
1006	이이경	    0202023234567	남자	20
1007	김이나	    8012122234567	여자	42
1008	아이유	    8105042234567	여자	41
1009	선동열	    7209301234567	남자	50
1010	선우용녀	7001022234567	여자	52
1011	선우선	    9001022234567	여자	32
1012	남진	    8009011234567	남자	42
1013	남궁현	    8203051234567	남자	40
1014	남도일	    9208091234567	남자	30
1015	김남길	    0202023234567	남자	20
*/


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
            
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1990년대 생 / 2000년대 생)
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 
    , HIREDATE " 입사일"
    , SAL "급여"
FROM TBL_SAWON;
--==>>
/*
1001	김소연	    9307302234567	여자	29	2001-01-03	3000
1002	이다영	    9510272234567	여자	27	2010-11-05	2000
1003	이지영	    0909014234567	여자	13	2012-08-16	1000
1004	손다정	    9406032234567	여자	28	1999-02-02	4000
1005	이하이	    0406034234567	여자	18	2013-07-15	1000
1006	이이경	    0202023234567	남자	20	2011-08-17	2000
1007	김이나	    8012122234567	여자	42	1999-11-11	3000
1008	아이유	    8105042234567	여자	41	1999-11-11	3000
1009	선동열	    7209301234567	남자	50	1995-11-11	3000
1010	선우용녀	7001022234567	여자	52	1995-10-10	3000
1011	선우선	    9001022234567	여자	32	2001-10-10	2000
1012	남진	    8009011234567	남자	42	1998-02-13	4000
1013	남궁현	    8203051234567	남자	40	2002-02-13	3000
1014	남도일	    9208091234567	남자	30	2002-02-13	3000
1015	김남길	    0202023234567	남자	20	2015-01-10	2000
*/

--@ 마치 테이블 묶어서 생성한 것처럼 사용 가능!
SELECT T.사원번호, 연봉
FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", SAL "급여", SAL*12 "연봉"
    FROM TBL_SAWON
)T;


SELECT TBL_SAWON.SANO
FROM TBL_SAWON;
/*
SELECT T.SANO
FROM TBL_SAWON T;

SELECT TBL_SAWON.SANO
FROM SCOTT.TBL_SAWON;

SELECT SCOTT.TBL_SAWON.SANO
FROM SCOTT.TBL_SAWON;
*/

SELECT TBL_SAWON.SANO, TBL_SAWON.SANAME, TBL_SAWON.SAL
FROM TBL_SAWON;

SELECT S.SANO, S.SANAME, S.SAL
FROM TBL_SAWON S;

--
SELECT A.사원번호, A.사원명, A.연봉, A.연봉*2 "두배연봉"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", SAL "급여", SAL*12 "연봉" -- 연봉*2 "두배연봉" 
                                                                        --> 이거 안됨! SELECT는 한번에 쾅! 찍히기 때문에..
    FROM TBL_SAWON
) A;
--@ '인라인 뷰'라고 부름... 라인단위안에서 보고싶은거 만들어서 뷰처럼 활용



--○ 문제
-- TBL_SWAON 테이블을 활용하여 다음과 같은 항목들을 조회한다.
-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 단, 현재나이는 한국나이 계산법에 따라 연산을 수행한다. (태어나면 기본 한 살 먹음)
-- 또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해(연도)의
-- 그 직원의 입사 월, 일로 연산을 수행한다.

-- 그리고, 보너스는 4000일 이상 8000일 미만 근무한 사원은 --> ※ 보너스 조건 변경!
-- 그 사원의 원래 급여 기준 30% 지급,
-- 8000일 이상 근무한 사원은
-- 그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다. 

SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     -- 정년퇴직일
     -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
     -- 현재 나이가... 58세...  2년 후       2021 → 2023
     -- 현재 나이가... 35세... 25년 후       2021 → 2046
     -- ADD_MONTHS(SYSDATE, 남은년수*12)
     --                     -------
     --                     (60 - 현재나이)
     -- ADD_MONTHS(SYSDATE, (60 - 현재나이)*12) → 이 결과에서 정년퇴직 년도만 필요
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이)*12), 'YYYY') → 정년퇴직 년도만 추출 
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이)*12), 'YYYY') || '-' ||  TO_CHAR(HIREDATE, 'MM-DD')
      , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' ||  TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
     
     -- 근무일수 = 현재일 - 입사일
      , TRUNC(SYSDATE - T.입사일) "근무일수"
      
     -- 남은일수 = 정년퇴직일 - 현재일
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') 
       || '-' ||  TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
     
     , T.급여
     
     -- 보너스
     -- 근무일수가 4000일 이상 8000일 미만 → 원래 급여의 30%
     -- 근무일수가 8000일 이상             → 원래 급여의 50%
     -- 나머지 0
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
        END "보너스"
     
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 
    , HIREDATE "입사일"
    , SAL "급여"
FROM TBL_SAWON
) T;



--@○ 위 내용 주석 제거판

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일

      , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' ||  TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
      , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') 
       || '-' ||  TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
        END "보너스"
     
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 
    , HIREDATE "입사일"
    , SAL "급여"
FROM TBL_SAWON
) T;


--※ 상기 내용에서... 특정 근무일수의 사원을 확인해야 한다거나...
--   특정 보너스 금액을 받는 사원을 확인해야 할 경우가 생길 수 있다.
--   이와 같은 경우... 해당 쿼리문을 다시 구성하는 번거로움을 줄일 수 있도록
--   뷰(VIEW)를 만들어 저장해 둘 수 있다.

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일

      , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' ||  TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
      , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') 
       || '-' ||  TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
        END "보너스"
     
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 
    , HIREDATE "입사일"
    , SAL "급여"
FROM TBL_SAWON
) T;
--==>> 에러 발생
/*
ORA-01031: insufficient privileges
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/
--> 권한이 불충분하여 발생하는 에러

-- ※ SYS 로부터 VIEW 를 생성할 수 있는 권한을 부여받은 후
--    다시 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일

      , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' ||  TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
      , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') 
       || '-' ||  TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
        END "보너스"
     
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 
    , HIREDATE "입사일"
    , SAL "급여"
FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON이(가) 생성되었습니다.
--@ 복붙하지 말고 하나씩 하나씩 항목 따로따로 작성하기!!
--@ 오라클은 가급적, 점심시간에 저장 다 하고 PC 재부팅하기!
--@ 커밋 하시겠습니까? 나오면 커밋하기! (롤백X)

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT *
FROM VIEW_SAWON;
--==>>
/*
1001	김소연	    9307302234567	여자	29	2001-01-03	2052-01-03	7548	11078	3000	900
1002	이다영     	9510272234567	여자	27	2010-11-05	2054-11-05	3955	12115	2000	0
1003	이지영     	0909014234567	여자	13	2012-08-16	2068-08-16	3305	17148	1000	0
1004	손다정	    9406032234567	여자	28	1999-02-02	2053-02-02	8249	11474	4000	2000
1005	이하이	    0406034234567	여자	18	2013-07-15	2063-07-15	2972	15289	1000	0
1006	이이경	    0202023234567	남자	20	2011-08-17	2061-08-17	3670	14592	2000	0
1007	김이나	    8012122234567	여자	42	1999-11-11	2039-11-11	7967	6642	3000	900
1008	아이유	    8105042234567	여자	41	1999-11-11	2040-11-11	7967	7008	3000	900
1009	선동열	    7209301234567	남자	50	1995-11-11	2031-11-11	9428	3720	3000	1500
1010	선우용녀	7001022234567	여자	52	1995-10-10	2029-10-10	9460	2958	3000	1500
1011	선우선	    9001022234567	여자	32	2001-10-10	2049-10-10	7268	10263	2000	600
1012	남진	    8009011234567	남자	42	1998-02-13	2039-02-13	8603	6371	4000	2000
1013	남궁현	    8203051234567	남자	40	2002-02-13	2041-02-13	7142	7102	3000	900
1014	남도일	    9208091234567	남자	30	2002-02-13	2051-02-13	7142	10754	3000	900
1015	김남길	    0202023234567	남자	20	2015-01-10	2061-01-10	2428	14373	2000	0
*/  
--@ 뷰를 쓰는 두 가지 큰 이유(나중에 뷰파트가서 할거지만..미리 간략하게)
--1. 보안 목적 사용
--2. 편의성 (@ 마치 사진 찰칵! 찍는거처럼 만들어놓으면.. 별도 긴 쿼리 없이도 필요 데이터 출력 가능)

--○ TBL_SAWON 테이블의 김소원 사원의 입사일 및 급여 데이터 변경
-- 현재 TABLE 상태 : 1001	김소연	9307302234567	2001-01-03	3000
-- 현재 VIEW 상태  : 1001	김소연	9307302234567	여자	29	2001-01-03	2052-01-03	7548	11078	3000	900

SELECT *
FROM VIEW_SAWON;

UPDATE TBL_SAWON
SET HIREDATE=SYSDATE, SAL=5000
WHERE SANO=1001;
--@ 업데이트 구문 사용시 그이후 반드시 WHERE 부터 작성
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_SAWON
WHERE SANO=1001;
--==>> 1001	김소연	9307302234567	2021-09-03	5000

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_SAWON;
--@ 뷰 생성후 테이블 바꿔도... 뷰도 알아서 바뀜! (이거도 뷰의 매우 중요한 특징) (※ 기억해두기!)
--@ 오라클 내부적으로는 뷰 조회마다 뷰 구문이 돌아감... 때문에 연결되어있는 테이블이 바뀌면 뷰도 따라서 바뀜



--○ TBL_SAWON 테이블의 김소원 사원의 입사일 및 급여 데이터 변경 이후 다시 확인
-- 현재 TABLE 상태 : 1001	김소연	9307302234567	2001-01-03	3000
-- 변경 후 상태    : 1001	김소연	9307302234567	2021-09-03	5000
-- 현재 VIEW 상태  : 1001	김소연	9307302234567	여자	29	2001-01-03	2052-01-03	7548	11078	3000	900
-- 변경 후 상태    : 1001	김소연	9307302234567	여자	29	2021-09-03	2052-09-03	   0	11322	5000	  0


--○ 문제
-- 서브쿼리를 활용하여 TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
/*
----------------------------------------------------
   사원명   성별   현재나이    급여   나이보너스
-----------------------------------------------------

단, 나이보너스는 현재 나이가 40세 이상이면 급여의 70%
    30세 이상 40세 미만이면 급여의 50%
    20세 이상 30세 미만이면 급여의 30%로 한다.
    
또한, 완성된 조회 구문을 기반으로
VIEW_SAWON2 라는 이름의 뷰(VIEW)를 생성한다.
*/

--◈ 내가 작성한 코드
/*
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
            END "성별"
            
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1990년대 생 / 2000년대 생)
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
           ELSE -1
    END "현재나이" 

SELECT 사원명, 성별, 현재나이, 급여, 나이보너스
FROM TBL_SAWON;

SELECT SANAME "사원명"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
           WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
           ELSE '성별불명'
    END 성별
    -- 현재나이 : 현재년도 - 태어난 년도 + 1 
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
           ELSE -1 --'나이불명' --@ 모든 THEN, ELSE 문에 같은 형태가 나와야 오류 안 나나봄..!
    END 현재나이
    , SAL "급여"
    */
    /*
    , CASE WHEN 40세 이상이면 THEN 급여의 70% 
           WHEN 30세 이상 40세 미만이면 THEN 급여의 50%
           WHEN  20세 이상 30세 미만이면 THEN 급여의 30%
           ELSE -1
    END 나이보너스
    */
    -- 직접 꺼내올수가 없으니까 따로따로 가져와야 할 거 같은데
    -- 90년대 00년대생 나눠서 어떻게,,,,적용시키지,,,,,?
    -- 00년대생이 22살....
    /*
    , CASE WHEN 40세 이상이면 THEN SAL * 0.7
           WHEN 30세 이상 40세 미만이면 THEN SAL * 0.5
           WHEN 20세 이상 30세 미만이면 THEN SAL * 0.3
           ELSE -1
    END 나이보너스1
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
           THEN 
           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
           THEN 
           ELSE -1
    END 나이보너스2
FROM TBL_SAWON;
*/

--@ 이게 메인쿼리?
SELECT SANAME "사원명"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '확인불가'
       END 성별
      , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
             WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
             ELSE -1   --'확인불가'는 사용 X
             --@ THEN, ELSE 이하에 데이터 타입 같은 게 들어가야 함! (문자, 숫자..)
             --@ CNTL + F : 찾기
         END "현재나이"
      , SAL "급여"
FROM TBL_SAWON;

--@ FROM 절 먼저 작성하는게 어색하면 안 돼용~!!
SELECT T.*
     , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
            WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
            WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
            ELSE 0
            END "나이보너스"

--@ 서브쿼리?            
FROM
(
    SELECT SANAME "사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '확인불가'
           END 성별
          , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                 WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                 ELSE -1   --'확인불가'는 사용 X
                 --@ THEN, ELSE 이하에 데이터 타입 같은 게 들어가야 함! (문자, 숫자..)
                 --@ CNTL + F : 찾기
             END "현재나이"
          , SAL "급여"
    FROM TBL_SAWON --@ 세미콜론 지우는 거 주의!
) T;
--@ 프롬절 형태의 서브쿼리.... 인라인 뷰! () 안에거만 잡아서 실행시켜도 실행 되어야함


CREATE USER 유저명;
CREATE TABLE 테이블명;
CREATE INDEX 인덱스명;
CREATE VIEW 뷰명;
--@ 얘네는 똑같은 이름 이미 존재하면 오류 남
--@ USER, TABLE, INDX는 여기저기 연결되어 있는 경우가 다수... 때문에 이것만 바꾸기 쉽지 않음

--CREATE OR REPLACE VIEW 뷰명
--@ 얘는 똑같은 이름 존재해도 오류나지 않음
--@ 새로 만들거나, 같은 이름이 있다면 덮어쓰서 저장
--@ VIEW는 여기저기 연결되어 있지 않음 가벼움! 때문에 이렇게 자주 사용

--CREATE 사람 사람이름;
--CREATE OR REPLACE 종이컵 종이컵이름; --@ 종이컵 경우에는 다른 종이컵으로 사용!

CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.*
     , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
            WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
            WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
            ELSE 0
            END "나이보너스"

--@ 서브쿼리?            
FROM
(
    SELECT SANAME "사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '확인불가'
           END 성별
          , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                 WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                 ELSE -1   --'확인불가'는 사용 X
                 --@ THEN, ELSE 이하에 데이터 타입 같은 게 들어가야 함! (문자, 숫자..)
                 --@ CNTL + F : 찾기
             END "현재나이"
          , SAL "급여"
    FROM TBL_SAWON --@ 세미콜론 지우는 거 주의!
) T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.


--○ 생성된 뷰 조회(확인)
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
김소연	    여성	29	5000	1500
이다영	    여성	27	2000	600
이지영	    여성	13	1000	0
손다정	    여성	28	4000	1200
이하이	    여성	18	1000	0
이이경	    남성	20	2000	600
김이나	    여성	42	3000	2100
아이유	    여성	41	3000	2100
선동열	    남성	50	3000	2100
선우용녀	여성	52	3000	2100
선우선 	    여성	32	2000	1000
남진	    남성	42	4000	2800
남궁현	    남성	40	3000	2100
남도일	    남성	30	3000	1500
김남길	    남성	20	2000	600
*/


--------------------------------------------------------------------------------

--○ RANK()  등수(순위)를 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP;
--==>>
/*
7839	KING	10	5000	 1
7902	FORD	20	3000	 2
7788	SCOTT	20	3000	 2
7566	JONES	20	2975	 4
7698	BLAKE	30	2850	 5
7782	CLARK	10	2450	 6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500	 8
7934	MILLER	10	1300	 9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	 950	13
7369	SMITH	20	 800	14
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내 급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP;
--==>>
/*
7839	KING	10	5000	1	 1
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7698	BLAKE	30	2850	1	 5
7782	CLARK	10	2450	2	 6
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7934	MILLER	10	1300	3	 9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	950	    6	13
7369	SMITH	20	800	    5	14
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내 급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 6
7934	MILLER	10	1300	3	 9
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7876	ADAMS	20	1100	4   12
7369	SMITH	20	 800	5   14
7698	BLAKE	30	2850	1	 5
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	 950	6	13
*/
--@ 9위가 두명이면 다음이 11위!

--○ DENSE_RANK()    → 서열을 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내 급여서열"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체 급여서열"
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 5
7934	MILLER	10	1300	3	 8
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	2	 3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12
7698	BLAKE	30	2850	1	 4
7499	ALLEN	30	1600	2	 6
7844	TURNER	30	1500	3	 7
7654	MARTIN	30	1250	4	 9
7521	WARD	30	1250	4	 9
7900	JAMES	30	 950    5	11
*/
--@ 9위가 두명이더라도 다음이 10위!


--○ EMP 테이블의 사원 정보를
--   사원명, 부서번호, 연봉, 부서내 연봉순위, 전체 연봉순위 항목으로 조회한다.
/*
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내 급여서열"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP
ORDER BY 3, 4 DESC;
*/
/*
--◈ 내가 작성한 코드
SELECT 사원명, 부서번호, 연봉, 부서내 연봉순위, 전체 연봉순위
FROM EMP;

SELECT ENAME "사원명", EMPNO "부서번호", SAL*12 "연봉"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12 DESC) "부서내 연봉순위"
     , RANK() OVER(ORDER BY SAL*12 DESC) "전체 연봉순위"
FROM EMP;
*/


--○ EMP 테이블의 사원 정보를
--   사원명, 부서번호, 연봉, 부서내 연봉순위, 전체 연봉순위 항목으로 조회한다.
SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내 연봉순위"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체 연봉순위"
FROM EMP
ORDER BY 2, 3 DESC;
--==>>
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
MILLER	10	15600	3	10
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
ADAMS	20	13200	4	12
SMITH	20	9600	5	14
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
WARD	30	15500	5	11
JAMES	30	11400	6	13
*/

SELECT T.*
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내 연봉순위"
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체 연봉순위"
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호"
               , SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
) T
ORDER BY 2, 3 DESC;

--○ EMP 테이블에서 전체 연봉 순위가 1등부터 5등 까지만...
--   사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다.
/*
--◈ 내가 작성한 코드
SELECT 사원명, 부서번호, 연봉, 전체연봉순위
FROM EMP
WHERE 전체 연봉 순위가 1등부터 5등;

SELECT T.*
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체 연봉순위"
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호"
               , SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
) T
WHERE 'T.전체 연봉순위'>0 AND 'T.전체 연봉순위'<6;
--@ FROM WHERE GROUP BY.... HAVING SELECT ORDER BY
*/

--○ 함께 작성한 코드
SELECT 사원명, 부서번호, 연봉, 전체연봉순위
FROM EMP
WHERE 전체 연봉 순위가 1등부터 5등;

SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉순위"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) <=5;
--==>> 에러 발생
/*
ORA-30483: window  functions are not allowed here
30483. 00000 -  "window  functions are not allowed here"
*Cause:    Window functions are allowed only in the SELECT list of a query.
           And, window function cannot be an argument to another window or group
           function.
*Action:
1,023행, 37열에서 오류 발생
*/

--※ 위의 내용은 RANK() OVER() 를 WHERE 조건절에서 사용한 경우이며...
--   이 함수는 WHERE 조건절에서 사용할 수 없는 함수이며
--   이 규칙을 어겼기 때문에 발생하는 에러이다.
--   이 경우... 우리는 INLINE VIEW 를 활용하여 풀이해야 한다.

SELECT T.*
FROM 
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉순위"
    FROM EMP
) T
WHERE T.전체연봉순위 <= 5;
--==>>
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/

SELECT T2.*
FROM
(
    SELECT T1.*
          , RANK() OVER(ORDER BY T1.연봉 DESC) "전체연봉순위"
    FROM 
    (
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
        FROM EMP
    ) T1
) T2
WHERE T2.전체연봉순위 <=5;
--==>>
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/


--○ EMP 테이블에서 각 부서별로 연봉 등수가 1등 부터 2등 까지만...
--   사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수 항목을 조회할 수 있도록 한다.

--1.
SELECT T.*
FROM 
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉등수"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉등수"
    FROM EMP
) T
WHERE T.부서내연봉등수 <= 2;

--2.
SELECT T2.*
FROM
(
    SELECT T1.*
          , RANK() OVER(PARTITION BY T1.부서번호 ORDER BY T1.연봉 DESC) "부서내연봉등수"
          , RANK() OVER(ORDER BY T1.연봉 DESC) "전체연봉등수"
    FROM 
    (
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
        FROM EMP
    ) T1
) T2
WHERE T2.부서내연봉등수 <=2;


--------------------------------------------------------------------------------

--■■■ 그룹 함수 ■■■---

-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값,
-- VARIANCE() 분산, STDDEV() 표준편차

--※ 그룹 함수의 가장 큰 특징은
--   처리해야 할 데이터들 중 NULL 이 존재하면
--   이 NULL 은 제외하고 연산을 수행한다는 것이다.

-- SUM()
-- EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SUM(SAL)      -- 800 + 1600 + 1250 + 2975 + 1250 + 2850... 1300
FROM EMP;
--==>> 29025

SELECT SUM(COMM)     -- NULL+ + 300 + 500 + NULL + .... + NULL (Ⅹ)
FROM EMP;            -- 300 + 500 + 1400 + 0                   (○)
--==>> 2200

-- COUNT()
-- 행의 갯수 조회하여 결과값 반환
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(SAL)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- COMM 컬럼의 행의 갯수 조회 → NULL 은 제외~!!!
FROM EMP;
--==>>  4

SELECT COUNT(*)
FROM EMP;
--==>>  4



--○ AVG()
-- 평균 반환
SELECT SUM(SAL) / COUNT(SAL) "1", AVG(SAL) "2"
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/

SELECT AVG(COMM)
FROM EMP;
--==>> 550

SELECT SUM(COMM) / COUNT(COMM)
FROM EMP;
--==>> 550

SELECT SUM(COMM) / 14
FROM EMP;
--==>> 157.142857142857142857142857142857142857

SELECT SUM(COMM) / COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857


--※ 표준편차의 제곱이 분산
--   분산의 제곱근이 표준편차
SELECT AVG(SAL), VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2) "급여표준편차제곱"
     , VARIANCE(SAL) "급여분산"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) "급여분산제곱근"
     , STDDEV(SAL) "급여표준편차"
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/
--@ 요정도는 기억 해두기! 분산, 표준편차....


--○ MAX() / MIN()
--  최대값   최소값 반환
SELECT MAX(SAL), MIN(SAL)
FROM EMP;
--==>> 5000 800

--※ 주의
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
1,215행, 8열에서 오류 발생
*/

SELECT ENAME, SAL
FROM EMP;

SELECT ENAME, SUM(SAL)
FROM EMP;


SELECT DEPTNO, SUM(SAL) --@ 두개 엮어서, 단일행에 보여줄 수 있는 방법이 없음!
FROM EMP;
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
1,233행, 8열에서 오류 발생
*/


--○ 부서별 급여합 조회
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY DEPTNO
--@ 부서끼리 번호별로 묶어줘...
ORDER BY DEPTNO;
--==>>
/*
10	 8750
20	10875
30	 9400
*/

--○ 직종별 급여합 조회
SELECT JOB "직종명", SUM(SAL) "급여합"
FROM EMP
GROUP BY JOB;
--==>>
/*
CLERK	    4150
SALESMAN	5600
PRESIDENT	5000
MANAGER	    8275
ANALYST	    6000
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);


--------------------------------------------------------------------------------

-- 공유...조인성...등등
--○ 데이터 입력
INSERT INTO TBL_EMP VALUES 
(8001, '차은우', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES 
(8002, '서강준', 'CLERK', 7566, SYSDATE, 1000, 0, NULL);
 --==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

INSERT INTO TBL_EMP VALUES
(8003, '공유', 'SALESMAN', 7698, SYSDATE, 2000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '이동욱', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);

INSERT INTO TBL_EMP VALUES
(8005, '조인성', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		        20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250   1400	    30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
8003	공유	SALESMAN	7698	2021-09-06	2000		
8004	이동욱	SALESMAN	7698	2021-09-06	2500		
8005	조인성	SALESMAN	7698	2021-09-06	1000		
8001	차은우	CLERK	    7566	2021-09-03	1500	   10	
8002	서강준	CLERK	    7566	2021-09-03	1000	    0	
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.








