/*

    DML (MANIPULATION ����) :  SELECT, INSERT, UPDATE, DELETE
    DDL (DEFINITION ����) : CREATE, ALTER, DROP
    DCL (CONTROL ����) : GRANT, REVOKE, COMMIT, ROLLBACK
    
    DQL (QUERY ���� ) :  SELECT 
    DML              : INSERT, UPDATE, DELETE
    DDL              : CREATE, ALTER, DROP
    DCL              : GRANT, REVOKE
    TCL (TRANSACTION ) : COMMIT, ROLLBACK
 
    
    * DDL(DATA DEFINITION LANGUAGE) : ������ ����
    ����Ŭ���� �����ϴ� ��ü(OBJECT)����
    ������ �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ���� (DROP)�ϴ� ����
    
    �ַ� DB������, ������ ����ϴ� ����
    
    ����Ŭ���� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE)
                        �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER)
                        ���ν���(PROCEDURE),�Լ�(FUNCTION),
                        ���Ǿ�(SYNONYM), �����(USER)
    

     <CREATE>
     �پ��� ��ü(����)�� �����ϴ� ����
     
     1. ���̺� ����
     - ���̺�? :  ��(ROW)�� ��(COLUMN)�� �����Ǿ��ִ� ���� �⺻���� �����ͺ��̽� ��ü
                 ������ ������ ���� ���� �ٽ����� ��ü
                 
    [ǥ����]
    CREATE TABLE ���̺�� (
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷���
        ....
        
        
    )
    
    *�ڷ���(DATA TYPE)
    - ���� (CHAR(ũ��) / VARCHAR2(ũ��))
        > CHAR(ũ��) : �ִ� 2000BYTE���� ���� ����  / �������� (�ƹ��� ���� ���� ���͵� ó�� �Ҵ��� ũ�� �״��)
        > VARCHAR2(ũ��) : �ִ� 4000BYTE���� ���� ����  / �������� (��� ���� ���� ���� ũ�� ������)
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
    
*/


--> ȸ���� �����͸� ��� ���� ���̺� MEMBER ����

CREATE TABLE MEMBER(
    MEM_NO NUMBER,          -- ȸ�� ��ȣ 
    MEM_ID VARCHAR2(20),    -- ȸ�� ���̵�
    MEM_PWD VARCHAR2(20),   -- ȸ�� ��й�ȣ
    MEM_NAME VARCHAR2(20),  -- ȸ�� ��
    GENDER CHAR(3),         -- ȸ�� ����
    PHONE CHAR(13),         -- ��ȭ ��ȣ
    EMAIL VARCHAR2(50),     -- �̸���
    MEM_DATE DATE           -- ȸ�� ������
    
);

SELECT * FROM MEMBER;

-----------------------------------------------------------------------------------------------
/*
    2. �÷� �ּ� �ޱ� (�÷��� ���� ����)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';


-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�(�̹� ����)   -- 
--[����] USER_TABLES : �� ����ڰ� ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;

-- [����] USER_TAB_COLUMNS : ���̺� ���ǵǾ��ִ� ��� �÷� �������� ���� Ȯ�� ������ �ý��� ���̺�
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- ������ �߰��� �� �ִ� ���� 
-- INSERT INTO ���̺�� VALUES(�÷���1,�÷���2,...,�÷���N); --���̺� �ִ� �÷� ���� ���缭

INSERT INTO MEMBER VALUES(1,'user01','pass01','ȫ�浿','��','010-1111-2222',null, SYSDATE);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2,'user02','pass02','ȫ���','��','010-1111-2222',null, '19/07/21');
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
SELECT * FROM MEMBER;

/*
    < ���� ���� CONSTRANINTS >
    - ���ϴ� �����Ͱ�(��ȿ�� ��)�� �����ϱ� ���� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    - ������ �����Ͱ� ������ ������ �ڵ����� �˻��� ����
    
    * ���� : NOT NULL, UNIQUE, CHECK(����), PRIMARY KEY(�⺻Ű), FOREIGN KEY(�ܷ�Ű), 
    
    
*/

/*
    * NOT NULL ��������
      �ش� �÷��� �ݵ�� ���� �־���ϴ� ��� (�ش� �÷� NULL���� ���ͼ��� �ȵǴ� ���)
      ���� / ������ NULL���� ������� �ʵ��� ����
*/

-- �������� �ο��ϴ� ��� 2���� (�÷��������, ���̺������)
-- NOT NULL�������� �ο��� �÷����� ��ĸ� ����
-- �÷�������� : �÷��� �ڷ���[(ũ��)] ��������  

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

INSERT INTO MEM_NOT_NULL VALUES(1, 'user01','pass01','ȫ�浿','��',null,null); 
INSERT INTO MEM_NOT_NULL VALUES(2,'user02','pass02','�踻��',NULL,NULL,NULL);
--> NOT NULL �������ǿ� ����Ǿ� ���� �߻�(���� �ǵ��� ���)

INSERT INTO MEM_NOT_NULL
VALUES (3, 'user01', 'pass03','ȫ���','��','010-2222-3333','aaa@naver.com');

------------------------------------------------------------------------------------------

/*
    *   UNIQUE ��������
        �ش� �÷� ���� �ߺ����� �����ϴ� ��������
        ���� / ������ ������ �ִ� ������ �� �߿� �ߺ����� ���� ��� �����߻�!
        
        �÷��������/���̺������  �Ѵ� ��밡��
    
    
*/

-- DROP TABLE MEM_UNIQUE;

-- ���̺������ : ��������(�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,    --> �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_ID) --> ���̺� ���� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','ȫ�浿','��',null,null); 
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','�踻��',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01','pass03','ȫ���',null,null,null);
--> UNIQUE �������ǿ� ����Ǿ����Ƿ�, INSERT ����!!
--> ���������� �������Ǹ����� �˷���! (Ư�� �÷��� � �������� ����Ǿ����� ���ϰ� �˷����� ����)
--> ���� �ľ� ����� (�������Ǹ��� ���� ���������� ������, �ý��ۿ��� �˾Ƽ� ������ �������Ǹ� �ο�)

/*
    * �������Ǹ���� �̸������ָ鼭 �������� �ο� ���
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��)[CONSTRAINT  �������Ǹ�] ��������,
        �÷��� �ڷ���
        
    );    
    
    >���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���
        [CONSTRAINT  �������Ǹ�] �������� (�÷���)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEM_NO_NM NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEM_ID_NM NOT NULL,    --> �÷��������
    MEM_PWD VARCHAR2(20) CONSTRAINT MEM_PWD_NM NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NM NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_ID_UQ UNIQUE (MEM_ID) --> ���̺� ���� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','ȫ�浿','��',null,null); 
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','�踻��',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03','pass03','ȫ���','��',null,null);
--> ������ ��ȿ�� ���� �ƴѰ� �־ �� INSERT �Ǿ����!
SELECT * FROM MEM_UNIQUE;


-------------------------------------------------------------------------------------

/*
    * CHECK(����) ��������
        �÷��� ���� ���� ���� ������ ������ �� ����
        �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
        
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER_CK CHECK(GENDER IN('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- CONSTRAINT GENDER_CK CHECK(GENDER IN ('��', '��'))
);

INSERT INTO MEM_CHECK VALUES(1, 'user01','pass01','ȫ�浿','��',null,null); 
INSERT INTO MEM_CHECK VALUES(2,'user02','pass02','�踻��',NULL,NULL,NULL);
INSERT INTO MEM_CHECK VALUES(3, 'user03','pass03','ȫ���','��',null,null);
--> GENDER �÷��� ���� �ִ´ٸ� '��' �Ǵ� '��'�� ����
--> �Ӹ��ƴ϶� NULL���� ����
--> NULL�� ���ְ� �ҷ���, NOT NULL �������� ���� �ο�!

INSERT INTO MEM_CHECK VALUES(3, 'user04','pass04','�踻��','��','010-1111-2222', 'bbb@naver.com');
--> ȸ����ȣ�� �����ص� ���������� insert��.....

SELECT * FROM MEM_CHECK;


--------------------------------------------------------------------------------------------
/*
    * PRIMARY KEY (�⺻Ű)
    ���̺��� �� ���� ������ �ĺ��ϱ� ���� ����� �÷��� �ο��ϴ� ���� ���� (�ĺ��� ����)
    EX) �й�, ȸ����ȣ, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ����� ��ȣ
    
    
    PRIMARY KEY ���� ������ �ο��ϰ� �Ǹ� 
    �ش� �� �÷��� NOT NULL + UNIQUE �������� �ǹ�
    
    �������� : �� ���̺� �� �Ѱ��� ���� ����
    
*/


 

INSERT INTO MEM_PRIMARYKEY VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��',null,null);

INSERT INTO MEM_PRIMARYKEY VALUES(NULL, 'user02','pass02','�̼���',null,null,null);
--> �⺻Ű�� NULL�� �������� �� �� ���� �߻�!!
INSERT INTO MEM_PRIMARYKEY 
VALUES(1, 'user02','pass02','�̼���',null,null,null);
--> �⺻Ű�� �ߺ��� �������� �� �� ���� �߻�!!

--> PRIMARY KEY == NOT NULL + UNIQUE
INSERT INTO MEM_PRIMARYKEY 
VALUES(2, 'user02','pass02','�̼���',null,null,null);


-- * ���� �� �� : �� ���̺�� �Ѱ��� PRIMARY KEY�� ����!!
CREATE TABLE MEM_PRIMARYKEY2 (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN ('��', '��')),
    PRIMARY KEY (MEM_NO, MEM_ID)    --> ��� PRIMARY KEY �������� �ο�����(����Ű)
);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��',null,null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(1, 'user02', 'pass02', 'ȫ���', '��',null,null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(2, 'user02', 'pass03', '�踻��',NULL,null,null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES(NULL, 'user03', 'pass04', '�踻��',NULL,null,null);
--> �⺻Ű�� �����ִ� �� �÷����� ���� NULL���� ������ �ȵ�!!


SELECT * FROM MEM_PRIMARYKEY2;


-- ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30,'Ư��ȸ��');

SELECT * FROM MEM_GRADE;


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --CHECK(GRADE_ID IN (10,20,30))   -->ȸ����޹�ȣ ���� ������ �÷�
);


INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿',NULL,NULL,NULL,NULL);

INSERT INTO MEM VALUES(2,'USER02','PASS02','�踻��','��',NULL,NULL,10);

INSERT INTO MEM VALUES(3,'USER03','PASS03','�̼���',NULL,NULL,NULL,40);

SELECT * FROM MEM;

------------------------------------------------------------------------------------

/*

    *FOREIGN KEY(�ܷ�Ű)
     �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� ���� ����
     
     --> �ٸ����̺��� �����Ѵٰ� ǥ��
     --> FOREIGN KEY �������ǿ� ���ؼ� ���̺� ���� ���� ����!!
     
     >  �÷����� ���
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ������ ���̺��(�÷���) 
        
     > ���̺��� ���
       [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCE ������ ���̺�� [(�÷���)]
*/

SELECT * FROM MEM_GRADE;

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE        --> �÷��������
    -- FOREIGN KEY(GRADE_ID)REFEERECES MEM_GRADE(GRADE_CODE)    --> ���̺������
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿',NULL,NULL,NULL,10);

INSERT INTO MEM VALUES(2,'USER02','PASS02','�踻��','��',NULL,NULL,20);

INSERT INTO MEM VALUES(3,'USER03','PASS03','�̼���',NULL,NULL,NULL,10);

INSERT INTO MEM VALUES(4,'USER04','PASS04','���߱�',NULL,NULL,NULL,NULL);
--> �ܷ�Ű ���������� �ο��� �÷����� �⺻������ NULL�� ��� �� ����

INSERT INTO MEM VALUES(5,'USER05','PASS05','�Ż��Ӵ�',NULL,NULL,NULL,40);
--> PARENT KEY�� ã�� �� ����.
--> 40�̶�� ���� MEM_GRADE ���̺� GRADE_CODE�÷��� �����ǰ� �ִ� ���� �ƴ�


-- �θ����̺�(MEM_GRADE) -1------<- �ڽ����̺�(MEM)   (1:N) ����

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


--> ������ �θ����̺�(MEM-GRADE)���� ������ ���� ������ �� ���� �߻�!!
SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

--> 10�� ��� ����!, ������ ����
-- DELETE FROM ���̺�� WHERE ���ǽ�;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;

--> �ڽ����̺�(MEM) �߿� 10�� ����ϰ� �־ ����� ����!
-- �ڽ����̺� ����ϰ� �ִ� ���� ���� ��� �θ����̺�κ��� ������ �ȵǴ� "���� ����" �ɼ� �ɷ�����!!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

ROLLBACK;

--------------------------------------------------------------------------------------------

/*
    �θ����̺��� ������ ������ �ڽ����̺� ���� ��� ó���� ���� �ɼ����� ���� �� �� ����!!
    ���� ? => �ڽ����̺� ������ �� �ܷ�Ű �������� �ο�
    
    * FOREING KEY ���� �ɼ�
    
    ���� �ɼ��� ������ �������� ������, 

*/

-- 1) ON DELETE SET NULL : �θ����� ������, �ش� ������ ����ϰ� �ִ� �ڽ� ������ ���� NULL ������ �����Ѵ�!!

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(2,'USER02','PASS02','�踻��','��',NULL,NULL,20);
INSERT INTO MEM VALUES(3,'USER03','PASS03','�̼���',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(4,'USER04','PASS04','���߱�',NULL,NULL,NULL,NULL);

SELECT * FROM MEM;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;

SELECT * FROM MEM_GRADE;

ROLLBACK;

-- 2) ON DELETE CASCADE : �θ����� ������, �ش� �����͸� ���� �ִ� �ڽ� ������ ������ ��� ����!!

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(2,'USER02','PASS02','�踻��','��',NULL,NULL,20);
INSERT INTO MEM VALUES(3,'USER03','PASS03','�̼���',NULL,NULL,NULL,10);
INSERT INTO MEM VALUES(4,'USER04','PASS04','���߱�',NULL,NULL,NULL,NULL);

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;  --> �� ������!(��, �ش� ������ ����ϴ� �ڽ� �����͵� ��� ������!!) 

-------------------------------------------------------------------------------------------

/*
    <DEFAULT �⺻��>
    
    �÷� �������� �ʰ�, INSERT �� �⺻���� INSERT�ϰ��� �� �� ���� �� ���� �� �ִ� ��
    (���� ������ �ƴϴ�.)
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20),
    MEM_AGE NUMBER DEFAULT 20,
    MEM_DATE DATE DEFAULT SYSDATE 
);

SELECT * FROM MEMBER;
-- INSERT INTO ���̺�� VALUES();
INSERT INTO MEMBER VALUES(1,'ȫ�浿',20,SYSDATE);

-- INSERT INTO ���̺��(�÷���, �÷���) VALUES(�÷���, �÷���);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(2, '�踻��');
--> ���� �ȵ� �÷����� �⺻������ NULL ���� ��!
--> �ش� �� �÷��� DEFAULT���� �ο� �Ǿ��ִٸ�, DEFAULT���� ����!!

-- ��ǰ�� ���� �����͸� ������ ���̺�(��ǰ��ȣ, ��ǰ��, �귣���, ����, ������)

CREATE TABLE PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(20) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 10
);

INSERT INTO PRODUCT VALUES(1,'������','�Ｚ',1300000,100);
INSERT INTO PRODUCT(PRODUCT_NO, PRODUCT_NAME, BRAND) VALUES(2,'������12PRO','����');
INSERT INTO PRODUCT VALUES(3,'�����е�','����',2500000, DEFAULT);

SELECT * FROM PRODUCT;

---------------------------------------------------------------------------------

/*
    !!!!!!!!!!!!!!!!!!!!!!!!!!! KH�������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    <SUBQUERY �̿��� ���̺� ����(���̺� ����)>
    
    [ǥ����]
    CREATE TABLE ���̺��
    AS ��������;
    
*/

-- EMPLOYEE ���̺� ������ ���ο� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
--> �÷�, ����ִ� �����Ͱ�, �������� ���� ���� NOT NULL�� �����!
SELECT * FROM EMPLOYEE_COPY;


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE 1=0;  -->������ ���� , ������ �����ϰ� ���� ���� ��!
    
SELECT * FROM EMPLOYEE_COPY2; 

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME,SALARY, SALARY*12 "����"
    FROM EMPLOYEE;
--> �������� SELECT���� �������� �Ǵ� �Լ��� ����� ��� �ݵ�� ��Ī �����ؾ���!    
    
SELECT * FROM EMPLOYEE_COPY3; 

---------------------------------------------------------------------------------



