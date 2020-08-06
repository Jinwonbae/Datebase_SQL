-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오

-- ORACLE
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명,
       E.SALARY 급여

FROM EMPLOYEE E,
     JOB J,
     DEPARTMENT D,
     LOCATION L
     
WHERE   E.JOB_CODE = J.JOB_CODE
    AND J.JOB_NAME = '대리'
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.LOCAL_NAME LIKE 'ASIA%';

-- ANSI

SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명,
       E.SALARY 급여
       
FROM EMPLOYEE E

JOIN JOB J USING(JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)

WHERE J.JOB_NAME = '대리' 
    AND L.LOCAL_NAME LIKE 'ASIA_';


-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오

-- ORACLE

SELECT E.EMP_NAME 사원명,
       E.EMP_NO 주민번호,
       D.DEPT_TITLE 부서명,
       J.JOB_NAME 직급명
       
 FROM EMPLOYEE E, DEPARTMENT D, JOB J
 
 WHERE E.JOB_CODE = J.JOB_CODE
    AND E.DEPT_CODE = D.DEPT_ID
    AND SUBSTR(E.EMP_NO,1,1) = '7'
    AND SUBSTR(E.EMP_NAME,1,1) = '전'
    AND SUBSTR(E.EMP_NO,8,1) = '2';


-- ANSI

SELECT E.EMP_NAME 사원명,
       E.EMP_NO 주민번호,
       D.DEPT_TITLE 부서명,
       J.JOB_NAME 직급명
 
 FROM EMPLOYEE E
 
 JOIN JOB J USING(JOB_CODE)
 JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)

 WHERE SUBSTR(E.EMP_NO,1,1) = '7' 
    AND SUBSTR(E.EMP_NAME,1,1) = '전'
    AND SUBSTR(E.EMP_NO,8,1) = '2';



-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오

-- ORACLE
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_NAME 직급명
       
   FROM EMPLOYEE E,
        JOB J
   
   WHERE E.JOB_CODE = J.JOB_CODE
    AND E.EMP_NAME LIKE '%형%';

-- ANSI
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_NAME 직급명
   
   FROM EMPLOYEE E
   
   JOIN JOB J USING(JOB_CODE)
   
   WHERE E.EMP_NAME LIKE '%형%';

-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오

-- ORACEL
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       D.DEPT_ID 부서코드,
       D.DEPT_TITLE 부서명

 FROM EMPLOYEE E, 
      JOB J,
      DEPARTMENT D
 
 WHERE E.JOB_CODE = J.JOB_CODE 
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.DEPT_TITLE LIKE '해외영업%'
 
 ORDER BY 부서명;
    
--ANSI
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       D.DEPT_ID 부서코드,
       D.DEPT_TITLE 부서명

 FROM EMPLOYEE E
 
 JOIN JOB J USING(JOB_CODE)
 JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
 
 WHERE D.DEPT_TITLE LIKE '해외영업%'
 
 ORDER BY 부서명;


-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오

-- ORACLE
SELECT E.EMP_NAME 사원명,
       E.BONUS 보너스,
       E.SALARY*12 연봉,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명
       
  FROM EMPLOYEE E,
       DEPARTMENT D,
       LOCATION L
  
  WHERE E.BONUS IS NOT NULL
    AND E.DEPT_CODE = D.DEPT_ID(+) 
    AND D.LOCATION_ID = L.LOCAL_CODE(+);
    
 

-- ANSI
SELECT E.EMP_NAME 사원명,
       E.BONUS 보너스,
       E.SALARY*12 연봉,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명
       
  FROM EMPLOYEE E
  
  LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  
  WHERE E.BONUS IS NOT NULL;


-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
-- ORACLE
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명
       
   FROM EMPLOYEE E,
        JOB J,
        DEPARTMENT D,
        LOCATION L
        
   WHERE    E.JOB_CODE = J.JOB_CODE 
        AND E.DEPT_CODE = D.DEPT_ID  
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND E.DEPT_CODE IS NOT NULL;

-- ANSI

SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명
       
   FROM EMPLOYEE E
   
   JOIN JOB J USING(JOB_CODE)
   JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
   
   WHERE E.DEPT_CODE IS NOT NULL;


-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오

-- ORACLE
SELECT E.EMP_NAME 사원명,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명,
       N.NATIONAL_NAME 근무국가명
       
  FROM EMPLOYEE E,
       DEPARTMENT D,
       LOCATION L,
       NATIONAL N
       
  WHERE E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND (N.NATIONAL_NAME = '일본' OR N.NATIONAL_NAME = '한국');

-- ANSI       
SELECT E.EMP_NAME 사원명,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명,
       N.NATIONAL_NAME 근무국가명
       
  FROM EMPLOYEE E

  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
  
  WHERE N.NATIONAL_NAME = '일본' 
        OR N.NATIONAL_NAME = '한국';


-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오

-- ORACLE
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       E.SALARY 급여
       --J.JOB_CODE 직급코드
       
   FROM EMPLOYEE E,
        JOB J
        
   WHERE E.JOB_CODE = J.JOB_CODE
     AND E.BONUS IS NULL
     AND (J.JOB_CODE = 'J4' 
            OR J.JOB_CODE = 'J7');
        
-- ANSI       
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       E.SALARY 급여

    FROM EMPLOYEE E
    JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
    
    WHERE E.BONUS IS NULL
        AND (J.JOB_CODE = 'J4' 
            OR J.JOB_CODE = 'J7');

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.

-- ORACLE
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       DECODE((S.SAL_LEVEL), 'S1', '고급',
                             'S2', '고급',
                             'S3', '중급',
                             'S4', '중급',
                             'S5', '초급',
                             'S6', '초급') 급여등급
       
   FROM EMPLOYEE E,
        JOB J,
        SAL_GRADE S
        
   WHERE E.JOB_CODE = J.JOB_CODE
     AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL

   ORDER BY 급여등급;

-- ANSI
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       DECODE((S.SAL_LEVEL), 'S1', '고급',
                             'S2', '고급',
                             'S3', '중급',
                             'S4', '중급',
                             'S5', '초급',
                             'S6', '초급') 급여등급
       
   FROM EMPLOYEE E
   
   JOIN JOB J USING(JOB_CODE)
   JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
   

-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오

-- ORACLE 
SELECT D.DEPT_TITLE 부서명,
       SUM(SALARY) 급여합

    FROM EMPLOYEE E,
         DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
        
    GROUP BY D.DEPT_TITLE
    
    HAVING SUM(SALARY) >= 10000000;
    
         
-- ANSI
SELECT D.DEPT_TITLE 부서명,
       SUM(SALARY) 급여합

    FROM EMPLOYEE E
    
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    
    GROUP BY D.DEPT_TITLE
    
    HAVING SUM(SALARY) >= 10000000;



-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.

-- ANSI
SELECT D.DEPT_TITLE 부서명,
       TRUNC(AVG(SALARY)) 평균급여
       
    FROM EMPLOYEE E
    
    FULL JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         
    GROUP BY D.DEPT_TITLE
    ORDER BY 1;      












