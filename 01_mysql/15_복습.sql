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