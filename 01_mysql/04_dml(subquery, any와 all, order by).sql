/* subquery */
/* TODO: 쓰는이유  */
-- * where절에서 칼럼의 특정값을 찾아야하는데 기억이 안남 & [그 값의 다른 칼럼 값을 알고] 있어서 
-- * -> 내부에서 한번 더 쿼리를 날려, [다른칼럼으로 해당 칼럼의 값을 SELECT로 return받아]서 검색해야할 때
-- ex> 나는 Name은 Seoul인 것은 아는데, 그 CountryCode가 기억이 안난다.

/* 1) ... 그 값이 생각이 안나지만, 나는 Name이 Seoul이라는 것을 알고 있다. */
/* SELECT
    *
FROM 
    city 
WHERE
    CountryCode = ?? */

/* 2) 그자리에서 subquery로 [Name이 Seoul 데이터들은 어떤 CountyCode를 가지는지 select로 리턴받는다.] */
-- 부분 실행을 통해 서브쿼리 안에 제대로 반환해주는지 보자.  
-- * my) [지금 생각이 안나는 값]의 칼럼(WHERE CountryCode = ? ) = [subquery의 select절에서 받을 값]의 칼럼명( SELECT CountryCode ) 
/* SELECT
    *
FROM 
    city 
WHERE
    CountryCode = ( */
        SELECT 
            CountryCode
        FROM 
            city
        WHERE
            Name = 'Seoul' --;
    /* ) */
/* 
CountryCode
-----------
KOR 
*/

/* 3) subquery를 부분실행된 값을 확인했지만, 그대로 서브쿼리로 실행시켜보자. */
-- subquery안에서는 ; 찍으면 안됨.


/* any ()*/
/* TODO: 뒤에나올 여러개의 값(subquery결과)들 중 1개라도 만족하면 그것으로 처리해줘 */
-- * my)  부등호 any (subquery가 여러개의 값 return) 는...  여러값들 중 마지노선보다 크거나 작으면 전체를 다 처리하도록 해주는 관대한 놈이다.
-- * 여러개의 subquery결과값이 반환된다면? 숫자면, =이 아니라 > < 등호의 조건연산자로 처리되어야한다.
-- * if) 문자면 OR 나 IN()으로 처리되어야한다?
-- * 숫자칼럼 > any () :  여러값들 중 어느값보다도 크면  == 가장 작은값보다도 크면, 다 출력해줘 -> 하한선보다 크면 다 출력
-- * 숫자칼럼 < any () :  여러값들 중 어느값보다도 크면  == 가장 큰 값보다도 작으면, 다 출력해줘 -> 상한선보다 작으면 다 출력


/* - 칼럼 > ANY ( 여러 값을 return하는 subquery)  */
SELECT
    *
FROM 
    city 
WHERE 
    Population = ( -- * 3) SELECT가 반환하는 값이 1개가 아니라서 Population = (1개값) 조건이 에러가 난다.
        SELECT 
            Population -- 1) 찾는 값이 기억안나지만 Population이라면, subquery의 SELECT도 population을 반환해야한다.
        FROM 
            city
        WHERE
            District = 'New York' -- 2) population 대신 아는 값이, subquery의 where절에서 데이터를 뽑아낸다.
    );

SELECT
    *
FROM 
    city 
WHERE 
    -- * 4) Population = () 대신 Population > ANY () 를 통해, 1개라도 걸리면 그걸로 해줘
    -- * District가 NewYork인, 여러 Population이 있는데, 어느 하나보다도 크다? => 젤 작은값보다 크기만 하면, 다 출력해줘
    Population > ANY ( 
        SELECT 
            Population
        FROM 
            city
        WHERE
            District = 'New York' 
    );

-- any대신 some을 넣어줘도 완전히 똑같다.
SELECT
    *
FROM 
    city 
WHERE 
    Population > SOME ( 
        SELECT 
            Population
        FROM 
            city
        WHERE
            District = 'New York' 
    );


/* all */
-- * my) 부등호 all ( subquery) 는 전부다 통과해야만 출력 -> [가장 뭐뭐한 것보다도 더 커야하는 짠놈]이다.
-- * my)  부등호 any (subquery) : 관대한놈.  vs  부등호 all (subquery) : 짠놈.

SELECT
    *
FROM 
    city 
WHERE 
    Population > ALL ( -- * 여러개의 subquery결과값 중 전체보다 커야한다 == 가장 큰놈보다 커야 통과되서 출력한다.
        SELECT 
            Population
        FROM 
            city
        WHERE
            District = 'New York' 
    );



/* order by */
--ORDER BY 칼럼명뒤에 DESC[ASC은 기본이라 생략가능]
SELECT
    *
FROM
    city
ORDER BY 
    Population DESC
LIMIT 10;

-- 여러개를 입력해야할 경우는 ASC를 생략하지말고 명시하자.
SELECT
    *
FROM
    city
ORDER BY -- 콤마 다음에는 줄바꿔스 칼럼명 , 테이블명 등은 1개씩 오도록 하자.
    Population DESC,
    CountryCode ASC
LIMIT 10;


/* q4. 인구수로 내림차순하여 한국에 있는 도시 보기 / 국가면적크기로 내림차순하여 나라보기  */
SELECT
    *
FROM
    city
WHERE 
    CountryCode = 'KOR'
ORDER BY
    Population DESC;

DESC country; -- DESC 테이블 중요! city는 도시 country는 국가.

SELECT 
    *
FROM 
    country
ORDER BY
    SurfaceArea DESC
LIMIT 10;
