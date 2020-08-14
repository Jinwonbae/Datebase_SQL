/*
    <TCL : TRANSACTION CONTROL LANGUAGE>
    Ʈ������� �����ϴ� ���
    
    * Ʈ�����
    - �����ͺ��̽��� ���� �������
    - ������ �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
      COMMIT �ϱ� ������ ������׵��� �ϳ��� Ʈ����ǿ� ��Ե�
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)  

    COMMIT(Ʈ����� ����ó�� �� Ȯ��), ROLLBACK(Ʈ����� ���), SAVEPOINT(�ӽ� ����)
    
    COMMIT : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڼ�!
    ROLLBACK ���� : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ������ �� ������ COMMIT �������� ���ư�!
    
    SAVEPOINT : �ӽ��������� �������ִ� ��
                ROLLBACK ����� ��ü�۾��� �� �����ϴ°� �ƴ� SAVEPOINT���� �Ϻθ� �ѹ� ����
                
                SAVEPOINT ����Ʈ��1;        -- ������ ����
                ROLLBACK TO ����Ʈ��1;      -- �ش�����Ʈ ���������� Ʈ����Ǹ� �ѹ�
*/




-- ����� 901 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 901;
-- ����� 900 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 900;

---------------------------------------------

-- 200�� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 800, ȫ�浿, �ѹ��� ��� �߰�
INSERT INTO EMP_01 VALUES(800,'ȫ�浿','�ѹ���');

COMMIT;

SELECT * FROM EMP_01;


----------------------------------------------------------
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(30)
);




SELECT EMP_ID, EMP_NAME, DEPT_TITLE

FROM EMPLOYEE

LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

-- 217, 216, 214 ��� �����
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 3�� ���� ������ ������ SAVEPOINT ����
SAVEPOINT SP1;


-- 801, '�踻��', '�λ��'
INSERT INTO EMP_01 VALUES(801, '�踻��', '�λ��');

-- 218�� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 218;


ROLLBACK TO SP1;
COMMIT;

---------------------------------------------------------------------------------------

-- 900�� 901�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

-- 218�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- ���̺� ���� (DDL)
CREATE TABLE TEST (
    TID NUMBER
);

--> DDL����(CREATE, ALTER, DROP)�� �����ϴ� ���� ������ Ʈ����ǿ� �ִ� ��������� ������ ���� DB�� �ݿ��ع���!
--> ��, DDL ���� �� ������׵��� �־��ٸ� ��Ȯ�� �Ƚ�(COMMIT, ROLLBACK) �Ұ�!

ROLLBACK;
SELECT * FROM EM_01;