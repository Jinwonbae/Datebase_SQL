-- DML

-- 1.
INSERT INTO TB_CLASS_TYPE VALUES ('01','전공필수');
INSERT INTO TB_CLASS_TYPE VALUES ('02','전공선택');
INSERT INTO TB_CLASS_TYPE VALUES ('03','교양필수');
INSERT INTO TB_CLASS_TYPE VALUES ('04','교양선택');
INSERT INTO TB_CLASS_TYPE VALUES ('05','논문지도');

-- 2.
CREATE TABLE TB_STUINFO
    AS SELECT  STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS 
    FROM TB_STUDENT;
-- 3.
-- ORACLE
CREATE TABLE TB_DEPT_KOR
    AS SELECT  STUDENT_NO 학번, 
           STUDENT_NAME 학생이름,
           TO_CHAR(TO_DATE((SUBSTR(STUDENT_SSN,1,2)),'RRRR'),'RRRR') 출생년도,
           PROFESSOR_NAME 교수이름
    FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D
    WHERE S.DEPARTMENT_NO = P.DEPARTMENT_NO
        AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
        AND DEPARTMENT_NAME = '국어국문학과';
 
 
 
         
 