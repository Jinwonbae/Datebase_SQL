

-- 


CREATE TABLE TEST(
    TEST_ID NUMBER

);

-- ������ �����ϰ� �ִ� ���̺��� �ٷ� ���� ����!
SELECT * FROM TEST;
INSERT INTO TEST VALUES(10);

-- �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ����....
CREATE VIEW  V_TEST
AS SELECT * FROM TEST;

---------------------------------------------------------
-- �ٸ� ������ ���̺� ������ �� �ִ� ������ ����...
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT;

INSERT INTO 
KH.DEPARTMENT VALUES ('D0','ȸ���','L2');

ROLLBACK;


