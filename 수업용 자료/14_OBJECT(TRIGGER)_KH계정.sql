/*
    < Ʈ���� TRIGGER >

    ���� ������ ���̺� INSERT, UPDATE, DELETE ���� DML���� ���� ����� ���(���̺� �̺�Ʈ �߻���)
    �ڵ����� �Ź� ����� ������ �����ص� �� �ִ� ����ü
    ������ ���Ἲ�� ����
    
    EX) ����� ���� ������ ���(INSERT)�� �� ���� �ش� ��ǰ�� ���� ��� ������ �Ź� ����(UPDATE)�� �� �ִ�!
        ���� ȸ�����̺� ������(DELETE) �� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERTó�� �� �� �ִ�!
        �Ű� Ƚ���� ���� �Ѿ��� �� ���������� ������Ʈ ó���ϰԲ�!
    
    * Ʈ������ ����
    - SQL���� ���� �ñ⿡ ���� �з�
    > BEFORE TRIGGER :
    > AFTER  TRIGGER : 
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
    > STATEMENT TRIGGER(���� Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
    
    > ROW TRIGGER(�� Ʈ����) : �ش� SQL�� ������ �� ���� �Ź� Ʈ���� ����
                              Ʈ���� ���� ���� �ۼ��� FOR EACH ROW �ɼ� ����ؾߵ�!
                 > : OLD    : BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�) 
                 > : NEW    : AFTER INSERT(�Է��� �ڷ�), AFTER DELETE(������ �ڷ�)
                 
    * Ʈ���� ���� ����
    
    [ǥ����]
    
    CREATE [OR REPLACE] TRIGGER TRG_Ʈ���Ÿ�
    BEFORE | AFTER  INSERT|UPDATE|DELETE ON ���̺��
    [FOR EACH ROW]      --> �� Ʈ����
    
    AFTER INSERT ON DEPARTMENT
    
    [DECLARE
        ���� ����;]
    BEGIN
        ���� ����; (�ش� ���� ������ �̺�Ʈ �߻��� ���������� �ڵ����� ������ ����)
    [EXCEPTION
        ���� ó��;]
    END;
    /
*/

SET SERVEROUTPUT ON;    -- ��¹��� ���̴� ����


-- EMPLOYEE ���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޼��� ����ϴ� Ʈ���� ����

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT 
ON EMPLOYEE

BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի�� �޾ƶ�!');
END;
/

INSERT INTO EMPLOYEE (
                      EMP_ID
                    , EMP_NAME
                    , EMP_NO
                    , DEPT_CODE
                    , JOB_CODE
                    , HIRE_DATE) 
VALUES  (400
        , '�̼���'
        , '800918-2154678'
        , 'D7'
        , 'J7'
        , SYSDATE);
              
INSERT INTO EMPLOYEE (
                        EMP_ID
                      , EMP_NAME
                      , EMP_NO
                      , DEPT_CODE
                      , JOB_CODE
                      , HIRE_DATE)
                      
VALUES (    
        401
      ,'�漺��'
      ,'800918-2354678'
      ,'D8'
      ,'J7'
      ,SYSDATE);

---------------------------------------------------------------------------------

-- ��ǰ �԰� �� ��� ���� ����


-->> �ʿ��� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� ������ ������ ���̺� (TB_PRODUCT)

CREATE TABLE TB_PRODUCT (
       PCODE NUMBER PRIMARY KEY,        -- ��ǰ�ڵ�
       PNAME VARCHAR(30),               -- ��ǰ��
       BRAND VARCHAR(30),               -- �귣��
       PRICE NUMBER,                    -- ����
       STOCK NUMBER DEFAULT 0           -- ���
       
);

-- ��ǰ�ڵ� �ߺ� �ȵǰ� ���ο� ��ȣ �Ź� �߻���Ű�� ������(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE;      --�⺻������ ���� 1���� ������!

-- ���� ������ �߰�

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,'������20','����',1400000,DEFAULT);

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,'������12PRO','���',NULL,DEFAULT);

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,'�����','������',600000,20);


COMMIT;


-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
--    � ��ǰ�� � �� ��� �԰� �Ǵ� ��� �Ǿ����� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
        DCODE NUMBER PRIMARY KEY,
        PCODE NUMBER,
        PDATE DATE,
        AMOUNT NUMBER,
        STATUS VARCHAR2(10) CHECK (STATUS IN ('�԰�', '���')),
        FOREIGN KEY (PCODE) REFERENCES TB_PRODUCT(PCODE)
);

-- ���ڵ�� ���ο� ��ȣ�� �߻���Ű�� ������ (SEQ_DCODE)
CREATE SEQUENCE SEQ_DECODE;

-- 1�� ��ǰ�� ���ó�¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL
VALUES (SEQ_DECODE.NEXTVAL
        , 1
        , SYSDATE
        , 10
        , '�԰�');

-- �������� �����ؾ���
UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
    WHERE PCODE = 1;
    

COMMIT;

-- 2�� ��ǰ�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES (SEQ_DECODE.nextval
      , 2
      , SYSDATE
      , 20
      , '�԰�');

UPDATE TB_PRODUCT
    SET STOCK = STOCK + 20
    WHERE PCODE = 2;

COMMIT;


-- 1�� ��ǰ�� ���ó�¥�� 3�� ���
INSERT INTO TB_PRODETAIL
VALUES ( SEQ_DECODE.NEXTVAL
       , 1
       , SYSDATE
       , 3
       , '���');

-- ��� ������ ����
UPDATE TB_PRODUCT
    SET STOCK = STOCK - 3
    WHERE PCODE = 1;


SELECT * FROM TB_PRODUCT;

-- TB_PRODETAIL ���̺� ������ ���� (INSERT) ��
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ��� ���� UPDATE �ǰԲ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW -- ��Ʈ����    
BEGIN

   -- ��ǰ�� �԰�� ���    --> ������ ����
    IF (:NEW.STATUS = '�԰�')
    THEN 
        UPDATE TB_PRODUCT 
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;    
    
   -- ��ǰ�� ���� ���    --> ������ ����
    IF (:NEW.STATUS = '���')
    THEN
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;    

END;
/


-- 3�� ��ǰ�� ���ó�¥�� 9�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL,3,SYSDATE, 9, '���');

-- 2�� ��ǰ�� ���ó�¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES (SEQ_DECODE.NEXTVAL,2,SYSDATE,100,'�԰�');

SELECT * FROM TB_PRODUCT;


