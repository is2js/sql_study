-- �ǽ���_2.sql 
-- Data Modification : exploratory data analysis�� ���� �ǽ� 

--�� 7���� Table �ľ� ��--------
Person, Diagnosis, Drug, Laboratory, Electrocardiogram
DrugCodeMaster, DiagnosisCodeMaster 

-- 0. datarow count -- ���� ��� �м��� �⺻�� �ȴ�.
-- �� ��ġ�� ������� ������� reasonable�Ѱ��� ��� �Ӹ������� �ٽ� �����Ѵ�
SELECT count(1) FROM Person					-- 18570
SELECT count(1) FROM Diagnosis				-- 296690
SELECT count(1) FROM Drug					-- 1890626
SELECT count(1) FROM Laboratory				-- 147716
SELECT count(1) FROM Electrocardiogram		-- 35932
SELECT count(1) FROM DrugCodeMaster			-- 2627
SELECT count(1) FROM DiagnosisCodeMaster	-- 7553 

-- 1. Person Table ���캸�� 
-- Table�� �÷�, data type, precision ���� Ȯ���Ѵ�.
sp_help Person 

-- Data�� �뷫���� ���¸� ������ Ȯ���Ѵ� 
SELECT top 100 * FROM Person 

-- �� �÷����� ������ �ľ��Ѵ�.
personid
sex
birthday
ethnicity

-- ID - ����
SELECT count(DISTINCT personid) FROM Person -- 18570
SELECT count(DISTINCT sex) FROM Person -- 2

-- ���� -- �ڵ尪? 
SELECT DISTINCT sex FROM Person 
-- ���� -- ���? 
SELECT sex, count(personid) FROM Person GROUP BY sex -- 9263 / 9307

-- ������� -- ����?
SELECT birthday, count(personid) AS person_cnt FROM Person GROUP BY birthday -- 9263 / 9307
ORDER BY birthday

-- ������� --> ���̷� �ٲٱ�
SELECT CONVERT(CHAR(8),birthday,112), * FROM Person
SELECT DATEDIFF(year,birthday,getdate()),* FROM Person
SELECT DISTINCT DATEDIFF(year,birthday,getdate()) - DATEDIFF(day,birthday,getdate())/365 FROM Person

SELECT DATEDIFF(year,birthday,getdate()),DATEDIFF(day,birthday,getdate())/365,* FROM Person
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

SELECT AGE, sex, count(personid) FROM 
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
AS AGE, sex, personid FROM Person
) Z 
GROUP BY AGE, sex
ORDER BY 1, 2

-- 2. Drug table 
sp_help Drug

personid
drugdate
druglocalcode
atccode
drugdept
route
duration

-- Data�� �Ը� �ľ��ϱ�
-- ȯ�ڼ�? 
SELECT COUNT(DISTINCT personid) FROM Drug -- 15430

-- ** ���� ** �������� ���� �Ͼ�� �Ǽ� : count�� �����ϱ� n���� ���� ���̴�!
SELECT DISTINCT COUNT(personid) FROM Drug

-- ����� �Ⱓ?
SELECT MIN(Drugdate)	-- 1994-06-24 00:00:00.000
	, MAX(Drugdate)		-- 2011-08-23 00:00:00.000
FROM Drug 

-- ������ �ִ� code�� ��?
SELECT COUNT(DISTINCT druglocalcode) FROM Drug  -- 2276 
SELECT COUNT(DISTINCT atccode) FROM Drug  -- 984 

-- ** MIN, MAX�� ���� : ���ڵ� �������ش�. datatype�� �Բ� Ȯ�� 
-- ALTER TABLE Drug
-- ADD drugdate_char VARCHAR(20) 

-- UPDATE Drug SET drugdate_char = drugdate FROM drug

/* 
SELECT MIN(drugdate_char)	-- 1994-06-24 00:00:00.000		-- 01  1 1996 12:00AM
	, MAX(drugdate_char)		-- 2011-08-23 00:00:00.000  -- 12 31 2010 12:00AM
FROM Drug 

SELECT top 100 CONVERT(CHAR(8), drugdate, 10), * FROM drug 

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
*/

SELECT top 100  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), * FROM Drug

SELECT COUNT(DISTINCT route) FROM Drug 
SELECT DISTINCT route FROM Drug 
SELECT route, count(personid) FROM Drug GROUP BY route
-- E -- 1176263
-- P -- 714363
SELECT drugdept, count(drugdept) FROM Drug GROUP BY drugdept
-- E -- 82257
-- H -- 1770
-- I -- 1431086
-- O -- 375513

SELECT min(duration), max(duration), avg(duration) FROM Drug 

SELECT druglocalcode, count(personid) FROM drug GROUP BY druglocalcode

SELECT SUBSTRING(CONVERT(varchar(20),drugdate),7,4), atccode, count(personid)  FROM drug 
GROUP BY  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), atccode

SELECT SUBSTRING(CONVERT(varchar(20),drugdate),7,4), LEFT(atccode,1), count(personid)  FROM drug 
GROUP BY  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), LEFT(atccode,1)

SELECT druglocalcode, count(personid) AS Cnt 
FROM drug WHERE LEFT(atccode,1) = 'A'
GROUP BY druglocalcode

-- Drug local code? 
SELECT top 100 * FROM DrugCodeMaster 

-- In line view 
SELECT 
(SELECT drugigrdname FROM DrugCodeMaster a WHERE a.druglocalcode = z.druglocalcode ) AS DrugName 
, druglocalcode, count(personid) AS Cnt 
FROM drug  z WHERE LEFT(atccode,1) = 'A'
GROUP BY druglocalcode

SELECT 
(SELECT drugigrdname FROM DrugCodeMaster a WHERE a.druglocalcode = z.druglocalcode ) AS DrugName 
, druglocalcode, count(personid) AS Cnt 
FROM drug  z WHERE LEFT(atccode,1) = 'A'
GROUP BY druglocalcode
ORDER BY 3 DESC  -- 370

-- In line view�� Join���� ��κ� ��ü�ȴ�.
SELECT 
--(SELECT drugigrdname FROM DrugCodeMaster a WHERE a.druglocalcode = z.druglocalcode ) AS DrugName 
a.drugigrdname
, z.druglocalcode, count(personid) AS Cnt 
FROM drug  z 
JOIN DrugCodeMaster a ON  a.druglocalcode = z.druglocalcode
WHERE LEFT(atccode,1) = 'A'
GROUP BY z.druglocalcode,a.drugigrdname
ORDER BY 3 DESC  -- 370

