/*

    <   GROUP BY ��>
    �׷������ ������ �� �ִ� ����( �ش� �׷���غ��� �׷��� ���� �� �ִ�.)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���

*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --> ��ü ������� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

SELECT COUNT(*)
FROM EMPLOYEE;  --> ��ü ��� ��

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- �� �μ��� �� �޿����� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) -- 3.
FROM EMPLOYEE       -- 1.
GROUP BY DEPT_CODE      -- 2.
ORDER BY DEPT_CODE;     -- 4.

-- �� ���޺� �� �޿� ��
SELECT JOB_CODE ����, SUM(SALARY) �޿���, COUNT(*) �����, COUNT(BONUS) ���ʽ��޴»����,
        FLOOR(AVG(SALARY)) ��ձ޿�, MAX(SALARY) �����ְ�޿�,MIN(SALARY) ���������޿�
        
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;


-- �� �μ���, �ѻ����, ���ʽ� �޴� �����, �޿���, ��� �޿�, �ְ�޿�, �����޿�
SELECT DEPT_CODE �μ�,
        COUNT(*) �ѻ����,
        COUNT(BONUS) ���ʽ��޴»����,
        SUM(SALARY) �޿���,
        FLOOR(AVG(SALARY)) ��ձ޿�,
        MAX(SALARY) �ְ�޿�,
        MIN(SALARY) �����޿�
    FROM EMPLOYEE
 GROUP BY DEPT_CODE
 ORDER BY 1;
 
 
 -- ���� �÷��� �׷�������� ���� ����
 SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE, JOB_CODE -- �Ѵ� �����ϴ� �׷����� ������
 ORDER BY 1;

-------------------------------------------------------------------------


/*

        <HAVING ��>

        �׷쿡 ���� ������ ������ �� ���Ǵ� ����(�ַ� �׷��Լ��� ����� ������ �� ����)
        

*/

-- �� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE      
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>= 3000000;

-- �� ���޺� �ѱ޿����� 1000���� �̻��� ����, �޿��� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;


-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ��� ��ȸ
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;



------------------------------------------------------------------------------

/*
   5 SELECT *|��ȸ�ϰ���� �÷���|��������|�Լ���| [AS] "��Ī"
   1 FROM    ��ȸ�ϰ���� ���̺��
   2 WHERE   ���ǽ�
   3 GROUP BY �׷���ؿ� �ش��ϴ� �÷���, �÷���,...
   4 HAVING �׷��Լ��Ŀ� ���� ���ǽ�
   6 ORDER BY �÷���|��Ī|�÷����� [ASC|DESC] [NULLS FIRST | NULLS LAST];
    
*/


------------------------------------------------------------------------------


/*

    < ���� �Լ�>

    �׷캰 ������ ��� ���� �߰����踦 ������ִ� �Լ�
    
    
    ROLLUP, CUBE    (GROUP BY���� ���Ǵ� �Լ�)



*/

-- �� ���޺� �޿���

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ROLLUP

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (JOB_CODE)
ORDER BY JOB_CODE;

-- CUBE

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (JOB_CODE)
ORDER BY JOB_CODE;

-- �׷� �������� �ϳ��� �÷��� �����ϰ� �Ǹ� ROLLUP�̵� CUBE�� �� ���� ����
-- ������ �࿡ ��ü �� �޿��ձ��� ���� ����


------ ROLLUP�� CUBE�� ������ (�׷������ ��� �ΰ��̻� �÷��̿�����!)

-- �μ��ڵ�, ���� �ڵ� ���� ��� �׷� ���
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;         --> 13���� �׷�

-- ROLLUP(�÷�1, �÷�2) => �÷�1�� ������ �ٽ� �߰� ���踦 ���ִ� �Լ�
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;        



-- CUBE(�÷�1, �÷�2) => �÷�1�� ������ �߰�����, �÷�2�� ������ �߰����踦 ��
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;    

-------------------------------------------------------------------------

/*

        <���� ������>
        SET OPERATION
        
        �������� �������� ������ �ϳ��� ���������� ����� ������
        
        - UNION     : ������(�� ������ ������ ������� ���� �� �ߺ� �Ǵ� �κ��� �ѹ� �� ���) OR
        - INTERSECT : ������(�� ������ ������ ��� ���� �ߺ��� �����) AND
        - UNION ALL : ������ ������� �������� ������ ����(�� ������ ������ ������� ������ ����) => �ߺ��� ���� �ι� �� �� ����
        - MINUS     : ������(���� ������ ����� ���� ���� ������ ������� ���)
        
*/


-- 1. UNION
-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(���, �̸�, �μ��ڵ�, �޿�)

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- ���� ������ ��� �Ʒ�ó�� WHERE ���� ���ؼ��� �ذ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


-- �� �μ��� �޿��� (GROUP BY�� �̿�)
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--�� �μ��� �޿��� (UNION)
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D2'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';


-- 2. UNIONALL : �������� ���� ����� ������ ���ϴ� ������(�ߺ��� ����)
SELECT EMP_NO,EMP_NAME, DEPT_CODE, BONUS "���ʽ� �Ǵ� �޿�"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION ALL

SELECT EMP_NO,EMP_NAME, DEPT_CODE,  SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- 3. INTERSECT : (������)
-- �μ� �ڵ尡 D5�̸鼭 �׸��� �޿������� 300���� �ʰ��� ���

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

INTERSECT

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ����
SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;


-- 4. MINUS
--  �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ����� ������ �����

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 

MINUS

SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ����
SELECT EMP_NO,EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;

