/* insert */
INSERT INTO test2
    VALUES(2, 123, 1.1, "TEST");

SELECT
    *
FROM
    test2;



CREATE TABLE test (
    id INT NOT NULL PRIMARY KEY,
    col1 INT NULL,
    col2 FLOAT NULL,
    col3 VARCHAR(45) NULL
);


/* insert into  select  */
-- * 테이블을 통째로 select해서  [양식똑같은 기존테이블에] 삽입시키는 방법 
/* : 생성된 양식같은 테이블에    타 테이블내용 복사 */
-- * cf) CREATE TABLE AS (SELECT)
 /* : 생성과 동시에          타테이블내용 복사 */
INSERT INTO test SELECT 
    *
FROM
    test2;

SELECT
    *
FROM
    test;




/* update */
-- * update, delete는?? select where부터!!!
SELECT
    * 
FROM 
    test2
WHERE 
    id = 1;

/* SELECT
    * 
FROM  */
-- * 복사해서 select * from을 날리고 update + 중간에 set 칼럼=값, 추가
UPDATE 
    test2
SET 
    col1=1,
    col2=3.14,
    col3="ㅋㅋㅋ"
WHERE 
    id = 1;

-- * 다시 한번 첨 작성했던 select where로 변경확인
SELECT
    * 
FROM 
    test2
WHERE 
    id = 1;




/* delete */
-- * 복구가 가능하게 내부에 숨겨두고 지워서, 용량은 줄진 않는다. ROLL BACK 가능한 휴지통에 넣기

-- * update와 마찬가지로 delete도 select where부터
SELECT
    *
FROM
    test2
where 
    id=2;

/* SELECT
    * */
-- 이번에는 select * 까지만 날리고 delete
DELETE FROM
    test2
where 
    id=2;


/* truncate table */
-- * 복구불가로 내용삭제(껍데기만 남아있다) +용량도 줄어듬 
TRUNCATE TABLE test;

SELECT
    *
FROM
    test;


/* DROP TABLE */
-- * delete, truncate는 내용만 지우고 껍데기는 남겼으나
-- * drop table이 진짜 아예 없애는 것
DROP TABLE test2;

SELECT
    *
FROM
    test;

/* DROP DATABASE */
DROP DATABASE suan;

/* q8. 자신만의 연락처 테이블 만들어보기 */
/* https://dev.mysql.com/doc/refman/8.0/en/data-types.html */
CREATE DATABASE chojaeseong; 
USE chojaeseong; 
CREATE TABLE information (
    id INT NOT NULL PRIMARY KEY, 
    myname VARCHAR(40) NULL, 
    phone INT NULL, 
    address VARCHAR(50) NULL, 
    email VARCHAR(40) NULL 
);