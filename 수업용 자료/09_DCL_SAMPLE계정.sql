

-- 


CREATE TABLE TEST(
    TEST_ID NUMBER

);

-- 계정이 소유하고 있는 테이블을 바로 조작 가능!
SELECT * FROM TEST;
INSERT INTO TEST VALUES(10);

-- 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없음....
CREATE VIEW  V_TEST
AS SELECT * FROM TEST;

---------------------------------------------------------
-- 다른 계정의 테이블에 접근할 수 있는 권한이 없다...
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT;

INSERT INTO 
KH.DEPARTMENT VALUES ('D0','회계부','L2');

ROLLBACK;


