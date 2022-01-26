--DDL--
--은행A에서 은행B로 전달하기--
CREATE TABLE BANK_A (
이름 CHAR(20),
계좌 TEXT,
잔고 INT
);

CREATE TABLE BANK_B (
이름 CHAR(20),
계좌 TEXT,
잔고 INT
);

SELECT * FROM BANK_A;
SELECT * FROM BANK_B;

INSERT BANK_A VALUES ('김효정', '1', '500000');


--은행b에 다른사람 넣기--***mysql이랑 INTO없음
INSERT BANK_B VALUES ('김유리', '2', '300000');            -- INSERT 테이블 VALUES (,,)



--트랜잭션 전 확인하기-
SELECT * FROM BANK_A
SELECT * FROM BANK_B

BEGIN TRAN --트랜잭션 시작***------------------------------------------------------------------------------
UPDATE BANK_A SET 잔고 = 잔고 - 50000 WHERE 이름 = '김효정' --UPDATE 테이블 SET 칼럼=칼럼조작 WHERE 조건문
SELECT * FROM BANK_A
UPDATE BANK_B SET 잔고 = 잔고 + 50000 WHERE 이름 = '김유리'
SELECT * FROM BANK_B  -- 여기까지 한번에 실행

COMMIT -- 마음에들어서 트랜잭션 저장하는 것
ROLLBACK --BEGIN TRAN 한것을 되돌리는 것
----------------------------------------------------------------------------------------------------------


--index------------------------------------------------
--** index확인
sp_help Person; -- indexname까지 있으면, index가 존재하는 것
-- 가장 많이 나오는 칼럼을 인덱스로 잡아주는 게 좋다.



---join------------------------------------------------
--서로 다른 테이블을, 하나의 공통칼럼으로 연결하는 것--
CREATE TABLE A (
LETTER_U CHAR(1),
Number smallint
);

CREATE TABLE B (
LETTER_U CHAR(1),
LETTER_S CHAR(1),
);

SELECT * FROM A;
SELECT * FROM B;

INSERT A VALUES ('A','1');
INSERT A VALUES ('A','2');
INSERT A VALUES ('B','1');
INSERT A VALUES ('C','2');

INSERT B VALUES ('A','a');
INSERT B VALUES ('D','d');


-------------------------------------join시작----
--테이블간의 연결은 LETTER_U
--1. INNER JOIN = JOIN
--inner join은 교집합이라 선후관계가 상관없다***
--inner join의 조건문은 ON***** , join의 조건은 각각의 table을 적어줘야한다.
SELECT * FROM A INNER JOIN B ON A.LETTER_U = B.LETTER_U

--알리아스(alias) : 별명만 만들어주기
SELECT * FROM A AS a INNER JOIN B AS b ON a.LETTER_U = b.LETTER_U
--만든 것 sp_help

--2. OUTER JOIN -> 한 테이블은 다 살리고 나머니지 칼럼 교집합 살리겠다.--
-- 방향은 LEFT, RIGHT, FULL JOIN =  OUTER JOIN 

--참고) 지우는 연습 SELECT -> DELTEE

SELECT * FROM A WHERE LETTER_U = A;
DELETE FROM A WHERE LETTER_U = A;

DELETE FROM A; --where안주면, table안의 내용 전체 지우기
CREATE TABLE A

INSERT A VALUES ('A',1 )
INSERT A VALUES ('A',2 )
INSERT A VALUES ('B',1 )
INSERT A VALUES ('C',2 )

SELECT * FROM A;
SELECT * FROM B;
SELECT * FROM A LEFT JOIN B ON A.LETTER_U = B.LETTER_U;

SELECT * FROM A;
SELECT * FROM B;
SELECT * FROM A RIGHT JOIN B ON A.LETTER_U = B.LETTER_U; -- 유니크하지 않는 left 테이블때문에 오른쪽을 다 살리려면 row3개가 나온다.

--FULL JOIN -> 교집합 + 여집합 싹다
SELECT * FROM A FULL JOIN B ON A.LETTER_U = B.LETTER_U;

--cross join : n X m 다 만들기
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