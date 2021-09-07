SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750        -- 부서번호가 10번인 사원들의 급여합
20	    10875       -- 부서번호가 20번인 사원들의 급여합
30	    9400        -- 부서번호가 30번인 사원들의 급여합
(null)  8000        -- 부서번호가 존재하지 않는 사원들(NULL)의 급여합
(null)	37025       -- 모든 부서의 사원들의 급여합
*/


-- 위에서 조회한 내용을
/*
10	         8750        -- 부서번호가 10번인 사원들의 급여합
20	        10875        -- 부서번호가 20번인 사원들의 급여합
30	         9400        -- 부서번호가 30번인 사원들의 급여합
인턴         8000        -- 부서번호가 존재하지 않는 사원들(NULL)의 급여합
모든부서	37025        -- 모든 부서의 사원들의 급여합
*/
-- 이와 같이 조회하고자 한다.

SELECT CASE DEPTNO WHEN NULL 
                   THEN '인턴'
                   ELSE DEPTNO
       END "부서번호"
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
31행, 29열에서 오류 발생
*/
--@ THEN 뒤와 ELSE 뒤의 자료형이 맞지 않기 때문에 에러 발생함

SELECT CASE DEPTNO WHEN NULL
                   THEN '인턴'
                   ELSE TO_CHAR(DEPTNO)
       END "부서번호"
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
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END "부서번호"
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
인턴
인턴
인턴
인턴
인턴
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END "부서번호"
       , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
인턴	8000
인턴	37025
*/


--※ GROUPING()

--==>>
/*
30	    9400	0
(null)	8000	0
20	    10875	0
10  	8750	0
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합", GROUPING(DEPTNO)
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
10	         8750        -- 부서번호가 10번인 사원들의 급여합
20	        10875        -- 부서번호가 20번인 사원들의 급여합
30	         9400        -- 부서번호가 30번인 사원들의 급여합
인턴         8000        -- 부서번호가 존재하지 않는 사원들(NULL)의 급여합
모든부서	37025        -- 모든 부서의 사원들의 급여합
*/

--◈ 내가 작성한 코드
/*
SELECT DEPTNO "부서번호", SUM(SAL) "급여합", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 0
            THEN '인턴'
            WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 1
            THEN '모든부서'
            ELSE TO_CHAR(DEPTNO)
       END "부서번호"
       , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
*/

SELECT CASE WHEN THEN ELSE END "부서번호"
       , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '모든부서' END "부서번호"
       , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
(null)	     8000
모든부서	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서' END "부서번호"
       , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8000
모든부서	37025
*/


--○ TBL_SWAON 테이블을 다음과 같이 조회할 수 있도록
--   쿼리문을 구성한다.
/*
------------------------------
     성별      급여합
------------------------------
      남       XXXX
      여       XXXX
      모든사원 XXXXX
------------------------------
*/

--◈ 내가 작성한 코드
/*
SELECT *
FROM TBL_SAWON;

SELECT 성별, 급여합
FROM TBL_SWAON;

SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
       WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
       ELSE '확인불가'
       END "성별"
FROM TBL_SAWON;


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
       WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
       ELSE '확인불가'
       END "성별"
       , GROUPING(성별) WHEN 1 THEN '모든사원'
         ELSE 성별
         END "성별2"
FROM TBL_SAWON
GROUP BY ROLLUP(성별);

SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
       WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
       ELSE '확인불가'
       END "성별"
       , GROUPING(JUBUN) WHEN WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                         WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
         ELSE 성별
         END "성별2"
FROM TBL_SAWON
GROUP BY ROLLUP(성별);
*/

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
            ELSE '모든사원'
        END "성별"
        , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
           WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
           ELSE '확인불가'
           END "성별"
           , SAL "급여"
           FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);



-- ○ TBL_SWAON 테이블을 다음과 같이 연령대별 인원수 형태로
--    조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------
     연령대         인원수
--------------------------------
      10              X
      20              X
      30              X
      40              X
      50              X
    전체             XX
--------------------------------
*/

--◈ 내가 작성한 코드
/*
SELECT CASE WHEN T.현재나이 <20 THEN '10' 
            WHEN T.현재나이 <30 THEN '20'
            WHEN T.현재나이 <40 THEN '30'
            WHEN T.현재나이 <50 THEN '40'
            WHEN T.현재나이 <60 THEN '50'
            ELSE '확인불가' 
            END "연령대"
FROM                  
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1
    END "현재나이" 
FROM TBL_SAWON
) T;

SELECT CASE WHEN T.현재나이 <20 THEN '10' 
            WHEN T.현재나이 <30 THEN '20'
            WHEN T.현재나이 <40 THEN '30'
            WHEN T.현재나이 <50 THEN '40'
            WHEN T.현재나이 <60 THEN '50'
            ELSE '확인불가' 
            END "연령대"
FROM                  
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1
    END "현재나이" 
FROM TBL_SAWON
) T;



SELECT CASE WHEN T.현재나이 <20 THEN '10' 
            WHEN T.현재나이 <30 THEN '20'
            WHEN T.현재나이 <40 THEN '30'
            WHEN T.현재나이 <50 THEN '40'
            WHEN T.현재나이 <60 THEN '50'
            ELSE '확인불가' 
            END "각자연령대"
FROM                  
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1
    END "현재나이" 
FROM TBL_SAWON
) T
GROUP BY "각자연령대";


SELECT
FROM
(
    SELECT CASE WHEN T.현재나이 <20 THEN '10' 
                WHEN T.현재나이 <30 THEN '20'
                WHEN T.현재나이 <40 THEN '30'
                WHEN T.현재나이 <50 THEN '40'
                WHEN T.현재나이 <60 THEN '50'
                ELSE '확인불가' 
                END "각자연령대"
    FROM                  
    (
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1
        END "현재나이" 
    FROM TBL_SAWON
    ) T
) T2
GROUP BY(T2.각자연령대);
*/

-- 방법 1. (INLINE VIEW 를 두 번 중첩~!!!)

-- 연령대별 인원수
SELECT CASE GROUPING(Q.연령대) WHEN 0 THEN TO_CHAR(Q.연령대)
            ELSE '전체'
        END "연령대"
     , COUNT(Q.연령대) "인원수"
FROM
(
    -- 연령대
    SELECT CASE WHEN T.나이 >= 50 THEN 50
                WHEN T.나이 >= 40 THEN 40
                WHEN T.나이 >= 30 THEN 30
                WHEN T.나이 >= 20 THEN 20
                WHEN T.나이 >= 10 THEN 10
                ELSE 0
           END "연령대"
    FROM 
    (
    -- 나이
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) -- 2000 - 1!
                ELSE 0
                END "나이"
    FROM TBL_SAWON
    ) T
) Q
GROUP BY ROLLUP(Q.연령대);
--==>>
/*
10	     2
20	     5
30	     2
40	     4
50  	 2
전체	15
*/

-- 방법 2. (INLINE VIEW 를 한 번만 사용~!!!)

--SELECT TRUNC(나이, -1)
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0 END, -1) "연령대"
           --@ 오라클에서 쿼리문 한번에 풀려고 하지 말기.. 안에 있는 애들 먼저 만든 후 그후 치환해야 풀 수 있음
FROM TBL_SAWON;

SELECT TRUNC(23, -1) "확인"
FROM DUAL;
--==>> 20 → 23세의 연령대

-- 인라인 뷰 사용해서 묶는 방법 작성해보기! 위와 상동... --@ 실행 완료!

SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
            ELSE '전체'
        END "연령대"
     , COUNT(T.연령대) "인원수"
    
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE 0 END, -1) "연령대"
               --@ 오라클에서 쿼리문 한번에 풀려고 하지 말기.. 안에 있는 애들 먼저 만든 후 그후 치환해야 풀 수 있음
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);


--○ ROLLUP 활용 및 CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)  	8750        -- 10번 부서 모든 직종의 급여합
20	    ANALYST	    6000    
20	    CLERK   	1900
20	    MANAGER	    2975
20	    (null)  	10875       -- 20번 부서 모든 직종의 급여합
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600    
30	    (null)  	9400        -- 30번 부서 모든 직종의 급여합
(null)  (null)		29025       -- 모든 부서 모든 직종의 급여합
*/


--○ CUBE() → ROLLUP() 보다 자세한 결과를 반환받을 수 있다.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10		(null)       8750       -- 10번 부서 모든 직종의 급여합
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20		(null)      10875       -- 20번 부서 모든 직종의 급여합
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30		(null)       9400       -- 30번 부서 모든 직종의 급여합
(null)	ANALYST	     6000       -- 모든 부서 ANALYST 직종의 급여합
(null)	CLERK	     4150       -- 모든 부서 CLERK 직종의 급여합
(null)	MANAGER 	 8275       -- 모든 부서 MANAGER 직종의 급여합
(null)	PRESIDENT	 5000       -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	 5600       -- 모든 부서 SALESMAN 직종의 급여합
(null)  (null)		29025       -- 모든 부서 모든 직종의 급여합
*/


-- ※ ROLLUP() 과 CUBE() 는
--    그룹을 묶어주는 방식이 다르다. -- 차이

-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

--   CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위의 처리 내용은 너무 많은 결과물이 출력되기 때문에
--     다음의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는  조회하고자 하는 그룹만 『GROUPING SETS』를
--     이용하여 묶어주는 방법이다.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
            END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
부서번호                                    직종     급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           2500
인턴                                     SALESMAN        5500
인턴                                     전체직종        8000
전체부서                                 전체직종       37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
            END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
부서번호                                    직종      급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           2500
인턴                                     SALESMAN        5500
인턴                                     전체직종        8000
전체부서                                 ANALYST         6000
전체부서                                 CLERK           6650
전체부서                                 MANAGER         8275
전체부서                                 PRESIDENT       5000
전체부서                                 SALESMAN       11100
전체부서                                 전체직종       37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
            END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB))
ORDER BY 1, 2;
--==>>
/*
부서번호                                   직종       급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           2500
인턴                                     SALESMAN        5500
인턴                                     전체직종        8000
전체부서                                 ANALYST         6000
전체부서                                 CLERK           6650
전체부서                                 MANAGER         8275
전체부서                                 PRESIDENT       5000
전체부서                                 SALESMAN       11100
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
            END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())     -- ROLLUP() 과 같은 결과
ORDER BY 1, 2;
--==>>
/*
부서번호                                   직종       급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           2500
인턴                                     SALESMAN        5500
인턴                                     전체직종        8000
전체부서                                 전체직종       37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
            END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (JOB), ())     -- CUBE() 와 같은 결과
ORDER BY 1, 2;
--==>>
/*
부서번호                                   직종      급여합
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
인턴                                     CLERK           2500
인턴                                     SALESMAN        5500
전체부서                                 ANALYST         6000
전체부서                                 CLERK           6650
전체부서                                 MANAGER         8275
전체부서                                 PRESIDENT       5000
전체부서                                 SALESMAN       11100
전체부서                                 전체직종       37025
*/


--○ TBL_EMP 테이블에서 입사년도별 인원수를 조회한다.
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

/*
-----------------------
   입사년도    인원수
-----------------------
   1980          1 
   1981         10
   1982          1
   1987          2
   2021          5
   전체         19
------------------------
*/
-- ◈내가 작성한 코드
/*
--GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
       
SELECT CASE GROUPING(HIREDATE) WHEN 0 THEN SUBSTR(TO_CHAR(HIREDATE), 1, 4)
                               ELSE '전체' END "입사년도"
     --, COUNT(입사년도) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(HIREDATE);

SELECT SUBSTR(TO_CHAR(HIREDATE), 1, 4) "입사년도"
FROM TBL_EMP;

-- 됐당 ㅠㅠ!!
SELECT CASE GROUPING(T.입사년도) WHEN 0 THEN TO_CHAR(T.입사년도)
                               ELSE '전체' END "입사년도"       
       , COUNT(T.입사년도) "인원수"
FROM
(
SELECT SUBSTR(TO_CHAR(HIREDATE), 1, 4) "입사년도"
FROM TBL_EMP
) T
GROUP BY ROLLUP(T.입사년도);
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
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


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
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

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS(EXTRACT(YEAR FROM HIREDATE), ()) --@ 년도별로 한번, 전체로 한번 묶어줘라
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


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
770행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
784행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
798행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      -- '1980' '1981' '1982' ...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
812행, 26열에서 오류 발생
*/
--@ 맨첨 SELECT HIREDATE와 GROUP BY 데이터타입이 다르기 때문에 에러 발생일까? 단순히 그건 아님


SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
      , COUNT(*) "인원수"
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


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      -- '1980' '1981' '1982' ...
ORDER BY 1;
--@ SELECT의 '파싱 타입' 때문.... 단순히 문자열 타입만 다르기 때문임은 아님! --※ 중요!
--@ GROUP BY 된걸 가지고 SELECT 구문에 올려서 처리해야 함...!
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
843행, 26열에서 오류 발생
*/

SELECT TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY')) "입사년도"
      , COUNT(*) "인원수"
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

--■■■ HAVING ■■■--

-- ○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--    부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.

--@ HAVING을 사용하지 않고 이 문제 해결해 보기! 해결보다는 어떤 문제가 발생하는지 확인해보기.
--◈ 내가 작성한 코드
/*
SELECT *
FROM TBL_EMP;

SELECT 부서의 총 급여가 10000보다 적을 경우만 부서별 총 급여
FROM TBL_EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;

-- 부서별 총 급여
SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
GROUP BY GROUPING SETS(DEPTNO)
ORDER BY 1;
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
--@ 실행 가능

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--@ 에러 발생

/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
906행, 7열에서 오류 발생
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
HAVING SUM(SAL) < 10000;
--@ 아래구문보다 이 구문을 더 권장! 부서번호가 20, 30만 메모리에 올려놓고 처리! -> 리소스 소모가 덜 큼
--==>>
/*
30  9400
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20, 30)
   AND SUM(SAL) < 10000;
-- 부서번호 모두 메모리에 올려놓고 처리! -> 리소스 소모가 더 큼
--==>>
/*
30	9400
*/


--------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- 이마저도... MSSQL 은 불가능하다.
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
--@ 주의! 2레벨까지만 중첩 가능


-- RANK()
-- DENSE_RANK()
--> ORACLE 9i 부터 적용... MSSQL 2005 부터 적용...

--※ 하위 버전에서는 RANK() 나 DENSE_RANK() 를 사용할 수 없기 때문에
--   이를 대체하여 연산을 수행할 수 있는 방법을 강구해야 한다.

-- 예를 들어, 급여의 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 확인한 숫자에 +1 을 추가 연산해주면 그것이 곧 등수가 된다.

-- 80 90 10 50 → 3
--          --

SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--==>> 14 → SMITH 의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;
--==>> 7 → ALLER 의 급여 등수

SELECT ENAME, SAL, RANK() OVER(ORDER BY SAL DESC)
FROM EMP;


-- ※ 서브 상관 쿼리 (상관 서브 쿼리)
--    메인 쿼리에 있는 테이블의 컬럼이
--    서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--    우리는 이 쿼리문을 서브 상관 쿼리 라고 부른다.

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;

SELECT E1.ENAME "사원명", E1.SAL "급여", (SELECT COUNT(*) + 1
                                          FROM EMP E2
                                          WHERE E2.SAL > E1.SAL) "급여등수" --@ 특정 쿼리를 안에 사용..
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

-- ○ EMP 테이블을 대상으로
--    사원명, 급여, 부서번호, 부서급여내등수, 전체급여등수 항목을 조회한다.
--    단, RANK() 함수를 사용하지 않고, 상관 서브 쿼리를 활용할 수 있도록 한다.

--◈ 내가 작성한 코드
/*
SELECT *
FROM EMP;

SELECT ENAME "사원명", SAL "급여", 부서번호 "DEPTNO"
     , 부서내급여내등수
     , 전체급여등수
FROM EMP;

SELECT E1.ENAME "사원명", E1.SAL "급여", E1.DEPTNO "부서번호" 
     --,"부서내급여내등수"
     , (SELECT COUNT(*) + 1 "전체급여등수"
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "전체급여등수"
FROM EMP E1;

SELECT E1.ENAME "사원명", E1.SAL "급여", E1.DEPTNO "부서번호" 
     --,"부서내급여내등수"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "전체급여등수"
    ,   (SELECT COUNT(*) + 1 
        FROM EMP E3
        WHERE E3.DEPTNO = E1.DEPTNO AND E3.SAL > E1.SAL) "부서내급여등수"
FROM EMP E1
ORDER BY DEPTNO;
*/

SELECT ENAME "사원명", SAL "급여", DEPTNO "부서번호"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL AND E2.DEPTNO = E1.DEPTNO) "부서내급여등수"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "전체급여등수"
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

-- ○ EMP 테이블을 대상으로 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------------------------------------------
   사원명   부서번호   입사일      급여      부서내입사별급여누적
--------------------------------------------------------------------
   CLERK       10     1981-06-09   2450        2450  
   KING        10     1981-11-17   5000        7450
   MILLER      10     1982-01-23   1300        8750
   SMITH       20     1980-12-17    800         800
                          :  
*/

/*
SELECT 사원명, 부서번호, 입사일, 급여, 부서내입사별급여누적
FROM EMP;

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , "부서내입사별급여누적"
FROM EMP;

-
, (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL AND E2.DEPTNO = E1.DEPTNO) "부서내급여등수"
-

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO AND E1.HIREDATE >= E2.HIREDATE) "부서내입사별급여누적"
FROM EMP E1
ORDER BY E1.DEPTNO, E1.HIREDATE;
*/

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , (1)"부서내입사별급여누적"
FROM EMP
ORDER BY 2, 3;


SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , (SELECT SUM(SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
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


--○ TBL_EMP 테이블에서 입사한 사원의 수가 제일 많았을 때의
--   입사년월과 인원수를 조회할 수 있는 쿼리문을 구성한다.
/*
--------------------------------------
    입사년월             인원수
--------------------------------------
    XXXX-XX                 X
--------------------------------------
*/

/*
SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , (SELECT SUM(SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;
*/

SELECT ENAME, HIREDATE
FROM TBL_EMP
ORDER BY 2;

/*
--------------------------------------
    입사년월             인원수
--------------------------------------
     2021-09                5
--------------------------------------
*/

-- 내가 작성한 코드
/*
SELECT ENAME, HIREDATE
     , (SELECT HIREDATE
        FROM TBL_EMP E2 
        WHERE 입사한 사원 수가 가장 많았을 때) "입사년월"
     , (SELECT COUNT(*)
        FROM TBL_EMP E2 
        WHERE E1.HIREDATE = E2.HIREDATE) "인원수"
FROM TBL_EMP E1
ORDER BY 2;
*/

SELECT TO_CHAR(HIREDATE,'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
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

SELECT TO_CHAR(HIREDATE,'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (5);
--=>> 2021-09	5


SELECT MAX(COUNT(*))
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 5

--@ 5 값에 위 쿼리 집어넣음!
SELECT TO_CHAR(HIREDATE,'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM TBL_EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>> 2021-09	5


--------------------------------------------------------------------------------

--■■■ ROW_NUMBER() ■■■--
--@ 스크립트 출력시 가장 왼쪽에 있는 숫자열을 뜻함

SELECT ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC)"테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;


--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는 보안 측면에서나... 미관적인 측면에서나... 바람직하지 않은 상황일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE나 IDENTITY 를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 좋다.


--※ 관찰
CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(30)
, GRADE     CHAR(10)
);
--==>> Table TBL_AAA이(가) 생성되었습니다.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '손범석', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '송해덕', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '김진령', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '최수지', 'D');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '서승균', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '정미화', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '손범석', 'A');
--==>> 1 행 이(가) 삽입되었습니다. * 7


SELECT *
FROM TBL_AAA;
--==>>
/*
1	손범석	A         
2	송해덕	B         
3	김진령	A         
4	최수지	D         
5	서승균	A         
6	정미화	A         
7	손범석	A         
*/


COMMIT;
--==>> 커밋 완료.


UPDATE TBL_AAA
SET GRADE='A'
WHERE NAME='최수지';
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_AAA;


UPDATE TBL_AAA
SET NAME = '송해덕'
WHERE GRADE = 'A';

UPDATE TBL NAME = '손범석'
SET GRADE = B
WHERE NAME = '손범석';


--○ SEQUENCE (시퀀스 : 주문번호) 생성
--   → 사전적인 의미 : 1.(일련의) 연속적인 사건들  2.(사건, 행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD   -- 시퀀스 생성 기본 구문(MSSQL 의 IDENTITY 와 동일한 개념)
START WITH 1                -- 시작값
INCREMENT BY 1              -- 증가값
NOMAXVALUE                  -- 최대값 제한 없음
NOCACHE;                    -- 캐시 사용 안함(없음) 
--@ NOCACHE 캐시 : 은행에 고객들이 몰림.. 번호표 뽑으러감. 번호표 앞에 줄 생김... 청원경찰이 먼저 번호표 막 뽑아놓음
--@ 시간 단축 가능, BUT 버려지는 시퀀스들이 많음. 이용되지 않았는데 번호가 많이 뛰어버리는 현상이 생길수 있음....
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 테이블 생성(TBL_BOARD)
CREATE TABLE TBL_BOARD              -- TBL_BOARD 이름의 테이블 생성 → 게시판           
( NO        NUMBER                  -- 게시물 번호       -- Ⅹ --@ 사용자가 작성 Ⅹ
, TITLE     VARCHAR2(50)            -- 게시물 제목       -- ○ --@ 사용자가 작성 ○
, CONTENTS  VARCHAR2(2000)          -- 게시물 내용       -- ○
, NAME      VARCHAR2(20)            -- 게시물 작성자     -- △ --@ 게시판 설정에 따라 사용자가 적을수도/아닐수도..
, PW        VARCHAR2(20)            -- 게시물 패스워드   -- △
, CREATED   DATE DEFAULT SYSDATE    -- 게시물 작성일     -- Ⅹ
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 데이터 입력 → 게시판에 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '앗싸~1등', '내가 1등이지롱', '이찬호', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '건강관리', '다들 건강 챙깁시당', '이윤서', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '저녁 뭘 먹지', '손다정', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '갑자기 비가오네', '윤유동', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '공부하고싶은데', '자꾸 졸려요', '정효진', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문', '배고프면 어떻게 하나요', '박혜진', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문', '어려우면 어떡하죠', '박효빈', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	    내가 1등이지롱	        이찬호	JAVA006$	21/09/06
2	건강관리	    다들 건강 챙깁시당	    이윤서	JAVA006$	21/09/06
3	오늘은	        저녁 뭘 먹지	        손다정	JAVA006$	21/09/06
4	오늘은	        갑자기 비가오네	        윤유동	JAVA006$	21/09/06
5	공부하고싶은데	자꾸 졸려요	            정효진	JAVA006$	21/09/06
6	질문	        배고프면 어떻게 하나요	박혜진	JAVA006$	21/09/06
7	질문	        어려우면 어떡하죠	    박효빈	JAVA006$	21/09/06
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=5;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '졸려요', '전 그냥 잘래요', '김진희', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	내가 1등이지롱	        이찬호	JAVA006$	21/09/06
3	오늘은	    저녁 뭘 먹지	        손다정	JAVA006$	21/09/06
4	오늘은	    갑자기 비가오네	        윤유동	JAVA006$	21/09/06
6	질문	    배고프면 어떻게 하나요	박혜진	JAVA006$	21/09/06
7	질문	    어려우면 어떡하죠	    박효빈	JAVA006$	21/09/06
8	졸려요	    전 그냥 잘래요	        김진희	JAVA006$	21/09/06
*/

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=7;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	내가 1등이지롱	        이찬호	JAVA006$	21/09/06
3	오늘은	    저녁 뭘 먹지	        손다정	JAVA006$	21/09/06
4	오늘은	    갑자기 비가오네	        윤유동	JAVA006$	21/09/06
6	질문	    배고프면 어떻게 하나요	박혜진	JAVA006$	21/09/06
*/

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저는요', '잘 지내고 있어요', '정가연', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 확인
SELECT *
FROM TBL_BOARD;
--==>
/*
1	앗싸~1등	내가 1등이지롱	        이찬호	JAVA006$	21/09/06
3	오늘은	    저녁 뭘 먹지	        손다정	JAVA006$	21/09/06
4	오늘은	    갑자기 비가오네	        윤유동	JAVA006$	21/09/06
6	질문	    배고프면 어떻게 하나요	박혜진	JAVA006$	21/09/06
9	저는요	    잘 지내고 있어요	    정가연	JAVA006$	21/09/06
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	저는요	    정가연	21/09/06
4	질문	    박혜진	21/09/06
3	오늘은	    윤유동	21/09/06
2	오늘은	    손다정	21/09/06
1	앗싸~1등	이찬호	21/09/06
*/


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '멋지죠', '멋져 멋져', '이중호', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

COMMIT;
--==>> 커밋 완료.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*  
6	멋지죠	    이중호	21/09/06
5	저는요     	정가연	21/09/06
4	질문	    박혜진	21/09/06
3	오늘은	    윤유동	21/09/06
2	오늘은	    손다정	21/09/06
1	앗싸~1등	이찬호	21/09/06
*/

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 행 이(가) 삭제되었습니다.

COMMIT;
--==>> 커밋 완료.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	멋지죠	    이중호	21/09/06
4	저는요	    정가연	21/09/06
3	질문	    박혜진	21/09/06
2	오늘은	    윤유동	21/09/06
1	앗싸~1등   	이찬호	21/09/06
*/


