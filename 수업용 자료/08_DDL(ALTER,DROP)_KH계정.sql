/*
    * DDL(DATA DEFINITION LANGUAGE)
    ������ ���� ���
    
    <ALTER>
    ��ü���� �����ϴ� ����
    
    >> ���̺� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� ������ ����;
    
    
    - ������ ���� - 
    1) �÷� �߰� / ���� / ����
    2) �������� �߰� / ���� => ������ �Ұ�  (�����ϰ��� �Ѵٸ�, ������ �� ���� �߰�!)
    3) ���̺�� / �÷��� / �������Ǹ� ����
    
*/

-- 1) �÷� �߰�/ ����/ ����
-- 1-1) �÷� �߰� ADD : ADD �÷��� ������ Ÿ�� [DEFALUT �⺻��];

SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� , �⺻������ NULL������ ä����

-- LNAME �÷� �߰� (�⺻�� �߰�!)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
--> ���ο� �÷��� ���������, ���� ������ �⺻������ ä����!


-- 1_2) �÷� ���� (MODIFY)
--      ������ Ÿ�� ���� : MODIFY �÷��� �ٲ� ������ Ÿ��
--          �⺻�� ���� : MODIFY �÷��� DEFAULT �ٲ� �⺻��
SELECT * FROM DEPT_COPY;

-- DEPT_ID �÷��� ������ Ÿ���� CHAR(3)���� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- DEPT_TITLE �÷��� ������ Ÿ���� VARCHARS2(40)���� ����,
-- LOCATION_ID �÷��� ������ Ÿ���� VARCHAR2(2)���� ����,
-= LNAME �÷��� �⺻���� '�̱�'���� ����

ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID  VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';
--> ���� ���� ����

-- 1_3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ� �÷���
--      ������ ��: ���̺��� �ּ� �Ѱ� �÷� �����ؾ���

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- CNAME, LNAME �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;


ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID; --> �ּ� �Ѱ��� �־����

ALTER TABLE DEPARTMENT DROP COLUMN DEPT_ID;
--> �����ǰ� �ִ� �÷��� ���� �Ұ�

-----------------------------------------------------------------------------

-- 2) �������� �߰� / ����
-- PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
-- FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��(������ �÷���); 
-- UNIQUE      : ALTER TABLE ���̺�� ADD UNIQUE;
-- CHECK       : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ����); 
-- NOT NULL    : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;

-- DEPT_COPY ���̺�

-- DEPT_ID�� PRIMARY KEY ���� ���� �߰�    (ADD)
-- DEPT_TITLE�� UNIQUE �������� �߰�       (ADD)
-- LNAME�� NOT NULL ���� ���� �߰�         (MODIFY)

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID)
ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE (DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

-- 2_2) �������� ���� : DROP CONSTRAINT �������Ǹ� / MODIFY �÷��� NULL 

-- DCOPY_PK �������� ����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_DTITLE_UQ �����, LNAME �÷� �ٽ� NULL �����ϰ�!
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DTITLE_UQ
MODIFY LNAME NULL;

----------------------------------------------------------------------------------

-- 3) �÷���/ ���̺�� / �������Ǹ� ���� (RENAME)


-- 3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ� �÷���
-- DEPT_TITLE --> DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ� �������Ǹ�
-- SYS_C007075 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007075 TO DCOPY_LID_NN;

-- 3_3) ���̺�� ���� : RENAME TO �ٲ����̺��;
-- DEPT_COPY --> DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
SELECT * FROM DEPT_TEST;

----------------------------------------------------------------------

-- ���̺� ���� : DROP TABLE ���̺�� [CASCADE CONSTRAINT]
-- ������ �� : ��𼱰� �����ǰ� �ִ� �θ����̺��� �Ժη� �����ȵ�!!
-- ���� ������ ���1 : �ڽ����̺� ���� ������ �θ����̺��� �����ϴ� ���
-- ���� ������ ���2 : �θ����̺� ���� �� �������ǵ� �Բ� ����

DROP TABLE DEPT_TEST CASCADE CONSTRAINT;




