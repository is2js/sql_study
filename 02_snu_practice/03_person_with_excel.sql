
/* https://nittaku.tistory.com/413?category=764930  */

-- 위 블로그처럼, 엑셀로 테이블들을 나타내보자.
--  엑셀 alt+2(병합), 3(모든테두리), 4(굵-바깥테두리) 5(셀채우기) 등 단축키를 잘 활용한다.

-- * 1) 테이블  칼럼|type 들을 다 복붙해서 나타내기

--  -> vscode mysql [ext desc table;]보다는
--  -> workbench 툴에서 클릭만 하면 바로 excel 복붙가능한 정도로 나온다.
/* Table: person
Columns:
personid int 
sex int 
birthday datetime 
ethnicity int */


-- * 2) 각 테이블별 count(1)를 한 뒤, 코드 및 엑셀에 붙혀넣기
select count(1) from person; --18570 
select count(1) from drug; --1890626 
select count(1) from drugcodemaster; --2627 
select count(1) from diagnosis; --296690 
select count(1) from diagnosiscodemaster; --7553 
select count(1) from electrocardiogram; --35932 
select count(1) from laboratory; --147716 
select count(1) from person; --18570 

################ person table ##############
-- * order by +  limit으로 상위 N개만 데이터만 보기
select * from person limit 10;
select * from person order by personid limit 10;


-- * 환자 수 = [[[  유니크한id 갯수  ]]] 확인하기
--  환자 데이터 수(한 환자 중복가능) vs 환자 수(distinct) -> 서로 다른 것
-- personid : 환자 [수]의 정보밖에 없다. 한 환자당 여러데이터가 있으니, distinct한 갯수를 세어야한다.
SELECT
	/* DISTINCT personid */ -- 유니크한(종류별1개씩) personid 데이터 다 불러오기
	COUNT(DISTINCT personid) -- 18570
FROM
	person;


-- 범주칼럼 sex 의 유니크한 데이터->범주 보기
select
	/* distinct sex -- 1, 0 */
	count(distinct sex) --  2
from
	person; 


-- 범주칼럼별 -> 환자 수 확인하기 
select
	sex,
	count(DISTINCT personid)
from
	person
group by 
	sex; --0:9263 /1:9307

-- select에서 덧셈연산을 바로 할 수 있다. -> 전체 환자수와 동일한지 확인해보자. 
select 9263 + 9307; --18570

-- * null칼럼 찾기 by select * from person [where 칼럼 IS NULL]
select 
	*
from
	person
where 
	sex IS NULL; -- none

-- 범주(성별)별 환자수 -> order by 만 더해서 내림차순으로 보기 
select
	sex,
	count(distinct personid)
from
	person
group by
	sex
order by
	sex desc;


-- birthday칼럼만 10개 보기 
SELECT 
	birthday 
FROM 
	person
LIMIT 10;
/* 1952-10-04 00:00:00
1950-08-01 00:00:00 */ 

-- 생일별 환자수-> 2명이상의 중복되는 생일이 존재하기도 한다.
select
	birthday,
	count(distinct personid) as '성별별_환자수'
from 
	person
group by
	birthday
HAVING
	/* count(distinct personid) > 1; */
	성별별_환자수 > 1; -- 집계외 타칼럼의 alias도 적용가능하다.


-- * [EXCEL 시각화] 다양한 범주를 가진 것을 -> [범주(날짜)별 갯수]를 엑셀로 데이터 그리기
-- 1)  vscode ext -> export -> csv 복붙해서 excel에 붙혀넣는다.
select
	birthday,
	count(distinct personid) as 'person_count'
from 
	person
group by
	birthday;
order by 
	birthday ASC;

-- 2) 00:00:00 time은 필요가 없으니 엑셀에서 제거한다.
-- 날짜칼럼 셀 모두 선택 -> 우클릭 -> 셀서식 -> [표시형식]날짜 -> yyyy-mm-dd 선택

-- 3) 데이터 모두(칼럼까지) 선택 -> 삽입 -> 피벗차트 -> 
--    count -> [값]으로 이동 + [합계->갯수]로 변경 / birthday -> [축]으로 이동
