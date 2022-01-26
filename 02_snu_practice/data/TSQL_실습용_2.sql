-- 실습용_2.sql 
-- Data Modification : exploratory data analysis를 통한 실습 

--★ 7개의 Table 파악 ★--------
Person, Diagnosis, Drug, Laboratory, Electrocardiogram
DrugCodeMaster, DiagnosisCodeMaster 

-- 0. datarow count -- 이후 모든 분석의 기본이 된다.
-- 이 수치를 기반으로 결과값이 reasonable한가를 계속 머릿속으로 다시 점검한다
SELECT count(1) FROM Person					-- 18570
SELECT count(1) FROM Diagnosis				-- 296690
SELECT count(1) FROM Drug					-- 1890626
SELECT count(1) FROM Laboratory				-- 147716
SELECT count(1) FROM Electrocardiogram		-- 35932
SELECT count(1) FROM DrugCodeMaster			-- 2627
SELECT count(1) FROM DiagnosisCodeMaster	-- 7553 

-- 1. Person Table 살펴보기 
-- Table의 컬럼, data type, precision 등을 확인한다.
sp_help Person 

-- Data의 대략적인 형태를 눈으로 확인한다 
SELECT top 100 * FROM Person 

-- 각 컬럼별로 성격을 파악한다.
personid
sex
birthday
ethnicity

-- ID - 갯수
SELECT count(DISTINCT personid) FROM Person -- 18570
SELECT count(DISTINCT sex) FROM Person -- 2

-- 성별 -- 코드값? 
SELECT DISTINCT sex FROM Person 
-- 남녀 -- 몇명? 
SELECT sex, count(personid) FROM Person GROUP BY sex -- 9263 / 9307

-- 생년월일 -- 분포?
SELECT birthday, count(personid) AS person_cnt FROM Person GROUP BY birthday -- 9263 / 9307
ORDER BY birthday

-- 생년월일 --> 나이로 바꾸기
SELECT CONVERT(CHAR(8),birthday,112), * FROM Person
SELECT DATEDIFF(year,birthday,getdate()),* FROM Person
SELECT DISTINCT DATEDIFF(year,birthday,getdate()) - DATEDIFF(day,birthday,getdate())/365 FROM Person

SELECT DATEDIFF(year,birthday,getdate()),DATEDIFF(day,birthday,getdate())/365,* FROM Person
SELECT 
CASE WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 0 AND 9
	THEN '10세미만'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 10 AND 19 
	THEN '10대' 
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 20 AND 29 
	THEN '20대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 30 AND 39 
	THEN '30대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 40 AND 49 
	THEN '40대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 50 AND 59 
	THEN '50대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 60 AND 69 
	THEN '60대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 70 AND 79 
	THEN '70대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 80 AND 89 
	THEN '80대'
	WHEN DATEDIFF(day,birthday,getdate())/365 >= 90 
	THEN '90세이상'
	END
AS AGE, * FROM Person

SELECT AGE, count(personid) FROM 
(
SELECT 
CASE WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 0 AND 9
	THEN '10세미만'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 10 AND 19 
	THEN '10대' 
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 20 AND 29 
	THEN '20대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 30 AND 39 
	THEN '30대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 40 AND 49 
	THEN '40대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 50 AND 59 
	THEN '50대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 60 AND 69 
	THEN '60대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 70 AND 79 
	THEN '70대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 80 AND 89 
	THEN '80대'
	WHEN DATEDIFF(day,birthday,getdate())/365 >= 90 
	THEN '90세이상'
	END
AS AGE, personid FROM Person
) Z 
GROUP BY AGE 
ORDER BY 1

SELECT AGE, sex, count(personid) FROM 
(
SELECT 
CASE WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 0 AND 9
	THEN '10세미만'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 10 AND 19 
	THEN '10대' 
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 20 AND 29 
	THEN '20대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 30 AND 39 
	THEN '30대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 40 AND 49 
	THEN '40대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 50 AND 59 
	THEN '50대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 60 AND 69 
	THEN '60대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 70 AND 79 
	THEN '70대'
	WHEN DATEDIFF(day,birthday,getdate())/365 BETWEEN 80 AND 89 
	THEN '80대'
	WHEN DATEDIFF(day,birthday,getdate())/365 >= 90 
	THEN '90세이상'
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

-- Data의 규모 파악하기
-- 환자수? 
SELECT COUNT(DISTINCT personid) FROM Drug -- 15430

-- ** 주의 ** 생각보다 자주 일어나는 실수 : count를 했으니까 n수를 셌을 것이다!
SELECT DISTINCT COUNT(personid) FROM Drug

-- 저장된 기간?
SELECT MIN(Drugdate)	-- 1994-06-24 00:00:00.000
	, MAX(Drugdate)		-- 2011-08-23 00:00:00.000
FROM Drug 

-- 가지고 있는 code의 수?
SELECT COUNT(DISTINCT druglocalcode) FROM Drug  -- 2276 
SELECT COUNT(DISTINCT atccode) FROM Drug  -- 984 

-- ** MIN, MAX의 주의 : 문자도 정렬해준다. datatype을 함께 확인 
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

-- In line view는 Join으로 대부분 대체된다.
SELECT 
--(SELECT drugigrdname FROM DrugCodeMaster a WHERE a.druglocalcode = z.druglocalcode ) AS DrugName 
a.drugigrdname
, z.druglocalcode, count(personid) AS Cnt 
FROM drug  z 
JOIN DrugCodeMaster a ON  a.druglocalcode = z.druglocalcode
WHERE LEFT(atccode,1) = 'A'
GROUP BY z.druglocalcode,a.drugigrdname
ORDER BY 3 DESC  -- 370

