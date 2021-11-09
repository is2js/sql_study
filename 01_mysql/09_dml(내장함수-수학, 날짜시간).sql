/* FLOOR(), CEIL(), ROUND() */
SELECT
    FLOOR(10.95),
    CEIL(10.95),
    ROUND(10.95);

/* SQRT(), POW(), EXP(), LOG() */
SELECT 
    SQRT(4),
    POW(2, 3),
    EXP(3),
    LOG(3)

/* SIN(), COS(), TAN(), PI() */
-- * PI()라는 상수를 반환하는 함수도 있다.
SELECT 
    SIN(PI()/2), 
    COS(PI()), 
    TAN(PI()/4)

/* ABS(), RAND() */
-- * RAND() 기본: 0.0~1.0사이의 랜덤 [실수] 생성. 
-- * RAND() * 100 + ROUND(, 0): 0.0~100.0 -> 소수점제거를 위한 0번째자리(일의 자리)로 반올림
SELECT 
    ABS(-3), 
    RAND(), 
    ROUND(RAND()*100, 0)
