/* https://github.com/is2js/SQL-study */

/* https://nittaku.tistory.com/413?category=764930  */

-- *  [EXCEL 시각화1] 테이블  칼럼|type 들을 다 복붙해서 나타내기

-- * null칼럼 찾기 by [where 칼럼 IS NULL]

-- * [EXCEL 시각화2] 다양한 범주를 가진 것을 -> [범주(날짜)별 갯수]를 엑셀로 데이터 그리기

-- * [생년월일 -> age 변환] by to_days()로 일수차이 + round() 를 이용한다.

-- *  case문으로 [만나이]변경한 것을 -> [연령대]로 매핑칼럼 만들기
-- * [case 매핑칼럼] <<<앞>>>>에 *, 기존칼럼을 모두 가진 상태를 subquery로서, from () Z로 활용 -> 매핑칼럼으로 group by 집계하기
-- * [case문 매핑칼럼] -> [합쳐서 subquery에 얹고 집계] -> [추가 집계]

-- * [EXCEL 시각화3] 연령대별-성별별-갯수  <집계된 3개칼럼>을 엑셀에 옮긴 뒤 [엑셀에서 뒷 집계기준칼럼을 unmelting]
-- *               -> 성별(0, 1)은 [unmelting]한 것처럼, 2row-> 1row로 2개 칼럼으로 나눠서 배치
-- 10대미만|0|12  --->           0 | 1
-- 10대미만|1|30       10대미만| 12| 30