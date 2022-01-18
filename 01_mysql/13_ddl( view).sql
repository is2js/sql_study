/* DDL: db, 테이블, 뷰, 인덱스를 create, drop, alter */

/* VIEW */
-- * DB에 존재하는 가상테이블 = 행과열을 가지고 있으나 but 실제 데이터로 저장하고 있지 않음. 형태만 TABLE로
-- * Mysql은 뷰에 저장된 데이터를 보여주는 용도로만쓰임. 다른dbms는 수정삭제도 될 수도있음.
-- * 장점: 
-- 1) 여러개테이블을 묶어서 1개 테이블 형태로 
-- 2) 1개테이블에서 필요한 칼럼만 뽑아보기 
-- 3) 복잡한 쿼리 단순화 + 쿼리 재사용 간능 
-- * 단점: 1) 한번생성후 변경불가 2)  삽입삭제갱신에 제한사항 3) 자신만의 인덱스 없음 
-- 그래도 막강한 장점들 때문에, VIEW를 사용한다. 


/* CREATE VIEW */
-- * create table as (select)처럼 생성한다.?
-- * 특정 칼럼만 모아서 보고싶어요 -> view
CREATE VIEW testView AS (
    SELECT 
        col1, 
        col2
    FROM
        test2
);

/* select from view */
-- * 조회도 select from table처럼 한다.
SELECT
    *
FROM
    testView


/* alter view */
-- * view를 수정해야하면 create view 문장을 복사해서 수정한다.
-- * 만약, col3를 빠뜨렸다-> alter view as ( select문을 수정 )
-- * ALTER VIEW는 AS( select) 속 [select문장 자체를 변경해서, 새로만드는 개념]인 것 같다.
ALTER VIEW testView AS (
    SELECT 
        col1, 
        col2,
        col3
    FROM
        test2
);

/* DROP VIEW */
DROP VIEW testView;


/* q7. city, country, countrylanguage 테이블을 join후 한국정보만 VIEW로 생성하기 */
USE world;
-- * 1. view로 만들 정보를 select 문으로 완성한다. -> create view as (select) 안에 넣기만 하면 되므로 
/* 1) join 다하기 */
SELECT
    *
FROM 
    city
    INNER JOIN country
    ON city.CountryCode = country.Code
    INNER JOIN countrylanguage
    ON city.CountryCode = countrylanguage.CountryCode;


/* 2)  필요한 정보 추리기
/* 2-1) (*)전체 대신 필요한 칼럼만 가져오기 */ 
/* 2-2) where로 조건 걸기. join까지 다 끝난 것(들여쓰기로 수행됨) FROM에 걸린 테이블이다. where 은 그 다음이다. */
SELECT
    city.Name, 
    country.SurfaceArea, 
    city.Population,
    countrylanguage.Language
FROM 
    city
    INNER JOIN country
    ON city.CountryCode = country.Code
    INNER JOIN countrylanguage
    ON city.CountryCode = countrylanguage.CountryCode
WHERE
    city.CountryCode = 'KOR';


-- * 필요한 정보를 view로 만들고 -> 이후에는 편하게 select로 보기
CREATE VIEW allView AS (
    SELECT
        city.Name, 
        country.SurfaceArea, 
        city.Population,
        countrylanguage.Language
    FROM 
        city
        INNER JOIN country
        ON city.CountryCode = country.Code
        INNER JOIN countrylanguage
        ON city.CountryCode = countrylanguage.CountryCode
    WHERE
        city.CountryCode = 'KOR'
);

/* 내가 필요한 정보를 select * from view로 볼 수 있다. */
SELECT
    *
FROM
    allView;