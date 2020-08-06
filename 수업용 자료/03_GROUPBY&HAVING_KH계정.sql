/*

    <   GROUP BY 절>
    그룹기준을 제시할 수 있는 구문( 해당 그룹기준별로 그룹을 묶을 수 있다.)
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용

*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --> 전체 사원들의 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

SELECT COUNT(*)
FROM EMPLOYEE;  --> 전체 사원 수

-- 각 부서별 사원 수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별 오름차순 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY) -- 3.
FROM EMPLOYEE       -- 1.
GROUP BY DEPT_CODE      -- 2.
ORDER BY DEPT_CODE;     -- 4.

-- 각 직급별 총 급여 합
SELECT JOB_CODE 직급, SUM(SALARY) 급여합, COUNT(*) 사원수, COUNT(BONUS) 보너스받는사원수,
        FLOOR(AVG(SALARY)) 평균급여, MAX(SALARY) 직급최고급여,MIN(SALARY) 직급최저급여
        
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;


-- 각 부서별, 총사원수, 보너스 받는 사원수, 급여합, 평균 급여, 최고급여, 최저급여
SELECT DEPT_CODE 부서,
        COUNT(*) 총사원수,
        COUNT(BONUS) 보너스받는사원수,
        SUM(SALARY) 급여합,
        FLOOR(AVG(SALARY)) 평균급여,
        MAX(SALARY) 최고급여,
        MIN(SALARY) 최저급여
    FROM EMPLOYEE
 GROUP BY DEPT_CODE
 ORDER BY 1;
 
 
 -- 여러 컬럼을 그룹기준으로 제시 가능
 SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE, JOB_CODE -- 둘다 만족하는 그룹으로 묶어줌
 ORDER BY 1;

-------------------------------------------------------------------------


/*

        <HAVING 절>

        그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹함수한 결과를 가지고 비교 수행)
        

*/

-- 각 부서별 평균 급여 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE      
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>= 3000000;

-- 각 직급별 총급여합이 1000만원 이상인 직급, 급여합 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;


-- 각 부서별 보너스를 받는 사원이 없는 부서만 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;



------------------------------------------------------------------------------

/*
   5 SELECT *|조회하고싶은 컬럼명|산술연산식|함수식| [AS] "별칭"
   1 FROM    조회하고싶은 테이블명
   2 WHERE   조건식
   3 GROUP BY 그룹기준에 해당하는 컬럼명, 컬럼명,...
   4 HAVING 그룹함수식에 대한 조건식
   6 ORDER BY 컬럼명|별칭|컬럼순번 [ASC|DESC] [NULLS FIRST | NULLS LAST];
    
*/


------------------------------------------------------------------------------


/*

    < 집계 함수>

    그룹별 산출한 결과 값의 중간집계를 계산해주는 함수
    
    
    ROLLUP, CUBE    (GROUP BY절에 사용되는 함수)



*/

-- 각 직급별 급여합

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ROLLUP

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (JOB_CODE)
ORDER BY JOB_CODE;

-- CUBE

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (JOB_CODE)
ORDER BY JOB_CODE;

-- 그룹 기준으로 하나의 컬럼만 제시하게 되면 ROLLUP이든 CUBE든 별 차이 없음
-- 마지막 행에 전체 총 급여합까지 같이 나옴


------ ROLLUP과 CUBE의 차이점 (그룹기준이 적어도 두개이상 컬럼이여야함!)

-- 부서코드, 직급 코드 같은 사원 그룹 지어서
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;         --> 13개의 그룹

-- ROLLUP(컬럼1, 컬럼2) => 컬럼1을 가지고 다시 중간 집계를 내주는 함수
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;        



-- CUBE(컬럼1, 컬럼2) => 컬럼1을 가지고 중간집계, 컬럼2를 가지고 중간집계를 냄
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;    

-------------------------------------------------------------------------

/*

        <집합 연산자>
        SET OPERATION
        
        여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
        
        - UNION     : 합집합(두 쿼리문 수행한 결과값을 더한 후 중복 되는 부분을 한번 뺀 결과) OR
        - INTERSECT : 교집합(두 쿼리문 수행한 결과 값에 중복된 결과값) AND
        - UNION ALL : 합집합 결과값에 교집합이 더해진 경험(두 쿼리문 수행한 결과값을 무조건 더함) => 중복된 값이 두번 들어갈 수 있음
        - MINUS     : 차집합(선행 쿼리문 결과값 빼기 후행 쿼리문 결과값의 결과)
        
*/


-- 1. UNION
-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회(사번, 이름, 부서코드, 급여)

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- 위의 쿼리문 대신 아래처럼 WHERE 절을 통해서라도 해결 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


-- 각 부서별 급여합 (GROUP BY절 이용)
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--각 부서별 급여합 (UNION)
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D2'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';


-- 2. UNIONALL : 여러개의 쿼리 결과를 무조건 더하는 연산자(중복값 있음)
SELECT EMP_NO,EMP_NAME, DEPT_CODE, BONUS "보너스 또는 급여"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION ALL

SELECT EMP_NO,EMP_NAME, DEPT_CODE,  SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- 3. INTERSECT : (교집합)
-- 부서 코드가 D5이면서 그리고 급여까지도 300만원 초과인 사원

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

INTERSECT

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 동일
SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;


-- 4. MINUS
--  부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원을 제외한 결과값

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

MINUS

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 동일
SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;

