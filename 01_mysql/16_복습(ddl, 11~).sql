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