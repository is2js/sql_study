--������ ��ȸ--
SELECT * FROM Person;



--���͸�--
SELECT * FROM Person WHERE SEX=1;
SELECT * FROM Person WHERE SEX=0;

SELECT * FROM [dbo].[Drug];



--ī����--
SELECT COUNT(*) FROM PERSON; --���̺� ��ü ī����--
SELECT SEX,COUNT(*) FROM PERSON GROUP BY SEX; --����Į������, ����Į���� ī��Ʈ ���ִ� Į���� �̸��� ����--

SELECT SEX,COUNT(*) AS CNT FROM PERSON GROUP BY SEX;



--*** �����Լ� ~ GROUP BY �׷���*** �����Լ��� ������ ������Ѵ�.--
SELECT * FROM PERSON GROUP BY SEX; --�׷���̸� ����Ҷ��� �ݵ�� �����Լ��� ����ؾ��Ѵ�. �ȱ׷��� ��������.
SELECT COUNT(*) FROM PERSON GROUP BY SEX; --�������� ����ī����**--



--*** DISTINCT ����ũ�� �� ����***--
SELECT DISTINCT personid FROM Drug;



--*** TOP 3 * ���� 3���� ����***--
SELECT * FROM Drug;
SELECT TOP 3 * FROM Drug;
SELECT TOP 10 * FROM Drug;



---WHERE ����--
-- ��
SELECT * FROM Drug WHERE duration>=90

SELECT * FROM Drug WHERE (duration <= 30) AND (duration >= 90) --between�� �׻� 30����~90����



-- ***���̰� : Į���� BETWEEN 100 AND 500
SELECT * FROM Drug 
SELECT * FROM Drug WHERE duration BETWEEN 3 AND 5

SELECT * FROM [dbo].[Electrocardiogram]
SELECT * FROM [dbo].[Electrocardiogram] WHERE QTc BETWEEN 400 AND 500




-- ***IN, NOT IN  : Į���� IN ( a, b, c )     OR�� ���
SELECT TOP 15 * FROM DRUG;

SELECT * FROM DRUG WHERE atccode = 'N01BB02';

SELECT * FROM DRUG WHERE atccode = 'N01BB02' OR atccode = 'N01AX10'; --OR�� 2�� ������ �Ҹ��ϴ�.

SELECT * FROM DRUG WHERE atccode IN ('N01BB02', 'M03AC09','N01AX10');




-- ***Į���� LIKE ���� -->  Į���� LIKE %diabetes%  -> �յڿ� �����ٵ簣�� diabetes�˻�
SELECT TOP 15 * FROM DRUG;

SELECT * FROM DRUG WHERE atccode LIKE 'J01%' -- J01�� �����ϴ� ��� ��

SELECT * FROM DRUG WHERE atccode LIKE 'J01[A-Z][A-Z]10' -- J01�� ����, ��� 2���ڴ� �ƹ��ų�, ���� 10���� �P



-- IS NULL, IS NOT NULL ; Į���� IS NULL  <---> 0�� �����Ͱ����� NULL�� �ٸ�
-- �������� ( ) AND (  )



-- ***ORDER BY Į���� DESC ASC  :  WHERE ���� �ִٸ�, �� ������ ������ ��--
SELECT TOP 15 * FROM DRUG;

SELECT * FROM DRUG ORDER BY personid DESC;
SELECT * FROM DRUG ORDER BY personid, drugdate ASC; -- **ȯ�ں��� ����***(��¥) ���� ���� ���� �Ծ�����

SELECT * FROM DRUG WHERE DURATION > 90
ORDER BY personid ASC, drugdate DESC; -- WHERE������ ����, Į������ ���������ο�����***



-- *** �����Լ�, SUM AVG COUNT MAX MIN(Į����)  AS ǥ�õ� Į����
-- *** ī��Ʈ �����,,,�����Լ�(Į����)
-- *** ���� cast(Į�Ÿ� as float)***�� ���� �ٲٰ� �� ��, �������

SELECT AVG(duration) as avg_duration FROM Drug;  -- cast( as float)���ϰ� �ϸ�,,, �Ҽ����� �� ©��������********
SELECT AVG(cast(duration as float)) as avg_duration FROM Drug; --*** �����Լ�����,,, �׻� �Ǽ������� �ٲٰ� ����ϱ�***

SELECT COUNT(*) AS row_cnt FROM Drug; --**ī��Ʈ�� (*)


--** Ư��Į���� count�� �׷���̸� �̿��ؼ�--
-- ó������� ó�����Į���� count�غ���
-- ***���������� �Լ� groupby Į�� == count(*)���� Į���� �����ϰ� ó���ϰ� ����.
SELECT * FROM Drug;

SELECT drugdept FROM Drug GROUP BY drugdept;


SELECT drugdept, COUNT(*) AS cnt_drugdept FROM Drug GROUP BY drugdept;




--** route�� duration�� �ִ밪 ��ȸ
SELECT * FROM Drug;

SELECT route,* FROM Drug GROUP BY route; -- ������ �ȵ�����, <<groupby �� selectĮ������ �����ϰ� �ϴ�..>>*** ��������,,, �ڿ� �����Լ�( Ư��Į���� )
SELECT route, MAX(duration) AS max_duration FROM Drug GROUP BY route;
SELECT [route], MAX(duration) AS max_duration FROM Drug GROUP BY route; --zĮ������ ������϶��� ���ȣ�� �����൵ �ȴ�.