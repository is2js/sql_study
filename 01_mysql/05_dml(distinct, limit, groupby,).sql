/* distinct */
-- SELECT절에서 중복된 것을 제거하고 보여준다.
-- * my) [데이터 다수로 인한 중복출력]을, 중복제거하여 [[[[[값의 종류별 최대 1개씩만]]]]] 보여준다. 테이블 크기가 클수록 효율적이다.
/* 1) CountryCode는 한국은  KOR 1개 뿐이지만, 한국데이터가 많으므로 출력시 중복되어 보여진다. */
SELECT 
    CountryCode 
FROM
    city;

SELECT 
    DISTINCT CountryCode 
FROM
    city;


/* limit */
-- * [ORDER BY랑 같이 써서  상위 N개]만 보여줄 수 있다.  악성 쿼리문 개선시에도 사용한다.
-- workbench는 자체적으로 [Limit to 1000 rows]가 설정되어있다.
SELECT 
    *
FROM
    city 
ORDER BY
    Population DESC 
LIMIT 10;


/* group by */
-- * [데이터 다수로 인한 중복출력],  [[[특정칼럼의 값별로 묶어서]]]  --->  1) 기본적으로 SELECT에서 기준칼럼표시 + 2)기준칼럼별로 묶인 타칼럼 집계도 가능
-- AVG()-평균, MIN()-최소값, MAX()-최대값, COUNT()-행의 개수, COUNT(DISTINCT)-중복 제외된 행의 개수, STDEV()표준편차, VARIANCE()-분산
-- DISTINCT : [ 데이터 다수로 인한 중복출력]을 제거만 해서 [제일 위에것을 종류별로 1개만]  출력.
-- COUNT(): 데이터(행)의 갯수 ---> COUNT(DISTINCT ): 중복제거하고 1개씩만 남긴 뒤, 행의 갯수

SELECT
    CountryCode
FROM
    city
GROUP BY 
    CountryCode;

SELECT
    CountryCode,
    MAX(CountryCode) 
FROM
    city
GROUP BY 
    CountryCode;

SELECT
    CountryCode,
    AVG(Population) AS 'Average', -- 데이터다수를 묶은 칼럼이 아니라, 그 묶음 단위로 타 칼럼을 집계할 수 있다.
    SUM(Population) AS 'SUM', -- 데이터다수를 묶은 칼럼이 아니라, 그 묶음 단위로 타 칼럼을 집계할 수 있다.
    COUNT(DISTINCT Population) AS 'COUNT' -- 데이터다수를 묶은 칼럼이 아니라, 그 묶음 단위로 타 칼럼을 집계할 수 있다.
FROM
    city
GROUP BY 
    CountryCode;


/* q5.  도시는 몇개인가, 도시들의 평균 인구수는?*/
DESC city;
/* SELECT 
    COUNT(DISTINCT NAME) AS '도시의 갯수'
FROM 
    city; */

SELECT 
    COUNT(*) -- .. 행의 갯수로 세어버렸내.. COUNT( DISTINCT * )는 없다. 나는 COUNT( DISTINCT Name )으로 함.
FROM 
    city;

SELECT 
    AVG(Population) AS '평균인구수'
FROM 
    city;
