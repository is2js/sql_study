/* having */
-- * 특정칼럼의 값별로 그룹화 한 [groupby이후 집계된 결과 칼럼에]조건을 주는 것
-- * 집계칼럼: SELECT MAX(Population) -> HAVING MAX(Population) [[having절에도 집계칼럼의 집계상태 그대로 쓴다!!]]
SELECT
    CountryCode, 
    MAX(Population)
FROM 
    city
GROUP BY 
    CountryCode
HAVING 
    MAX(Population) > 8000000 -- SELECT에 집계시켰던 MAX(Population) 그대로 쓴다.




/* with rollup */
-- * 처음 보는 개념: 중간합계, 총합이 필요한 경우, [[2개이사의 기준을 가진 GROUP BY의 그룹마다, 첫번째기준을 바탕으로 1row씩 총집계를 추가로 보여준다.]] 
-- * (combination형태의 cube와 반대로) permutation형태로 각각을 보여준다.

SELECT 
    CountryCode,
    SUM(Population)
FROM 
    city
GROUP BY 
    CountryCode 


SELECT 
    CountryCode,
    SUM(Population)
FROM 
    city
GROUP BY 
    CountryCode WITH ROLLUP -- 그룹바이 기준이 1개 일때는 안나타남.

SELECT 
    Name, 
    SUM(Population)
FROM 
    city
GROUP BY 
    Name 
    WITH ROLLUP -- 그룹바이 기준이 1개 일때는 안나타남.

--* groupby 기준이 2개이상부터, WITH ROLLUP을 걸어주면, 첫번째기준만 남기고, 다른기준은 null로 채우면서 1row추가되서 첫번째그룹마다집계결과를 알려준다.
/* 
CountryCode	Name	SUM(Population)

ABW	Oranjestad	29034
ABW	null	29034

AFG	Herat	186800
AFG	Kabul	1780000
AFG	Mazar-e-Sharif	127800
AFG	Qandahar	237500
AFG	null	2332100
 */
SELECT 
    CountryCode,
    Name, 
    SUM(Population)
FROM 
    city
GROUP BY 
    CountryCode,
    Name 
    WITH ROLLUP -- 그룹바이 기준이 1개 일때는 안나타남.

