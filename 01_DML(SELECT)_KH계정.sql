
-- ���� �ּ�


/*
    < SELECT >
    �����͸� ��ȸ�� �� ���Ǵ� ��ɾ� (DML, DQL)
    
    >> RESULT SET : SELECT���� ���� ��ȸ�� �����
    
    [ǥ����]
    SELECT ��ȸ�ϰ����ϴ� �÷�, �÷�, �÷�.... 
    FROM ���̺��;
    
    
*/


-- EMPLOYEE ���̺�κ��� ��ü ��� ��� �÷� ���� ��ȸ
SELECT *
FROM EMPLOYEE;

-- JOB ���̺�κ��� ��ü ������ ��ü �÷� ��ȸ
SELECT *
FROM JOB;

-- DEPARTMENT ���̺�κ��� ��ü �μ��� ��ü �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

-- EMPLOYMEE ���̺�κ��� ��ü ������� ���, �̸�, �޿����� ��ȸ
-- SELECT ���� ��ȸ�ϰ��� �ϴ� �÷����� ����

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DEPARTMENT ���̺�κ��� �μ����̵�, �μ����� ��ȸ

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- EMPLOYEE ���̺�κ���, �����, �̸���, ��ȭ��ȣ, �Ի��� ������ ��ȸ

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- Ű����, ���̺��, �÷��� ��� ��ҹ��ڸ� ������ �ʴ´�.( ��, ���� ����ִ� �����Ͱ��� ��ҹ��ڸ� ������.)

----------------------------------------------------------------------------------------------


/*
    < �÷����� ���� �������>
    
    SELECT ���� ���������(+-/*)�� �����ؼ� �������� ��� ��ȸ ����!
*/

-- EMPLOYEE ���̺�κ��� ������, �޿�, ������ ���� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������, �޿�, ���ʽ�, ������ ����, ���ʽ� ���Ե� ����
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;
--> ������� �߿� NULL���� ������ ��� ������� ��������� ������ NULL������ ��ȸ��!!

-- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���ĵ� ���� ����
-- ���� ��¥ : SYSDATE(DATE ���� == ����� �ú���)

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------

/*

    <�÷��� ��Ī �����ϱ�>
    
    [ǥ����]
    �÷��� AS ��Ī  | �÷��� AS "��Ī" | �÷��� ��Ī  | �÷��� "��Ī"
    
    AS�� ���̵� �Ⱥ��̵� �ο��ϴ� ��Ī�� Ư������, ���Ⱑ ���� ��� �ݵ�� "" �ٿ����Ѵ�.
*/

SELECT EMP_NAME AS �̸� , SALARY AS "�޿�" , BONUS ���ʽ�,
       SALARY*12 "����(��)",  (SALARY + (SALARY*BONUS))*12 "�� �ҵ�(��)"
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------

/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ� (**)�� SELECT���� ����ϸ�
    ���� �� ���̺� �����ϵ� ������ó�� ��ȸ����

*/

-- EMPLOYEE ���̺��� ���, �����, �޿�, ����('��') ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' ����
FROM EMPLOYEE;
--> SELECT ���� ������ ���ͷ� ���� ��ȸ����� ��� �࿡ �ݺ������� ��µ�


/*
    <DISTINCT>
    �÷��� ���Ե� �ߺ����� �� �ѹ����� ǥ���ϰ��� �� �� ���
    (��, SELECT���� �� �Ѱ��� ���� ����)
    
*/

-- EMPLOYEE���̺��� �μ��ڵ� ��ȸ (���� ������� � �μ��� �����ִ���)
SELECT DEPT_CODE
FROM EMPLOYEE;


-- EMPLOYEE���̺�κ��� �ߺ������� �μ��ڵ� ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;


-- EMPLOYEE���̺�κ��� �ߺ������� �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
--> DEPT_CODE���̶� JOB_CODE���̶� ��Ʈ�� ��� �ߺ��Ǻ�!


/*

    <WHERE ��>
    
    ��ȸ�ϰ��� �ϴ� ���̺��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ����ϴ� ����

    [ǥ����]
    SELECT ��ȸ�ϰ����ϴ� �÷�, �÷�, �÷�, ...
    FROM ���̺��
    WHERE ���ǽ�;
    
    -> ���ǽĿ� �پ��� ������ ��� ����
    
    <�� ������>

    >, <, >=, <=    -> ��Һ�
         =          -> �����
     !=, ^=,<>      -> ���� �ʴ�. 

*/

-- EMPLOYEE ���̺��� �޿��� 400���� �̻��� ����鸸 ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� ����� ��ȸ

SELECT EMP_NAME, DEPT_CODE, SALARY      -- 3
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE = 'D9';                 -- 2

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D9';

------------------------------------�ǽ�����----------------------------------


-- 1. EMPLOYEE ���̺��� �޿��� 300���� �̻� �������� ������, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME,SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE 3000000 <= SALARY; 

-- 2. EMPLOYEE���̺��� �������� �������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_NO, EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 3. EMPLOYEE���̺��� �����ڵ尡 J2�� �������� ������, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 4. EMPLOYEE���̺��� ������ 5000���� �̻��� �������� ������, �޿�, ����, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12 ����, HIRE_DATE
FROM EMPLOYEE               
WHERE SALARY*12 >= 50000000;


/*
    <��������>
    �������� ������ ���� �� ���
    AND(~�̸鼭, �׸���), OR(~�̰ų�, �Ǵ�)
*/

-- �μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� �������� ������, �μ��ڵ�, �޿���ȸ
SELECT EMP_NAME, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;


-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ���� ������, �μ��ڵ� �޿� ��ȸ

SELECT EMP_NAME, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;


-- �޿��� 350���� �̻��̰� 600���� ������ �������� ������, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;





