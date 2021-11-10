/* DDL: db, 테이블, 뷰, 인덱스를 create, drop, alter */

/* index */
-- * 테이블을 순서대로 가 아닌, 빠르게 검색하고 싶을 때 생성해서 쓴다. 
-- 검색, 질의 시 테이블 전체를 안읽기 때문에 빠름
-- * 단점: 삽입/삭제/수정이 빈번하게 발생할 경우, index가 커지고 데이터 수정에 따라 인덱스도 함께 수정되어야하므로 오버헤드가 발생
-- 검색이 많은 테이블에 생성하여 사용한다.
DESC test2;

/* create index */
-- * 해당테이블 ON (해당칼럼) 까지 가서 인덱스를 생성하네...
CREATE INDEX
    Col1Idx
    ON test2 (
        col1
    );

/* show index  */
-- PRIMARY KEY로 생성한 칼럼은, PRIMARY라는 index를 자동으로 가진다.
SHOW INDEX
FROM 
    test2;


/* create unique index */
-- * 중복값을 허용하지 않는 인덱스 만들기 
CREATE UNIQUE INDEX 
    Col2Idx
    ON test2 (
        col2
    );

-- * Non_unique가 0이므로 unique다.
SHOW INDEX 
FROM 
    test2;


/* fulltext index */
-- * 일반적인 인덱스와 달리, 각 테이블의 [모든 TEXT칼럼들을 검색해서 봄]
-- * 문자열 전체를 검색시, 이놈이 작동해서 빠르게 처리한다.

-- * 여러방법이 있지만, 테이블에 칼럼 추가하듯이 ALTER TABLE로 추가한다.
-- *  - col3칼럼에 주는 것처럼 만들지만, 텍스트칼럼 전체를 검색함. 
ALTER TABLE 
    test2
ADD 
    FULLTEXT Col3Idx(col3);

-- * Index_type이 다른 index들은 BTREE지만, 이것만 FULLTEXT라고 떠있다.
SHOW INDEX 
FROM 
    test2; 




/* INDEX 삭제(ALTER) */
-- * 인덱스 삭제 방법은 2가지가 있다. 1)alter table  drop index  2)  DROP INDEX
/* 1) alter table */
ALTER TABLE
    test2
DROP INDEX 
    Col3Idx;

SHOW INDEX
FROM 
    test2;


/* 2) drop index */
-- DROP문은 내부적으로 ALTER 문으로 자동 변환되어 명시된 이름의 인덱스를 삭제
DROP INDEX
    Col2Idx
    ON test2;

SHOW INDEX
FROM 
    test2;