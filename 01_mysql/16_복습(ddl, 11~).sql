-- 1) dml : 데이터 조작, [row]를 선택삽입수정삭제 -> select, insert, update, delete + 트랜잭션
-- * 2) ddl : 데이터 정의, [db,테이블,뷰,인덱스]를 만들거나 삭제 변경 -> create, drop, alter + 트랜잭션X 롤백X커밋X 실행즉시 MySQl에 적용,  
-- 3) dcl : 데이터 제어, [권한부여or권한뺏기]  + [커밋or롤백] 까지 -> grant, revoke,  commit, rollback



--* create table XX as (select ): select한 기존테이블을 복사해서 새로운 table로 생성
create table city3 as (
	select
		*
	from
		city
);

desc city3;


-- * create database XX;
-- -> database는 use xx;를 통해서 변경해야 쿼리문 사용가능해짐.
create DATABASE js;
use js;


-- create table
create table test3 (
	id INT NOT NULL PRIMARY KEY,
	col1 INT NULL,
	col2 FLOAT NULL,
	col3 VARCHAR(45) NULL
);

select
	*
from
	test3;

-- * alter table XX ADD|MODIFY|DROP 칼럼;
-- alter table은 칼럼을 추가/수정/삭제 시키는 명령어다. 
alter table
	test3
ADD	
	col4 INT NULL;

desc test3;

use world;
alter table
	test3
modify
	col4 VARCHAR(20) NULL;

desc test3;

alter table
	test3
drop
	col4;


-- * index
-- 1. 테이블을 순서대로 가 아닌, 빠르게 검색하고 싶을 때 생성해서 쓴다. 
-- 2. 검색, 질의 시 테이블 전체를 안읽기 때문에 빠름
-- 3. 검색이 많은 테이블에 생성하여 사용한다.
-- 4. 단점: 삽입/삭제/수정이 빈번하게 발생할 경우, index가 커지고 데이터 수정에 따라 인덱스도 함께 수정되어야하므로 오버헤드가 발생

desc test3;

-- create (unique) index 인덱스명(칼럼+Idx) 
--     ON [talble] ( [Col] );
create index Col1Idx
	ON test3 (col1);

show index from test3;

create unique index Col2Idx
	on test3 (
		col2
	);

show index from test3;


-- * 문자열 검색을 위한, fulltext index 생성
-- * 일반적인 인덱스와 달리, 각 테이블의 [모든 TEXT칼럼들을 검색해서 봄]
-- * 문자열 전체를 검색시, 이놈이 작동해서 빠르게 처리한다.
-- * 여러방법이 있지만, 테이블에 칼럼 추가하듯이 [[[ALTER TABLE    ADD FULLTEXT 인덱스명(칼럼); 으로 fulltext index를 추가]]]한다.
-- alter table [테이블] add fulltext 인덱스명 (칼럼명);
-- * - col3칼럼에 주는 것처럼 만들지만, 텍스트칼럼 전체를 검색함. 
desc test3;
alter table test3
	add fulltext Col3Idx (col3);

show index from test3;

-- * 인덱스 생성은 create index, create unique index, alter table 테이블 add fulltext 
-- * 인덱스 조회는 show index from 테이블;
-- * 인덱스 삭제는 
-- (1) alter table [테이블] drop index [인덱스명];
-- (2) drop index [인덱스명] on [테이블명]; -> 내부에선 (1)로 작동됨.

alter table 
	test3
	drop index 
		Col3Idx;

show index from test3;

drop index Col2Idx
	on test3;


-- * view
-- DB에 존재하는 가상테이블 = 행과열을 가지고 있으나 but 실제 데이터로 저장하고 있지 않음. 형태만 TABLE로
-- Mysql은 뷰에 저장된 데이터를 보여주는 용도로만쓰임. 다른dbms는 수정삭제도 될 수도있음.
-- * 장점: 
-- 1) 1개테이블에서 필요한 칼럼만 뽑아보기 
-- 2) 여러개 테이블을 묶어서 1개 테이블 형태로 
-- 3) 복잡한 쿼리 단순화 + 쿼리 재사용 간능 
-- * 단점: 1) 한번생성후 변경불가 2) 삽입삭제갱신에 제한사항 3) 자신만의 인덱스 없음
-- 그래도 막강한 장점들 때문에, VIEW를 사용한다. 

-- * 특정칼럼만 보고 싶다? create view  XXX as (select  )
-- 생성방법은 create table XXX as (select )와 동일함.
desc city;
create view
	cityView as (
		select
			name,
			countrycode
		from
			city
	);

-- 조회도 select * from View로 테이블과 비슷하다.
select
	*
from
	cityView;


-- * view의 수정은 alter view인데, 
-- * -> create view    as (select )를 가져와 수정해서 쓴다.
-- create view
alter view
	cityView as (
		select
			name,
			countrycode,
			population
		from
			city
	);

select * from cityView;


-- drop view
drop view cityView;


/* q7. city, country, countrylanguage 테이블을 join후 한국정보만 VIEW로 생성하기 */
use world;

select 
*
from
city;

desc country;
desc countrylanguage;

-- * 1) join -> where하여 특정조건의 데이터를 select한다
-- * 2) 특정칼럼만 뽑도록 select한다.
-- * 3) 특정칼럼만 뽑은 것을 view로 만들어 편하게 본다. create view   as (select )

select
	*
from
	city c
	inner join country t
	on c.CountryCode = t.Code
	inner join countrylanguage l
	on c.CountryCode = l.CountryCode;

select
	*
from
	city c
	inner join country t
	on c.CountryCode = t.Code
	inner join countrylanguage l
	on c.CountryCode = l.CountryCode
where 
	c.CountryCode = 'KOR';


select
	c.name,
	c.Population as '도시인구',
	t.SurfaceArea as '국가면적',
	l.Language as '국가언어'
from
	city c
	inner join country t
	on c.CountryCode = t.Code
	inner join countrylanguage l
	on c.CountryCode = l.CountryCode
where 
	c.CountryCode = 'KOR';

create view cityView as (

	select
		c.name,
		c.Population as '도시인구',
		t.SurfaceArea as '국가면적',
		l.Language as '국가언어'
	from
		city c
		inner join country t
		on c.CountryCode = t.Code
		inner join countrylanguage l
		on c.CountryCode = l.CountryCode
	where 
		c.CountryCode = 'KOR'
);


select 
*
from
cityView;