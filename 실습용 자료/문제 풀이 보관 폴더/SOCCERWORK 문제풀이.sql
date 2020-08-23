--1. PLAYER ���̺��� K02, K05 ���� �ش��ϴ� �������� �̸��� ������, ���ȣ, Ű�� ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM PLAYER
WHERE TEAM_ID IN ('K02','K05');


--2. PLAYER ���̺��� ������ ��õ� �������� �̸��� ������ ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME, NATION
FROM PLAYER
WHERE NATION IS NOT NULL;


--3. PLAYER ���̺��� ��ID�� K02�̰ų� K07�� �������� �̸��� ������, ���ȣ, ��ID, Ű�� ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME, POSITION, BACK_NO, TEAM_ID, HEIGHT
FROM PLAYER
WHERE TEAM_ID IN ('K02','K07');


--4. TEAM ���̺��� �� ���� �����ȣ �� ���� '-' �����ڷ� ���Ͽ� ��ID�� �����ȣ ������ ��ȸ�Ͻÿ�.
SELECT ZIP_CODE1 || ' - '||ZIP_CODE2 "�����ȣ"
FROM TEAM;

--5. PLAYER ���̺��� ��� �������� �ο� ���� ���� ũ�Ⱑ ��ϵ� ������ ��, �ִ� ����� �ּ� ����, ��� ������ ������ ��ȸ�Ͻÿ�.
SELECT COUNT(*) , COUNT(HEIGHT), MAX(HEIGHT), MIN(HEIGHT), TRUNC(AVG(HEIGHT))
FROM PLAYER;

--6. PLAYER ���̺��� Ȱ���Ͽ� �� �� �� �ο����� ��ȸ�ϴ� SQL�� �ۼ��ϵ� ������ �ο� �� �������� �������� �����Ͽ� ��ȸ �Ͻÿ�.
SELECT TEAM_ID, COUNT(TEAM_ID) "���� �ο���"
FROM PLAYER
GROUP BY TEAM_ID
ORDER BY "���� �ο���" DESC;

--7. PLAYER�� TEAM ���̺��� Ȱ���Ͽ� �� ������ �̸��� �Ҽ������� ��ȸ �Ͻÿ�.
-- ORACLE
SELECT P.PLAYER_NAME
     , T.TEAM_ID
     
FROM PLAYER P, TEAM T

WHERE P.TEAM_ID = T.TEAM_ID; 

-- ANSI
SELECT PLAYER_NAME
     , TEAM_ID
     
FROM PLAYER 

JOIN TEAM USING(TEAM_ID);

--8. PLAYER, TEAM, STADIUM ���̺��� Ȱ���Ͽ� �� �������� ���� ��
--   ������, ������, �����, ����, Ȩ����� ���� ��ȸ�Ͻÿ�.
-- ORACLE
SELECT P.PLAYER_NAME
    ,  P.POSITION
    ,  T.REGION_NAME
    ,  T.TEAM_ID
    ,  S.STADIUM_NAME
    
FROM PLAYER P, TEAM T, STADIUM S

WHERE P.TEAM_ID = T.TEAM_ID
    AND T.STADIUM_ID = S.STADIUM_ID;

-- ANSI
SELECT P.PLAYER_NAME
    ,  P.POSITION
    ,  T.REGION_NAME
    ,  T.TEAM_ID
    ,  S.STADIUM_NAME
    
FROM PLAYER P

JOIN TEAM T ON (P.TEAM_ID = T.TEAM_ID)
JOIN STADIUM S ON (T.STADIUM_ID = S.STADIUM_ID);

--9. TEAM, STADIUM ���̺��� Ȱ���Ͽ� �� ���� �̸��� �����ID, �������� ��ȸ�ϵ�
--   �����ID�� �����ϴ� ���� ��ȸ �ϰ� ����� ����� ���� �������� ������ �ǵ��� ��ȸ�Ͻÿ�.
-- ORACLE

SELECT T.TEAM_NAME
    ,  T.STADIUM_ID
    ,  S.STADIUM_NAME
    
FROM TEAM T, STADIUM S

WHERE T.STADIUM_ID = S.STADIUM_ID(+)
    AND TEAM_ID IS NOT NULL

ORDER BY 3;    

/*
WHERE T.STADIUM_ID = S.STADIUM_ID;
*/

-- ANSI
SELECT TEAM_NAME
    ,  STADIUM_ID
    ,  STADIUM_NAME
    
FROM TEAM 

JOIN STADIUM USING(STADIUM_ID)

ORDER BY 3;    

--10. PLAYER ���̺��� Ȱ���Ͽ� ���� ũ�Ⱑ ��� ������ ���� ������ ��� �̻���
--    �������� ������, ������, ���ȣ�� �����̸� ���� ������������ ��ȸ�Ͻÿ�.

SELECT PLAYER_NAME
    ,  POSITION
    ,  BACK_NO
    
FROM PLAYER

WHERE HEIGHT > ( SELECT AVG(HEIGHT)
                 FROM PLAYER)
                 
ORDER BY PLAYER_NAME;

--11. ���� �� '������'��� ���������� ���� ���� �ѱ� ��Ī�� ���� ��Ī, �Ҽ� ������ ��ȸ�Ͻÿ�.

SELECT PLAYER_NAME
    ,  TEAM_NAME
    ,  E_TEAM_NAME
    ,  REGION_NAME
    
FROM  PLAYER P
    , TEAM T

WHERE  P.TEAM_ID = T.TEAM_ID
    AND PLAYER_NAME = '������';

-- ANSI
SELECT PLAYER_NAME
    ,  TEAM_NAME
    ,  E_TEAM_NAME
    ,  REGION_NAME
    
FROM  PLAYER 

JOIN TEAM USING(TEAM_ID)

WHERE PLAYER_NAME = '������';




--12. PLAYER ���̺��� �� ���� ���� ������ �� �Ҽӵ� ���� ��� ���庸�� ���� ���̰� ����
--   �������� ����, ������, ������, ���ȣ, ���� ���̸� ��ȸ�Ͻÿ�.

SELECT T.TEAM_NAME, P.PLAYER_NAME, P.BACK_NO, P.HEIGHT

FROM PLAYER P
   , TEAM T

WHERE P.TEAM_ID = T.TEAM_ID
    AND HEIGHT < ANY (SELECT AVG(HEIGHT)
                  FROM PLAYER
                  GROUP BY TEAM_ID);

--13. ������ �̸��� ������, ���ȣ, ��ID, ������ ��ȸ�ϴ� ��(V_TEAM_PLAYER)�� �ϳ� ������ ��
--     ������ �並 Ȱ���Ͽ� 'Ȳ'������ ���� �������� ������ ��ȸ�Ͻÿ�.
CREATE VIEW V_TEAM_PLAYER
AS SELECT PLAYER_NAME, POSITION, BACK_NO, TEAM_ID, TEAM_NAME
FROM PLAYER
JOIN TEAM USING(TEAM_ID);

SELECT *
FROM V_TEAM_PLAYER
WHERE PLAYER_NAME LIKE 'Ȳ%';


--14. ��� ���� ���� '����ȣ' ������ ���� ���ԵǾ���.
--     �ش� ������ ���� �� �������� DF�̸� 1987�� 3�� 16�ϻ�, ����� �����԰� ���� 176cm, 75kg���� 
--     �����ٰ� ���� ��, ����ȣ ������ ����ID�� ���� ������ �� ���� ū ���ڸ� ���� �������� 
--     ���ڸ� �ϳ� �������� �߰��� �� �ִ� ������ �ۼ��Ͻÿ�.
SELECT TEAM_ID, TEAM_NAME, MAX(PLAYER_ID)
FROM TEAM
JOIN PLAYER USING(TEAM_ID)
WHERE TEAM_NAME LIKE '���%'
GROUP BY TEAM_NAME,TEAM_ID; -->  K01,�������,2012130


CREATE SEQUENCE SEQ_PLAYER_ID
START WITH 2012137
INCREMENT BY 1;


INSERT INTO PLAYER(PLAYER_ID, PLAYER_NAME, TEAM_ID, POSITION, BIRTH_DATE, HEIGHT, WEIGHT)
VALUES (SEQ_PLAYER_ID.NEXTVAL,'����ȣ','K01','DF','19870616',176,75);

--15. SCHEDULE�� ��ϵ� ������ �� ���� ���� ���� ��ϵ� ������ ��¥�� ����� ��, 
--     HOME���� AWAY���� �� ��� �� ���� ����� ���� ���� ��ȸ�Ͻÿ�.
--
SELECT SCHE_DATE
     , STADIUM_NAME
     , C.TEAM_NAME "HOME ��"
     , HOME_SCORE
     , D.TEAM_NAME "AWAY ��"
     , AWAY_SCORE

FROM SCHEDULE A
JOIN STADIUM B USING(STADIUM_ID)
LEFT JOIN TEAM C ON (A.HOMETEAM_ID = C.TEAM_ID)
LEFT JOIN TEAM D ON (A.AWAYTEAM_ID = D.TEAM_ID)

WHERE HOME_SCORE = (SELECT MAX(HOME_SCORE)FROM SCHEDULE)
     OR AWAY_SCORE = (SELECT MAX(AWAY_SCORE)FROM SCHEDULE);


COMMIT;



--16. �ֱ� �ѱ� ���������� ������Ȳ�� �� ������ �� ���� �� ���� ������ 3�� ������ ������
--    �����ϰ� �Ǿ���. TEAM ���̺��� Ȱ���Ͽ� ���� �Ҽӵ� ������ 3�� ������ ������ ã��
--    �ش� �����͸� �����ϴ� ������ �ۼ��Ͻÿ�.

DELETE FROM TEAM
WHERE TEAM_NAME IN (SELECT TEAM_NAME
                    FROM PLAYER
                    JOIN TEAM USING(TEAM_ID)
                    GROUP BY TEAM_NAME
                    HAVING COUNT(*) <= 3);

ALTER TABLE PLAYER DROP CONSTRAINT PLAYER_FK;

