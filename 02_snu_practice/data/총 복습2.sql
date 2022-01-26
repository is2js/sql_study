
CREATE DATABASE practice_medi2

USE practice_medi2

-- CodeMaster 칼럼2개 제외 DB우클릭 > T, I > END + W + TAb 아래2칸 + ShiftTaB3칸 파일선택  > N > N > END 위로3칸  > N N F 
-- 가져오기마법사로 실패하는 경우
-- 1. Table 생성 > 2. BELK INSERT 로 csv 파일 집어넣기

CREATE TABLE DrugCodeMaster (
druglocalcode varchar(20),
drugigrname varchar(100)
)

CREATE TABLE DiagnosisCodeMaster (
diaglocalcode varchar(20),
diagname varchar(max)
)

BULK INSERT [dbo].[DrugCodeMaster] FROM 'C:\Users\is2js\Desktop\인턴활동\0111 DB세미나\sql_loading_sample\DrugCodeMaster.csv'
WITH (FIRSTROW = 2, KEEPNULLS, format='CSV')

BULK INSERT [dbo].[DiagnosisCodeMaster] FROM 'C:\Users\is2js\Desktop\인턴활동\0111 DB세미나\sql_loading_sample\DiagnosisCodeMaster.csv'
WITH (FIRSTROW = 2, KEEPNULLS, format='CSV')



-- 실전 분석해보기 --
-- alt+f1, 엑셀--
[dbo].[person]
[dbo].[drug]
[dbo].[DrugCodeMaster]
[dbo].[Diagnosis]
[dbo].[DiagnosisCodeMaster]
[dbo].[Electrocardiogram]
[dbo].[laboratory]

-- 개수 한꺼번에 세기
SELECT COUNT(1) FROM [person]				--18570
SELECT COUNT(1) FROM [drug]					--1890626
SELECT COUNT(1) FROM [DrugCodeMaster]		--2627
SELECT COUNT(1) FROM [Diagnosis]			--296690
SELECT COUNT(1) FROM [DiagnosisCodeMaster]	--7553
SELECT COUNT(1) FROM [Electrocardiogram]	--35932
SELECT COUNT(1) FROM [laboratory]			--147716


---person table 분석
Person
--칼럼명
personid
sex
birthday
ethnicity

-- 데이터 전체 head보기
SELECT TOP 100 * FROM person
-- key 칼럼의 distinct한 개수 보기
-- person
SELECT COUNT(DISTINCT personid) FROM person		--18570

-- sex	
SELECT TOP 100 sex FROM person					--head

SELECT DISTINCT sex FROM person					--sex의 종류 : 1, 0

SELECT COUNT(DISTINCT sex) FROM person			--sex 종류개수 : 2가지 - 종류가 너무 많을 때

SELECT sex, COUNT(personid) cnt FROM person		--1	9307 / 0	9263
GROUP BY sex


SELECT 9307 + 9263								-- 전체(18570)과 sex의 범주별 합(1+0)이 같은지 보고, sex에서 null없나 확인

SELECT * FROM person							-- sex에 null값 확인
WHERE sex IS NULL

SELECT sex, COUNT(personid) FROM person
GROUP BY sex
ORDER BY 1

--birthday
SELECT TOP 100 birthday FROM person					--head

SELECT birthday, COUNT(personid) cnt FROM person	--시계열별 groupby count(사람수)
GROUP BY birthday

SELECT birthday, COUNT(personid) cnt FROM person	--시계열별 groupby count(사람수) -> Order by 후 엑셀 시각화
GROUP BY birthday
ORDER BY 1


SELECT GETDATE()

SELECT DATEDIFF(year, birthday, GETDATE()) FROM person		-- 해나이 : interval을 year로
SELECT DATEDIFF(day, birthday, GETDATE()) / 365 FROM person -- 만나이 : interval을 day로 계산한 뒤, 365일을 나눠주기(몫만 남음)

SELECT  DATEDIFF(year, birthday, GETDATE()) 해나이, DATEDIFF(day, birthday, GETDATE()) / 365 만나이 FROM person


SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10세 미만'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90세 이상'
END AS 연령대, * FROM person

-- 변형칼럼을 groupby 하기 위해, SELECT *INTO* FROM으로 새 테이블 만들기
SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10세 미만'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90세 이상'
END AS 연령대, * 
INTO person_with_age
FROM person

SELECT TOP 100 * FROM person_with_age

-- 새 테이블로 연령대별 groupby 사람수 카운트하기
SELECT 연령대, COUNT(personid) cnt FROM person_with_age
GROUP BY 연령대
ORDER BY 1


--subquery로 테이블 생성없이 하기
SELECT 연령대, COUNT(personid) cnt FROM (
SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10세 미만'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90세 이상'
END AS 연령대, * FROM person
)Z
GROUP BY 연령대
ORDER BY 1


SELECT 연령대, sex,  COUNT(personid) cnt FROM (
SELECT
CASE WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 0 and 9
	THEN '10세 미만'
	 WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 10 and 19
	THEN '10대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 20 and 29
	THEN '20대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 30 and 39
	THEN '30대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 40 and 49
	THEN '40대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 50 and 59
	THEN '50대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 60 and 69
	THEN '60대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 70 and 79
	THEN '70대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 BETWEEN 80 and 89
	THEN '80대'
	WHEN  DATEDIFF(day, birthday, GETDATE()) / 365 >= 90
	THEN '90세 이상'
END AS 연령대, * FROM person
)Z
GROUP BY 연령대, sex
ORDER BY 1, 2

-- 엑셀에서 연령대별 성별별 시각화해보기 : shift+핸들바로 밀어올리기 활용 / 홈>스타일> 조건부서식 > 데이터 막대



--ethnicity 칼럼
SELECT TOP 100 ethnicity FROM person

SELECT DISTINCT ethnicity FROM person

SELECT COUNT(DISTINCT ethnicity) FROM person

SELECT ethnicity, COUNT(personid) cnt FROM person
GROUP BY ethnicity
ORDER BY 1
--0	172
--1	18398




--drug 테이블--
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

--key칼럼인 personid
SELECT COUNT(DISTINCT personid) FROM person				--18570
SELECT COUNT(DISTINCT personid) FROM drug				--15430  약 안받은 환자 3100명

SELECT cast(15430 as float)/ cast(18570 as float)		--0.830910070005385 = 83%
SELECT 15430 * 1.0 / 18570


--범주형 drugdept
SELECT TOP 100 drugdept FROM drug

SELECT DISTINCT drugdept FROM drug						-- I E H O

SELECT COUNT(DISTINCT drugdept) FROM drug				-- 범주 4가지

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

SELECT 82257+1770+1431086+375513						--1890626  == drug전체데이터 1890626 => null값 없음
SELECT * FROM drug WHERE drugdept IS NULL




-- 범주형 route칼럼
SELECT TOP 100 route FROM drug

SELECT DISTINCT route FROM drug							--E P 
SELECT COUNT(DISTINCT route) FROM drug					--2종류

SELECT route, COUNT(personid) cnt FROM drug
GROUP BY route
ORDER BY 1
--E	1176263
--P	714363

SELECT * FROM drug WHERE route IS NULL






-- 범주형 같아보이지만 연속형 duration
SELECT TOP 100 duration FROM drug


SELECT DISTINCT duration FROM drug	
SELECT DISTINCT CONVERT(smallint, duration) "duration(int)" FROM drug		--응용					-- 
ORDER BY 1

SELECT COUNT(DISTINCT duration) FROM drug					--126종류


ALTER TABLE drug ALTER COLUMN duration int					--칼럼 타입 변경

SELECT MIN(duration) min, MAX(duration) max, AVG(duration) avg FROM drug -- 0	390	7





--날짜(생년월일x) 칼럼 drugdate
SELECT TOP 100 drugdate FROM drug

ALTER TABLE drug ALTER COLUMN drugdate DATETIME					--칼럼 타입 변경

SELECT MIN(drugdate) min, MAX(drugdate) max FROM drug		--1994-06-24 00:00:00	2011-08-23 00:00:00

SELECT TOP 100 CONVERT(char(20), drugdate, 112) as YYYYmmdd, * FROM drug -- CONVERT 112 : YYYYmmdd

SELECT TOP 100 SUBSTRING(CONVERT(char(20), drugdate, 112), 1, 4) as year FROM drug -- 필요시 SUBSTRING( CONVERT, 시작,이후갯수) ->: YYYY

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





--연속형처럼보이는 범주형 code칼럼 : druglocalcode

SELECT DISTINCT druglocalcode FROM drug					-- 종류 너무 많음

SELECT COUNT(DISTINCT druglocalcode) FROM drug			--2276

SELECT druglocalcode, COUNT(personid) cnt			-- 범주의 종류가 많으면, 카운트 칼럼으로 머를 많이 썼는지 DESC ORDER BY
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


--연도별 처방빈도
SELECT SUBSTRING( CONVERT(varchar(8), drugdate,112), 1, 4) year, * FROM drug

SELECT year, COUNT(personid) cnt
FROM(
SELECT SUBSTRING( CONVERT(varchar(8), drugdate,112), 1, 4) year, * FROM drug
)Z
GROUP BY year
ORDER BY year DESC

--월별별 처방빈도
SELECT months, COUNT(personid) cnt
FROM(
SELECT SUBSTRING( CONVERT(varchar(8), drugdate,112), 5, 2) months, * FROM drug
)Z
GROUP BY months
ORDER BY months ASC



-- 범주형칼럼 route
SELECT TOP 100 route FROM drug

SELECT DISTINCT route FROM drug

SELECT COUNT(DISTINCT route) FROM drug

SELECT route, COUNT(DISTINCT personid) cnt FROM drug 
GROUP BY route
--E	14321
--P	12077

SELECT COUNT(DISTINCT personid) FROM drug			-- 15430 사람수보다 E + P이 크다 = 교집합이 있다.

SELECT * FROM drug WHERE route IS NULL



--의미내포 범주형 code칼럼 : atccode
SELECT TOP 100 atccode FROM drug

SELECT COUNT(DISTINCT atccode) FROM drug			--984

SELECT LEFT(atccode, 1) FROM drug
SELECT LEFT(atccode, 1), * FROM drug

SELECT												-- 내포코드별 빈도확인
atc_1, COUNT(personid) cnt
FROM(
SELECT LEFT(atccode, 1) atc_1, * FROM drug
)Z
GROUP BY atc_1
ORDER BY 2 DESC


-- 연도별 내포코드별 빈도확인
SELECT SUBSTRING(CONVERT(varchar(8), drugdate, 112), 1, 4) FROM drug

SELECT												
year, atc_1, COUNT(personid) cnt
FROM(
SELECT SUBSTRING(CONVERT(varchar(8), drugdate, 112), 1, 4) year, LEFT(atccode, 1) atc_1, * FROM drug
)Z
GROUP BY year, atc_1
ORDER BY 1 ASC