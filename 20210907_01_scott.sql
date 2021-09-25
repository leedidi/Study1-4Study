SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ JOIN(조인) ■■■--

-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(Catersian Product)
--  두 테이블을 합친(결합한) 모든 경우의 수
--@ 어지간해선 잘 안씀....

SELECT COUNT(*)
FROM EMP, DEPT;
--==>> 56

-- Equi Join : 서로 정확히 일치하는 데이터들끼리 연결시키는 결합
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
--==>>
/*
7782	CLARK	MANAGER	    7839	81/06/09	2450		10	    10	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		    81/11/17	5000		10	    10	ACCOUNTING	NEW YORK
7934	MILLER	CLERK	    7782	82/01/23	1300		10	    10	ACCOUNTING	NEW YORK
7566	JONES	MANAGER	    7839	81/04/02	2975		20	    20	RESEARCH	DALLAS
7902	FORD	ANALYST	    7566	81/12/03	3000		20	    20	RESEARCH	DALLAS
7876	ADAMS	CLERK	    7788	87/07/13	1100		20	    20	RESEARCH	DALLAS
7369	SMITH	CLERK	    7902	80/12/17	800		    20	    20	RESEARCH	DALLAS
7788	SCOTT	ANALYST	    7566	87/07/13	3000		20	    20	RESEARCH	DALLAS
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30	    30	SALES	    CHICAGO
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30	    30	SALES	    CHICAGO
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30	    30	SALES	    CHICAGO
7900	JAMES	CLERK	    7698	81/12/03	950		30	30	    S   ALES	    CHICAGO
7698	BLAKE	MANAGER	    7839	81/05/01	2850		30	    30	SALES	    CHICAGO
7654	MARTIN	SALESMAN	7698	81/09/28	1250   1400 30	    30	SALES	    CHICAGO
*/

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>
/*
7782	CLARK	MANAGER	    7839	81/06/09	2450		10	10	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		    81/11/17	5000		10	10	ACCOUNTING	NEW YORK
7934	MILLER	CLERK	    7782	82/01/23	1300		10	10	ACCOUNTING	NEW YORK
7566	JONES	MANAGER	    7839	81/04/02	2975		20	20	RESEARCH	DALLAS
7902	FORD	ANALYST	    7566	81/12/03	3000		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	    7788	87/07/13	1100		20	20	RESEARCH	DALLAS
7369	SMITH	CLERK	    7902	80/12/17	800		    20	20	RESEARCH	DALLAS
7788	SCOTT	ANALYST	    7566	87/07/13	3000		20	20	RESEARCH	DALLAS
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30	30	SALES	CHICAGO
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30	30	SALES	CHICAGO
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30	30	SALES	CHICAGO
7900	JAMES	CLERK	    7698	81/12/03	950		    30	30	SALES	CHICAGO
7698	BLAKE	MANAGER	    7839	81/05/01	2850		30	30	SALES	CHICAGO
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30	30	SALES	CHICAGO
*/

-- Non Equi Join : 범위 안에 적합한 데이터들끼리 연결시키는 결합
SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- Equi Join 시 『(+)』 를 활용한 결합 방법
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5)은 모두 누락~!!!

SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> 총 19건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들도 모두 조회된 상황
--@ (+) : 추가 옵션 개념. 오른쪽에 (+) 붙이면, 왼편이 다 나오고 오른편은 거드는 것
--@ (+) 있는쪽에 시선이 가지만... (+)가 없는 쪽이 주인공! 오른쪽을 다 보여준다음 (+) 붙은 쪽은 양념으로 첨가해줘!
--@ (+) 없는 쪽을 메모리에 다 올려주고, 그다음 (+) 붙은 쪽을 추가해줘!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 16건의 데이터가 결합되어 조회된 상황
--  즉, 부서에 소속된 사원이 아무도 없는 부서도 모두 조회된 상황


-- ※ (+)가 없는 쪽 테이블의 데이터를 모두 메모리에 적재한 후 
--    (+)가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--    JOIN 이 이루어진다.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> 위와 같은 이유로... 이러한 형식의 JOIN 구문은 존재하지 않는다.



-- 2. SQL 1999 CODE → 『JOIN』 키워드 등장 → JOIN 유형 명시
--                      결합 조건은 『WHERE』 대신 『ON』 사용


-- CROSS JOIN
--@ ㅇ X ㅇ 이렇게 조인되기 때문에.... 크로스 조인
--  ㅇ   ㅇ
--@ , 가 크로스로 바뀐 것
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN 
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--※ INNSER JOIN 시 INNER 는 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--ON E.DETPNO = D.DEPTNO;- 얜왜오류였을까...?

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- OUTER JOIN 
--@ (+) 헷깔리니까 바꿔보자! 해서 나옴
--@ (+) 를 이걸로 해결.... 방향성을 LEFT/OUTER로 바꿈. LEFT : 왼쪽이 주인공/ RIGHT : 오른쪽이 주인공
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--@ 왼쪽이 주인공

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--@ 오른쪽이 주인공

--※ 방향이 지정된 쪽 테이블(→ LEFT/ RIGHT) 의 데이터를 모두 메모리에 적재하 후
--   방향이 지정되지 않은 쪽 테이블들의 데이터를 각각 확인하여 결합시키는 형태로
--   JOIN 이 이루어진다.
/*
SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
*/ -- @ 얜 왜 오류나지.....?????

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--@ 양쪽 다!


--※ OUTER JOIN 에서 OUTER 는 생략 가능
SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D    -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D          -- INNER JOIN
ON E.DEPTNO = D.DEPTNO;


--------------------------------------------------------------------------------
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- 이 결과에서... 직종이 CLERK 인 사원들만 조회...

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- 이렇게 쿼리문을 구성해도 조회하는 데는 문제가 없다.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--@ 하지만 별도의 조건이기 때문에.. ON 원래 취지는 이게 아니니까!
-- 하지만, 이와 같이 구성하여 조회할 수 있도록 권장한다.

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND JOB = 'CLERK';

--------------------------------------------------------------------------------

-- ○ EMP 테이블과 DEPT 테이블을 대상으로
--    직종이 MANAGER 와 CLERK 인 사원들만
--    부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.

--◈ 내가 작성한 코드
/*
SELECT DEPTNO "부서번호", DNAME "부서명", ENAME "사원명", JOB "직종명", SAL "급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
WHERE JOB IN ('MANAGER', 'CLERK')
*/

-- ○ EMP 테이블과 DEPT 테이블을 대상으로
--    직종이 MANAGER 와 CLERK 인 사원들만
--    부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
--    --------  ------  ------  ------  ----
--     DEPTNO    DNAME   ENAME   JOB    SAL
--    --------  ------  ------- ------- -----
--      E,D       D        E      E      E

--@ 먼저 구조 파악 필요! 어떤 칼럼이 있고... 연결고리가 뭔지////
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러 발생
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
241행, 8열에서 오류 발생
*/
--> 두 테이블 간 중복되는 컬럼에 대한 소속 테이블을
--  정해줘야(명시해 줘야) 한다.

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼이 존재하지 않는 조회 구문은
--  에러 발생하지 않는다.
--==>>
/*
ACCOUNTING	CLARK	MANAGER	    2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	    1300
RESEARCH	JONES	MANAGER	    2975
RESEARCH	FORD	ANALYST 	3000
RESEARCH	ADAMS	CLERK	    1100
RESEARCH	SMITH	CLERK	    800
RESEARCH	SCOTT	ANALYST	    3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	    950
SALES	    BLAKE	MANAGER	    2850
SALES	    MARTIN	SALESMAN	1250
*/

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--> 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--  부서(DEPT), 사원(EMP) 중 어떤 테이블을 지정해도
--  쿼리문 수행에 대한 결과 반환에 문제가 없다.

-- ※ 하지만...
--    두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--    부모 테이블의 컬럼을 참조할 수 있도록 해야 한다.

--@ 연결고리 컬럼부터 찾기...!! -> 'DEPTNO'
--@ 부모자식 기준? 연결고리 칼럼에서 하나/여러개 들어있는거 판단
--@ 10, 20, 30,,, 이게 딱 하나만 있는 테이블이 부모! 그래야 중복되지 않음
--@ 10, 10, 20, 20,,,, 일 대 다수 테이블은 자식 테이블!

SELECT *
FROM EMP;   -- 부모 테이블
SELECT *
FROM DEPT;  -- 자식 테이블

--※ 부모 자식 테이블 관계를 명확히 정리할 수 있도록 한다.

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--@ 연결고리 컬럼 아니어도 앞에 위치 명시해주는게 좋음.. 안 명시하면 양쪽 다 둘러보기 때문. 리소스 소모!
--@ 10번 가봄(리소스 소모 ↑)

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--@ 5번 가봄(리소스 소모 ↓)
--> 두 테이블 간 중복된 컬럼(공통 컬럼)이 아니더라도...
--  소속 테이블을 명시할 수 있도록 권장한다.
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E LEFT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E LEFT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;
--
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;
-- 수정 완료...
-- 위 둘/ 아래 둘 차이? 자식 테이블 참조시 마지막 줄 OPERATION(부서)이 추가!

--○ SELF JOIN (자기 조인)
-- EMP 테이블의 정보를 다음과 같이 조회할 수 있도록 한다. (~11:28)
/*
   E       E      E      E           E         E
 EMPNO   ENAME   JOB    MGR
                        EMPNO      ENAME      JOB
----------------------------------------------------------
사원번호 사원명 직종명 관리자번호 관리자명 관리자직종명
-----------------------------------------------------------
  7369   SMITH  CLERK    7902      FORD      ANALYST
  EMP     EMP    EMP     EMP
  --------------------------- ①
                         EMP        EMP        EMP
                        ---------------------------- ②
*/
-- 내가 작성한 코드
/*
SELECT *
FROM EMP;

SELECT *
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종명", MGR "관리자번호", 관리자명, 권리자직종명
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명"
     , E1.MGR "관리자번호", E2.ENAME "관리자명", E2.JOB"권리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
*/

 EMPNO   ENAME   JOB    MGR
                        EMPNO      ENAME      JOB

SELECT EMPNO, ENAME, JOB, MGR, ENAME, JOB
FROM EMP;

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB"관리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--@ 까지 하면 KING이 나오지 않음
--==>> KING 누락

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB"관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--@ 하면 매니저 없는 킹도 나옴!
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER 	7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT			
*/

