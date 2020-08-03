-- 1. �а���, �迭 ��ȸ
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY  "�迭"
FROM TB_DEPARTMENT;

-------------------------------------------------------------------------

-- 2. �а��� ���� ��ȸ
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' "�а��� ����"
FROM TB_DEPARTMENT;

-------------------------------------------------------------------------

-- 3. ������а�, ���л�, ������ ��ȸ
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001 AND ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN,8,1) = 2;


-------------------------------------------------------------------------

-- 4. ��� ��ü�� �̸� �Խ� ( A513079,A513090,A513091,A513110,A513119)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME ASC;

---------------------------------------------------------------------------

-- 5. ���� ���� 20�� �̻� 30�� ���� �а�, �迭
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;


---------------------------------------------------------------------------

-- 6. �������б� ���� �̸���?
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

---------------------------------------------------------------------------

-- 7. �а��� �����ȵ� �л���?
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE LENGTH(DEPARTMENT_NO) != 3; -- �а���ȣ�� NULL�� �̿����� �ʰ� 001~063(������ Ÿ�� : ���ڰ�) => ���� 3 => 3�̾ƴϸ� �а� �������� �Ǵ�

---------------------------------------------------------------------------


-- 8. ���������� �����ϴ� ������?
SELECT CLASS_NO
FROM TB_CLASS
WHERE preattending_class_no IS NOT NULL;

---------------------------------------------------------------------------

-- 9. ����� � �迭�� ������?
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

---------------------------------------------------------------------------

-- 10 . 02�й�, ���� ������(���л� ����) �й�, �̸�, �ֹι�ȣ
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS,1,2) = '����' AND SUBSTR(ENTRANCE_DATE,1,2) = 02 AND absence_yn = 'N';

