/* select */
SELECT 
    *
FROM 
    city;

SELECT 
    Name, 
    Population
FROM 
    city;
/* 
SELECT 
    select_expr 
[FROM 
    table_references] 
[WHERE 
    where_condition] 
[GROUP BY 
    {col_name | expr | position}] [
    HAVING where_condition] 
[ORDER BY 
    {col_name | expr | position}]
 */


/* where */
/* where + 조건연산자(= > < ) 및 관계연산(NOT, AND, OR) */
SELECT 
    Name, 
    Population
FROM 
    city
WHERE
    Population >= 8000000;

SELECT 
    Name, 
    Population
FROM 
    city
WHERE
    Population < 8000000
    AND Population > 7000000;


/* q2. 한국에 있는 도시들/  미국에 있는 도시들 보기  / 한국에 있는 도시들 중 인구 100만 이상인 도시들 보기*/
DESC city; -- TODO: 테이블 검사는 항상 하자.
/* SELECT
    DISTINCT(CountryCode)
FROM
    city; */

SELECT
    *
FROM
    city
WHERE
    CountryCode = 'KOR';
    /* CountryCode = 'USA'; */

SELECT
    *
FROM
    city
WHERE
    CountryCode = 'KOR'
    AND Population >= 1000000;

/* between and */
/* [숫자 칼럼]의 [연속된 범위 지정]시 조건연산자 대신 관계연산자(AND) + between을 활용 */
SELECT
    *
FROM
    city
WHERE
    Population BETWEEN 7000000 and 8000000;

/* IN() */
/* [이산적인 칼럼]의 [띄엄띄엄or범위 여러개 지정]시 */
/* DESC city; */
SELECT
    *
FROM
    city
WHERE
    Name IN('Seoul', 'New York', 'Tokyo');

/* q3. 한국, 미국 일본들의 도시 보기 */
/* -> 국가코드를 한국미국일본으로 지정해주면 해당하는 도시들이 다 나올 것이다. */
SELECT
    *
FROM
    city
WHERE
    CountryCode IN('KOR', 'USA', 'JPN');



/* LIKE */
/* - [문자열 검색]을 위해 사용,  like질의라고도 함, 포함하냐 안하냐*/
/* 1) LIKE '_'  : 1글자가 뭔지 기억이 안날때 */
/* - 기억이 잘안날때는? LIKE 다음에 '_'언더바를 문자1개로 매칭시킨다. */
-- 예를 들어, KOA인지 KOR인지 기억이 잘 안난다?  -> LIKE 'KO_'로 매칭시킨다.
SELECT 
    *
FROM
    city
WHERE
    CountryCode LIKE 'KO_';

/* 2) LIKE '%'  : 앞뒤로 전체가 생각이 안날 때 */
-- ex> Tel로 시작하는 도시이름 찾기
SELECT 
    *
FROM
    city
WHERE
    Name LIKE 'Tel %';

