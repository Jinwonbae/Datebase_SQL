-- 1. ������а�, �й�, �̸�, ���г⵵
SELECT STUDENT_NO "�й�", STUDENT_NAME "�̸�", ENTRANCE_DATE "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY �̸� ASC;

-- 2. �̸� ������ �ƴ� ���� �̸�, �ֹι�ȣ ���

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(professor_name) != 3;
 -- TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RR')
-- 3. ���ڱ����� �̸� ���� ���, ���̰� ���� ��� ������ ���
SELECT PROFESSOR_NAME "�̸�", TO_CHAR(SYSDATE, 'YYMMDD') - SUBSTR(PROFESSOR_SSN,1,6)
FROM TB_PROFESSOR


