/*
    <PL/SQL>
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL ���� ����
    �ټ��� SQL���� �ѹ��� ���� (BLOCK������!)
    
    * PL/SQL ����
    - [�����(DECLARE SECTION)] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - �����(EXCUTEABEL SECTION) : BEGIN���� ����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ ����ϴ� �κ�
    - [����ó����(EXCEPTION SECTION)] : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ� ���� ���� ���!
    
*/


-- * �����ϰ� ȭ�鿡 HELLO ORACLE ���

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;    
/
-----------------------------------------------------------

-- 1. DECLARE �����
-- ���� �� ��� ������ ���� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
-- �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���

-- 1_1) �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
--      [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��];

DECLARE 
    EID NUMBER; -- INT EID
    ENAME VARCHAR2(20);
    PI NUMBER := 3.14;

BEGIN 
    EID := 800;
    ENAME := '���峲';
    -- System.out.println("eid : " + eid);  -- eid : 800
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI );
END;    
/    

-------------------------------------------------------

--1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� ���̺��� � �÷��� ������Ÿ���� �����ؼ� ��Ÿ������ ����)
--      [ǥ����] ������ ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ ���� EID, ENAME, SAL ������ ���
    -- �������� (SELECT INTO�� �̿��ؼ� ��ȸ����� �� ������ ���Խ�Ű���� �Ѵٸ� �ݵ�� �Ѱ��� ������ ��ȸ)
    SELECT  EMP_ID, EMP_NAME, SALARY
    INTO    EID,ENAME,SAL
    FROM    EMPLOYEE
    --WHERE EMP_ID = 200;
    --WHERE   EMP_ID = &���;
    WHERE EMP_NAME = '&�̸�'; -- ��������!
    --> & ��ȣ�� ��ü����(���� �Է�)�� �Է��ϱ� ���� â�� �߰� ���ִ� ����
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    
END;
/
    
---------------------------------�ǽ�����--------------------------------

/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE �� ����
    �� �ڷ����� EMPLOYEE���̺� �� EMP_ID, EMP_NAME, JOB_CODE, SALARY �÷�����
              DEPARTMENT ���̺��� DEPT_TITLE�÷� Ÿ���� �����ϰԲ�
              
    ����ڰ� �Է��� ������ ��ġ�ϴ� ����� ��ȸ(���, �����, �����ڵ�, �޿�, �μ���) ��
    ��ȸ����� �� ������ ������ ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO   EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME = '&�����';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
    
END;
/
    
    
-----------------------------------------------------------------------------------

-- 1_3) ���̺��� �� �࿡ ���� Ÿ�� ���� ����(���̺��� �� �࿡ ���� ��� �÷� ���� �Ѳ����� ���� �� �ִ� ����)
--      [ǥ����] ������ ���̺�� 


DECLARE 
    E EMPLOYEE%ROWTYPE;
    

BEGIN
    
    SELECT *    -- ROWTYPE�� ������ *�� ��߾��Ѵ�!
    INTO E
    FROM EMPLOYEE
    WHERE EMP_NAME = '���ö';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('��ȭ��ȣ : ' || E.PHONE);
    
END;
/

-----------------------------------------------------------------------

-- 2. BEGIN

-- <���ǹ�>

-- 1) IF ���ǹ� THEN ���೻�� END IF; (���� IF��)
-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN

    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)   
    INTO   EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    IF(BONUS = 0) 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || (BONUS*100)||'%');

END;
/

-----------------------------------------------------------------------------

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� (IF-ELSE)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN

    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)   
    INTO   EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    IF(BONUS = 0) 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || (BONUS*100)||'%');
    END IF;
    
END;
/


-- �˻��� �ش� ����� ���, �̸�, �μ���, �����ڵ�(NATIONAL_CODE) ��ȸ�� �������
-- �ش����� ���, �̸�, �μ���, �Ҽ�(������/�ؿ���) ���


DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN

    SELECT EMP_ID , EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO   EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &���;
    
    /*
    SELECT EMP_ID , EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO   EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
    WHERE E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND EMP_ID = &���;
    
    
    */
    
 
    IF(NATIONAL_CODE = 'KO' ) 
        THEN TEAM := '������';
    ELSE  TEAM := '�ؿ���';
    END IF;
           
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);

END;
/

--------------------------------------------------------------------------

--3) IF ���ǽ�1 THEN ���೻�� 1 ELSEIF ���ǽ�2 THEN ���೻��2 .. ELSE ���೻��N END IF;


-- ����ڿ��� �Է¹��� �������� SCORE������ ������ ��
-- 90�� �̻� A / 80�� �̻� B / 70�� �̻� C/ 60�� �̻� D/ 60�� �̸� F ó�� �� GRADE������ ����
-- '����� ������ XX���̰�, ������ X���� �Դϴ�!' ����ϱ�


--------------------------------------------------------------------
-- <�ݺ���>

/*
    1) BASIC LOOP ��
    
    [ǥ����]
    LOOP
        �ݺ������� ������ ����
    
    END LOOP;
    
    --> �ݺ����� �������� ���� (2����)
        1) IF ���ǽ� THEN EXIT;
*/


-- 1~5���� ���������� 1�� �����ϴ� �� ���

DECLARE
    I NUMBER := 1;

BEGIN 

    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        
        IF I = 6 THEN EXIT; END IF;
        -- EXIT WHEN I = 6;
        
    END LOOP;
    
    
END;
/

----------------------------------------------------------------------

/*
    2) FOR LOOP��
    
    [ǥ����]
    FOR ���� IN [REVERSE] �ʱⰪ .. ������
    LOOP
        �ݺ������� ������ ����
    END LOOP;
    
*/

BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        
    END LOOP;

END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP    
        DBMS_OUTPUT.PUT_LINE(I);
        
    END LOOP;

END;
/

-- �ݺ����� �̿��� ������ ����
CREATE TABLE TEST2(
    NUM NUMBER PRIMARY KEY,
    TODAY DATE
);

CREATE SEQUENCE SEQ_TEST
START WITH 200
INCREMENT BY 1
MAXVALUE 500
NOCYCLE
NOCACHE;


SELECT * FROM TEST2;

BEGIN

    FOR I IN 1..100
    LOOP    
        INSERT INTO TEST2 VALUES (SEQ_TEST.NEXTVAL, SYSDATE);
    END LOOP;

END;
/


-- ��ø �ݺ���
-- ������(2~9��) ����ϱ�

DECLARE
    RESULT NUMBER;
    
BEGIN 
    
    -- �ٱ��� FOR���� �ܼ�(2~9)
    -- ���� FOR�� �������� �� (1~9)
    
    FOR DAN IN 2..9
    LOOP
    
    DBMS_OUTPUT.PUT_LINE('====' || DAN || '�� ====');
    
    FOR SU IN 1..9
    LOOP
        RESULT := DAN * SU;
        
        DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || '=' || RESULT);
        
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
    
    END LOOP;


END;
/

--------------------------------------------------------------------------------

/*
    3) WHILE LOOP
    
    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP
    
    END LOOP;
    

*/

DECLARE
    I NUMBER := 1;
    
BEGIN
    WHILE I < 6
    LOOP
    
    DBMS_OUTPUT.PUT_LINE(I);
    
    I := I +1;
    
    END LOOP;

END;
/


-------------------------------------------------------------------------

/*
    3) ����ó���� (EXCEPTION)
     
    ����(EXCEPTION) : ���� �� �߻��ϴ� ����
        
        try {
        } catch (�θ𿹿� Ŭ���� �Ű�����) {
        }
        
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ....
        WHEN OTHERS THEN ����ó������N;
        
  
    * �ý��� ���� (����Ŭ���� �̸����� �Ǿ��ִ� ����)
    - NO_DATA_FOUND : SELECT�� ����� �� �൵ ���� ���
    - TOO_MANY_ROWS : SELECT�� ����� �������� ��
    - ZERO_DIVIDE   : 0���� ���� ��
    - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ����Ǿ��� ���
    ....
    
*/


-- ����ڰ� �Է��� ���� ������ ������ ��� ���

DECLARE
    RESULT NUMBER;

BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ���� �� �� 0 ���� �����!');
    
END;
/


-- UNIQUE �������� �����

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME = '���ö';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����̾�!');
END;
/

SELECT * FROM EMPLOYEE;
ROLLBACK;


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
EXCEPTION
    --WHEN NO_DATE_FOUND THEN DBMS_OUTPUT.PUT_LINE('��ȸ��� ����!');
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���ε�?');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('��...���ܴ�!!');

END;
/
