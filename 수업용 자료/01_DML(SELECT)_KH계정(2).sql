SELECT *
FROM EMPLOYEE;

/*

?	<BETWEEN AND>

?	���̻� �������� ������ ���� ���� ������ �� ���

?	[ǥ����]

?	WHERE �񱳴�� �÷��� BETWEEN ���� AND ����;

*/



SELECT EMP_NAME, EMP_ID, JOB_CODE

FROM EMPLOYEE

WHERE SALARY BETWEEN 3500000 AND 6000000;



350 �̸�, 600 �̸� �ϰ�쿡��



WHER SALARY NOT BETWEEN 3500000 AND 6000000;





-- BETWEEN AND �����ڴ� DATE ���Ŀ��� ��밡��

-- �Ի��� '90/01/01' ~ '01/01/01' ��� �÷� ��ȸ

SELECT *

FROM EMPLOYEE

WHERE HIRE DATE BETWEEN '90/01/01' AND '01/01/01';







/*

?	<LIKE 'Ư������'>

?	���Ϸ��� �÷� ���� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ

?	- Ư�����Ͽ� '%', '_'�� ���ϵ� ī��� ��� �� �� ����

	> '%' : 0���� �̻�
	>
	> EX) 	�񱳴���÷��� LIKE '����%' => �÷��� �߿� '���� '�� ���۵Ǵ� ���� ��ȸ�Ѵ�!
        	�񱳴���÷��� LIKE '%����' => �÷��� �߿� '����'�� ������ ���� ��ȸ�Ѵ�!
            �񱳴���÷��� LIKE '%����%' => �÷��� �߿� '����'�� "����"�Ǵ� ���� ��ȸ
            
    > '_' : 1����
    EX)     �񱳴���÷��� LIKE '_����' => �÷��� �߿� '���� '�տ� ������ �ѱ��ڰ� �� ��� ��ȸ!
            �񱳴���÷��� LIKE '__����' => �÷��� �߿� '���� '�տ� ������ �α��ڰ� �� ��� ��ȸ!
    
*/

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';


-- �̸� �� '��' �� ���Ե� ��� ����� , �ֹι�ȣ, �μ��ڵ� ��ȸ
 SELECT EMP_NAME, EMP_NO, DEPT_CODE
 FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- �̸��� �߿� _�ձ��ڰ� 3������ �̸��� �ּҸ� ���� ������� ���, �̸�, �̸��� ��ȸ
-- �̸��� 4��° �ڸ��� _�� �����ϴ� ���
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';  -- ���ϵ� ī��� ���Ǵ� ���ڿ� ���� ����ִ� �÷����� ������ ��� ���� �߻�

-- ��� ���ϵ� ī��� ��� ������ ������ ���������ָ��!!
-- �����Ͱ����� �νĽ�ų �� �տ� ���Ƿ� ������ ���ϵ� ī�� ����, ������ ���ϵ�ī�带 ESCAPE�� ���


-- �达 ���� �ƴ� ������� ���, �����, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE NOT EMP_NAME LIKE '��%';
WHERE EMP_NAME NOT LIKE '��%';

------------------------------------------------------ ���� �ǽ� ����

-- 1. �̸� ���� '��'���� ������ ��� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. ��ȭ ��ȣ ó�� 3���ڰ� 010�� �ƴ� ��� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%'

-- 3. �μ����̺��� �ؿ� ������ ��� Į�� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

-----------------------------------------------------------------------------------

/*
    < IS NULL  /  IS NOT NULL>
    
    [ǥ����]
    �񱳴���÷� IS NULL : �÷����� NULL�� ���
    �񱳴���÷� IS NOT NULL : �÷����� NULL�� �ƴ� ���
    



*/

-- ���ʽ� ���� �ʴ� ��� ���, �̸� �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ����� ��ȸ�ϰڴ�!
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- ����� ���� ��� ���, ������, ���ʽ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- ����� ���� �μ���ġ�� ���� �ʴ� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ���ġ�� ���� �ʾ�� ���ʽ� �޴� ��� ��ȸ(�����, ���ʽ�, �μ��ڵ�)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-------------------------------------------------------------------------------------------


/*

    < IN >
    �񱳴���÷����� ��ϵ� �߿� ��ġ�ϴ� ���� �ִ���
    
    [ǥ����]
    �񱳴�� �ø� IN (��, ��, ��, ....)
    
    


*/



-- �μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �����, �μ��ڵ�, �޿� ��ȸ

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- �� ���� �����?

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE NOT DEPT_CODE IN ('D6', 'D8', 'D5');
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

---------------------------------------------------------------------------------

/*

    <���� ������ || >
    ���� �÷������� �ϳ��� �÷��ΰ�ó�� ��������ִ� ������
    �÷��� ���ͷ� (������ ���ڿ�)�� ������ ���� �ִ�.
    

*/

-- System.out.println("num : " + num);
-- +�� ���� �����̶�� ���� �ȴ�!


-- ���, �����, �޿��� �ϳ��� �÷����� ���ļ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- XXX�� XXX�� ������ XXXXX���Դϴ�.
SELECT EMP_ID || '�� ' || EMP_NAME || '�� ������ ' || SALARY || '���Դϴ�.' AS "���޸���"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*

    <������ �켱����>
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL,     LIKE,      IN
    5. BETWEEN AND
    6. NOT
    7. AND(��������)
    8. OR(��������)
    
*/

-- OR���� AND�� ���� ����

-- ���� �ڵ尡 J7�̰ų� �Ǵ� J2�� ����� �߿��� �޿��� 200���� �̻��� ����鸸 ��ȸ ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >= 2000000;
-- ��ȣ�� ���� ������ �����ڵ尡 J2�̸鼭 �޿��� 200�����̻��� �ֵ� + J7�ξֵ� ��� ��ȸ

/*
    3 : SELECT 
    1 : FROM
    2 : WHERE

*/

-----------------------------------------------------------------------

/*

    < ORDER BY �� >
    SELECT�� ���� �������� �����ϴ� ����
    SELECT�� ���� �������� �ۼ��ϴ� �� �Ӹ��ƴ϶� ���� ���� ���� ���� �������� ����
    [ǥ����]
    SELECT ��ȸ�� �÷�, �÷�.....
    FROM ��ȸ�� ���̺� ��
    WHERE ���ǽ�
    ORDER BY ���Ľ�Ű�����ϴ��÷��� |��Ī| �÷� ���� [ASC | DESC]    [NULLS FIRST|NULLS LAST]
    
    - ASC : �������� ���� (������ �⺻��)
    - DESC :  �������� ���� 
    
    - NULLS FIRST : �����ϴ� �÷����� NULL �� �Ǿ����� ����
    - NULLS LAST :  �����ϴ� �÷����� NULL �� �ǵڷ� ����
    
    
    ** ���� ���� **
    1. FROM ��
    2. WHERE ��
    3. SELECT ��
    4. ODER BY ��
    

*/
-- �� ������� ���ʽ��� �������� ���� ��ȸ
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; -- ASC �Ǵ� DESC ������ �⺻���� ASC

--ORDER BY BONUS ASC; -- �������� ������ �⺻������ NULLS LAST
--OREDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- �������� ������ �⺻������ NULLS FIRST
ORDER BY BONUS DESC, SALARY ASC; -- ù��° ������ ���� �÷����� ��ġ�� ���, �ι�° ������ ���ı����� ������ ����

-- ������ �������� ���ķ� ��ȸ(�����, ����)
SELECT EMP_NAME, SALARY*12 ����
FROM EMPLOYEE
--ORDER BY ���� DESC; -- ��Ī ���
ORDER BY 2 DESC;    -- �÷� ���� ���� ��� ����







