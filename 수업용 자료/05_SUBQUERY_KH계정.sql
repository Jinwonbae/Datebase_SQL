
/*
    * SUBQUERY(��������)
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SELECT ��
    - ���� SQL���� ���� ���� ���� �ϴ� ������

*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ����� ������� ������� �̸� ��ȸ

-- 1) ���� ���ö ����� �μ��ڵ�


SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; --> 'D9' �ΰ��� �˾Ƴ�

-- 2) �μ��ڵ� D9�� ��� ��ȸ

SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� 2�ܰ踦 �ϳ��� ������!

SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                        WHERE EMP_NAME = '���ö');


-- ���� �������� ���� 2

-- �� ������ ��� �޿� ���� �� ���� �޿��� �޴� ��� ��ȸ ���, �̸�, �����ڵ�, �޿�

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--------------------------------------------------------------------------------------

/*

    * �������� ����
        ���������� ������ ������� ���� ��̳� ���� �з���
        
        - ������ [���Ͽ�] �������� : ���������� ��ȸ ������� ������ ������ 1���� ��
        - ������ [���Ͽ�] �������� : ���������� ��ȸ ������� ����� ������ �� ��
        - [���Ͽ�] ���߿� �������� : ���������� ��ȸ ������� �� �������� ������ ������ �� ��
        - ������ ���߿� ��������   : ���������� ��ȸ ������� ���� �� ���� �÷� �� ���
        
        > ���������� ������� ���� ��� ���� ��밡���� �����ڰ� �޶���
        
*/


/*
    1. ������ ��������(SINGLE ROW SUBQUERY)
        ���������� ��ȸ ����� ������ 1�� �� ��
        
        �Ϲ� ������ ��� ����
        
        
*/

-- �� �������� ��� �޿����� �� ���� �޴� ���� ��ȸ �����, ���� �ڵ� , �޿�

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY <= (SELECT AVG(SALARY)     -->  ����� 1�� 1�� 
                    FROM EMPLOYEE);     
                    
                    
 -- ���� �޿��� �޴� ����� ���, �̸�, ���� �ڵ�, �޿� , �Ի��� ��ȸ
 SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
 FROM EMPLOYEE
 WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
 
 -- ���ö ����� �޿����� �� ���� �޴� ��� ���, �̸� , �μ��ڵ�, �����ڵ�, �޿�
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY , DEPT_TITLE, JOB_NAME
 FROM EMPLOYEE E
 JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID)
 JOIN JOB J USING(JOB_CODE)
 WHERE SALARY >  (SELECT SALARY 
                  FROM EMPLOYEE 
                  WHERE EMP_NAME = '���ö');
                 
 
-- �������� ���� �μ��� ������� ��ȸ ���, �����, ��ȭ��ȣ, �μ���
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = (SELECT DEPT_TITLE 
                    FROM EMPLOYEE E
                    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
                    WHERE EMP_NAME = '������') AND
                    EMP_NAME != '������';
 
                    
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMPLOYEE
                     WHERE EMP_NAME = '������') 
    AND EMP_NAME != '������';
    
    
 -- �μ��� �޿����� ���� ū �μ��� ��ȸ �μ��ڵ�, �޿���
 
 -- �� �μ��� �޿���
 SELECT DEPT_CODE, SUM(SALARY)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);
 ----------------------------------------------------------------------------------------
 
 /*
    2. ������ �������� (MULITI ROW SUBQERY)
       ���������� ��ȸ ������� ������ �� ��
       
       - IN �������� / NOT IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� ������  / ���ٸ� �̶�� �ǹ�
       - > ANY �������� : �������� ����� �߿��� "�ϳ���" Ŭ���
                        �������� ����� �߿��� ���� ���� �� ���� Ŭ���
                        
       - < ANY �������� : �������� ����� �߿��� "�ϳ���" Ŭ���
                         �������� ����� �߿��� ���� ū ������ ���� ���
                         
       - > ALL �������� : �������� ����� "��� ��" ���� Ŭ ���
                        �������� ����� �߿��� ���� ū ������ Ŭ ���
                        
       - < ALL �������� : �������� ����� "��� ��" ���� ���� ���
                        �������� ����� �߿��� ���� ���� ������ ���� ���
                        
 */                       
                        
-- �μ��ڵ尡 D5, D6, D7�� ����� ��ȸ

SELECT *
FROM EMPLOYEE;
--WHERE DEPT_CODE IN ('D5','D6','D7');

 
-- �� �μ��� �ְ�޿� ���� �̸�, ���� �ڵ�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--> �� �μ���  �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--> ���� �޿� �޴� ���  ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000,3660000,8000000,3760000,3900000,2490000,2550000);
 
--> ���ļ� �ϳ��� ����������!!
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY) --> ������� ������ 1��
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);


-- ��� => �븮 => ���� => ���� => ���� ...
-- �븮 �����ӿ��� �ұ��ϰ� ���� ���޵��� �ּұ޿� ���� ���� �޴� ���� ��ȸ ���, �̸�, ����, �޿� 

-->> ���� ������ �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '����';        --> 2200000,2500000,3760000

--> ������ �븮�̸鼭, �޿����� ���� ��ϰ� �߿� �ϳ��� ū ���
--> �ϳ��� ���ĺ��� !!
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '�븮' 
    AND SALARY > ANY(SELECT SALARY     
                     FROM EMPLOYEE E
                     JOIN JOB J USING(JOB_CODE)
                     WHERE J.JOB_NAME = '����');
    -- SALARY > 2200000 OR SALARY >2500000 OR SALARY > 3760000   
    -- ANY�� OR�� ���
    
--> ���� �� ���� ������ �� ���� = ���� ������ �޿� �ּҰ����� ũ��.
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '�븮' 
    AND SALARY >    (SELECT MIN(SALARY)         --> ����� 1��
                     FROM EMPLOYEE E
                     JOIN JOB J USING(JOB_CODE)
                     WHERE J.JOB_NAME = '����');
                     
 
 
-- ���� �����ӿ��� �ұ��ϰ� ���� ������ �ִ� �޿����� �� ���� �޴� ��� ��ȸ (���, �����, ���޸�, �޿�)
--1)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '����'
    AND SALARY > ALL (2800000,1550000,2490000,2480000);
                -- AND
                -- SALARY > 280�� AND SALARY > 155�� AND SALARY > 248��
                
--2)                
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '����'
    AND SALARY > ALL (SELECT SALARY
                      FROM EMPLOYEE E
                      JOIN JOB J USING(JOB_CODE)
                      WHERE J.JOB_NAME = '����');
                      
--3) -- ������ ���� ������!!    
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '����'
    AND SALARY >     (SELECT MAX(SALARY)
                      FROM EMPLOYEE E
                      JOIN JOB J USING(JOB_CODE)
                      WHERE J.JOB_NAME = '����');
                      
------------------------------------------------------------------------------------------------
/*
    3. [������] ���߿� �������� 
        ��ȸ ������� ����������, ������ �÷� ���� ������ �� ��
*/

-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ������� ��ȸ

-->> ������ ����� �����ڵ�, �μ��ڵ� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';     --> D5/J5

-->> �μ��ڵ尡 D5, �����ڵ� J5 ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM employee
WHERE DEPT_CODE = 'D5' 
    AND JOB_CODE = 'J5';

--> �ϳ��� ���������� (�����༭������)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
   AND JOB_CODE = (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME ='������');                

--> �ϳ��� ������ (���߿� ��������)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE   --> ����� 1�� ������
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������');



-- �ڳ��� ����� �����ڵ尡 ��ġ�ϴ� ���� ����� ������ �ִ� ��� ��ȸ (���, �̸� ,�����ڵ�, ������)
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID --> ����� 1�� ������
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');

--------------------------------------------------------------------------------- 

/*
    4. ������ ���߿� ��������
        �������� ��ȸ ������� ������ ������ ���
*/
                      
-- 1) �� ���޺��� �ּ� �޿� �޴� ��� ���, �̸�, �����ڵ�, �޿� 

-->> �� ���޺� �ּ� �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) = ('J2',3700000)
    OR (JOB_CODE,SALARY) = ('J7',1380000)
    OR (JOB_CODE,SALARY) = ('J4',1550000)

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE, MIN(SALARY)        --> ������ ���߿�
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE)
ORDER BY JOB_CODE;

-- �� �μ��� �ְ�޿� �޴� ����� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------------

/*
    5. �ζ��� �� (INLINE-VIEW)
        FROM ���� ���������� �����ϴ� ��
        
        ���������� ������ ��� ���̺� ��� �����!!
*/

-- ���ʽ� ���� ������ 3000���� �̻��� ������� ���, �̸�, ���ʽ����� ����, �μ��ڵ� ��ȸ
SELECT EMP_ID,EMP_NAME, (SALARY + NVL(BONUS, 0)*SALARY)*12 ���ʽ����Կ���,DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + NVL(BONUS, 0)*SALARY)*12 >= 30000000;

SELECT EMP_ID, EMP_NAME, ���ʽ����Կ���
FROM (SELECT EMP_ID,EMP_NAME, (SALARY + NVL(BONUS, 0)*SALARY)*12 ���ʽ����Կ���,DEPT_CODE
      FROM EMPLOYEE)
WHERE ���ʽ����Կ��� >= 30000000;


-->> �ζ��� �並 �ַ� ����ϴ� ��
--  *TOP-N �м�

-- ������ �� �޿��� ���� ���� ���� 5��

-- * ROWNUM : ����Ŭ���� �⺻������ �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM,EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- FROM -> SELECT(���ĵǱ����� ROWNUM) => ORDERBY
-- ������ ���׹���


--> ORDER BY�� ������� ������ ROWNUM�ο��Ұ�.

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT ROWNUM,EMP_NAME, SALARY, DEPT_CODE
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <=10;


SELECT ROWNUM ����, E.*
FROM (SELECT EMP_NAME, SALARY, DEPT_CODE
      FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <=10;


-- �� �μ��� ��ձ޿��� ���� 3���� �μ� ��ȸ �μ��ڵ�, ��ձ޿�
SELECT ROWNUM ����, DEPT_CODE, ROUND(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) ��ձ޿�
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY ��ձ޿� DESC)
WHERE ROWNUM <=3;
    
----------------------------------------------------------

/*
    6. ���� �ű�� �Լ�
    RANK() OVER(���ı���)       /   DENSE_RANK() OVER(���ı���)
    
    - RANK() OVER(���ı���) : EX) ���� 1���� 3���̸�, �� ���������� 4��
    - DENSE_RANK() OVER(���ı���) : EX) ���� 1���� 3���̴��� �� ���������� 2��
    
    * SELECT������ ���԰���
    
*/


-- ����� �޿��� ���� ������� ���� �Űܼ�, �����, �޿�, ���� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;
--> ���� 19�� 2�� �� ���� ���� 21��

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;
--> ���� 19�� 2�� �� ���� ���� 20��

-- ���� 5�� ��ȸ
SELECT *

FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
      FROM EMPLOYEE)
      
WHERE ���� <= 5;
--> ���� �ű�� �Լ��� SELECT������ ��� ����