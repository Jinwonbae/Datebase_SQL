/*

    DML (MANIPULATION 조작) :  SELECT, INSERT, UPDATE, DELETE
    DDL (DEFINITION 정의) : CREATE, ALTER, DROP
    DCL (CONTROL 제어) : GRANT, REVOKE, COMMIT, ROLLBACK
    
    DQL (QUERY 질의 ) :  SELECT 
    DML              : INSERT, UPDATE, DELETE
    DDL              : CREATE, ALTER, DROP
    DCL              : GRANT, REVOKE
    TCL (TRANSACTION ) : COMMIT, ROLLBACK
 
    
    * DDL(DATA DEFINITION LANGUAGE) : 데이터 정의
    오라클에서 제공하는 객체(OBJECT)들을
    새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제 (DROP)하는 구문
    
    주로 DB관리자, 설계자 사용하는 구문
    
    오라클에서 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE)
                        인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
                        프로시져(PROCEDURE),함수(FUNCTION),
                        동의어(SYNONYM), 사용자(USER)
    

     <CREATE>
     다양한 객체(구조)를 생성하는 구문
     
     1. 테이블 생성
     - 테이블? :  행(ROW)과 열(COLUMN)로 구성되어있는 가장 기본적인 데이터베이스 객체
                 데이터 보관을 위한 제일 핵심적인 객체
                 
    [표현법]
    CREATE TABLE 테이블명 (
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명
        ....
        
        
    )
    
    *자료형(DATA TYPE)
    - 문자 (CHAR(크기) / VARCHAR2(크기))
        > CHAR(크기) : 최대 2000BYTE까지 저장 가능  / 고정길이 (아무리 적은 값이 들어와도 처음 할당한 크기 그대로)
        > VARCHAR2(크기) : 최대 4000BYTE까지 저장 가능  / 가변길이 (담긴 값에 따라 공간 크기 맞춰짐)
    - 숫자 (NUMBER)
    
    - 날짜 (DATE)
    
    
*/


--> 회원의 데이터를 담기 위한 테이블 MEMBER 생성

CREATE TABLE MEMBER(
    MEM_NO NUMBER,          -- 회원 번호 
    MEM_ID VARCHAR2(20),    -- 회원 아이디
    MEM_PWD VARCHAR2(20),   -- 회원 비밀번호
    MEM_NAME VARCHAR2(20),  -- 회원 명
    GENDER CHAR(3),         -- 회원 성별
    PHONE CHAR(13),         -- 전화 번호
    EMAIL VARCHAR2(50),     -- 이메일
    MEM_DATE DATE           -- 회원 가입일
    
);

SELECT * FROM MEMBER;

-----------------------------------------------------------------------------------------------
/*
    2. 컬럼 주석 달기 (컬럼에 대한 설명)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';


-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블(이미 있음)   -- 
--[참고] USER_TABLES : 이 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TABLES;

-- [참고] USER_TAB_COLUMNS : 테이블에 정의되어있는 모든 컬럼 전반적인 구조 확인 가능한 시스템 테이블
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- 데이터 추가할 수 있는 구문 
-- INSERT INTO 테이블명 VALUES(컬럼값1,컬럼값2,...,컬럼값N); --테이블에 있는 컬럼 갯수 맞춰서

INSERT INTO MEMBER VALUES(1,'user01','pass01','홍길동','남','010-1111-2222',null, SYSDATE);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2,'user02','pass02','홍길녀','여','010-1111-2222',null, '19/07/21');
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
SELECT * FROM MEMBER;

/*
    < 제약 조건 CONSTRANINTS >
    - 원하는 데이터값(유효한 값)만 유지하기 위해 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다.
    - 들어오는 데이터가 문제가 없는지 자동으로 검사할 목적
    
    * 종류 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY(기본키), FOREIGN KEY(외래키), 
    
    
*/

/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 있어야하는 경우 (해당 컬럼 NULL값이 들어와서는 안되는 경우)
      삽입 / 수정시 NULL값을 허용하지 않도록 제한
*/

-- 제약조건 부여하는 방식 2가지 (컬럼레벨방식, 테이블레벨방식)
-- NOT NULL제약조건 부여는 컬럼레벨 방식만 가능
-- 컬럼레벨방식 : 컬럼명 자료형[(크기)] 제약조건  

CREATE TABLE MEM_NOT_NULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(20)
);

SELECT * FROM MEM_NOT_NULL;

INSERT INTO MEM_NOT_NULL VALUES(1, 'user01','pass01','홍길동','남',null,null); 
INSERT INTO MEM_NOT_NULL VALUES(2,'user02','pass02','김말순',NULL,NULL,NULL);
--> NOT NULL 제약조건에 위배되어 오류 발생(내가 의도한 대로)

INSERT INTO MEM_NOT_NULL
VALUES (3, 'user01', 'pass03','홍길녀','여','010-2222-3333','aaa@naver.com');

------------------------------------------------------------------------------------------

/*
    *   UNIQUE 제약조건
        해당 컬럼 값에 중복값을 제한하는 제약조건
        삽입 / 수정시 기존에 있는 데이터 값 중에 중복값이 있을 경우 오류발생!
        
        컬럼레벨방식/테이블레벨방식  둘다 사용가능
    
    
*/

-- DROP TABLE MEM_UNIQUE;

-- 테이블레벨방식 : 제약조건(컬럼명)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,    --> 컬럼레벨방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_ID) --> 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','홍길동','남',null,null); 
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','김말순',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01','pass03','홍길녀',null,null,null);
--> UNIQUE 제약조건에 위배되었으므로, INSERT 실패!!
--> 오류구문을 제약조건명으로 알려줌! (특정 컬럼에 어떤 제약조건 위배되었는지 상세하게 알려주지 않음)
--> 쉽게 파악 어려움 (제약조건명을 직접 지정해주지 않으면, 시스템에서 알아서 임의의 제약조건명 부여)

/*
    * 제약조건명까지 이름지어주면서 제약조건 부여 방식
    > 컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기)[CONSTRAINT  제약조건명] 제약조건,
        컬럼명 자료형
        
    );    
    
    >테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형
        [CONSTRAINT  제약조건명] 제약조건 (컬럼명)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEM_NO_NM NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEM_ID_NM NOT NULL,    --> 컬럼레벨방식
    MEM_PWD VARCHAR2(20) CONSTRAINT MEM_PWD_NM NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NM NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_ID_UQ UNIQUE (MEM_ID) --> 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','홍길동','남',null,null); 
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','김말순',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03','pass03','홍길녀','강',null,null);
--> 성별에 유효한 값이 아닌게 있어도 잘 INSERT 되어버림!
SELECT * FROM MEM_UNIQUE;


-------------------------------------------------------------------------------------

/*
    * CHECK(조건) 제약조건
        컬럼에 들어올 값에 대한 조건을 제시할 수 있음
        해당 조건에 만족하는 데이터값만 담길 수 있음
        
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER_CK CHECK(GENDER IN('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- CONSTRAINT GENDER_CK CHECK(GENDER IN ('남', '여'))
);

INSERT INTO MEM_CHECK VALUES(1, 'user01','pass01','홍길동','남',null,null); 
INSERT INTO MEM_CHECK VALUES(2,'user02','pass02','김말순',NULL,NULL,NULL);
INSERT INTO MEM_CHECK VALUES(3, 'user03','pass03','홍길녀','여',null,null);
--> GENDER 컬럼에 값을 넣는다면 '남' 또는 '여'만 가능
--> 뿐만아니라 NULL값도 가능
--> NULL을 못넣게 할려면, NOT NULL 제약조건 같이 부여!

INSERT INTO MEM_CHECK VALUES(3, 'user04','pass04','김말똥','남','010-1111-2222', 'bbb@naver.com');
--> 회원번호가 동일해도 성공적으로 insert됨.....

SELECT * FROM MEM_CHECK;


--------------------------------------------------------------------------------------------
/*
    * PRIMARY KEY (기본키)
    테이블에서 각 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약 조건 (식별자 역할)
    EX) 학번, 회원번호, 사원번호, 부서코드, 직급코드, 주문번호, 예약번호, 운송장 번호
    
    
    PRIMARY KEY 제약 조건을 부여하게 되면 
    해당 그 컬럼에 NOT NULL + UNIQUE 제약조건 의미
    
    주의할점 : 한 테이블 당 한개만 설정 가능
    
*/


 

INSERT INTO MEM_PRIMARYKEY VALUES(1, 'user01', 'pass01', '홍길동', '남',null,null);

INSERT INTO MEM_PRIMARYKEY VALUES(NULL, 'user02','pass02','이순신',null,null,null);
--> 기본키에 NULL값 담으려고 할 때 오류 발생!!
INSERT INTO MEM_PRIMARYKEY 
VALUES(1, 'user02','pass02','이순신',null,null,null);
--> 기본키에 중복값 담으려고 할 때 오류 발생!!

--> PRIMARY KEY == NOT NULL + UNIQUE
INSERT INTO MEM_PRIMARYKEY 
VALUES(2, 'user02','pass02','이순신',null,null,null);


-- * 주의 할 점 : 한 테이블당 한개의 PRIMARY KEY만 가능!!
CREATE TABLE MEM_PRIMARYKEY2 (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN ('남', '여')),
    PRIMARY KEY (MEM_NO, MEM_ID)    --> 묶어서 PRIMARY KEY 제약조건 부여가능(복합키)
);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(1, 'user01', 'pass01', '홍길동', '남',null,null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(1, 'user02', 'pass02', '홍길녀', '여',null,null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(2, 'user02', 'pass03', '김말똥',NULL,null,null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(NULL, 'user03', 'pass04', '김말녀',NULL,null,null);
--> 기본키로 묶여있는 각 컬럼에는 절대 NULL값이 들어가서는 안됨!!


SELECT * FROM MEM_PRIMARYKEY2;


-- 회원등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30,'특별회원');

SELECT * FROM MEM_GRADE;


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --CHECK(GRADE_ID IN (10,20,30))   -->회원등급번호 같이 보관할 컬럼
);


INSERT INTO MEM VALUES(1,'USER01','PASS01','홍길동',NULL,NULL,NULL,NULL);

INSERT INTO MEM VALUES(2,'USER02','PASS02','김말똥','남',NULL,NULL,10);

INSERT INTO MEM VALUES(3,'USER03','PASS03','이순신',NULL,NULL,NULL,40);

SELECT * FROM MEM;

------------------------------------------------------------------------------------

/*

    *FOREIGN KEY(외래키)
     다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약 조건
     
     --> 다른테이블을 참조한다고 표현
     --> FOREIGN KEY 제약조건에 의해서 테이블 간의 관계 형성!!
     
     >  컬럼레벨 방식
        컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할 테이블명(컬럼명) 
        
     > 테이블레벨 방식
       [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCE 참조할 테이블명 [(컬럼명)]
*/

SELECT * FROM MEM_GRADE;

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE        --> 컬럼레벨방식
    -- FOREIGN KEY(GRADE_ID)REFEERECES MEM_GRADE(GRADE_CODE)    --> 테이블레벨방식
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','홍길동',NULL,NULL,NULL,10);

INSERT INTO MEM VALUES(2,'USER02','PASS02','김말똥','남',NULL,NULL,20);

INSERT INTO MEM VALUES(3,'USER03','PASS03','이순신',NULL,NULL,NULL,10);

INSERT INTO MEM VALUES(4,'USER04','PASS04','안중근',NULL,NULL,NULL,NULL);
--> 외래키 제약조건이 부여된 컬럼에는 기본적으로 NULL값 담는 것 가능

INSERT INTO MEM VALUES(5,'USER05','PASS05','신사임당',NULL,NULL,NULL,40);
--> PARENT KEY를 찾을 수 없다.
--> 40이라는 값은 MEM_GRADE 테이블 GRADE_CODE컬럼에 제공되고 있는 값이 아님


-- 부모테이블(MEM_GRADE) -1------<- 자식테이블(MEM)   (1:N) 관계

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

-- ORACLE
SELECT MEM_NO, MEM_ID, MEM_NAME, GRADE_NAME
FROM MEM M, MEM_GRADE G
WHERE M.GRADE_ID = G.GRADE_CODE(+);

-- ANSI
SELECT MEM_NO, MEM_ID, MEM_NAME, GRADE_NAME
FROM MEM
FULL JOIN MEM_GRADE ON (GRADE_ID = GRADE_CODE);


--> 문제는 부모테이블(MEM-GRADE)에서 데이터 값을 삭제할 때 문제 발생!!
SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

--> 10번 등급 삭제!, 데이터 삭제
-- DELETE FROM 테이블명 WHERE 조건식;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;

--> 자식테이블(MEM) 중에 10을 사용하고 있어서 지울수 없다!
-- 자식테이블에 사용하고 있는 값이 있을 경우 부모테이블로부터 삭제가 안되는 "삭제 제한" 옵션 걸려있음!!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

ROLLBACK;

--------------------------------------------------------------------------------------------

/*
    부모테이블의 데이터 삭제시 자식테이블 값을 어떻게 처리할 건지 옵션으로 정해 둘 수 있음!!
    언제 ? => 자식테이블 생성할 때 외래키 제약조건 부여
    
    * FOREING KEY 삭제 옵션
    
    삭제 옵션을 별도로 제시하지 않으면, 

*/

-- 1) ON DELETE SET NULL : 부모데이터 삭제시, 해당 데이터 사용하고 있는 자식 데이터 값을 NULL 값으로 변겅한다!!

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','홍길동',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(2,'USER02','PASS02','김말똥','남',NULL,NULL,20);
INSERT INTO MEM VALUES(3,'USER03','PASS03','이순신',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(4,'USER04','PASS04','안중근',NULL,NULL,NULL,NULL);

SELECT * FROM MEM;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;

SELECT * FROM MEM_GRADE;

ROLLBACK;

-- 2) ON DELETE CASCADE : 부모데이터 삭제시, 해당 데이터를 쓰고 있는 자식 데이터 값까지 모두 삭제!!

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','홍길동',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(2,'USER02','PASS02','김말똥','남',NULL,NULL,20);
INSERT INTO MEM VALUES(3,'USER03','PASS03','이순신',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(4,'USER04','PASS04','안중근',NULL,NULL,NULL,NULL);

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;  --> 잘 삭제됨!(단, 해당 데이터 사용하는 자식 데이터도 모두 삭제됨!!) 

-------------------------------------------------------------------------------------------

/*
    <DEFAULT 기본값>
    
    컬럼 지정하지 않고, INSERT 시 기본값을 INSERT하고자 할 때 세팅 해 놓을 수 있는 값
    (제약 조건은 아니다.)
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20),
    MEM_AGE NUMBER DEFAULT 20,
    MEM_DATE DATE DEFAULT SYSDATE 
);

SELECT * FROM MEMBER;
-- INSERT INTO 테이블명 VALUES();
INSERT INTO MEMBER VALUES(1,'홍길동',20,SYSDATE);

-- INSERT INTO 테이블명(컬럼값, 컬럼값) VALUES(컬럼값, 컬럼값);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(2, '김말순');
--> 지정 안된 컬럼에는 기본적으로 NULL 값이 들어감!
--> 해당 그 컬럼에 DEFAULT값이 부여 되어있다면, DEFAULT값이 들어간다!!

-- 상품에 대한 데이터를 보관할 테이블(상품번호, 상품명, 브랜드명, 가격, 재고수량)

CREATE TABLE PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(20) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 10
);

INSERT INTO PRODUCT VALUES(1,'갤럭시','삼성',1300000,100);
INSERT INTO PRODUCT(PRODUCT_NO, PRODUCT_NAME, BRAND) VALUES(2,'아이폰12PRO','애플');
INSERT INTO PRODUCT VALUES(3,'아이패드','애플',2500000, DEFAULT);

SELECT * FROM PRODUCT;

---------------------------------------------------------------------------------

/*
    !!!!!!!!!!!!!!!!!!!!!!!!!!! KH계정에서 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    <SUBQUERY 이용한 테이블 생성(테이블 복사)>
    
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
    
*/

-- EMPLOYEE 테이블 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
--> 컬럼, 담겨있는 데이터값, 제약조건 같은 경우는 NOT NULL만 복사됨!
SELECT * FROM EMPLOYEE_COPY;


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE 1=0;  -->구조만 복사 , 데이터 복사하고 싶지 않을 때!
    
SELECT * FROM EMPLOYEE_COPY2; 

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME,SALARY, SALARY*12 "연봉"
    FROM EMPLOYEE;
--> 서브쿼리 SELECT절에 산술연산식 또는 함수식 기술된 경우 반드시 별칭 지정해야함!    
    
SELECT * FROM EMPLOYEE_COPY3; 

---------------------------------------------------------------------------------



