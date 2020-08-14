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


