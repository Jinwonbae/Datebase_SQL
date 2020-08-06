-- 9. �й��� A517178 �ѾƸ� �л��� ���� �� ������ ���Ͻÿ�(�ݿø� �Ҽ��� ���ڸ�������)
SELECT ROUND(AVG(POINT), 1) "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. �а���ȣ, �л���(��)  ���
SELECT DEPARTMENT_NO "�а���ȣ", COUNT(*) "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;


-- 11. ���� ���� ���� ���޴� �л��� ���?
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 ���� �л��� �⵵ �� ������ ���϶�
-- GROUP BY������ ������ ����� ���� ����, �Լ� ��� ����
/*
SELECT SUBSTR(TERM_NO,1,4), STUDENT_NO, POINT
FROM TB_GRADE
GROUP BY SUBSTR(TERM_NO,1,4), POINT, STUDENT_NO
HAVING STUDENT_NO = 'A112113' AND SUBSTR(TERM_NO,1,4) = '2001'
ORDER BY SUBSTR(TERM_NO,1,4);
*/
-- �⵵�� ���� ����
--1. HAVING�� ����� ����
SELECT SUBSTR(TERM_NO,1,4)"�⵵",ROUND(AVG(POINT), 1) "�⵵�� ����"
FROM TB_GRADE
GROUP BY SUBSTR(TERM_NO,1,4), STUDENT_NO -- �⵵�� �л��� ���� ����
HAVING STUDENT_NO = 'A112113';

--2. WHERE + GROUP BY ����غ���
SELECT SUBSTR(TERM_NO,1,4)"�⵵",ROUND(AVG(POINT), 1) "�⵵�� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4);


-- 13. �а��� ���л� �� 

SELECT DEPARTMENT_NO " �а��ڵ��", COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) �� �ο�����
-- ���� ABSENCE_YN�� ���� 'Y'���� ��� COUNT(1)�� �Ǿ� ������ ���� �ǰ�
--     ABSENCE_YN�� ���� 'Y'�� �ƴϿ��� ��� COUNT(NULL)�� �Ǿ� ������ ���� �ʰԵǴ� ����!!



-- 14. ���� ���� ã��

SELECT STUDENT_NAME "�����̸�", COUNT(*) "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY STUDENT_NAME;

-- 15. �й� A112113 ���� �л� �⵵, �б⺰ ����, �⵵ �� ���� ����, �� ����
SELECT SUBSTR(TERM_NO,1,4)"�⵵", SUBSTR(TERM_NO,5,2)"�б�", ROUND(AVG(POINT),1) "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY "�⵵";




