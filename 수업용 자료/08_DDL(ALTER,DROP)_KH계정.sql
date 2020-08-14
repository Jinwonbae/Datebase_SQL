/*
    * DDL(DATA DEFINITION LANGUAGE)
    데이터 정의 언어
    
    <ALTER>
    객체들을 수정하는 구문
    
    >> 테이블 수정
    
    [표현법]
    ALTER TABLE 테이블명 수정할 내용;
    
    
    - 수정할 내용 - 
    1) 컬럼 추가 / 수정 / 삭제
    2) 제약조건 추가 / 삭제 => 수정은 불가  (수정하고자 한다면, 삭제한 후 새로 추가!)
    3) 테이블명 / 컬럼명 / 제약조건명 변경
    
*/

-- 1) 컬럼 추가/ 수정/ 삭제
-- 1-1) 컬럼 추가 ADD : ADD 컬럼명 데이터 타입 [DEFALUT 기본값];

SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> 새로운 컬럼이 만들어지고 , 기본적으로 NULL값으로 채워짐

-- LNAME 컬럼 추가 (기본값 추가!)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
--> 새로운 컬럼이 만들어지고, 내가 지정한 기본값으로 채워짐!


-- 1_2) 컬럼 수정 (MODIFY)
--      데이터 타입 변경 : MODIFY 컬럼명 바꿀 데이터 타입
--          기본값 변경 : MODIFY 컬럼명 DEFAULT 바꿀 기본값
SELECT * FROM DEPT_COPY;

-- DEPT_ID 컬럼의 데이터 타입을 CHAR(3)으로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- DEPT_TITLE 컬럼의 데이터 타입을 VARCHARS2(40)으로 변경,
-- LOCATION_ID 컬럼의 데이터 타입을 VARCHAR2(2)으로 변경,
-= LNAME 컬럼의 기본값을 '미국'으로 변경

ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID  VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';
--> 다중 수정 가능

-- 1_3) 컬럼 삭제 (DROP COLUMN) : DROP COLUMN 삭제하고자하는 컬럼명
--      주의할 점: 테이블에는 최소 한개 컬럼 존재해야함

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- CNAME, LNAME 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;


ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID; --> 최소 한개는 있어야함

ALTER TABLE DEPARTMENT DROP COLUMN DEPT_ID;
--> 참조되고 있는 컬럼은 삭제 불가

-----------------------------------------------------------------------------

-- 2) 제약조건 추가 / 삭제
-- PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
-- FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명); 
-- UNIQUE      : ALTER TABLE 테이블명 ADD UNIQUE;
-- CHECK       : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건); 
-- NOT NULL    : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;

-- DEPT_COPY 테이블에

-- DEPT_ID에 PRIMARY KEY 제약 조건 추가    (ADD)
-- DEPT_TITLE에 UNIQUE 제약조건 추가       (ADD)
-- LNAME에 NOT NULL 제약 조건 추가         (MODIFY)

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID)
ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE (DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

-- 2_2) 제약조건 삭제 : DROP CONSTRAINT 제약조건명 / MODIFY 컬럼명 NULL 

-- DCOPY_PK 제약조건 지움
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_DTITLE_UQ 지우기, LNAME 컬럼 다시 NULL 가능하게!
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DTITLE_UQ
MODIFY LNAME NULL;

----------------------------------------------------------------------------------

-- 3) 컬럼명/ 테이블명 / 제약조건명 변경 (RENAME)


-- 3_1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀 컬럼명
-- DEPT_TITLE --> DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀 제약조건명
-- SYS_C007075 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007075 TO DCOPY_LID_NN;

-- 3_3) 테이블명 변경 : RENAME TO 바꿀테이블명;
-- DEPT_COPY --> DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
SELECT * FROM DEPT_TEST;

----------------------------------------------------------------------

-- 테이블 삭제 : DROP TABLE 테이블명 [CASCADE CONSTRAINT]
-- 주의할 점 : 어디선가 참조되고 있는 부모테이블은 함부러 삭제안됨!!
-- 삭제 가능한 방법1 : 자식테이블 먼저 삭제후 부모테이블을 삭제하는 방법
-- 삭제 가능한 방법2 : 부모테이블 삭제 후 제약조건도 함께 삭제

DROP TABLE DEPT_TEST CASCADE CONSTRAINT;




