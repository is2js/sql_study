
### 생성 목적(21.11.08)
 - 알고리즘 및 자료구조(21.09.01 ~ 21.11.05) 2개월 학습 이후 우테코 4기 코딩테스트 7문제 7제출(6 ~ 7솔)성공후 숙련도가 부족한(2019이후 미사용한) SQL 연습을 위해 작성한 레포입니다.
    - 처음부터 linewalks Sql style guide에 따라 작성하여 연습하였습니다.
 - 참고블로그  : https://chaelinyeo.github.io/etc/MySQL%EC%A0%95%EB%A6%AC/

### 공부환경
- vscode(windows10) : local db연결 편의성을 위해 wsl2 사용안함.
- vscode extension : MySQL cweijan

### style guide
 - https://github.com/linewalks/de-common/wiki/SQL-Style-Guide
#### Basic
 - 들여쓰기는 4칸으로 한다.
 - SQL 구문, 내장 함수, 예약어 등은 `대문자로 작성`한다.
    - SELECT, FROM, WHERE, AS, COUNT, SUM 등
 - 테이블, 컬럼, 변수 이름은 `snake_case`로 작성한다.
    - 외부 제공 테이블의 경우는 예외가 있을 수 있음
 - Subquery는 지양한다.
    - 되도록이면 Common Table Expression(CTE) 사용
    - 참고사이트 : https://yahwang.github.io/posts/49

#### Format
 - SELECT, FROM, JOIN 등은 한 줄에 단독으로 존재한다.
 - JOIN과 ON은 FROM절 안으로 들여쓴다.
    - SELECT 구문이 실행되는 대상 테이블이 FROM + JOIN 전체 대상임.
 - 한 줄에는 하나의 컬럼, 하나의 조건만 들어가게 작성한다.
    - 쉼표(,)는 줄의 마지막에 쓴다.
    - AND, OR, +, - 등의 연산자는 줄의 앞에 쓴다.

```sql
-- Do
SELECT
    a.subject_id,
    a.hadm_id
FROM
    mimiciii.admissions a
    LEFT JOIN
        mimiciii.patients p
    ON
        a.subject_id = p.subject_id
    LEFT JOIN
        mimiciii.prescriptions d
    ON
        a.subject_id = d.subject_id
        AND a.hadm_id = d.hadm_id
WHERE
    a.admittime + INTERVAL '1 day' > d.startdate
    AND gender = 'F'
    AND dob > '2100-01-01'

-- Don't (줄이 쉼표로 시작)
SELECT
    subject_id
    , a.hadm_id
FROM
    mimiciii.patients p
WHERE
    gender = 'F'
    AND dob > '2100-01-01'

-- Don't (줄이 AND로 끝남)
SELECT
    subject_id,
    a.hadm_id
FROM
    mimiciii.patients p
WHERE
    gender = 'F' AND
    dob > '2100-01-01'
```

#### Case문 예시
```sql
SELECT
    CASE 
        WHEN a = 1 THEN 1
        WHEN a = 2 THEN 2
        ELSE 123
    END AS some_col
FROM
    some_table
```

#### Join
 - Join 타입을 명시한다.
    - Default Join은 DBMS에 따라 달라질 수 있기 때문
 - Implicit Join(암시적 조인을 사용하지 않는다)

```sql
-- Do
SELECT
    *
FROM
    table_a
    INNER JOIN --join 타입 명시
        table_b
    ON
        table_a.id = table_b.id

-- Don't (Implicit Join 사용 'from a, b')
SELECT
    *
FROM
    table_a,
    table_b
WHERE
    table_a.id = table_b.id

-- Don't (JOIN 타입 명시x)
SELECT
    *
FROM
    table_a
    JOIN
        table_b
    ON
        table_a.id = table_b.id
```

#### 괄호
 - 괄호 안의 내용이 여러 줄일 때
    - 여는 괄호 후엔 줄 바꿈
    - 닫히는 괄호 전에 줄 바꿈
    - 괄호 안의 내용은 한 단계 들여씀

```sql
-- Do
WITH sample AS (
    SELECT
        client_id
    FROM
        main_summary
    WHERE
        sample_id =42
),
sample2 AS (
    SELECT
        client_id
    FROM
        main_summary
    WHERE
        sample_id = 43
)

-- Don't (닫히는 괄호 위치)
WITH sample AS (
    SELECT
        client_id
    FROM
        main_summary
    WHERE
        sample_id = 42)

-- Don't (들여쓰기 안함)
WITH sample AS (
SELECT
    client_id,
FROM
    main_summary
WHERE
    sample_id = 42
)
```