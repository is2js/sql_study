--�ǽ���_1.sql : Transaction & JOIN  
-- Index�� �̷�/���� 

--�� 1-1. Transaction ���� ��--------

--DROP TABLE BANK_A
--DROP TABLE BANK_B

CREATE TABLE BANK_A
(
�̸� CHAR(20)
, ���� TEXT 
, �ܰ� INT  
)

CREATE TABLE BANK_B
(
�̸� CHAR(20)
, ���� TEXT 
, �ܰ� INT  
)

SELECT * FROM BANK_A 
SELECT * FROM BANK_B 

INSERT BANK_A VALUES ('��ȿ��','1', '500000')
INSERT BANK_B VALUES ('������','1', '0')

-- ���� A���� B�� ��ȿ�� --> ������ 5���� �۱�

BEGIN TRAN
UPDATE BANK_A SET �ܰ� = �ܰ� - 50000 WHERE �̸� = '��ȿ��'
SELECT * FROM BANK_A
SELECT * FROM BANK_B

ROLLBACK  


BEGIN TRAN
UPDATE BANK_A SET �ܰ� = �ܰ� - 50000 WHERE �̸� = '��ȿ��'
UPDATE BANK_B SET �ܰ� = �ܰ� + 50000 WHERE �̸� = '������' 

SELECT * FROM BANK_A
SELECT * FROM BANK_B

COMMIT  


--�� 1-2. Index ���� ��--------
CREATE CLUSTERED INDEX personid ON Person (personid); 
CREATE NONCLUSTERED INDEX birthday ON Person (birthday); 

SET SHOWPLAN_ALL { ON | OFF }  
SET SHOWPLAN_TEXT { ON | OFF }  
SET STATISTICS IO { ON | OFF }  
SET STATISTICS TIME { ON | OFF }  
SET STATISTICS PROFILE { ON | OFF }  

���������ȹ �����ڷ� 
https://docs.microsoft.com/ko-kr/sql/relational-databases/query-processing-architecture-guide?view=sql-server-2017


--�� 1-3. JOIN ���� ��--------
-- ���ø� ���� ���̺� ���� -- 
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

--�� JOIN�� ���� : INNER / LEFT / RIGHT / CROSS -- 
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

-- CROSS JOIN Ȱ�뿹�ø� ���� ���̺� ���� 
-- DROP TABLE �г�
-- DROP TABLE ��

CREATE TABLE �г�
( �г� CHAR(1) ) 

CREATE TABLE ��
( �� CHAR(1) )


INSERT �г� VALUES (1)
INSERT �г� VALUES (2)
INSERT �г� VALUES (3)
INSERT �г� VALUES (4)
INSERT �г� VALUES (5)
INSERT �г� VALUES (6)

INSERT �� VALUES (1)
INSERT �� VALUES (2)
INSERT �� VALUES (3)
INSERT �� VALUES (4)

SELECT * FROM �г� 

SELECT * FROM ��

SELECT �г� + '-' + �� FROM �г� ta
	CROSS JOIN �� tb 
	ORDER BY 1 

-- ������ Table ����
DROP TABLE A
DROP TABLE B
DROP TABLE BANK_A
DROP TABLE BANK_B
DROP TABLE �г�
DROP TABLE ��
