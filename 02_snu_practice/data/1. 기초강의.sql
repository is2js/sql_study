--데이터 조회--
SELECT * FROM Person;



--필터링--
SELECT * FROM Person WHERE SEX=1;
SELECT * FROM Person WHERE SEX=0;

SELECT * FROM [dbo].[Drug];



--카운팅--
SELECT COUNT(*) FROM PERSON; --테이블 전체 카운팅--
SELECT SEX,COUNT(*) FROM PERSON GROUP BY SEX; --성별칼럼별로, 성별칼럼을 카운트 해주는 칼럼에 이름이 없음--

SELECT SEX,COUNT(*) AS CNT FROM PERSON GROUP BY SEX;



--*** 집계함수 ~ GROUP BY 그룹핑*** 집계함수를 무조건 써줘야한다.--
SELECT * FROM PERSON GROUP BY SEX; --그룹바이를 사용할때는 반드시 집계함수를 사용해야한다. 안그러면 오류난다.
SELECT COUNT(*) FROM PERSON GROUP BY SEX; --성별별로 숫자카운팅**--



--*** DISTINCT 유니크한 값 보기***--
SELECT DISTINCT personid FROM Drug;



--*** TOP 3 * 상위 3개만 보기***--
SELECT * FROM Drug;
SELECT TOP 3 * FROM Drug;
SELECT TOP 10 * FROM Drug;



---WHERE 조건--
-- 비교
SELECT * FROM Drug WHERE duration>=90

SELECT * FROM Drug WHERE (duration <= 30) AND (duration >= 90) --between은 항상 30포함~90포함



-- ***사이값 : 칼럼명 BETWEEN 100 AND 500
SELECT * FROM Drug 
SELECT * FROM Drug WHERE duration BETWEEN 3 AND 5

SELECT * FROM [dbo].[Electrocardiogram]
SELECT * FROM [dbo].[Electrocardiogram] WHERE QTc BETWEEN 400 AND 500




-- ***IN, NOT IN  : 칼럼명 IN ( a, b, c )     OR랑 비슷
SELECT TOP 15 * FROM DRUG;

SELECT * FROM DRUG WHERE atccode = 'N01BB02';

SELECT * FROM DRUG WHERE atccode = 'N01BB02' OR atccode = 'N01AX10'; --OR는 2개 정도는 할만하다.

SELECT * FROM DRUG WHERE atccode IN ('N01BB02', 'M03AC09','N01AX10');




-- ***칼럼명 LIKE 패턴 -->  칼럼명 LIKE %diabetes%  -> 앞뒤에 뭐가붙든간데 diabetes검색
SELECT TOP 15 * FROM DRUG;

SELECT * FROM DRUG WHERE atccode LIKE 'J01%' -- J01로 시작하는 모든 것

SELECT * FROM DRUG WHERE atccode LIKE 'J01[A-Z][A-Z]10' -- J01로 시작, 가운데 2글자는 아무거나, 끝은 10으로 긑



-- IS NULL, IS NOT NULL ; 칼럼명 IS NULL  <---> 0과 데이터가없는 NULL은 다름
-- 복합조건 ( ) AND (  )



-- ***ORDER BY 칼럼명 DESC ASC  :  WHERE 문이 있다면, 그 다음에 나오는 것--
SELECT TOP 15 * FROM DRUG;

SELECT * FROM DRUG ORDER BY personid DESC;
SELECT * FROM DRUG ORDER BY personid, drugdate ASC; -- **환자별로 언제***(날짜) 약을 제일 많이 먹었는지

SELECT * FROM DRUG WHERE DURATION > 90
ORDER BY personid ASC, drugdate DESC; -- WHERE다음에 오고, 칼럼별로 순서개별부여가능***



-- *** 집계함수, SUM AVG COUNT MAX MIN(칼럼명)  AS 표시될 칼럼명
-- *** 카운트 빼고는,,,집계함수(칼럼명)
-- *** 계산시 cast(칼렴명 as float)***로 먼저 바꾸고 난 뒤, 계산하자

SELECT AVG(duration) as avg_duration FROM Drug;  -- cast( as float)안하고 하면,,, 소수점이 다 짤려버린다********
SELECT AVG(cast(duration as float)) as avg_duration FROM Drug; --*** 집계함수사용시,,, 항상 실수형으로 바꾸고 계싼하기***

SELECT COUNT(*) AS row_cnt FROM Drug; --**카운트만 (*)


--** 특정칼럼의 count를 그룹바이를 이용해서--
-- 처방과별로 처방과별칼럼을 count해보기
-- ***예제에서는 게속 groupby 칼럼 == count(*)해줄 칼럼을 동일하게 처리하고 있음.
SELECT * FROM Drug;

SELECT drugdept FROM Drug GROUP BY drugdept;


SELECT drugdept, COUNT(*) AS cnt_drugdept FROM Drug GROUP BY drugdept;




--** route별 duration의 최대값 조회
SELECT * FROM Drug;

SELECT route,* FROM Drug GROUP BY route; -- 실행은 안되지만, <<groupby 와 select칼럼명을 동일하게 일단..>>*** 만들어놓고,,, 뒤에 집계함수( 특정칼럼명 )
SELECT route, MAX(duration) AS max_duration FROM Drug GROUP BY route;
SELECT [route], MAX(duration) AS max_duration FROM Drug GROUP BY route; --z칼럼명이 예약어일때는 대괄호로 묶어줘도 된다.