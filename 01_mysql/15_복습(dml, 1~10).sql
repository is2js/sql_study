-- db = tables  -> show databases;
show databases;

--table -> use, show tables[or table status]
use world;
show tables;
show table status;

--columns -> desc 
describe city;
desc city; -- desc 는 테이블을 desc 
desc country;
desc countrylanguage;

-- dml : 데이터 조작, [row]를 선택삽입수정삭제 -> select, insert, update, delete + 트랜잭션
SELECT
	* 
FROM 
	city;

SELECT
	name,
	population
FROM 
	city;
SELECT
	name,
	population
FROM 
	city
WHERE
	population >= 800000;
SELECT
	name,
	population
FROM 
	city
WHERE
	population < 800000
	AND population > 700000;


DESC city;

SELECT
	*
FROM 
	city
WHERE 
	countrycode = 'KOR'
	AND population >= 1000000;

-- 숫자의 연속된 범위는 조건연산자 대신 BETWEEN을 쓰면, 칼럼명시를 줄인다.
SELECT
	*
FROM
	city
WHERE
	700000 <= population
	AND population <= 800000;

SELECT
	*
FROM
	city
WHERE
	population BETWEEN 700000 AND 800000;

-- 2개이상의 이산적인 범위(OR)는 IN ()을 쓴다. 
SELECT
	*
FROM
	city
WHERE
	name IN ('Seoul', 'New York', 'Tokyo');

/* q3. 한국, 미국 일본들의 도시 보기 */
/* -> 국가코드를 한국미국일본으로 지정해주면 해당하는 도시들이 다 나올 것이다. */
DESC city;
SELECT
	-- count(*)
	*
FROM 
	city
WHERE
	CountryCode IN ('KOR', 'USA', 'JPN');


-- 한단어(_)가 기억 안날 때, LIKE + '_'
desc city;
SELECT
	* 
FROM 
	city
WHERE
	CountryCode LIKE 'KO_';

--  통째(%)로 모를 때 , LIKE + '%' 
SELECT
	*
FROM 
	city
WHERE
	name LIKE 'Tel%';

-- * subquery 쓰는 이유: 특정칼럼 값은 알지만, [대응되는 다른칼럼값을 몰라서 얻고 싶을 때]
-- ex> name값은 seoul인 것을 아는 상태 -> 대응되는 countrycode의 값은 모를 때,

-- SELECT * FROM city
-- WHERE CountryCode == '??';

--1) 아는 칼럼값을 where에 걸고 -> 모르는 칼럼을 select에 넣어준다. -> 대응되는 값이 나온다. 
SELECT 
	countrycode
FROM
	city
WHERE
	name = 'Seoul';

--2) 굳이 답을 꺼내볼 필요가 없다면, ;세미콜론지우고 (subquery)로 보관
--   대응칼럼의 값이 1개가 아니라 여러개일 수도 있다. 그냥 subquery로 보관하고,
-- * subquery 속 select 칼럼을  [본 쿼리의 where 조건절칼럼 ]에 넣어준다. 
SELECT
	*
FROM
	city
WHERE
	-- 3) 기억안나는 칼럼2
	CountryCode = (
		-- subquery의 결과가 여러개라도 된다?? 아니면 IN으로 바꿔주면 된다?
		select
			-- 2) 기억안나는 칼럼1
			CountryCode
		FROM
			city
		where 
			-- 1) 대응되는 아는 칼럼
			name = 'Seoul'
	);


-- * 부등호 ANY ( 숫자2개이상-subquery ) : subquery의 결과값이 여러개 && 숫자일 때 [subquery 숫자결과값들 중 어느하나개에 대해서라도 ~ 만족시 통과]
-- *   -> 여러개 숫자중 하나라도 부등호를 만족한다면 그걸로 해줘
-- *   -> where  > ANY ( ) : 여러숫자중 최소값보다 크면 뽑아줘 
-- *   -> where  < ANY ( ) : 여러숫자중 최대값보다 크면 뽑아줘 
-- cF) subquery의 결과가 여러개 && 문자면 AND or BETWEEN or OR or IN 으로 ?? 
select
	*
from
	city
where
	-- 1) popoluation의 값을 모르는 상태인데, 대응되는 칼럼 district는 알고 있을 때
	Population = ( 
		-- 2) 대응값으로 subquery추출시 대응값이 숫자 && 2개 이상이라서, [ = ]조건연산자에서는 에러가난다.
		--    8008278, 292648, 219773, ...
		SELECT 
			Population 
		FROM 
			city 
		WHERE 
			district = 'New York'
	);
	
select
	*
from
	city
where	
	Population > ANY (
		SELECT Population FROM city WHERE District = 'New York'
	); --3782 rows


-- * 부등호 ALL ( 숫자2개이상-subquery ) : subquery의 결과값이 여러개 && 숫자일 때 [subquery 숫자결과값들 중 전체를 다 만족 -> 가장 까다로운 것을 만족시켜야 통과]
-- *   -> 여러개 숫자 전체애 대하여 부등호를 만족해야만 함.
-- *   -> where  > ALL( ) : 여러숫자중 최대값보다 커야한다.
-- *   -> where  < ALL ( ) : 여러숫자중 최소값보다 작아야한다.
SELECT
	*
FROM
	city
WHERE
	Population > ALL (
		select
		Population
		from
		city
		where
		District = 'New York'
	); --9 rows

-- ORDER BY 칼럼 [desc] asc은 default라 생략가능
-- * order by  + limit 섞어 써서, head tail보기
SELECT
	*
FROM
	city
ORDER BY 
	population desc 
LIMIT 10;


-- 여러개를 입력해야할 경우는 ASC를 생략하지말고 명시하자.
select
*
from
city
where 
CountryCode = 'KOR'
order by
population desc,
CountryCode asc
limit 10;


/* q4. 인구수로 내림차순하여 한국에 있는 [도시] 보기 + 국가 면적크기로 내림차순하여 [나라]보기  */
select
*
from
city
where 
CountryCode = 'KOR'
order by
Population DESC;

desc country;

select
*
from
country
order by
surfacearea desc
limit 10;


-- * DISTINCT : select절에 [종류별 최대 1개씩(젤위에것)]만 보여줘서 -> 중복된 것을 제거해줌.
-- 중복제거전)
select
countrycode
from
city;
-- 종류별 1개로 중복제거(제일 위에거 하나만 살림)

-- * COUNT(DISTINCT 칼럼) AS 'COUNT' : 종류별 1개씩만 남긴 것의 갯수 = 유니크한   [종류의 갯수]
select
	COUNT(DISTINCT countrycode) as 'COUNT'
from
	city;


select
	DISTINCT countrycode
from
	city;

-- limit : order by랑 같이 써서, 상위N개만 보여준다. 
select
	*
from
	city
order by
	population desc 
limit 10;

-- * group by : select에 기준칼럼, 집계할 타칼럼  순으로 명시해준다.
-- 기준칼럼, 이후 타칼럼 집계방법 / count도 기준칼럼에 대한 집계다. 
-- (1) AVG(), MIN(), MAX(), COUNT(), COUNT(DISTINCT ), STDEV(), VARIANCE()
-- (2) COUNT(): 기준칼럼별 [데이터(행)의 갯수]
-- * (3) COUNT(DISTINCT ): 기준칼럼별 [종류]의 갯수  -> 중복이없다면, [데이터(행)의 갯수]

-- 1) 기준칼럼만 select하면, 기준칼럼의 종류만 나온다.
select
	countrycode
from
	city
group by 
	countrycode;

-- 2) 
select
	countrycode,
	avg(population) as '인구수평균' -- alias에 띄워쓰기 쓰지말자.
from
	city
group by 
	countrycode;
select
	countrycode,
	avg(population) as '인구수평균',
	sum(population) as '인구수합계'
from
	city
group by 
	countrycode;
select
	countrycode,
	avg(population) as '인구수평균',
	sum(population) as '인구수합계',
	count(disctinct population) as '종류개수' -- 중복이 없다면, 데이터의 갯수...
from
	city
group by 
	countrycode;


/* q5.  도시는 몇개인가, 도시들의 평균 인구수는?*/
desc city;

select
	-- count(name) as '도시의갯수' -- 4079
	-- count(distinct name) as '도시종류' -- 4001 -- 중복이름이 있는 듯.
	count(id) -- 4079
from
	city;

select
	avg(population) as '평균인구수'
from
	city;


-- * having: group by시 쓰인 [타칼럼 집계코드]로 조건을 만들어준다. 
-- 쿼리문 실행순서: FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY 순서대로 실행
select
	countrycode,
	max(population) -- 1) 타칼럼집계
from
	city
group by 
	countrycode;

select
	countrycode,
	max(population) -- 1) 타칼럼집계
from
	city
group by 
	countrycode
having
	max(population) > 800000; -- 2) 타칼럼집계코드를 가지고 조건을 건다.


-- * group by [기준칼럼, 2개이상] with rollup:
-- -> 첫번째 기준칼럼에 대해, 2번째칼럼에는 null로 채워짐 + 집계칼럼부분에는 첫번째기준별 총합의 집계row가 1줄씩 추가되어 집계결과를 같이 표기한다.

select
	countrycode,
	sum(population)
from
	city
group by
	countrycode;
select
	countrycode,
	sum(population)
from
	city
group by
	countrycode with rollup;

select
	countrycode,
	name,
	sum(population) as '인구수_총합'
from
	city
group by
	countrycode,
	name;

-- group by 기준칼럼 2개이상부터는, 첫기준에 대해 집계(총합)row가 추가된다.
select
	countrycode,
	name,
	sum(population) as '인구수_총합'
from
	city
group by
	countrycode,
	name with rollup;



-- join
desc city;
desc country;

SELECT
	*
FROM
	city
	INNER JOIN
		country
	ON
		city.CountryCode = country.Code;


-- * 내장함수 시리즈
select
	length('asdfasdf');

select
	concat('My', 'SQL is Op', 'en Source');

-- * LOCATE('찾문', '원문') -> 첫시작 index반환. mysql 1부터 반환 -> 0반환시 몾찾은 것 
-- * LEFT, RIGHT('원문', n) -> 왼or오른쪽시작 n개 글자 뽑기
select
	locate('abc', 'asdfasdfbabcadf');
select
	left('asdfsadf', 3);

SELECT
	right('mysql is an open source system', 6);

SELECT
	lower('mysql is open source');
SELECT
	upper('mysql is open source');

select 
	trim('         asdf ');

-- * trim(leading or trailing '삭문' from '원문')을 이용한 특수문자 제거
SELECT
	trim('   mysql   '),
	trim(leading '#' from '###mysql###'),
	trim(trailing '#' from '###mysql###');

-- * format(숫자) -> error
-- * format(숫자, n) : 돈처럼 3자리씩 콜론 + 소수점n번째까지 자리수로 반올림
-- * format(숫자, 0) : 돈처럼 3자리씩 콜론
select
	format(12312.15, 1); --12,312.2

select
	format(12312.123, 0); --12,312

select
	floor(10.95),
	ceil(10.95),
	round(10.95);

select
	sqrt(4),
	pow(2, 3),
	exp(3),
	log(3);

select
	sin( pi()/2 ),
	cos( pi() ),
	tan( pi()/4 );

-- RAND() 기본: 0.0~1.0사이의 랜덤 [실수] 생성. 
-- RAND() * 100 + ROUND(, 0): 0.0~100.0 -> 소수점제거를 위한 0번째자리(일의 자리)로 반올림
select
	abs(-3),
	rand(),
	round( rand()*100, 0);

-- * 날짜 시리즈 

--* NOW(): 지금날짜+시간 = CURDATE():지금날짜 + CURTIME():지금시간 
-- DATE( now() ) : 날짜  = curdate() 

select 
	now(), --2022-01-21 16:46:34
	date(now()); --2022-01-21
select
	now(), --2022-01-21 16:48:03
	curdate(), -- 2022-01-21
	curtime(); -- 16:48:03

SELECT
	now(),
	year( now() ),
	month( now() ),
	day( now() ),
	hour( now() ),
	minute( now() ),
	second( now() );

-- * 월과 요일[만] 문자열로 변환[추출] monthname, dayname
select
	month(now()), --1
	monthname(now()),--January
	day(now()),--21
	dayname(now());--Friday? -> day(now())가 아닌.. week관련..을 변환한 것으로 추정됨.

select
	dayofmonth(now()), -- day와 동일
	dayofweek(now()),--* 6(금요일)  1일2월3화4수5목6금7토 일듯??1부터시작
	dayofyear(now());--day 와 동일

-- * date_format( now(), ' format ' )
-- 그냥 format()은 (숫자, 소수점) 으로 3자리씩 쉼표찍는 문자열(돈)으로 변경 
-- -> 날짜는 date_format(now(), )를 이용하면 될 듯.
select
	date_format(now(), '%y %m %d %D %n %j')--22 01 21 21st n 021




