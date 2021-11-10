/* DDL: db, 테이블, 뷰, 인덱스를 create, drop, alter */

/* CREATE TABLE AS SELECT */
-- * 테이블 복사!
-- * select로 만든 테이블정보 자체를 table로 만든다.
CREATE TABLE
    city2 AS (
        SELECT 
            *
        FROM 
            city
    ) -- 닫괄은 열때의 위치까지 가야한다. 

SELECT
    *
FROM
    city2;




/* CREATE DATABASE */
-- * DB를 생성함. 이 때는 USE DB;로 바꿔서 사용해야함.
CREATE DATABASE 
    suan;

USE suan; -- USE world;


/* CREATE TABLE */
-- * 테이블 직접 생성
CREATE TABLE 
    test2 (
        id INT NOT NULL PRIMARY KEY,
        col1 INT NULL,
        col2 FLOAT NULL,
        col3 VARCHAR(45) NULL
    );


SELECT
    *
FROM 
    test2;


/* ALTER TABLE  (ADD|MODIFY|DROP 칼럼)*/
-- * 테이블 만들었는데 실수해서, 수정(칼럼 추가|변경|삭제 등)하는 것!

-- * 여기선 ADD로 칼럼추가.
ALTER TABLE 
    test2
ADD 
    col4 INT NULL;
    
DESC test2;

-- * MODIFY로 칼럼 정보(type) 변경
ALTER TABLE 
    test2 
MODIFY
    col4 VARCHAR(20) NULL;

DESC test2;

ALTER TABLE
    test2
DROP
    col4;
