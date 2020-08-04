-- 1. ������а�, �й�, �̸�, ���г⵵
SELECT STUDENT_NO "�й�", STUDENT_NAME "�̸�", ENTRANCE_DATE "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY �̸� ASC;

-- 2. �̸� ������ �ƴ� ���� �̸�, �ֹι�ȣ ���

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(professor_name) != 3;


-- 3. ���ڱ����� �̸� ���� ���, ���̰� ���� ��� ������ ���

SELECT PROFESSOR_NAME "���� �̸�",
        --  1. �� ��¥ ���� ���� ��ȯ = �����̷� ���
        CASE WHEN TRUNC((MONTHS_BETWEEN( SYSDATE , TO_DATE (SUBSTR(PROFESSOR_SSN,1,6))))/12) < 0
        --  2. 2049�� ��� �� ���ǿ� �ɷ��� ��, 100�� �����ָ� �ذ�!
        THEN TRUNC((MONTHS_BETWEEN( SYSDATE , TO_DATE (SUBSTR(PROFESSOR_SSN,1,6))))/12) + 100
        ELSE TRUNC((MONTHS_BETWEEN( SYSDATE , TO_DATE (SUBSTR(PROFESSOR_SSN,1,6))))/12)
        END "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY ���� ASC;





/*

SELECT PROFESSOR_NAME "���� �̸�", 
        --  1. ���� �ֹι�ȣ�� ����⵵ ����, ������ 49�⵵�� ���, RR�� �ɷ��� �� ����, 2049�� ������, ���� ���� ����
        CASE WHEN TO_CHAR(SYSDATE, 'YYYY') - EXTRACT(YEAR FROM (TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RRRR'))) < 0
        --  2. ���ǿ� �ɷ��� ��, 100�� ���ָ� �ذ�!
        THEN TO_CHAR(SYSDATE, 'YYYY') - (EXTRACT(YEAR FROM (TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RRRR'))) - 100)
        --  3. �׷��� ������, �״�� ���ָ��.
        ELSE TO_CHAR(SYSDATE, 'YYYY') - (EXTRACT(YEAR FROM (TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RRRR')))) 
        END
        "����"
        

FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY "����" ASC;


SELECT  PROFESSOR_NAME,
        CASE WHEN FLOOR((SYSDATE - (TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD')))/365) < 0
        THEN FLOOR((SYSDATE - (TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD')))/365) + 100
        ELSE FLOOR((SYSDATE - (TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD')))/365)
        END "����"
        
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY "����" ASC;

*/

-- 4. �����̸��� �� �����ϰ� ���

SELECT SUBSTR(PROFESSOR_NAME, 2,2) "�̸�"
FROM TB_PROFESSOR;

-- 5. ����� ����� (20�쿡 �����ϸ� �����) ���
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
--       ���г⵵���� �⵵ ����              -  �л� �ֹι�ȣ���� �⵵ ����           = ���� ���   
WHERE (EXTRACT(YEAR FROM ENTRANCE_DATE)) - (EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6)))) = 20;


-- 6. 2020�� ũ���������� ���� ����?
SELECT TO_CHAR(TO_DATE('20201225'), 'DAY') "2020�� ũ��������" FROM DUAL;

-- 7. ���� ��� ��� ���� �ΰ�?

-- YY�� �̹� ����
SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL; -- 2099�� 10�� 11��
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL; -- 2049�� 10�� 11��

-- RR > 50 �̹� ����, RR <= 50 ���� ����
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL; -- 1999�� 10�� 11��
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL; -- 2049�� 10�� 11��

-- 8. 2000�⵵ ���� �й��� ���� �л����� �й��� �̸� ���

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) != 'A';

