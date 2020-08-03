-- 1. 학과명, 계열 조회
SELECT DEPARTMENT_NAME "학과 명", CATEGORY  "계열"
FROM TB_DEPARTMENT;

-------------------------------------------------------------------------

-- 2. 학과별 정원 조회
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' "학과별 정원"
FROM TB_DEPARTMENT;

-------------------------------------------------------------------------

-- 3. 국어국문학과, 여학생, 휴학중 조회
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001 AND ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN,8,1) = 2;


-------------------------------------------------------------------------

-- 4. 장기 연체자 이름 게시 ( A513079,A513090,A513091,A513110,A513119)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME ASC;

---------------------------------------------------------------------------

-- 5. 입학 정원 20명 이상 30명 이하 학과, 계열
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;


---------------------------------------------------------------------------

-- 6. 춘기술대학교 총장 이름은?
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

---------------------------------------------------------------------------

-- 7. 학과가 지정안된 학생이?
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE LENGTH(DEPARTMENT_NO) != 3; -- 학과번호는 NULL을 이용하지 않고 001~063(데이터 타입 : 문자값) => 전부 3 => 3이아니면 학과 없음으로 판단

---------------------------------------------------------------------------


-- 8. 선수과목이 존재하는 과목은?
SELECT CLASS_NO
FROM TB_CLASS
WHERE preattending_class_no IS NOT NULL;

---------------------------------------------------------------------------

-- 9. 춘대학 어떤 계열이 있을까?
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

---------------------------------------------------------------------------

-- 10 . 02학번, 전주 거주자(휴학생 제외) 학번, 이름, 주민번호
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS,1,2) = '전주' AND SUBSTR(ENTRANCE_DATE,1,2) = 02 AND absence_yn = 'N';

