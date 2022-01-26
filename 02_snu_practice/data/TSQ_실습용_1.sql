--실습용_1.sql : Transaction & JOIN  
-- Index는 이론/설명만 

--★ 1-1. Transaction 연습 ★--------

--DROP TABLE BANK_A
--DROP TABLE BANK_B

CREATE TABLE BANK_A
(
이름 CHAR(20)
, 계좌 TEXT 
, 잔고 INT  
)

CREATE TABLE BANK_B
(
이름 CHAR(20)
, 계좌 TEXT 
, 잔고 INT  
)

SELECT * FROM BANK_A 
SELECT * FROM BANK_B 

INSERT BANK_A VALUES ('김효정','1', '500000')
INSERT BANK_B VALUES ('김유리','1', '0')

-- 은행 A에서 B로 김효정 --> 김유리 5만원 송금

BEGIN TRAN
UPDATE BANK_A SET 잔고 = 잔고 - 50000 WHERE 이름 = '김효정'
SELECT * FROM BANK_A
SELECT * FROM BANK_B

ROLLBACK  


BEGIN TRAN
UPDATE BANK_A SET 잔고 = 잔고 - 50000 WHERE 이름 = '김효정'
UPDATE BANK_B SET 잔고 = 잔고 + 50000 WHERE 이름 = '김유리' 

SELECT * FROM BANK_A
SELECT * FROM BANK_B

COMMIT  


--★ 1-2. Index 예시 ★--------
CREATE CLUSTERED INDEX personid ON Person (personid); 
CREATE NONCLUSTERED INDEX birthday ON Person (birthday); 

SET SHOWPLAN_ALL { ON | OFF }  
SET SHOWPLAN_TEXT { ON | OFF }  
SET STATISTICS IO { ON | OFF }  
SET STATISTICS TIME { ON | OFF }  
SET STATISTICS PROFILE { ON | OFF }  

쿼리실행계획 참고자료 
https://docs.microsoft.com/ko-kr/sql/relational-databases/query-processing-architecture-guide?view=sql-server-2017


--★ 1-3. JOIN 예시 ★--------
-- 예시를 위한 테이블 생성 -- 
CREATE TABLE A
(
Letter_U CHAR(1)
, Number smallint 
)

INSERT A VALUES ('A',1 )
INSERT A VALUES ('A',2 )
INSERT A VALUES ('B',1 )
INSERT A VALUES ('C',2 )


SELECT * FROM A ORDER BY 1

CREATE TABLE B
(
Letter_U CHAR(1)
, Letter_S CHAR(1) 
)

INSERT B VALUES ('A','a' )
INSERT B VALUES ('D','d' )

SELECT * FROM A ORDER BY 1
SELECT * FROM B ORDER BY 1

--★ JOIN의 종류 : INNER / LEFT / RIGHT / CROSS -- 
-- INNER JOIN 
SELECT * FROM A ta
	JOIN B tb ON ta.Letter_U = tb.Letter_U
-- = INNER JOIN B tb ON ta.Letter_U = tb.Letter_U

-- LEFT JOIN 
SELECT * FROM A ta
	LEFT JOIN B tb ON ta.Letter_U = tb.Letter_U
-- = LEFT OUTER JOIN B tb ON ta.Letter_U = tb.Letter_U

-- RIGHT JOIN 	
SELECT * FROM A ta
	RIGHT JOIN B tb ON ta.Letter_U = tb.Letter_U
-- = RIGHT LEFT OUTER JOIN B tb ON ta.Letter_U = tb.Letter_U
	ORDER BY 3 

-- FULL OUTER JOIN 
SELECT * FROM A ta
	FULL OUTER JOIN  B tb ON ta.Letter_U = tb.Letter_U
-- = FULL OUTER JOIN B tb ON ta.Letter_U = tb.Letter_U
	ORDER BY  1

-- CROSS JOIN 
SELECT * FROM A ta
CROSS JOIN B tb  

-- CROSS JOIN 활용예시를 위한 테이블 생성 
-- DROP TABLE 학년
-- DROP TABLE 반

CREATE TABLE 학년
( 학년 CHAR(1) ) 

CREATE TABLE 반
( 반 CHAR(1) )


INSERT 학년 VALUES (1)
INSERT 학년 VALUES (2)
INSERT 학년 VALUES (3)
INSERT 학년 VALUES (4)
INSERT 학년 VALUES (5)
INSERT 학년 VALUES (6)

INSERT 반 VALUES (1)
INSERT 반 VALUES (2)
INSERT 반 VALUES (3)
INSERT 반 VALUES (4)

SELECT * FROM 학년 

SELECT * FROM 반

SELECT 학년 + '-' + 반 FROM 학년 ta
	CROSS JOIN 반 tb 
	ORDER BY 1 

-- 연습용 Table 삭제
DROP TABLE A
DROP TABLE B
DROP TABLE BANK_A
DROP TABLE BANK_B
DROP TABLE 학년
DROP TABLE 반
