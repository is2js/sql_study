/* join */
--DESC city;
--DESC country;

SELECT 
    *
FROM
    city
    INNER JOIN
        country
    ON 
        city.CountryCode = country.Code;

/* q6.  city, country, countrylanguage 3개 테이블 join*/
SELECT 
    *
FROM
    city
    INNER JOIN
        country
    ON 
        city.CountryCode = country.Code
    INNER JOIN
        countrylanguage
    ON
        city.CountryCode = countrylanguage.CountryCode;