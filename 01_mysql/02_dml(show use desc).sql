/* 전반적인 설명 */
-- * 1) dml : 데이터 조작, [row]를 선택삽입수정삭제 -> select, insert, update, delete + 트랜잭션
-- * 2) ddl : 데이터 정의, [db,테이블,뷰,인덱스]를 만들거나 삭제 변경 -> create, drop, alter + 트랜잭션X 롤백X커밋X 실행즉시 MySQl에 적용,  
-- * 3) dcl : 데이터 제어, [권한부여or권한뺏기]  + [커밋or롤백] 까지 -> grant, revoke,  commit, rollback



/* dml */
-- DBs
SHOW DATABASES;
USE world; --또는 Workbench에서 직접 선택해 사용 가능(네비게이터->스키마->데이터베이스 선택)

-- TABLEs  in USE db;
SHOW TABLES;
SHOW TABLE STATUS;

-- COLUMNs in table
DESCRIBE city;
/* DESC city; */

/* q1. 컨트리 테이블과 컨트리랭귀지 테이블 정보를 보기. */
DESC country;
DESC countrylanguage;
/*  2개 테이블 동시 요약은 안된다. */
/* DESC 
    country,
    countrylanguage; */
