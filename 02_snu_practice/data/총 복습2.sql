
CREATE DATABASE practice_medi2

USE practice_medi2

-- CodeMaster Į��2�� ���� DB��Ŭ�� > T, I > END + W + TAb �Ʒ�2ĭ + ShiftTaB3ĭ ���ϼ���  > N > N > END ����3ĭ  > N N F 
-- �������⸶����� �����ϴ� ���
-- 1. Table ���� > 2. BELK INSERT �� csv ���� ����ֱ�

CREATE TABLE DrugCodeMaster (
druglocalcode varchar(20),
drugigrname varchar(100)
)

CREATE TABLE DiagnosisCodeMaster (
diaglocalcode varchar(20),
diagname varchar(max)
)

BULK INSERT [dbo].[DrugCodeMaster] FROM 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\DrugCodeMaster.csv'
WITH (FIRSTROW = 2, KEEPNULLS, format='CSV')

BULK INSERT [dbo].[DiagnosisCodeMaster] FROM 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\DiagnosisCodeMaster.csv'
WITH (FIRSTROW = 2, KEEPNULLS, format='CSV')



-- ���� �м��غ��� --
-- alt+f1, ����--
[dbo].[person]
[dbo].[drug]
[dbo].[DrugCodeMaster]
[dbo].[Diagnosis]
[dbo].[DiagnosisCodeMaster]
[dbo].[Electrocardiogram]
[dbo].[laboratory]

-- ���� �Ѳ����� ����
SELECT COUNT(1) FROM [person]				--18570
SELECT COUNT(1) FROM [drug]					--1890626
SELECT COUNT(1) FROM [DrugCodeMaster]		--2627
SELECT COUNT(1) FROM [Diagnosis]			--296690
SELECT COUNT(1) FROM [DiagnosisCodeMaster]	--7553
SELECT COUNT(1) FROM [Electrocardiogram]	--35932
SELECT COUNT(1) FROM [laboratory]			--147716


---person table �м�
Person
--Į����
personid
sex
birthday
ethnicity

-- ������ ��ü head����
SELECT TOP 100 * FROM person
-- key Į���� distinct�� ���� ����
-- person
SELECT COUNT(DISTINCT personid) FROM person		--18570

-- sex	
SELECT TOP 100 sex FROM person					--head

SELECT DISTINCT sex FROM person					--sex�� ���� : 1, 0

SELECT COUNT(DISTINCT sex) FROM person			--sex �������� : 2���� - ������ �ʹ� ���� ��

SELECT sex, COUNT(personid) cnt FROM person		--1	9307 / 0	9263
GROUP BY sex


SELECT 9307 + 9263								-- ��ü(18570)�� sex�� ���ֺ� ��(1+0)�� ������ ����, sex���� null���� Ȯ��

SELECT * FROM person							-- sex�� null�� Ȯ��
WHERE sex IS NULL

SELECT sex, COUNT(personid) FROM person
GROUP BY sex
ORDER BY 1

--birthday
SELECT TOP 100 birthday FROM person					--head

SELECT birthday, COUNT(personid) cnt FROM person	--�ð迭�� groupby count(�����)
GROUP BY birthday

SELECT birthday, COUNT(personid) cnt FROM person	--�ð迭�� groupby count(�����) -> Order by �� ���� �ð�ȭ
GROUP BY birthday
ORDER BY 1


SELECT GETDATE()

SELECT DATEDIFF(year, birthday, GETDATE()) FROM person		-- �س��� : interval�� year��
SELECT DATEDIFF(day, birthday, GETDATE()) / 365 FROM person -- ������ : interval�� day�� ����� ��, 365���� �����ֱ�(�� ����)

SELECT  DATEDIFF(year, birthday, GETDATE()) �س���, DATEDIFF(day, birthday, GETDATE()) / 365 ������ FROM person


SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10�� �̸�'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90�� �̻�'
END AS ���ɴ�, * FROM person

-- ����Į���� groupby �ϱ� ����, SELECT *INTO* FROM���� �� ���̺� �����
SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10�� �̸�'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90�� �̻�'
END AS ���ɴ�, * 
INTO person_with_age
FROM person

SELECT TOP 100 * FROM person_with_age

-- �� ���̺��� ���ɴ뺰 groupby ����� ī��Ʈ�ϱ�
SELECT ���ɴ�, COUNT(personid) cnt FROM person_with_age
GROUP BY ���ɴ�
ORDER BY 1


--subquery�� ���̺� �������� �ϱ�
SELECT ���ɴ�, COUNT(personid) cnt FROM (
SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10�� �̸�'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90�� �̻�'
END AS ���ɴ�, * FROM person
)Z
GROUP BY ���ɴ�
ORDER BY 1


SELECT ���ɴ�, sex,  COUNT(personid) cnt FROM (
SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10�� �̸�'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80��'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90�� �̻�'
END AS ���ɴ�, * FROM person
)Z
GROUP BY ���ɴ�, sex
ORDER BY 1, 2

-- �������� ���ɴ뺰 ������ �ð�ȭ�غ��� : shift+�ڵ�ٷ� �о�ø��� Ȱ�� / Ȩ>��Ÿ��> ���Ǻμ��� > ������ ����



--ethnicity Į��
SELECT TOP 100 ethnicity FROM person

SELECT DISTINCT ethnicity FROM person

SELECT COUNT(DISTINCT ethnicity) FROM person

SELECT ethnicity, COUNT(personid) cnt FROM person
GROUP BY ethnicity
ORDER BY 1
--0	172
--1	18398




--drug ���̺�--
drug
personid
drugdate
druglocalcode
atccode
drugdept
route
duration

SELECT COUNT(1) FROM drug								--1890626

SELECT TOP 10 * FROM drug

--keyĮ���� personid
SELECT COUNT(DISTINCT personid) FROM person				--18570
SELECT COUNT(DISTINCT personid) FROM drug				--15430  �� �ȹ��� ȯ�� 3100��

SELECT cast(15430 as float)/ cast(18570 as float)		--0.830910070005385 = 83%
SELECT 15430 * 1.0 / 18570


--������ drugdept
SELECT TOP 100 drugdept FROM drug

SELECT DISTINCT drugdept FROM drug						-- I E H O

SELECT COUNT(DISTINCT drugdept) FROM drug				-- ���� 4����

SELECT drugdept, COUNT(personid) cnt FROM drug
GROUP BY drugdept
ORDER BY 1
--E	82257
--H	1770
--I	1431086
--O	375513

SELECT drugdept, COUNT(DISTINCT personid) cnt FROM drug
GROUP BY drugdept
ORDER BY 1
--E	5298
--H	868
--I	8747
--O	11294

SELECT 82257+1770+1431086+375513						--1890626  == drug��ü������ 1890626 => null�� ����
SELECT * FROM drug WHERE drugdept IS NULL




-- ������ routeĮ��
SELECT TOP 100 route FROM drug

SELECT DISTINCT route FROM drug							--E P 
SELECT COUNT(DISTINCT route) FROM drug					--2����

SELECT route, COUNT(personid) cnt FROM drug
GROUP BY route
ORDER BY 1
--E	1176263
--P	714363

SELECT * FROM drug WHERE route IS NULL






-- ������ ���ƺ������� ������ duration
SELECT TOP 100 duration FROM drug


SELECT DISTINCT duration FROM drug	
SELECT DISTINCT CONVERT(smallint, duration) "duration(int)" FROM drug		--����					-- 
ORDER BY 1

SELECT COUNT(DISTINCT duration) FROM drug					--126����


ALTER TABLE drug ALTER COLUMN duration int					--Į�� Ÿ�� ����

SELECT MIN(duration) min, MAX(duration) max, AVG(duration) avg FROM drug -- 0	390	7





--��¥(�������x) Į�� drugdate
SELECT TOP 100 drugdate FROM drug

ALTER TABLE drug ALTER COLUMN drugdate DATETIME					--Į�� Ÿ�� ����

SELECT MIN(drugdate) min, MAX(drugdate) max FROM drug		--1994-06-24 00:00:00	2011-08-23 00:00:00

SELECT TOP 100 CONVERT(char(20), drugdate, 112) as YYYYmmdd, * FROM drug -- CONVERT 112 : YYYYmmdd

SELECT TOP 100 SUBSTRING(CONVERT(char(20), drugdate, 112), 1, 4) as year FROM drug -- �ʿ�� SUBSTRING( CONVERT, ����,���İ���) ->: YYYY

SELECT YYYYmmdd
FROM (
SELECT  CONVERT(char(20), drugdate, 112) as YYYYmmdd, * FROM drug 
)Z

SELECT MIN(YYYYmmdd) min, MAX(YYYYmmdd) max									                            
FROM (
SELECT CONVERT(char(20), drugdate, 112) as YYYYmmdd, * FROM drug 
)Z


SELECT YYYYmmdd year, COUNT(personid) 								                            
FROM (
SELECT CONVERT(char(20), drugdate, 112) as YYYYmmdd, * FROM drug 
)Z
GROUP BY YYYYmmdd
ORDER BY 1





--������ó�����̴� ������ codeĮ�� : druglocalcode

SELECT DISTINCT druglocalcode FROM drug					-- ���� �ʹ� ����

SELECT COUNT(DISTINCT druglocalcode) FROM drug			--2276

SELECT druglocalcode, COUNT(personid) cnt			-- ������ ������ ������, ī��Ʈ Į������ �Ӹ� ���� ����� DESC ORDER BY
FROM drug
GROUP BY druglocalcode
ORDER BY 2 DESC
--Drug2069	27997
--Drug1472	23168
--Drug452	22800
--Drug2163	21542
--Drug2501	20501


SELECT * FROM DrugCodeMaster WHERE druglocalcode = 'Drug2069';	--Drug2069	Tramadol.HCl
--1)
SELECT drugigrname FROM DrugCodeMaster WHERE druglocalcode = 'Drug2069';
--2)
SELECT drugigrname FROM DrugCodeMaster WHERE druglocalcode = druglocalcode;
--3)
SELECT 
(SELECT drugigrname FROM DrugCodeMaster dcm WHERE dcm.druglocalcode = d.druglocalcode) drugigrname, *
FROM drug d
--4)
SELECT 
(SELECT drugigrname FROM DrugCodeMaster dcm WHERE dcm.druglocalcode = d.druglocalcode) drugigrname, d.druglocalcode, COUNT(personid) cnt
FROM drug d
GROUP BY d.druglocalcode
ORDER BY 3 DESC

--join
SELECT * FROM Drug a
JOIN DrugCodeMaster b ON a.druglocalcode = b.druglocalcode

SELECT drugigrname, a.druglocalcode, COUNT(personid) cnt FROM Drug a
JOIN DrugCodeMaster b ON a.druglocalcode = b.druglocalcode
GROUP BY drugigrname, a.druglocalcode
ORDER BY 3 DESC


--������ ó���
SELECT SUBSTRING( CONVERT(varchar(8), drugdate,112), 1, 4) year, * FROM drug

SELECT year, COUNT(personid) cnt
FROM(
SELECT SUBSTRING( CONVERT(varchar(8), drugdate,112), 1, 4) year, * FROM drug
)Z
GROUP BY year
ORDER BY year DESC

--������ ó���
SELECT months, COUNT(personid) cnt
FROM(
SELECT SUBSTRING( CONVERT(varchar(8), drugdate,112), 5, 2) months, * FROM drug
)Z
GROUP BY months
ORDER BY months ASC



-- ������Į�� route
SELECT TOP 100 route FROM drug

SELECT DISTINCT route FROM drug

SELECT COUNT(DISTINCT route) FROM drug

SELECT route, COUNT(DISTINCT personid) cnt FROM drug 
GROUP BY route
--E	14321
--P	12077

SELECT COUNT(DISTINCT personid) FROM drug			-- 15430 ��������� E + P�� ũ�� = �������� �ִ�.

SELECT * FROM drug WHERE route IS NULL



--�ǹ̳��� ������ codeĮ�� : atccode
SELECT TOP 100 atccode FROM drug

SELECT COUNT(DISTINCT atccode) FROM drug			--984

SELECT LEFT(atccode, 1) FROM drug
SELECT LEFT(atccode, 1), * FROM drug

SELECT												-- �����ڵ庰 ��Ȯ��
atc_1, COUNT(personid) cnt
FROM(
SELECT LEFT(atccode, 1) atc_1, * FROM drug
)Z
GROUP BY atc_1
ORDER BY 2 DESC


-- ������ �����ڵ庰 ��Ȯ��
SELECT SUBSTRING(CONVERT(varchar(8), drugdate, 112), 1, 4) FROM drug

SELECT												
year, atc_1, COUNT(personid) cnt
FROM(
SELECT SUBSTRING(CONVERT(varchar(8), drugdate, 112), 1, 4) year, LEFT(atccode, 1) atc_1, * FROM drug
)Z
GROUP BY year, atc_1
ORDER BY 1 ASC