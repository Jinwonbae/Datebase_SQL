/*
    <TCL : TRANSACTION CONTROL LANGUAGE>
    트랜잭션을 제어하는 언어
    
    * 트랜잭션
    - 데이터베이스의 논리적 연산단위
    - 데이터 변경사항(DML)들을 하나의 트랜잭션에 묶어서 처리
      COMMIT 하기 전까지 변경사항들을 하나의 트랜잭션에 담게됨
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)  

    COMMIT(트랜잭션 종료처리 후 확정), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시 저장)
    
    COMMIT : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠소!
    ROLLBACK 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 삭제한 후 마지막 COMMIT 시점으로 돌아감!
    
    SAVEPOINT : 임시저장점을 정의해주는 것
                ROLLBACK 진행시 전체작업을 다 삭제하는게 아닌 SAVEPOINT까지 일부만 롤백 가능
                
                SAVEPOINT 포인트명1;        -- 저장점 지정
                ROLLBACK TO 포인트명1;      -- 해당포인트 지점까지의 트랜잭션만 롤백
*/




-- 사번이 901 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 901;
-- 사번이 900 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 900;

---------------------------------------------

-- 200번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 800, 홍길동, 총무부 사원 추가
INSERT INTO EMP_01 VALUES(800,'홍길동','총무부');

COMMIT;

SELECT * FROM EMP_01;


----------------------------------------------------------
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(30)
);




SELECT EMP_ID, EMP_NAME, DEPT_TITLE

FROM EMPLOYEE

LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

-- 217, 216, 214 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 3개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;


-- 801, '김말똥', '인사부'
INSERT INTO EMP_01 VALUES(801, '김말똥', '인사부');

-- 218번 사원 지움
DELETE FROM EMP_01 WHERE EMP_ID = 218;


ROLLBACK TO SP1;
COMMIT;

---------------------------------------------------------------------------------------

-- 900번 901번 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

-- 218번 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- 테이블 생성 (DDL)
CREATE TABLE TEST (
    TID NUMBER
);

--> DDL구문(CREATE, ALTER, DROP)을 실행하는 순간 기존에 트랜잭션에 있던 변경사항을 무조건 실제 DB에 반영해버림!
--> 즉, DDL 수행 전 변경사항들이 있었다면 정확히 픽스(COMMIT, ROLLBACK) 할것!

ROLLBACK;
SELECT * FROM EM_01;