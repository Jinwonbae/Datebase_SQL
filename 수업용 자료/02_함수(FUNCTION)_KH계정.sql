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








