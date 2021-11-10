/* DB에서 날짜는 매우 중요함. */

/* NOW(), CURDATE(), CURTIME() */
/* NOW(): 지금날짜+시간, CURDATE():지금날짜, CURTIME():지금시간*/

-- * DATE(들어간 것)은 날짜만 보여주는게 아니라 시간도 00:00:00로 같이 온다. 
SELECT 
    NOW(),       -- Tue Nov 09 2021 21:04:00 GMT+0900 (대한민국 표준시)	
    DATE(NOW()), -- Tue Nov 09 2021 00:00:00 GMT+0900 (대한민국 표준시)
    CURDATE(),   -- Tue Nov 09 2021 00:00:00 GMT+0900 (대한민국 표준시)
    CURTIME()    -- 21:04:00

SELECT
    NOW(),
    DATE(NOW()), -- * 현재시간에 대한~ : 내부 인자로 NOW()를 가진다.
    -- * NOW / CURDATE / CURTIME  / DATE+NOW  -> TIME은 함수가 따로 없고 다 쪼개서 + NOW랑 같이 사용한다.
    YEAR(NOW()), -- 현재시간에 대한, 년정보만 보여줘
    MONTH(NOW()), -- 현재시간에 대한, 월
    DAY(NOW()), -- 현재시간에 대한,  일 
    HOUR(NOW()), -- 현재시간에 대한,  시간만 보여줘
    MINUTE(NOW()), -- 현재시간에 대한, 
    SECOND(NOW())-- 현재시간에 대한, 


    
/* MONTHNAME(), DAYNAME() */
SELECT 
    MONTHNAME(NOW()), -- November
    DAYNAME(NOW()) -- Tuesday


/* DAYOFWEEK(), DAYOFMONTH(), DAYOFYEAR() */
-- * DAYOFMONTH() 는 월중에 몇번째 일? -> 우리가 아는 day
-- * DAYOFWEEK() 요일을 의미 1일~7토  
-- * DAYOFYEAR() 연중에 몇번재 일? -> 1~366? 사이 값을 반환
SELECT 
    DAYOFMONTH(NOW()), -- November
    DAYOFWEEK(NOW()), -- 4
    DAYOFYEAR(NOW()) -- Tuesday


/* DATE_FORMAT() */
-- * python의 strftime과 동일한 듯. 
-- FORMAT은 그냥 3자리씩 끊어주는 문자열로 변환되었으나.. 
-- DATE_FORMAT은 format대로 변형해줌.
SELECT 
    DATE_FORMAT(NOW(), '%y %m %d %D %n  %j')
                    -- 21 11 09 9th n 313

