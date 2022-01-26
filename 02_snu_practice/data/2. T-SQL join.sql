--DDL--
--����A���� ����B�� �����ϱ�--
CREATE TABLE BANK_A (
�̸� CHAR(20),
���� TEXT,
�ܰ� INT
);

CREATE TABLE BANK_B (
�̸� CHAR(20),
���� TEXT,
�ܰ� INT
);

SELECT * FROM BANK_A;
SELECT * FROM BANK_B;

INSERT BANK_A VALUES ('��ȿ��', '1', '500000');


--����b�� �ٸ���� �ֱ�--***mysql�̶� INTO����
INSERT BANK_B VALUES ('������', '2', '300000');            -- INSERT ���̺� VALUES (,,)



--Ʈ����� �� Ȯ���ϱ�-
SELECT * FROM BANK_A
SELECT * FROM BANK_B

BEGIN TRAN --Ʈ����� ����***------------------------------------------------------------------------------
UPDATE BANK_A SET �ܰ� = �ܰ� - 50000 WHERE �̸� = '��ȿ��' --UPDATE ���̺� SET Į��=Į������ WHERE ���ǹ�
SELECT * FROM BANK_A
UPDATE BANK_B SET �ܰ� = �ܰ� + 50000 WHERE �̸� = '������'
SELECT * FROM BANK_B  -- ������� �ѹ��� ����

COMMIT -- �������� Ʈ����� �����ϴ� ��
ROLLBACK --BEGIN TRAN �Ѱ��� �ǵ����� ��
----------------------------------------------------------------------------------------------------------


--index------------------------------------------------
--** indexȮ��
sp_help Person; -- indexname���� ������, index�� �����ϴ� ��
-- ���� ���� ������ Į���� �ε����� ����ִ� �� ����.



---join------------------------------------------------
--���� �ٸ� ���̺���, �ϳ��� ����Į������ �����ϴ� ��--
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


-------------------------------------join����----
--���̺��� ������ LETTER_U
--1. INNER JOIN = JOIN
--inner join�� �������̶� ���İ��谡 �������***
--inner join�� ���ǹ��� ON***** , join�� ������ ������ table�� ��������Ѵ�.
SELECT * FROM A INNER JOIN B ON A.LETTER_U = B.LETTER_U

--�˸��ƽ�(alias) : ���� ������ֱ�
SELECT * FROM A AS a INNER JOIN B AS b ON a.LETTER_U = b.LETTER_U
--���� �� sp_help

--2. OUTER JOIN -> �� ���̺��� �� �츮�� ���Ӵ��� Į�� ������ �츮�ڴ�.--
-- ������ LEFT, RIGHT, FULL JOIN =  OUTER JOIN 

--����) ����� ���� SELECT -> DELTEE

SELECT * FROM A WHERE LETTER_U = A;
DELETE FROM A WHERE LETTER_U = A;

DELETE FROM A; --where���ָ�, table���� ���� ��ü �����
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
SELECT * FROM A RIGHT JOIN B ON A.LETTER_U = B.LETTER_U; -- ����ũ���� �ʴ� left ���̺����� �������� �� �츮���� row3���� ���´�.

--FULL JOIN -> ������ + ������ �ϴ�
SELECT * FROM A FULL JOIN B ON A.LETTER_U = B.LETTER_U;

--cross join : n X m �� �����
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