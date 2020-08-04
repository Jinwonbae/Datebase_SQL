/*

    <�Լ�  FUNCTION>
    - �ڹٷ� ġ�� �޼ҵ� ���� ����
    - ���ް��� �о� ����� ����� ��ȯ
    
    > ������ �Լ� : N���� ���� �о N���� ��� ���� ( �� �ึ�� �Լ� ���� ��� ��ȯ)
    > �׷� �Լ� : N���� ���� �о 1���� ����� ���� ( �ϳ��� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    * ���� �� �Լ��� �׷��Լ��� �Բ� ��� �� �� ���� !! : ��� ���� ���� �� �ٸ��� ����

    * �Լ��� �� �� �ִ� ��ġ : SELECT ��, WHERE ��, ORDER BY �� , GROUP BY ��, HAVING ��                         

*/


------------------------------------< ������ �Լ� > --------------------------------------

/*
    < ���� ���� �Լ�>
    
    * LENGTH / LENGTHB
    
    LENGTH(STRING) : �ش� ������ ���� �� ��ȯ
    LENGTHB(STRING) : �ش� ������ ����Ʈ ���� ��ȯ    
    
   > ������� NUMBER ������ ��ȯ 
    
   >  STRING : ���ڿ� �ش��ϴ� �÷� | '���ڰ�'
    '��', '��', '��' �ѱ� �� ���ڴ� 3 BYTE�� ���
    'A', 'a', '1', '!' �� ���ڴ� 1BYTE�� ���
    


*/

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ!')
FROM DUAL; --> �������̺� (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-----------------------------------------------------------------
/*

    * INSTR
    ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    
    INSTR(STRING, '����', [ã����ġ�ǽ��۰�, {����] ])
    => ����� NUMBER Ÿ��
    
    > ã����ġ�� ���۰�
    1 : �տ������� ã�ڴ�! (�⺻��)
    -1 : �ڿ������� ã�ڴ�!
    
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ã�� ��ġ ���۰�, ���� ������ �տ������� ù��°�� B�� ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ���� ����
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL, '@') "@��ġ"
FROM EMPLOYEE;

------------------------------------------------


/*

    * SUBSTR
    ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
    (�ڹٷ� ġ�� ���ڿ�.substring() �޼ҵ�� ����)
    
    => ����� CHRACTER Ÿ�� ��ȯ
    
    SUBSTR(STRING, POSITION, LENGTH)
    
    > STRING : ����Ÿ�� �÷� �Ǵ� '���ڰ�'
    > POSITION : ���ڿ��� �߶� ������ġ��
    > LENGTH : ������ ���� ����( ������ ������ �ǹ�)
    
    

*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',-8, 3) FROM DUAL; -- ������ġ�� ���������� �����ϸ� �ڿ������� ��ġ�� ã��


SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) ����
FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

---------------------------------------------------------------------

/*
    * LPAD / RPAD
    ���ڿ� ���� ���ϰ��ְ� �����ְ��� �� �� ���

    => ����� CHARACTER Ÿ��

    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����(����Ʈ), [�����̰����ϴ� ����])

    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� ������ ���ٿ� ���� N���� ��ŭ ���ڿ� ��ȯ
    > �����̰��� �ϴ� ���� ������ �⺻���� �������� ó��
    
    
*/

SELECT EMAIL,  RPAD(EMAIL,20,'$')
FROM EMPLOYEE;

-- 891201-2***** �ֹι�ȣ ��ȸ      => �� ���ڼ� : 14����
SELECT RPAD('891201-2', 14, '*') FROM DUAL;


-- �Լ� ��ø���� ��� ����
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8),14,'*') "�ֹι�ȣ ��ȣȭ"
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*

    *LTRIM  / RTRIM
    
    
    LTRIM/RTRIM(STRING, [�����ϰ����ϴ� ���ڵ�] )

    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
        
*/

SELECT LTRIM('     K H      ') FROM DUAL;
SELECT LTRIM('00012345600', '0') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL; -- �ش��ϴ� ���ڸ� �� �����! ���� �������!
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; 
SELECT LTRIM('578123KH', '0123456789') FROM DUAL;


----------------------------------------------------------------------------------

/*
    * TRIM
    ���ڿ��� ��/��/���� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ

*/

-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT TRIM('  K H  ') FROM DUAL;   -- �����ϰ��� �ϴ� ���� ������ �⺻���� ����

SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

SELECT TRIM(LEADING'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- LEADING : ��
SELECT TRIM(TRAILING'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- TRAILING(����) : ��
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;    -- BOTH(����) : �⺻��

-- TRIM([LEADING|TRAILING|BOTH] ['�����ϰ� ���� ����' FROM ] STRING)
-- => ����� CHARACTER Ÿ��

----------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : �� �ҹ��ڷ�
    UPPER : �� �빮�ڷ�
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� 
    
    LOWER/UPPER/INITCAP (STRING = Ư�� ���ڰ�, ���� Ÿ���� �÷� ��)


*/

SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('welcome to myworld') FROM DUAL; -- ������ �������� �� �ܾ� �Ǵ� ��, �ձ��ڸ� �빮�ڷ� �ٲ۴�.


----------------------------------------------------------------------------------

/*
    * CONCAT
    
CONCAT(STRING, STRING) : �ΰ� ���ڿ� ��ġ��!
=> ����� CHARACTER Ÿ��

*/

SELECT CONCAT('�����ٶ�','ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-- SELECT CONCAT('������, 'ABC', 'DEF') FROM DUAL; CONCAT�� �ΰ��� ���ڿ��� ����
SELECT '������' || 'ABC' || 'DEF' FROM DUAL;
--------------------------------------------------------------------------------

/*

    *REPLACE
    
    REPLACE(STRING, STR1, STR2)
    
    STRING���� ���� STR1 ã�Ƽ� STR2�� �ٲ� ���ڿ��� ��ȯ

*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com')
FROM EMPLOYEE;

------------------------------------------------------------------

/*
    <���� ���� �Լ�>
    
    * ABS
    ���� �����ִ� �Լ�
    
    ABS(NUMBER)
    
    > NUMBER : ����Ÿ���� �÷� / ���ڰ�

*/

SELECT ABS(-10) FROM DUAL;

SELECT ABS(-10.9) FROM DUAL;
------------------------------------------------------------------

/*
    *MOD
    �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER1, NUMBER2)

*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(-10.9, 3) FROM DUAL;

------------------------------------------------------------------
/*

    *ROUND
    �ݿø� ó�����ִ� �Լ�
    
    ROUND(NUMBER, [��ġ])

*/

SELECT ROUND(123.456) FROM DUAL; --- ��ġ ������ �⺻�� 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL; --- �������� ���� ����, ���������� ���� ���
SELECT ROUND(123.456, 4) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

---------------------------------------------------------------
/*

    *CEIL
    ������ �ø�ó�����ִ� �Լ�
    
    CEIL(NUMBER)


*/

SELECT CEIL(123.156) FROM DUAL;
SELECT CEIL(123.156, 2) FROM DUAL; -- ��ġ ���� �Ұ�

---------------------------------------------------------------

/*
    *FLOOR
    �Ҽ��� �Ʒ� ������ ���������� �Լ�
    
    FLOOR(NUMBER)
    
*/

SELECT FLOOR(123.456) FROM DUAL;

SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE)||'��' �ٹ��ϼ�
FROM EMPLOYEE;

---------------------------------------------------------------


/*
    *TRUNC
    ��ġ ���������� ����ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
    
*/

SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-----------------------------------------------------

/*
    <��¥ ���� �Լ�>
    
        
*/
-- DATE Ÿ���� ���� : ��/��/��, �ú���


-- * SYSDATE : ���ó�¥(�ý��� ��¥) ��ȯ

SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� ��ȯ
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE)|| '��' �ٹ��ϼ�, TRUNC((MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12))||'��' "�ٹ����"
FROM EMPLOYEE;


-- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥ ��ȯ
--  => ����� DATE Ÿ��
-- ���ó�¥�κ��� 5���� ��
SELECT ADD_MONTHS(SYSDATE,5) FROM DUAL;

-- �� ����鸶�� ������, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) "�Ի��� 6���� ��� ��"
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����)) : Ư����¥���� ���� ����� �ش� ������ ã�� �� ��¥ ��ȯ

SELECT NEXT_DAY(SYSDATE,'��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE,'������') FROM DUAL;
SELECT NEXT_DAY(SYSDATE,5) FROM DUAL; -- 1:�Ͽ���, 2: ������ ... 7 : �����
SELECT NEXT_DAY(SYSDATE,'THURSDAY') FROM DUAL; -- ���� ���� ��� Ÿ���� �ٸ��Ƿ�

-- ���� 
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE,'THURSDAY') FROM DUAL;

-- �ٽ� ��� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE,'��') FROM DUAL;

-- * LAST_DAY(DATE) : �ش� Ư�� ��¥ ���� ������ ��¥�� ���ؼ� ��ȯ
-- => ��� ���� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--������, �Ի���, �Ի���� ������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

-------------------------------------------------

/*
    *EXTRACT
    �⵵, ��, �� ������ �����ؼ� ��ȯ
    
    EXTRACT(YEAR FROM DATE) : Ư�� ��¥�κ��� �⵵�� ���� 
    EXTRACT(MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
    EXTRACT(DAY FROM DATE) : Ư�� ��¥�κ��� �ϸ� ����

    => ����� NUMBER Ÿ��

*/

-- ������, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,
    EXTRACT(YEAR FROM HIRE_DATE)|| '��' �Ի�⵵, 
    EXTRACT(MONTH FROM HIRE_DATE)|| '��' �Ի��, 
    EXTRACT(DAY FROM HIRE_DATE)|| '��' �Ի���
  FROM EMPLOYEE
 ORDER BY �Ի�⵵ ASC;


-------------------------------------------------

/*

    <����ȯ �Լ�>
    
    *NUMBER | DATE  => CHARACTER ���� ��ȯ��Ű�� �Լ�
    
    TO_CHAR(NUMBER|DATE, [����]) : ������ �Ǵ� ��¥�� �����͸� ������Ÿ������ ��ȯ
    => ����� CHARACTER Ÿ��


*/

--- NUMBER => CHARACTER
SELECT TO_CHAR(1234) FROM DUAL; ---- '1234'���� ��ȯ
SELECT TO_CHAR(1234,'00000') FROM DUAL; --- 1234 => '01234'         => ��ĭ�� 0���� ä��
-- System.out.printf("%5d",1234);
SELECT TO_CHAR(1234,'99999') FROM DUAL; -- 1234 => ' 1234'          => ��ĭ�� �������� ä��

SELECT TO_CHAR(1234, 'L00000') FROM DUAL; -- 1234 => '\01234'       => ���� ������ ������ ȭ�� ���� ������
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;


SELECT EMP_NAME, LTRIM(TO_CHAR(SALARY, 'L999,999,999')) ||'��' ���� -- ������ ���̱� ���� Ʈ���� ���.
FROM EMPLOYEE;

-- DATE(����Ͻú���) => CHARACTER
SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD') FROM DUAL; -- ���� DATE ó�� �޷��� ������ �ʰ�, TO_CHAR ��ȯ �߱� ������ ����Ÿ������ ����
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;


-- �⵵�ν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'), 
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;


-- ���ν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'), 
       TO_CHAR(SYSDATE, 'RM') -- �θ� ����
FROM DUAL;


-- �Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'D'),
       TO_CHAR(SYSDATE, 'D'),
       TO_CHAR(SYSDATE, 'DDD') -- 1����� ����°���� 
FROM DUAL;

-- ���Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- 2020�� 08�� 04�� (ȭ)
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY)') FROM DUAL;

-- ������, �Ի���(���� ���� ����)
SELECT EMP_NAME,  TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)') �Ի���
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    * NUMBER / CHARACTER    => DATE�� ��ȯ��Ű�� �Լ�
    
    TO_DATE(NUMBER|CHARACTER, [����]) : ������ �Ǵ� ������ �����͸� ��¥Ÿ������ ��ȯ
    => ����� DATE Ÿ��

*/

SELECT TO_DATE(20100201) FROM DUAL;
SELECT TO_DATE('20100201') FROM DUAL;
SELECT TO_DATE('100201') FROM DUAL;  -- 2010�⵵�� �ݿ��Ǿ��ִ�.

SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS') FROM DUAL;


SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;    -- TO_DATE �Լ��� ���� DATE�������� ��ȯ
                                                 --  YY ���� : ������ ���� ����
                                                
SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;    -- RR ���� : �ش� ���ڸ� ���ڰ��� 50�̻��̸� ��������, 50 �̸��̸� ���� ����




-- 1998�� 1�� 1�� ���Ŀ� �Ի��� ����� ��ȸ( ���, �̸�, �Ի��� ��ȸ)
SELECT EMP_NO, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');  --1988/01/01

------------------------------------------------------------------------

/*

    *CHARACTER      =>   NUMBER
    
    TO_NUMBER(CHARACTER, [����]) : ������ �����͸� ����Ÿ������ ��ȯ
    => ����� NUMBER Ÿ��


*/
-- 123123
SELECT '123' + '123' FROM DUAL;  --> �˾Ƽ� �ڵ�����ȯ �ѵ� ������� ����

SELECT '10,000,000' + '550,000' FROM DUAL; --> ���ڰ� ���ԵǾ��־� �ڵ�����ȯ �ȵ�

SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000','999,999') FROM DUAL;

----------------------------------------------------------------------------------------------

/*
    < NULL ó�� �Լ� >


*/

--- * NVL(�÷���, �ش� �÷����� NULL�� ��� ��ȯ�� �����)
SELECT  EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME, (SALARY + NVL(BONUS,0)*SALARY) *12
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '����')
FROM EMPLOYEE;

-- * NVL2(�÷���, �����1, �����2)
-- �ش� �÷����� �����ϸ� ����� 1����
-- �ش� �÷����� NULL�̸� ����� 2����


SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0) "���ʽ� ��� ����"
FROM EMPLOYEE;


-- * NULLIF(�񱳴��1, �񱳴��2)
-- �ΰ��� �� �����ϸ� NULL ��ȯ
-- �ΰ��� �� �������� ������ �񱳴�� 1��ȯ
SELECT NULLIF('123','123') FROM DUAL;


/*

    < ���� �Լ� >
    
    * DECODE(�񱳴��(�÷���|�������|�Լ�), ���ǰ�1, �����1, ���ǰ�2, �����2,...., �����(defalut����))
    
    --switch(�񱳴��){
    case ���ǰ�1 : �����1;
    case ���ǰ�2 : �����2;
    default : �����;
    } �� ���� ����

*/

SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1),1,'����',2,'����') ����
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- ���� �ڵ尡 J7�� ����� �޿��� 10% �λ��ؼ� ��ȸ
-- ���� �ڵ尡 J6�� ����� �޿��� 15% �λ��ؼ� ��ȸ
-- ���� �ڵ尡 J5�� ����� �޿��� 20% �λ��ؼ� ��ȸ
-- �׿��� ���� ������� �޿��� 5% �λ��ؼ� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY "���� �޿�", 
        DECODE((JOB_CODE),'J7', SALARY*1.1,
                            'J6', SALARY*1.15,
                            'J5', SALARY*1.2,
                            SALARY*1.05) "�λ� �� �޿�"
FROM EMPLOYEE;
     
SELECT EMP_ID, EMP_NAME,
        CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '��'
             WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '��'
        END "����"
FROM EMPLOYEE;        
    
/*

    *CASE WHEN TEHN ����
    
    DECODE �����Լ��� ���ϸ� DECODE�� �ش� ���� �˻�� ���� �񱳸��� �����Ѵٸ�
    CASE WHE THEN �������δ� Ư�� ���� ���ý� �������� ����
    (�ڹٷ� ������ IF-ELSE IF�� ���)
    
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         .....
         ELSE �����
    END


*/    
      
      
-- �����, �޿�, �޿����(��, ��, ��)
-- SALARY 500 �ʰ� ��� / 500���� 350 �ʰ� �߱� / 350 ���� �ʱ�

SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY > 5000000 THEN '���'
             WHEN SALARY > 3500000 THEN '�߱�'
             ELSE '�ʱ�'
        END �޿����
FROM EMPLOYEE;        



-------------------------------------------------------------------------------------





