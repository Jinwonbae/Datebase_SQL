-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�

-- ORACLE
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������,
       E.SALARY �޿�

FROM EMPLOYEE E,
     JOB J,
     DEPARTMENT D,
     LOCATION L
     
WHERE   E.JOB_CODE = J.JOB_CODE
    AND J.JOB_NAME = '�븮'
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.LOCAL_NAME LIKE 'ASIA%';

-- ANSI

SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������,
       E.SALARY �޿�
       
FROM EMPLOYEE E

JOIN JOB J USING(JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)

WHERE J.JOB_NAME = '�븮' 
    AND L.LOCAL_NAME LIKE 'ASIA_';


-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�

-- ORACLE

SELECT E.EMP_NAME �����,
       E.EMP_NO �ֹι�ȣ,
       D.DEPT_TITLE �μ���,
       J.JOB_NAME ���޸�
       
 FROM EMPLOYEE E, DEPARTMENT D, JOB J
 
 WHERE E.JOB_CODE = J.JOB_CODE
    AND E.DEPT_CODE = D.DEPT_ID
    AND SUBSTR(E.EMP_NO,1,1) = '7'
    AND SUBSTR(E.EMP_NAME,1,1) = '��'
    AND SUBSTR(E.EMP_NO,8,1) = '2';


-- ANSI

SELECT E.EMP_NAME �����,
       E.EMP_NO �ֹι�ȣ,
       D.DEPT_TITLE �μ���,
       J.JOB_NAME ���޸�
 
 FROM EMPLOYEE E
 
 JOIN JOB J USING(JOB_CODE)
 JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)

 WHERE SUBSTR(E.EMP_NO,1,1) = '7' 
    AND SUBSTR(E.EMP_NAME,1,1) = '��'
    AND SUBSTR(E.EMP_NO,8,1) = '2';



-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�

-- ORACLE
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_NAME ���޸�
       
   FROM EMPLOYEE E,
        JOB J
   
   WHERE E.JOB_CODE = J.JOB_CODE
    AND E.EMP_NAME LIKE '%��%';

-- ANSI
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_NAME ���޸�
   
   FROM EMPLOYEE E
   
   JOIN JOB J USING(JOB_CODE)
   
   WHERE E.EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�

-- ORACEL
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       D.DEPT_ID �μ��ڵ�,
       D.DEPT_TITLE �μ���

 FROM EMPLOYEE E, 
      JOB J,
      DEPARTMENT D
 
 WHERE E.JOB_CODE = J.JOB_CODE 
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.DEPT_TITLE LIKE '�ؿܿ���%'
 
 ORDER BY �μ���;
    
--ANSI
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       D.DEPT_ID �μ��ڵ�,
       D.DEPT_TITLE �μ���

 FROM EMPLOYEE E
 
 JOIN JOB J USING(JOB_CODE)
 JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
 
 WHERE D.DEPT_TITLE LIKE '�ؿܿ���%'
 
 ORDER BY �μ���;


-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�

-- ORACLE
SELECT E.EMP_NAME �����,
       E.BONUS ���ʽ�,
       E.SALARY*12 ����,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������
       
  FROM EMPLOYEE E,
       DEPARTMENT D,
       LOCATION L
  
  WHERE E.BONUS IS NOT NULL
    AND E.DEPT_CODE = D.DEPT_ID(+) 
    AND D.LOCATION_ID = L.LOCAL_CODE(+);
    
 

-- ANSI
SELECT E.EMP_NAME �����,
       E.BONUS ���ʽ�,
       E.SALARY*12 ����,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������
       
  FROM EMPLOYEE E
  
  LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  
  WHERE E.BONUS IS NOT NULL;


-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- ORACLE
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������
       
   FROM EMPLOYEE E,
        JOB J,
        DEPARTMENT D,
        LOCATION L
        
   WHERE    E.JOB_CODE = J.JOB_CODE 
        AND E.DEPT_CODE = D.DEPT_ID  
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND E.DEPT_CODE IS NOT NULL;

-- ANSI

SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������
       
   FROM EMPLOYEE E
   
   JOIN JOB J USING(JOB_CODE)
   JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
   
   WHERE E.DEPT_CODE IS NOT NULL;


-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�

-- ORACLE
SELECT E.EMP_NAME �����,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������,
       N.NATIONAL_NAME �ٹ�������
       
  FROM EMPLOYEE E,
       DEPARTMENT D,
       LOCATION L,
       NATIONAL N
       
  WHERE E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND (N.NATIONAL_NAME = '�Ϻ�' OR N.NATIONAL_NAME = '�ѱ�');

-- ANSI       
SELECT E.EMP_NAME �����,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������,
       N.NATIONAL_NAME �ٹ�������
       
  FROM EMPLOYEE E

  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
  
  WHERE N.NATIONAL_NAME = '�Ϻ�' 
        OR N.NATIONAL_NAME = '�ѱ�';


-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�

-- ORACLE
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       E.SALARY �޿�
       --J.JOB_CODE �����ڵ�
       
   FROM EMPLOYEE E,
        JOB J
        
   WHERE E.JOB_CODE = J.JOB_CODE
     AND E.BONUS IS NULL
     AND (J.JOB_CODE = 'J4' 
            OR J.JOB_CODE = 'J7');
        
-- ANSI       
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       E.SALARY �޿�

    FROM EMPLOYEE E
    JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
    
    WHERE E.BONUS IS NULL
        AND (J.JOB_CODE = 'J4' 
            OR J.JOB_CODE = 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�.

-- ORACLE
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       DECODE((S.SAL_LEVEL), 'S1', '���',
                             'S2', '���',
                             'S3', '�߱�',
                             'S4', '�߱�',
                             'S5', '�ʱ�',
                             'S6', '�ʱ�') �޿����
       
   FROM EMPLOYEE E,
        JOB J,
        SAL_GRADE S
        
   WHERE E.JOB_CODE = J.JOB_CODE
     AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL

   ORDER BY �޿����;

-- ANSI
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       DECODE((S.SAL_LEVEL), 'S1', '���',
                             'S2', '���',
                             'S3', '�߱�',
                             'S4', '�߱�',
                             'S5', '�ʱ�',
                             'S6', '�ʱ�') �޿����
       
   FROM EMPLOYEE E
   
   JOIN JOB J USING(JOB_CODE)
   JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
   

-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�

-- ORACLE 
SELECT D.DEPT_TITLE �μ���,
       SUM(SALARY) �޿���

    FROM EMPLOYEE E,
         DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
        
    GROUP BY D.DEPT_TITLE
    
    HAVING SUM(SALARY) >= 10000000;
    
         
-- ANSI
SELECT D.DEPT_TITLE �μ���,
       SUM(SALARY) �޿���

    FROM EMPLOYEE E
    
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    
    GROUP BY D.DEPT_TITLE
    
    HAVING SUM(SALARY) >= 10000000;



-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.

-- ANSI
SELECT D.DEPT_TITLE �μ���,
       TRUNC(AVG(SALARY)) ��ձ޿�
       
    FROM EMPLOYEE E
    
    FULL JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         
    GROUP BY D.DEPT_TITLE
    ORDER BY 1;      












