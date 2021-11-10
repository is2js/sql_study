/* 내장함수 */

/*  LENGTH() : 문자열 길이 반환*/
SELECT 
    LENGTH('asdfjklasdf');


/*  CONCAT() : 문자열 합치기*/
-- * 주의: 하나라도 null이면, null을 반환
SELECT 
    CONCAT('My', 'SQL is Op', 'en Source');


/*  LOCATE(찾문, 원문) : 처음나타나는 위치 반환*/
-- * 주의: mysql은 index가 1부터다., 원문을 뒤에 준다.
SELECT 
    LOCATE('abc','asdlkfjkalsabcsdfas');

/* LEFT(원문, n), RIGHT(원문, n) */
-- 한쪽에서 n개만 뽑아줘.
SELECT 
    LEFT('Mysql is an open source', 4);
SELECT 
    RIGHT('Mysql is an open source system', 6);


/* LOWER(), UPPER() */
SELECT 
    LOWER('Mysql is an open source');
SELECT 
    UPPER('Mysql is an open source system');

/* REPLACE() */
SELECT 
    REPLACE('MSSQL', 'MS', 'My');


/* TRIM() */
-- 기본적으로 공백을 없애지만
-- * 특정 문자도제거할 수 있다. python의 strip()
SELECT 
    TRIM('            asdfk  ');

SELECT 
    TRIM('            asdfk  '), -- 공백제거
    TRIM(LEADING '#' FROM '###Mysql###'), -- 앞에서 특정문자 제거
    TRIM(TRAILING '#' FROM '###Mysql###') -- 뒤에서 특정문자 제거

/* FORMAT() */
-- * FORMAT(숫자) -> [3자리씩 쉼표로 끈어주는 문자열]로 반환. + 2번째 인자를 주면, 반올림해서 만들 소수부분 자리수
SELECT 
    FORMAT(123132123.1231321, 4); -- 123,132,123.1231
    



