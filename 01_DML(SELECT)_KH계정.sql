
-- 한줄 주석


/*
    < SELECT >
    데이터를 조회할 때 사용되는 명령어 (DML, DQL)
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물
    
    [표현법]
    SELECT 조회하고자하는 컬럼, 컬럼, 컬럼.... 
    FROM 테이블명;
    
    
*/


-- EMPLOYEE 테이블로부터 전체 사원 모든 컬럼 정보 조회
SELECT *
FROM EMPLOYEE;

-- JOB 테이블로부터 전체 직급의 전체 컬럼 조회
SELECT *
FROM JOB;

-- DEPARTMENT 테이블로부터 전체 부서의 전체 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- EMPLOYMEE 테이블로부터 전체 사원들의 사번, 이름, 급여만을 조회
-- SELECT 절에 조회하고자 하는 컬럼명을 나열

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DEPARTMENT 테이블로부터 부서아이디, 부서명만을 조회

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- EMPLOYEE 테이블로부터, 사원명, 이메일, 전화번호, 입사일 정보만 조회

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 키워드, 테이블명, 컬럼명 등등 대소문자를 가리지 않는다.( 단, 실제 담겨있는 데이터값은 대소문자를 가린다.)

----------------------------------------------------------------------------------------------


/*
    < 컬럼값을 통한 산술연산>
    
    SELECT 절에 산술연산자(+-/*)를 기입해서 산술연산된 결과 조회 가능!
*/

-- EMPLOYEE 테이블로부터 직원명, 급여, 직원의 연봉 조회
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여, 보너스, 직원의 연봉, 보너스 포함된 연봉
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;
--> 산술연산 중에 NULL값이 존재할 경우 산술연산 결과마저도 무조건 NULL값으로 조회됨!!

-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식도 연산 가능
-- 오늘 날짜 : SYSDATE(DATE 형식 == 년원일 시분초)

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------

/*

    <컬럼명에 별칭 지정하기>
    
    [표현명]
    컬럼명 AS 별칭  | 컬럼명 AS "별칭" | 컬럼명 별칭  | 컬럼명 "별칭"
    
    AS를 붙이든 안붙이든 부여하는 별칭에 특수문자, 띄어쓰기가 있을 경우 반드시 "" 붙여야한다.
*/

SELECT EMP_NAME AS 이름 , SALARY AS "급여" , BONUS 보너스,
       SALARY*12 "연봉(원)",  (SALARY + (SALARY*BONUS))*12 "총 소득(원)"
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------

/*
    <리터럴>
    임의로 지정한 문자열 (**)을 SELECT절에 기술하면
    실제 그 테이블에 존재하든 데이터처럼 조회가능

*/

-- EMPLOYEE 테이블에서 사번, 사원명, 급여, 단위('원') 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' 단위
FROM EMPLOYEE;
--> SELECT 절에 제시한 리터럴 값은 조회결과의 모든 행에 반복적으로 출력됨


/*
    <DISTINCT>
    컬럼에 포함된 중복값을 단 한번씩만 표시하고자 할 때 사용
    (단, SELECT절에 단 한개만 기입 가능)
    
*/

-- EMPLOYEE테이블에서 부서코드 조회 (현재 사원들이 어떤 부서에 속해있는지)
SELECT DEPT_CODE
FROM EMPLOYEE;


-- EMPLOYEE테이블로부터 중복제거한 부서코드 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;


-- EMPLOYEE테이블로부터 중복제거한 직급코드 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
--> DEPT_CODE값이랑 JOB_CODE값이랑 세트로 묶어서 중복판별!


/*

    <WHERE 절>
    
    조회하고자 하는 테이블에서 특정 조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문

    [표현법]
    SELECT 조회하고자하는 컬럼, 컬럼, 컬럼, ...
    FROM 테이블명
    WHERE 조건식;
    
    -> 조건식에 다양한 연산자 사용 가능
    
    <비교 연산자>

    >, <, >=, <=    -> 대소비교
         =          -> 동등비교
     !=, ^=,<>      -> 같지 않다. 

*/

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 사원들만 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- EMPLOYEE 테이블에서 부서코드가 D9인 사원들 조회

SELECT EMP_NAME, DEPT_CODE, SALARY      -- 3
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE = 'D9';                 -- 2

-- EMPLOYEE 테이블에서 부서코드가 D9가 아닌 사원들 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D9';

------------------------------------실습문제----------------------------------


-- 1. EMPLOYEE 테이블에서 급여가 300만원 이상 직원들의 직원명, 급여, 입사일 조회
SELECT EMP_NAME,SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE 3000000 <= SALARY; 

-- 2. EMPLOYEE테이블에서 재직중인 직원들의 사번, 이름, 입사일 조회
SELECT EMP_NO, EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 3. EMPLOYEE테이블에서 직급코드가 J2인 직원들의 직원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 4. EMPLOYEE테이블에서 연봉이 5000만원 이상인 직원들이 직원명, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, SALARY*12 연봉, HIRE_DATE
FROM EMPLOYEE               
WHERE SALARY*12 >= 50000000;


/*
    <논리연산자>
    여러개의 조건을 엮을 때 사용
    AND(~이면서, 그리고), OR(~이거나, 또는)
*/

-- 부서코드가 'D9'이면서 급여가 500만원 이상인 직원들의 직원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;


-- 부서코드가 'D6'이거나 급여가 300만원 이상인 직원 직원명, 부서코드 급여 조회

SELECT EMP_NAME, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;


-- 급여가 350만원 이상이고 600만원 이하인 직원들의 직원명, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;





