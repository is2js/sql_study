-- E : table, R : PK와 FK로 연결선, D : 다이어그램
-- 만약 ERD까 없다면, 키를 가지고 논리적으로 연결해야한다.
-- 구조(Relational이 명확하게 정의되어 있어야 join시 n이 늘어나거나 이러는 오류가 안난다)
-- 구조-Relation이 명확하지 않으면(join시 n이 부풀 수 ) 아무리 분석해봐야 소용없다.

--1. DB 구조 파악하기( ALT + F1으로 sp_help 먼저 해보자)
----sp_help TABLE와 함께, 엑셀을 뛰워놓고 복사해놓자. 컬럼들 분석해보자. -> ERD 생성-> 키 설정
sp_help Person
sp_help Drug
sp_help DiagnosisCodeMaster

--2. database 사이즈 파악하기 -> 엑셀을 바탕으로 해보자.
-- 각 table의 rowcount를 세고, join시 늘어난다면 key relationship이 잘못된것이다.
-- > COUNT한 것을 주석으로 달아놓기
SELECT COUNT(*) FROM Person;           --18570
SELECT COUNT(1) FROM Person; -- 다 안부르고도 빨리 세는 방법, mysql에서는 안된다. 
SELECT COUNT(1) FROM [dbo].[Diagnosis] --296690
SELECT COUNT(1) FROM [dbo].[DiagnosisCodeMaster] --7553
SELECT COUNT(1) FROM [dbo].[Drug] --1890626
SELECT COUNT(1) FROM [dbo].[DrugCodeMaster]--2627
SELECT COUNT(1) FROM [dbo].[Electrocardiogram]--35932
SELECT COUNT(1) FROM [dbo].[Laboratory]--147716


--3. 각 칼럼분석(Person부터)
--3-1. 
--1) personid는 int네..
sp_help Person

--2) sex칼럼 -> 문자가 아닌 code(숫자형범주)로 되어있는 것을 확인 -> count세보기
SELECT TOP 100 * FROM Person

------이것은 전체 유니크한 범주 확인 안한것이므로, 비추
SELECT COUNT(1) FROM Person WHERE sex = 0; --9263
SELECT COUNT(1) FROM Person WHERE sex = 1; --9307

--3) sex칼럼의 유니크한 범주확인하기 -> NULL 값도 찾아낼 수 있다.
SELECT DISTINCT sex FROM Person

--4) 그룹바이로 세보기
SELECT sex, COUNT(*) FROM Person GROUP BY sex
SELECT sex, COUNT(*) FROM Person 
GROUP BY sex 
ORDER BY 1 DESC -- GROUP BY 이후 ORDERBY는 1 값이 들어간다??***

--3-2. birthday DATETIME 데이터 다루기-> 엑셀로 켜서-> 날짜형식바꾸고 -> pivot테이블 가능
----- 연령대별로 나눠보기
---- 생년월일을 나이로 바꿔보기
----1) 
SELECT * FROM Person

-------오늘 지금 날짜가져오는 함수

SELECT GETDATE();
-------생년월일을 현재날짜까지 year로 표시하기 DATEIFF (형식, 시작날짜, 끝나는 날짜)
SELECT CONVERT(CHAR(8),birthday,112), * FROM Person
SELECT DATEDIFF(year,birthday,getdate()),* FROM Person
SELECT DATEDIFF(day,birthday,getdate()),* FROM Person
--만나이 확인하기??
SELECT DISTINCT DATEDIFF(year,birthday,getdate()) - DATEDIFF(day,birthday,getdate())/365 FROM Person
SELECT DATEDIFF(year,birthday,getdate()),DATEDIFF(day,birthday,getdate())/365,* FROM Person
--- 소스 파일로 보기.. 못따라감... 
--- CASE WHEN을 이용해서 바꿔보기
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



--- 3번재 시간
SELECT
*
INTO person_2
FROM Person

---수정한 테이블을... 괄호 전체로 묶어서 TABLE로 생각하고 가상의 Person_3을 
--- 못알아들음


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
--- AGE뿐만아니라 sex도 하고 부차적으로 하고 싶다면,
--- SELECT AGE, sex -> groupby에도 sex를 붙혀준다.


--- 엑셀에 결과를 붙혀넣고,, 조건부서식 -> 데이터막대ㅗ 예쁘게

----


---- DRUG 테이블---
--
sp_help Drug --칼럼 종류를 아래에 붙혀넣고 쿼리날릴때 붙혀넣기 해서 활용ㅎㄴ다.

personid
drugdate
druglocalcode
atccode
drugdept
route
duration

---person과 drug 비교
SELECT count(1) FROM Person -- 18172389
SELECT count(1) FROM Drug -- 18172389

--셀 때, distinct를 밖에다가 하고 세면,, 전체row만 나온다... 안에 넣어야함 조심!
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



------minmax avg에 대해서,, 무서움----
--count
--minmax는 sorting을 해준다.-> 문자를 sorting 과 숫자를 sorting하는 것은 다르다.
-- 엑셀에서도 한 열에 91, 1, 11, 91, 111 - > 데이터타입을 숫자로 해주고 soring해주면  잘 정렬되나
--- 문자로셀서식-> 텍스트(문자)로 선언하고 난 뒤, soring하면 1, 11, 111, 91, 91
--> 우리 데이터에서도
--drugdate가 다행히 문자열이 아니라 DATETIME으로 선언되어있기 때문에 제대로 minmax-자동sorting이 잘되었다.

ALTER TABLE Drug
ADD drugdate_char VARCHAR(20) 
UPDATE Drug SET drugdate_char = drugdate FROM drug
SELECT 
MIN(drugdate)	-- 
	, MAX(drugdate)		-- 
 ,MIN(drugdate_char)	-- 1994-06-24 00:00:00.000		-- 01  1 1996 12:00AM
	, MAX(drugdate_char)		-- 2011-08-23 00:00:00.000  -- 12 31 2010 12:00AM
FROM Drug 


--date타입바꿔주기.. T-SQL만..해ㅏㄷㅇ하는 convert
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


--약을 머를 제일 많이 쓰는지 카운트

SELECT druglocalcode, count(personid) FROM drug 
GROUP BY druglocalcode
ORDER BY 2 --추가..

SELECT druglocalcode, count(personid) FROM drug 
GROUP BY druglocalcode
ORDER BY 2 DESC--추가..

--제일 많이 나온.. 이것을 코드마스터에서 무슨약인지 조회
SELECT * FROM DrugCodeMaster WHERE druglocalcode = 'Drug1472'

--2번째, 3번째약 모두 이렇게 조회할 수 없으니 join을 한다.
SELECT druglocalcode,
(SELECT drugigrdname FROM DrugCodeMaster as a WHERE a.druglocalcode = b.druglocalcode) AS 성분명
, count(personid) AS 처방건수
FROM drug as b
GROUP BY druglocalcode
ORDER BY 3 DESC

SELECT a.druglocalcode,
drugigrdname  AS 성분명
, count(personid) AS 처방건수
FROM drug as b
JOIN Drug as a ON a.druglocalcode = b.druglocalcode
GROUP BY a.druglocalcode, drugigrdname
ORDER BY 3 DESC
--위에 2놈 확실하지 않음..




---- DATETIME의 앞의 4글자를 빼오기 위해서는 CHAR 문자열로 넉넉하게 바꾼 다음가져온다.
SELECT SUBSTRING(CONVERT(varchar(20),drugdate),7,4), atccode, count(personid)  FROM drug 
GROUP BY  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), atccode



SELECT SUBSTRING(CONVERT(varchar(20),drugdate),7,4), LEFT(atccode,1), count(personid)  FROM drug 
GROUP BY  SUBSTRING(CONVERT(varchar(20),drugdate),7,4), LEFT(atccode,1)
--위에 2개도...


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




--WHO에서 나오는 ATC CODE--
--약물에 대해서 5개로 나누어 나타나는 시스템
--7개 캐릭터, 1-해부학적자리 2,3-A01이면 세부자리 4-약물학적특성, 5-개별성분명
-- ATC 첫번재 한자리만 가져오기

SELECT LEFT(atccode, 1), * FROM Drug

SELECT DISTINCT LEFT(atccode, 1), count(personid) * FROM Drug
GROUP BY LEFT(atccode, 1)

--연도별로 차이가 있나?

SELECT DISTINCT LEFT(atccode, 1) AS ATC_1,
LEFT (CONVERT(CHAR*10), drugdate, 20), 4) AS [Year]
count(personid) * FROM Drug
GROUP BY LEFT(atccode, 1)
--미완성

--SQL은 세로로만 데이터가 나오니까, 엑셀로 피벗그리기
--행 ATC_1  /  값은 합계로...
-- 우클릭 데이터 선택 -> 연도가 행으로, ATC_1은 범레로 보낼 수 있음..


SELECT
REPLACE