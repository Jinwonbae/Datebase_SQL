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


