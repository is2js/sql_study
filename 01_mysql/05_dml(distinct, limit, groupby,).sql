/* distinct */
-- SELECT절에서 중복된 것을 제거하고 보여준다.
-- * my) [데이터 다수로 인한 중복출력]을, 중복제거하고 보여준다. 테이블 크기가 클수록 효율적이다.
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



