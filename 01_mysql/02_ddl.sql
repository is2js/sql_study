/* ddl */
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
