/*
모든 환자에 대해 총 내원일수를 구하고
총 내원일수의 최대값과 총 내원일수 최대값을 가지는 환자수를 찾는 쿼리.
*/

-- 내원 = 외래,입원,응급
-- 입원, 응급 환자는 visit_end_date가 같기 때문에 처음 들어온 날을 구해준다.
with tmp as(
	select person_id, min(visit_start_date) as visit_start_date, visit_end_date
	from emr.visit_occurrence
	group by 3, 1
)

-- 위에 만든 테이블로 '내원일수' 계산
, tmp2 as(
	select person_id, sum(visit_end_date - visit_start_date + 1) as total_visit_date
	from tmp
	group by 1
	order by 2 desc
)

-- 총 내원일수의 최대값과 총 내원일수 최대값을 가지는 환자 수를 찾는 쿼리
select total_visit_date, count(total_visit_date)
from tmp2
group by 1
order by 1 desc
limit 1;