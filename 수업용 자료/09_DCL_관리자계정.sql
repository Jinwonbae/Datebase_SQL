/*
    <DCL : DATA CONTROL LANGUAGE>
    �����͸� �����ϴ� ���
    
    ��������  �ý��� ���� �Ǵ� ��ü ���� ������ �ο�(GRANT)�ϰų�, ȸ��(REVOKE)�ϴ� ���
    
    > �ý��� ���� : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
    > ��ü ���� ���� : Ư�� ��ü�� ���� �� �� �ִ� ����
    
    > �ý��۱��� ���� <
    - CREATE SESSION : ������ ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �� ������ �� �ִ� ����
    - CREATE SEQUENCE : ������ ������ �� �ִ� ����
    - ......
    
    
    [ǥ����]
    GRANT ����1, ����2, .. TO ������;
*/

-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 2. ������ �����ϱ� ���ؼ� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;
-- 3_1. ������ ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;
-- 3_2. ���̺� �����̽� �Ҵ��������! (SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- 4. ������ �� ���� ���� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

/*
    > ��ü ���� ����<
    Ư�� ��ü�� ������ �� �ִ� ����
    
    ��������   Ư����ü
    SELECT    TABLE, VIEW, SEQUENCE
    INSERT    TABLE, VIEW
    UPDATE    TABLE, VIEW
    DELETE    TABLE, VIEW
    ...
    
    [ǥ���]
    GRANT �������� ON Ư����ü TO ������;
    
*/

-- 5. �������� KH.EMPLOYEE ��ȸ ���� �ο�!
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. �������� KH.DEPARTMENT���̺� ����(INSERT)�� �� �ִ� ���� �ο�!
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--------------------------------------------------------------------

GRANT CONNECT, RESOURCE TO ������;

/*
    < �� ROLE >
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : CREATE SESSION
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ...
        
*/

SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');


-- �Ϲ� ����� ���� ������ CONNECT, RESOURCE ������ �ּ����� ���� �ο��� ��!

