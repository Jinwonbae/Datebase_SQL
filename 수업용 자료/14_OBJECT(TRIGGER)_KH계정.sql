/*
    < 트리거 TRIGGER >

    내가 지정한 테이블에 INSERT, UPDATE, DELETE 등의 DML문에 의해 변경될 경우(테이블 이벤트 발생시)
    자동으로 매번 실행될 내용을 정의해둘 수 있느 ㄴ객체
    데이터 무결성을 보장
    
    EX) 입출고에 대한 데이터 기록(INSERT)될 때 마다 해당 상품에 대한 재고 수량이 매번 수정(UPDATE)할 수 있다!
        기존 회원테이블에 데이터(DELETE) 후 탈퇴된 회원들만 따로 보관하는 테이블에 자동으로 INSERT처리 할 수 있다!
        신고 횟수가 일정 넘었을 때 묵시적으로 블랙리스트 처리하게끔!
    
    * 트리거의 종류
    - SQL문의 실행 시기에 따른 분류
    > BEFORE TRIGGER :
    > AFTER  TRIGGER : 
    
    - SQL문에 의해 영향을 받는 각 행에 따른 분류
    > STATEMENT TRIGGER(문장 트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
    
    > ROW TRIGGER(행 트리거) : 해당 SQL문 실행할 때 마다 매번 트리거 실행
                              트리거 생성 구문 작성시 FOR EACH ROW 옵션 기술해야됨!
                 > : OLD    : BEFORE UPDATE(수정전 자료), BEFORE DELETE(삭제전 자료) 
                 > : NEW    : AFTER INSERT(입력후 자료), AFTER DELETE(수정후 자료)
                 
    * 트리거 생성 구문
    
    [표현법]
    
    CREATE [OR REPLACE] TRIGGER TRG_트리거명
    BEFORE | AFTER  INSERT|UPDATE|DELETE ON 테이블명
    [FOR EACH ROW]      --> 행 트리거
    
    AFTER INSERT ON DEPARTMENT
    
    [DECLARE
        변수 선언;]
    BEGIN
        실행 내용; (해당 위에 지저된 이벤트 발생시 묵시적으로 자동으로 실행할 구문)
    [EXCEPTION
        예외 처리;]
    END;
    /
*/

SET SERVEROUTPUT ON;    -- 출력문이 보이는 구문


-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때마다 자동으로 메세지 출력하는 트리거 정의

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT 
ON EMPLOYEE

BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원 받아라!');
END;
/

INSERT INTO EMPLOYEE (
                      EMP_ID
                    , EMP_NAME
                    , EMP_NO
                    , DEPT_CODE
                    , JOB_CODE
                    , HIRE_DATE) 
VALUES  (400
        , '이순신'
        , '800918-2154678'
        , 'D7'
        , 'J7'
        , SYSDATE);
              
INSERT INTO EMPLOYEE (
                        EMP_ID
                      , EMP_NAME
                      , EMP_NO
                      , DEPT_CODE
                      , JOB_CODE
                      , HIRE_DATE)
                      
VALUES (    
        401
      ,'길성춘'
      ,'800918-2354678'
      ,'D8'
      ,'J7'
      ,SYSDATE);

---------------------------------------------------------------------------------

-- 상품 입고 및 출고 관련 예시


-->> 필요한 테이블 및 시퀀스 생성

-- 1. 상품에 대한 데이터 보관할 테이블 (TB_PRODUCT)

CREATE TABLE TB_PRODUCT (
       PCODE NUMBER PRIMARY KEY,        -- 상품코드
       PNAME VARCHAR(30),               -- 상품명
       BRAND VARCHAR(30),               -- 브랜드
       PRICE NUMBER,                    -- 가격
       STOCK NUMBER DEFAULT 0           -- 재고
       
);

-- 상품코드 중복 안되게 새로운 번호 매번 발생시키는 시퀀스(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE;      --기본값으로 실행 1부터 시작함!

-- 샘플 데이터 추가

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,'갤럭시20','샘송',1400000,DEFAULT);

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,'아이폰12PRO','사과',NULL,DEFAULT);

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,'대륙폰','샤오미',600000,20);


COMMIT;


-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
--    어떤 상품이 어떤 날 몇개가 입고 또는 출고가 되었는지 기록하는 테이블
CREATE TABLE TB_PRODETAIL(
        DCODE NUMBER PRIMARY KEY,
        PCODE NUMBER,
        PDATE DATE,
        AMOUNT NUMBER,
        STATUS VARCHAR2(10) CHECK (STATUS IN ('입고', '출고')),
        FOREIGN KEY (PCODE) REFERENCES TB_PRODUCT(PCODE)
);

-- 상세코드로 새로운 번호를 발생시키는 시퀀스 (SEQ_DCODE)
CREATE SEQUENCE SEQ_DECODE;

-- 1번 상품이 오늘날짜로 10개 입고
INSERT INTO TB_PRODETAIL
VALUES (SEQ_DECODE.NEXTVAL
        , 1
        , SYSDATE
        , 10
        , '입고');

-- 재고수량도 변경해야함
UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
    WHERE PCODE = 1;
    

COMMIT;

-- 2번 상품이 오늘날짜로 20개 입고
INSERT INTO TB_PRODETAIL
VALUES (SEQ_DECODE.nextval
      , 2
      , SYSDATE
      , 20
      , '입고');

UPDATE TB_PRODUCT
    SET STOCK = STOCK + 20
    WHERE PCODE = 2;

COMMIT;


-- 1번 상품이 오늘날짜로 3개 출고
INSERT INTO TB_PRODETAIL
VALUES ( SEQ_DECODE.NEXTVAL
       , 1
       , SYSDATE
       , 3
       , '출고');

-- 재고 수량도 변경
UPDATE TB_PRODUCT
    SET STOCK = STOCK - 3
    WHERE PCODE = 1;


SELECT * FROM TB_PRODUCT;

-- TB_PRODETAIL 테이블에 데이터 삽입 (INSERT) 후
-- TB_PRODUCT 테이블에 매번 자동으로 재고 수량 UPDATE 되게끔 트리거 정의
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW -- 행트리거    
BEGIN

   -- 상품이 입고된 경우    --> 재고수량 증가
    IF (:NEW.STATUS = '입고')
    THEN 
        UPDATE TB_PRODUCT 
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;    
    
   -- 상품이 출고된 경우    --> 재고수량 감소
    IF (:NEW.STATUS = '출고')
    THEN
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;    

END;
/


-- 3번 상품이 오늘날짜로 9개 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL,3,SYSDATE, 9, '출고');

-- 2번 상품이 오늘날짜로 100개 입고
INSERT INTO TB_PRODETAIL
VALUES (SEQ_DECODE.NEXTVAL,2,SYSDATE,100,'입고');

SELECT * FROM TB_PRODUCT;


