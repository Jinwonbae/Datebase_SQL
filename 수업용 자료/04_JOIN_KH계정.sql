/*

        <  JOIN   >


        두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
        조회 결과는 하나의 결과물(RESULT SET)로 나옴
        
        관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음(중복을 최소화하기 위해서)
        => 즉, JOIN 구문은 관계형 데이터베이스에서 여러개의 테이블간 "관계"를 맺는 방법
        
        무작정 JOIN을 해서 같이 조회를 하는게 아니라
        테이블 간 "연결고리"의 컬럼 데이터를 "매칭"시켜서 조회해야함!
        
                                                [JOIN 용어 정리]
                             JOIN은 크게 "오라클 전용 구문"과 "ANSI(미국국립표준협회) 구문"        
                         
                      오라클 DBMS에서만                             오라클 + 다른 DBMS 에서도 사용   
                         오라클 구문                     |               ANSI 구문
  ------------------------------------------------------------------------------------------------------------------------
                          등가 조인                     |       내부 조인 (INNER JOIN)  --> JOIN USING / ON   
                        (EQUAL JOIN)                  |       자연 조인 (NATURAL JOIN) --> JOIN USING
  ------------------------------------------------------------------------------------------------------------------------
                        포괄 조인                       |       왼쪽 외부 조인 ( LEFT OUTER JOIN),
                     (LEFT OUTER)                     |       오른쪽 외부 조인 (RIGHT OUTER JOIN),
                     (RIGHT OUTER)                    |       전체 외부 조인 (FULL OUTER JOIN, 오라클구문 사용 불가)
 ------------------------------------------------------------------------------------------------------------------------
                    카테시안 곱 (CARTESIAN PROUDCT)     |            교차 조인 (CROSS JOIN) 
 ------------------------------------------------------------------------------------------------------------------------
        자체 조인 (SELF JOIN), 비등가 조인(NON EQUAL JOIN) |                 JOIN ON     
  ------------------------------------------------------------------------------------------------------------------------
  
  
  
*/

-- 각 사원들의 사번, 사원명, 부서코드, 부서명까지 같이 조회 하고 싶을 때?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 각 사원들의 사번, 사원명, 직급 코드, 직급 명도 같이 조회 하고 싶다!
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

-- 조인을 통해서 연결고리에 해당하는 컬럼값만 제대로 매칭만 해주면 같이 하나의 결과물로 조회 가능 !!


/*

    1. 등가조인 (EQUAL JOIN)    /   내부조인 (INNER JOIN)
        연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회(== 일치하는 값이 없는 행은 조회 X)

*/

-->> 오라클 전용 구문 
--   FROM 절에 조회하고자 하는 테이블을 나열 (, 구분자로)
--   WHERE 절에 매칭시킬 컬럼명(연결고리)에 대한 조건을 제시함


-- 사번, 사원명, 부서코드, 부서명을 조회
-- 1) 연결할 두 컬럼명이 다른 경우(EMPLOYEE : DEPT_CODE /  DEPARTMENT:DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCATION_ID
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하지 않는 값은 조회에서 제외 되어서 23명중 21명이 인출됨
--> (DEPT_CODE가 NULL 이었던 2명의 사원데이터 조회 안됨, DEPT_ID가 D3, D4, D7 부서 데이터 조회 안됨)


-- 사번, 사원명, 직급 코드, 직급 명을 조회
-- 1) 연결할 두 컬럼명이 같은 경우 (EMPLOYEE : JOB_CODE / JOB : JOB_CODE)

-- 방법1) 테이블명을 이용하는 방법
SELECT EMP_NO, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME --3
FROM EMPLOYEE, JOB  --1
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;     --2
--> ambiguouly : 애매하다. 모호하다.


-- 방법2) 별칭 사용!  (각 테이블 마다 별칭 부여가능)
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;



-->     ANSI 구문
--      FROM절에 기준 테이블 하나 기술 한 뒤
--      그 뒤에 JOIN절에서 같이 조회하고자하는 테이블 기술 (또한, 매칭 시킬 컬럼에 대한 조건) => USING 구문, ON 구문

-- 사번, 사원명, 부서코드, 부서명 
-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
--      => JOIN     ON 구문만 사용가능!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
-- INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 사번, 사원명, 부서코드, 부서명
-- 2) 연결할 두 컬럼명이 일치하는 경우 (EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
--     => JOIN USING 구문, JOIN ON 구문
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE); -- ON 구문 : ambiguously 발생


SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE); -- USING 구문 : ambiguously 발생 x

-- [참고] 위의 구문을 NATURAL JOIN(자연 조인)으로도 가능 --
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;



-- 추가적인 조건도 제시 가능!!


-- 직급이 대리인 사원의 사번, 사원명, 급여 조회 
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME = '대리';  --> 'J6'

SELECT EMP_ID,EMP_NAME, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'


-- JOIN을 통해서
-->> 오라클 구문 (FROM절에 조회할 테이블 모두 기술, WHERE절에 매칭 시키는 조건 기술)
SELECT EMP_ID, EMP_NAME, SALARY, E.JOB_CODE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND JOB_NAME  = '대리';

-->> ANSI 구문 ( FROM절에 테이블 하나 기술, JOIN절에 추가로 조히하고자 하는 테이블 및 조건 (ON/USING)
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-------------------------------------------------<실습 문제>---------------------------

-- 1. 부서가 인사관리부인 사원들의 사번, 사원명 보너스를 조회
-->> 오라클 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '인사관리부';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
WHERE D.DEPT_TITLE = '인사관리부'; -- AND BONUS IS NULL;



-- 2. 부서가 총무부가 아닌 사원들의 사원명, 급여, 입사일 조회

-->> 오라클 구문

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.DEPT_CODE != 'D9'


-->> ANSI 구문

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE != '총무부';





-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-->> 오라클 구문

SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.BONUS IS NOT NULL
    AND E.DEPT_CODE = D.DEPT_ID;


-->> ANSI 구문

SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;


-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME)을 조회
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

-->> 오라클 구문

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;


-->> ANSI 구문

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE);


-- 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE;     --DEPT_CODE   JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID    
SELCCT * FROM JOB;          --           JOB_CODE

-->> 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN JOB J USING (JOB_CODE);


----------------------------------------------------------------------------------------------------

/*

    2. 포괄조인 / 외부조인 (OUTER JOIN)
    
    테이블간에 JOIN시 일치하지 않는 행도 포함시켜서 조회 가능
    단, 반드시 LEFT/RIGHT를 지정해야함! (기준 테이블 지정!)

*/


-- 사원명, 부서명, 급여

SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 부서가 배치 되지 않은(DEPT가 NULL) 직원 2명이 조회 되지 않음!
-- 부서에 배정된 사원이 없는 경우에는 부서 역시 조회 되지 않고 있음!


-- 1) LEFT OUTER JOIN : 두 테이블 중 왼편에 기술된 테이블 기준으로 JOIN
-- >> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> 부서코드가 없던 사원(하동운, 이오리)의 데이터도 조회됨!!


-->> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 오른쪽 테이블 컬럼에 + 표시




-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
--> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-->> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있음 (단, 오라클 구문은 안됨)
-- >> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-->> 오라클 구문(에러남)
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

-----------------------------------------------------------------------------------

/*

    3. 카테시안 곱(CATESIAN PRODUCT) / 교차조인 (CROSS JOIN)
    모든 테이블의 각 행들이 서로서로 매핑된 데이터가 조회됨 (곱집합)
    
    
    두 테이블의 행들이 모든 곱해진 행들의 조합 출력 --> 과부화 위험
    

*/

-- 사원명, 부서명

-->> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;  ---> 23 * 9 => 207행 


-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;


------------------------------------------------------------------------------------------------

/*

    4. 자체 조인 (SELF JOIN)

    같은 테이블을 다시 한번 조인하는 경우
    자기 자신과 조인을 맺는 것

*/


SELECT EMP_ID, EMP_NAME, SALARY, MANAGER_ID 
FROM EMPLOYEE;


-- 각각의 사원의 사원사번, 사원명, 사원부서 코드, 사수사번, 사수명
SELECT * FROM EMPLOYEE; -- 사원에 대한 테이블   MANAGER_ID
SELECT * FROM EMPLOYEE; -- 사수에 대한 테이블   EMP_ID

-->> 오라클 구문
SELECT  E1.EMP_ID "사원번호", E1.EMP_NAME "사원명", E1.DEPT_CODE "사원 부서 코드",
        E1.MANAGER_ID "사수 사번", M.EMP_NAME "사수명", M.DEPT_CODE
FROM EMPLOYEE E1, EMPLOYEE M
WHERE E1.MANAGER_ID = M.EMP_ID;


-->> ANSI 구문
SELECT  E.EMP_ID 사원사번, E.EMP_NAME 사원명, E.DEPT_CODE 사원부서코드, 
        E.MANAGER_ID 사수사번, M.EMP_NAME 사수명 , M.DEPT_CODE 사수부서코드
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-----------------------------------------------------------------------------------------------

/*

    5. 비 등가조인 (NON EQUAL JOIN)
    '=' (등호)를 사용하지 않는 조인문
    
    지정한 컬럼값이 일치하는 경우가 아닌, 값의 "범위"에 포함되는 경우 매치


*/

-- 사원명, 급여, 급여 등급(SAL_GRADE)
-->> 오라클 구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI 구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);


---------------------------------------------------------------------------------------


/*
    <다중 JOIN>

    N개의 테이블을 JOIN

*/
SELECT * FROM EMPLOYEE;   -- DEPT_CODE             JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID , LOCATION_ID
SELECT * FROM LOCATION;   --           LOCAL_CODE 
SELECT * FROM JOB;                                 JOB_CODE --              
-- 사번, 사원명, 부서명, 근무지역명(LOCAL_NAME)
-->> 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID 
    AND LOCATION_ID = LOCAL_CODE;

-->> ANSI 구문

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN JOB USING(JOB_CODE)
-- 다중 조인은 순서가 중요하다!

SELECT * FROM EMPLOYEE;   -- DEPT_CODE             JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID , LOCATION_ID
SELECT * FROM LOCATION;   --           LOCAL_CODE 
SELECT * FROM JOB;                                 JOB_CODE --              
SELECT * FROM NATIONAL;
SELECT * FROM SAL GRADE;



-- 사번, 사원명, 부서명, 직급명, 근무지역명, 근무국가 명, 급여등급
-->> 오라클 구문
SELECT E.EMP_NO 사번, 
       E.EMP_NAME 사원명,
       L.LOCAL_NAME 근무지역명,
       N.NATIONAL_NAME 근무국가명,
       S.SAL_LEVEL 급여등급
       
FROM EMPLOYEE E,
     DEPARTMENT D,
     JOB J
     LOCATION L,
     NATIONAL N,
     SAL_GRADE S
     
WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;

-->> ANSI 구문
SELECT E.EMP_NO 사번, 
       E.EMP_NAME 사원명,
       L.LOCAL_NAME 근무지역명,
       N.NATIONAL_NAME 근무국가명,
       S.SAL_LEVEL 급여등급

FROM EMPLOYEE E

JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J USING(JOB_CODE)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING(NATIONAL_CODE)
JOIN SAL_GRADE S ON(SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

