-- E : table, R : PK�� FK�� ���ἱ, D : ���̾�׷�
-- ���� ERD�� ���ٸ�, Ű�� ������ �������� �����ؾ��Ѵ�.
-- ����(Relational�� ��Ȯ�ϰ� ���ǵǾ� �־�� join�� n�� �þ�ų� �̷��� ������ �ȳ���)
-- ����-Relation�� ��Ȯ���� ������(join�� n�� ��Ǯ �� ) �ƹ��� �м��غ��� �ҿ����.

--1. DB ���� �ľ��ϱ�( ALT + F1���� sp_help ���� �غ���)
----sp_help TABLE�� �Բ�, ������ �ٿ����� �����س���. �÷��� �м��غ���. -> ERD ����-> Ű ����
sp_help Person
sp_help Drug
sp_help DiagnosisCodeMaster

--2. database ������ �ľ��ϱ� -> ������ �������� �غ���.
-- �� table�� rowcount�� ����, join�� �þ�ٸ� key relationship�� �߸��Ȱ��̴�.
-- > COUNT�� ���� �ּ����� �޾Ƴ���
SELECT COUNT(*) FROM Person;           --18570
SELECT COUNT(1) FROM Person; -- �� �Ⱥθ��� ���� ���� ���, mysql������ �ȵȴ�. 
SELECT COUNT(1) FROM [dbo].[Diagnosis] --296690
SELECT COUNT(1) FROM [dbo].[DiagnosisCodeMaster] --7553
SELECT COUNT(1) FROM [dbo].[Drug] --1890626
SELECT COUNT(1) FROM [dbo].[DrugCodeMaster]--2627
SELECT COUNT(1) FROM [dbo].[Electrocardiogram]--35932
SELECT COUNT(1) FROM [dbo].[Laboratory]--147716


--3. �� Į���м�(Person����)
--3-1. 
--1) personid�� int��..
sp_help Person

--2) sexĮ�� -> ���ڰ� �ƴ� code(����������)�� �Ǿ��ִ� ���� Ȯ�� -> count������
SELECT TOP 100 * FROM Person

------�̰��� ��ü ����ũ�� ���� Ȯ�� ���Ѱ��̹Ƿ�, ����
SELECT COUNT(1) FROM Person WHERE sex = 0; --9263
SELECT COUNT(1) FROM Person WHERE sex = 1; --9307

--3) sexĮ���� ����ũ�� ����Ȯ���ϱ� -> NULL ���� ã�Ƴ� �� �ִ�.
SELECT DISTINCT sex FROM Person

--4) �׷���̷� ������
SELECT sex, COUNT(*) FROM Person GROUP BY sex
SELECT sex, COUNT(*) FROM Person 
GROUP BY sex 
ORDER BY 1 DESC -- GROUP BY ���� ORDERBY�� 1 ���� ����??***

--3-2. birthday DATETIME ������ �ٷ��-> ������ �Ѽ�-> ��¥���Ĺٲٰ� -> pivot���̺� ����
----- ���ɴ뺰�� ��������
---- ��������� ���̷� �ٲ㺸��
----1) 
SELECT * FROM Person

-------���� ���� ��¥�������� �Լ�

SELECT GETDATE();
-------��������� ���糯¥���� year�� ǥ���ϱ� DATEIFF (����, ���۳�¥, ������ ��¥)
SELECT CONVERT(CHAR(8),birthday,112), * FROM Person
SELECT DATEDIFF(year,birthday,getdate()),* FROM Person
SELECT DATEDIFF(day,birthday,getdate()),* FROM Person
--������ Ȯ���ϱ�??
SELECT DISTINCT DATEDIFF(year,birthday,getdate()) - DATEDIFF(day,birthday,getdate())/365 FROM Person
SELECT DATEDIFF(year,birthday,getdate()),DATEDIFF(day,birthday,getdate())/365,* FROM Person
--- �ҽ� ���Ϸ� ����.. ������... 
--- CASE WHEN�� �̿��ؼ� �ٲ㺸��
SELECT 
CASE WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 0 AND 9
	THEN '10���̸�'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 10 AND 19 
	THEN '10��' 
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 20 AND 29 
	THEN '20��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 30 AND 39 
	THEN '30��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 40 AND 49 
	THEN '40��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 50 AND 59 
	THEN '50��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 60 AND 69 
	THEN '60��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 70 AND 79 
	THEN '70��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 80 AND 89 
	THEN '80��'
	WHEN DATEDIFF(day,birthday,getdate())/365 >= 90 
	THEN '90���̻�'
	END
AS AGE, * FROM Person



--- 3���� �ð�
SELECT
*
INTO person_2
FROM Person

---������ ���̺���... ��ȣ ��ü�� ��� TABLE�� �����ϰ� ������ Person_3�� 
--- ���˾Ƶ���


SELECT AGE, count(personid) FROM 
(
SELECT 
CASE WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 0 AND 9
	THEN '10���̸�'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 10 AND 19 
	THEN '10��' 
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 20 AND 29 
	THEN '20��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 30 AND 39 
	THEN '30��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 40 AND 49 
	THEN '40��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 50 AND 59 
	THEN '50��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 60 AND 69 
	THEN '60��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 70 AND 79 
	THEN '70��'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 80 AND 89 
	THEN '80��'
	WHEN DATEDIFF(day,birthday,getdate())/365 >= 90 
	THEN '90���̻�'
	END
AS AGE, personid FROM Person
) Z 
GROUP BY AGE 
ORDER BY 1
--- AGE�Ӹ��ƴ϶� sex�� �ϰ� ���������� �ϰ� �ʹٸ�,
--- SELECT AGE, sex -> groupby���� sex�� �����ش�.


--- ������ ����� �����ְ�,, ���Ǻμ��� -> �����͸���� ���ڰ�

----


---- DRUG ���̺�---
--
sp_help Drug --Į�� ������ �Ʒ��� �����ְ� ���������� �����ֱ� �ؼ� Ȱ�뤾����.

personid
drugdate
druglocalcode
atccode
drugdept
route
duration

---person�� drug ��
SELECT count(1) FROM Person -- 18172389
SELECT count(1) FROM Drug -- 18172389

--�� ��, distinct�� �ۿ��ٰ� �ϰ� ����,, ��ürow�� ���´�... �ȿ� �־���� ����!
SELECT COUNT(DISTINCT personid) FROM Drug -- 15430
SELECT DISTINCT COUNT(personid) FROM Drug
--
SELECT COUNT(DISTINCT druglocalcode) FROM Drug  -- 2276 
SELECT COUNT(DISTINCT atccode) FROM Drug  -- 984 
SELECT COUNT(DISTINCT drugdept) FROM Drug  -- 4

SELECT DISTINCT drugdept FROM drug
SELECT drugdept, COUNT(DISTINCT personid) FROM drug GROUP BY drugdept

SELECT count(DISTINCT route) FROM drug
SELECT DISTINCT route FROM drug

SELECT route, count(personid) FROM drug GROUP BY route

SELECT top 100 * FROM drug

SELECT min(duration), max(duration), avg(duration) FROM drug

-----drugdate_char
SELECT TOP 10 * FROM drug



------minmax avg�� ���ؼ�,, ������----
--count
--minmax�� sorting�� ���ش�.-> ���ڸ� sorting �� ���ڸ� sorting�ϴ� ���� �ٸ���.
-- ���������� �� ���� 91, 1, 11, 91, 111 - > ������Ÿ���� ���ڷ� ���ְ� soring���ָ�  �� ���ĵǳ�
--- ���ڷμ�����-> �ؽ�Ʈ(����)�� �����ϰ� �� ��, soring�ϸ� 1, 11, 111, 91, 91
--> �츮 �����Ϳ�����
--drugdate�� ������ ���ڿ��� �ƴ϶� DATETIME���� ����Ǿ��ֱ� ������ ����� minmax-�ڵ�sorting�� �ߵǾ���.

ALTER TABLE Drug
ADD drugdate_char VARCHAR(20) 
UPDATE Drug SET drugdate_char = drugdate FROM drug
SELECT 
MIN(drugdate)	-- 
	, MAX(drugdate)		-- 
 ,MIN(drugdate_char)	-- 1994-06-24 00:00:00.000		-- 01  1 1996 12:00AM
	, MAX(drugdate_char)		-- 2011-08-23 00:00:00.000  -- 12 31 2010 12:00AM
FROM Drug 


--dateŸ�Թٲ��ֱ�.. T-SQL��..�ؤ������ϴ� convert
SELECT MAX(MMDDYY), MIN(MMDDYY) FROM 
(
SELECT CONVERT(CHAR(8), drugdate, 10) AS MMDDYY, * FROM drug 
) Z 


SELECT  MAX(Date_MMDDYY), MIN(Date_MMDDYY) 
 , MAX(MMDDYY), MIN(MMDDYY) 
 FROM 
 (
SELECT CONVERT(datetime,MMDDYY,10) AS Date_MMDDYY , *  
FROM 
(
SELECT CONVERT(CHAR(8), drugdate, 10) AS MMDDYY, * FROM drug 
) Z
) ZZ


--���� �Ӹ� ���� ���� ������ ī��Ʈ

SELECT druglocalcode, count(personid) FROM drug 
GROUP BY druglocalcode
ORDER BY 2 --�߰�..

SELECT druglocalcode, count(personid) FROM drug 
GROUP BY druglocalcode
ORDER BY 2 DESC--�߰�..

--���� ���� ����.. �̰��� �ڵ帶���Ϳ��� ���������� ��ȸ
SELECT * FROM DrugCodeMaster WHERE druglocalcode = 'Drug1472'

--2��°, 3��°�� ��� �̷��� ��ȸ�� �� ������ join�� �Ѵ�.
SELECT druglocalcode,
(SELECT drugigrdname FROM DrugCodeMaster as a WHERE a.druglocalcode = b.druglocalcode) AS ���и�
, count(personid) AS ó��Ǽ�
FROM drug as b
GROUP BY druglocalcode
ORDER BY 3 DESC

SELECT a.druglocalcode,
drugigrdname  AS ���и�
, count(personid) AS ó��Ǽ�
FROM drug as b
JOIN Drug as a ON a.druglocalcode = b.druglocalcode
GROUP BY a.druglocalcode, drugigrdname
ORDER BY 3 DESC
--���� 2�� Ȯ������ ����..




---- DATETIME�� ���� 4���ڸ� ������ ���ؼ��� CHAR ���ڿ��� �˳��ϰ� �ٲ� ���������´�.
SELECT SUBSTRING(CONVERT(varchar(20),drugdate),7,4), atccode, count(personid)  FROM drug 
GROUP BY  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), atccode



SELECT SUBSTRING(CONVERT(varchar(20),drugdate),7,4), LEFT(atccode,1), count(personid)  FROM drug 
GROUP BY  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), LEFT(atccode,1)
--���� 2����...


SELECT
[YEAR]
count(person_id)
FROM 
(
SELECT
LEFT(CONVERT (CHAR(10), drugdate, 20, 4) AS [YEAR]
, * FROM drug)
AS Z
GROUP BY [YEAR]
ORDER BY 1

SELECT
SUBSTRING (CONVERT CHAR(10), drugdate, 20, 6, 2) AS MON
, * FROM drug




--WHO���� ������ ATC CODE--
--�๰�� ���ؼ� 5���� ������ ��Ÿ���� �ý���
--7�� ĳ����, 1-�غ������ڸ� 2,3-A01�̸� �����ڸ� 4-�๰����Ư��, 5-�������и�
-- ATC ù���� ���ڸ��� ��������

SELECT LEFT(atccode, 1), * FROM Drug

SELECT DISTINCT LEFT(atccode, 1), count(personid) * FROM Drug
GROUP BY LEFT(atccode, 1)

--�������� ���̰� �ֳ�?

SELECT DISTINCT LEFT(atccode, 1) AS ATC_1,
LEFT (CONVERT(CHAR*10), drugdate, 20), 4) AS [Year]
count(personid) * FROM Drug
GROUP BY LEFT(atccode, 1)
--�̿ϼ�

--SQL�� ���ηθ� �����Ͱ� �����ϱ�, ������ �ǹ��׸���
--�� ATC_1  /  ���� �հ��...
-- ��Ŭ�� ������ ���� -> ������ ������, ATC_1�� ������ ���� �� ����..


SELECT
REPLACE