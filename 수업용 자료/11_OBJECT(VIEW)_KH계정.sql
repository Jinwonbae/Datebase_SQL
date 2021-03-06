/*
        <VIEW 뷰>
        
        SELECT문(쿼리문)을 저장 해 둘 수 있는 객체 (자주 쓰는 긴 SELECET문을 저장해두면 긴 SELECT문을 매번 다시 기술 할 필요 없음)
        
*/

-- '한국'에서 근무하는 사원 사번, 이름, 부서명, 급여, 근무 국가명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)

WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사번, 이름, 부서명, 급여, 근무 국가명

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)

WHERE NATIONAL_NAME = '러시아';

----------------------------------------------------------------
/*
    1. VIEW 생성 방법
    
    [표현법]
    CREATE [OR REPLACE] VIEW 뷰명 
    AS 서브쿼리;
    
    [OR REPLACE] : 뷰 생성시 기존에 중복된 뷰가 없다면, 새로이 뷰 생성, 
                            기존에 중복된 뷰가 있다면, 뷰를 변경(갱신)하는 키워드
                            
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)
    JOIN JOB USING(JOB_CODE);

--> 처음 생성시 CREATE VIEW 권한 없는 문제 발생 -> CREATE VIEW 권한 부여

SELECT *
FROM VW_EMPLOYEE;

-- 한국 근무
SELECT * 
FROM VW_EMPLOYEE 
WHERE NATIONAL_NAME = '한국';

-- 러시아 근무
SELECT EMP_NAME, SALARY 
FROM VW_EMPLOYEE 
WHERE NATIONAL_NAME = '러시아';

-- 중국 근무
SELECT EMP_NAME, SALARY 
FROM VW_EMPLOYEE 
WHERE NATIONAL_NAME = '중국';

-- 뷰는 논리적인 가상 테이블 --> 실질적으로 데이터 저장하고 있지 않음! (단순히 쿼리문 TEXT문구로 저장되어있을 뿐)

-- [참고] 해당 계정이 가지고 있는 VIEW들의 내용 조회 가능!
SELECT * FROM USER_VIEWS;

------------------------------------------------------------------------

-- * 뷰 컬럼에 별칭 부여
--   서브쿼리의 SELECT 절에 함수식이나, 산술연산식 기술되어있는 경우 반드시 별칭 지정!

-- 사원의 사번, 이름, 직급명, 성별, 근무년수 조회 할 수 있는 SELECT문을 뷰로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별,
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
   FROM EMPLOYEE
   JOIN JOB USING (JOB_CODE);

CREATE OR REPLACE VIEW VW_EMP_JOB(사원, 사원명, 직급명, 성별, 근무년수)   --> 모든 컬럼에 대한 별칭 부여해야함
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE
   JOIN JOB USING (JOB_CODE);


SELECT 사원명, 근무년수
FROM VW_EMP_JOB;

SELECT 사원명, 근무년수
FROM VW_EMP_JOB
WHERE 성별 = '남';

SELECT 사원명, 근무년수
FROM VW_EMP_JOB
WHERE 성별 = '여';

SELECT *
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

-- 뷰 삭제 하고자 한다면
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------------------

-- 생성된 뷰를 이용해 DML(INSERT, UPDATE, DELETE) 사용가능
-- 뷰를 통해서 변경하게 되면 실제 데이터가 남겨있는 베이스 테이블 적용됨

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB;

--뷰에  INSERT
INSERT INTO VW_JOB VALUES('J8', '인턴');  -->베이스 테이블에 값 INSERT

-- 뷰로 UPDATE (J8 직급명을 '알바'로 변경)
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE ='J8';    -->베이스 테이블에 값 UPDATE

-- 뷰에 DELETE
DELETE FROM VW_JOB
WHERE  JOB_CODE = 'J8';  -->베이스 테이블에 값 DELETE

------------------------------------------------------------------------------------

/*
    * 하지만 DML 명령어로 조작이 불가능한 경우가 더 많음!
    
    1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
    2) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL 제약조건 지정된 경우
    3) 산술연산식 또는 함수식으로 정의된 경우
    4) 그룹함수 또는 GROUP BY 절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러테이블이 연결시켜 놓은 경우
    
*/

-- 1) VIEW에 정의되어있지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW VW_JOB2
AS SELECT JOB_CODE
    FROM JOB;

SELECT * FROM VW_JOB2;

-- INSERT?
INSERT INTO VW_JOB2 VALUES('J8','인턴');

-- J7 직급명을 인턴으로 변경
-- UPDATE
UPDATE VW_JOB2
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';

-- DELETE
DELETE FROM VW_JOB2
WHERE JOB_NAME = '사원';

-- 2) 뷰에 정의되어있지 않는 컬럼중에서 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW VW_JOB3
AS SELECT JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB3;    
    

-- INSERT
INSERT INTO VW_JOB3 VALUES('인턴');
--> 베이스테이블인 JOB에 JOB_CODE에 기본적으로 NULL을 넣으려고 함 (단, JOB_ CODE PRIMARY KEY 제약조건 걸려있음!)

SELECT * FROM JOB;

-- UPDATE
-- 사원을 알바로 변경
UPDATE VW_JOB3
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원';

ROLLBACK;

INSERT INTO JOB VALUES('J8','인턴');


--DELETE
DELETE FROM VW_JOB3
WHERE JOB_NAME = '인턴';


-- 3) 함수식, 산술 연산식으로 정의된 경우 

-- 사원의 사번, 사원명 ,급여, 연봉에 대해서 조회하는 뷰

CREATE OR REPLACE VIEW VW_EMP_SAL(사번, 사원명, 급여, 연봉)
AS SELECT EMP_ID,EMP_NAME, SALARY, SALARY*12
   FROM EMPLOYEE;
   

SELECT * FROM VW_EMP_SAL;

-- INSERT
INSERT INTO VW_EMP_SAL(사번, 사원명, 급여) VALUES(400,'정진훈', 3000000);

-- UPDATE(200번 사원의 연봉을 8000만원으로 변경)
UPDATE VW_EMP_SAL
SET 연봉 = 80000000
WHERE 사번 = 200;

-- UPDATE(200번 사원의 급여를 700만원으로 변경)
UPDATE VW_EMP_SAL
SET 급여 = 7000000
WHERE 사번 = 200;

SELECT * FROM EMPLOYEE;
    
-- DELETE
-- 연봉이 72000000사원 지우기

DELETE FROM VW_EMP_SAL
WHERE 연봉 = 72000000;

ROLLBACK;

-- 4) 그룹함수 또는 GROUP BY절을 포함한 경우

-- 부서별 급여합, 급여 평균
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUPDEPT;

-- INSERT
INSERT INTO VIEW VW_GROPDEPT VALUES('D0',8000000,4000000);

-- UPDATE 부서코드가 D1을 D0으로 변경 
UPDATE VW_GROUPDEPT
SET DEPT_ID = 'D0'
WHERE DEPT_ID = 'D1';

-- DELETE 부서코드가 D1 삭제
DELETE FROM VW_GROUPDEPT
WHERE DEPT_ID = 'D1';

-- 5) DISTINCT가 포함된 경우 
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE (J7 --> J8)
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

-- DELETE J2 삭제
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J2';

-- 6) 조인을 이용해서 여러테이블을 연결한 경우

CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT * FROM VW_JOINEMP;


-- INSERT
INSERT INTO VW_JOINEMP VALUES(888, '조세호', '총무부');

-- UPDATE (200번 사원의 이름을 선동일에서 서동일로)
UPDATE VW_JOINEMP
SET EMP_NAME = '서동일'
WHERE EMP_NAME = '선동일';

SELECT * FROM EMPLOYEE;

-- UPDATE(총무부를 총무1팀으로 변경)
UPDATE VW_JOINEMP
SET DEPT_TITLE = '총무1팀'
WHERE DEPT_TITLE = '총무부';


-- DELETE (200번 사원 삭제)
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

ROLLBACK;


---------------------------------------------------------------------------

/*
    * VIEW 옵션
    
    [상세 표현법]
    CREATE [OR REPLACE] [FORCE |"NOFORCE"(기본값)]VIEW 뷰명
    AS 서브쿼리
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
    1) OR REPLACE 옵션 : 기존에 동일한 뷰가 있으면 덮어쓰고, 존재하지 않으면 새로이 생성
    2) FORCE / NOFORCE옵션
        > FORCE : 서브쿼리에 기술된 테이블이 존재하지 않는 테이블이더라도 뷰가 생성 할수 있게
        > NOFORCE : 서브쿼리에 기술된 테이블이 존재 해야만 뷰가 생성 (생략시 기본값)
        
    3) WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않은 값으로 수정할 때 오류 발생
    4) WITH READ ONLY : 뷰에 대한 조회만 가능(DML 수행 불가)
    

*/

--2) FORCE / NOFORCE 옵션
-- NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰가 생성 (생략시 기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;

-- FORCE : 서브쿼리에 기술된 테이블이 존재하지 않는 테이블이더라도 뷰가 생성 할수 있게
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
--> 컴파일 오류와 함께 뷰 생성

    
SELECT * FROM VW_EMP;    


CREATE TABLE TT(    -->  TT테이블을 생성해야만 , 그때부터 VIEW 조회 가능 
    TCODE NUMBER,
    TNAME VARCHAR2(30),
    TCONTENT VARCHAR2(50)   
    );


-- 3) WITH CHECK OPTION 옵션 : 서브쿼리에 기술된 조건에 부합하지 않은 값으로 수정할 때 오류 발생

-- 급여가 300만원 이상
CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VW_EMP2;  --> 8명 조회


-- 200번 사원의 급여를 200만원으로 변경
UPDATE VW_EMP2
SET SALARY = 2000000
WHERE EMP_ID = 200;

ROLLBACK;

SELECT * FROM EMPLOYEE;

CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;   

SELECT * FROM VW_EMP2;

UPDATE VW_EMP2
SET SALARY = 2000000    --> 서브쿼리에 기술한 조건에 부합하지 않기 때문에 변경 불가
WHERE EMP_ID = 200;


UPDATE VW_EMP2
SET SALARY = 4000000     --> 서브쿼리에 기술한 조건에 부합하기 때문에 변경 가능
WHERE EMP_ID = 200;

-- 4) WITH READ ONLY : 뷰에 대한 조회만 가능(DML 수행불가)

CREATE OR REPLACE VIEW VW_EMPBONUS
AS SELECT * FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;    
    
SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
WHERE EMP_ID = 200;



    