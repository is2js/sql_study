# de_testing

### -- # <Solution 1>
select person_id, sum(visit_days) as sum_days, max(visit_days) as max_long_days
from (
	select person_id, (visit_end_date - visit_start_date + 1) as visit_days
	from visit_occurrence
) as tmp
group by person_id
order by max_long_days desc

### -- # <Solution 2>
select distinct hrt_disease.concept_name
from condition_occurrence AS co
join 
(
	select concept_id, concept_name
	from concept
	where 
	(
		LOWER(concept_name) like 'a%' or 
 		LOWER(concept_name) like 'b%' or 
 		LOWER(concept_name) like 'c%' or
 		LOWER(concept_name) like 'd%' or
 		LOWER(concept_name) like 'e%'
	) 
	and concept_name like '%heart%'
) AS hrt_disease
on co.condition_concept_id = hrt_disease.concept_id

### -- # <Solution 3>
select drug_concept_id, max(drug_exposure_end_date) - min(drug_exposure_start_date) as exposure_days
from drug_exposure 
where person_id = '1891866'
group by drug_concept_id
order by exposure_days desc

### -- # <Solution 4>
;with drug_list as (
select de.drug_concept_id, concept_name, count(*) as cnt
from drug_exposure de
join concept 
on de.drug_concept_id = concept_id
where drug_concept_id in (40213154,19078106,19009384,40224172,19127663,1511248,40169216,1539463, 19126352,1539411,1332419,40163924,19030765,19106768,19075601)
group by drug_concept_id, concept_name
order by count(*) desc
)
, drugs as (select drug_concept_id, concept_name from drug_list)
, prescription_count as (select drug_concept_id, cnt from drug_list)
select concept_name
from drugs
inner join
(
	select dp.drug_concept_id1 as id1, (pc.cnt) as cnt1, dp.drug_concept_id2 as id2, (pc2.cnt) as cnt2
	from drug_pair dp
	left outer join prescription_count pc
	on dp.drug_concept_id1 = pc.drug_concept_id
	left outer join prescription_count pc2
	on dp.drug_concept_id2 = pc2.drug_concept_id
	where pc2.cnt > pc.cnt
) as aaa
on drugs.drug_concept_id = aaa.id1
order by cnt1 desc

### -- # <Solution 5>
;with diabetes as (
select co.person_id, co.condition_concept_id, 2021-person.year_of_birth
from condition_occurrence as co 
inner join person
on person.person_id = co.person_id
where co.condition_concept_id in (3191208,36684827,3194332,3193274,43531010,4130162,45766052, 45757474,4099651,4129519,4063043,4230254,4193704,4304377,201826,3194082,3192767)
and 2021-person.year_of_birth >= 18
)
, drg_dt as (
	select person_id, days
	from (
	select person_id, drug_concept_id, (max(drug_exposure_end_date) - min(drug_exposure_start_date)) as days
	from drug_exposure 
	where drug_concept_id = '40163924'
	group by person_id, drug_concept_id
	order by days desc
) as drg_dt
where days >= 90
)
select count(*) as "진단약 90일 이상 복용한 환자수"
from diabetes dbt
inner join drg_dt
on dbt.person_id = drg_dt.person_id

### -- # <Solution 6> - Can't Solve😂
;with diabetes as (
select person_id, condition_concept_id 
from condition_occurrence as co
where co.condition_concept_id in (3191208,36684827,3194332,3193274,43531010,4130162,45766052, 45757474,4099651,4129519,4063043,4230254,4193704,4304377,201826,3194082,3192767)
)
, drug_concept as (
	select person_id, drug_concept_id , drug_exposure_start_date, drug_exposure_end_date
	from drug_exposure
	where drug_concept_id in (19018935, 1539411, 1539463, 19075601, 1115171)
	order by person_id, drug_exposure_start_date, drug_concept_id
)
select dbt.person_id as pid, drug_concept_id, lead(drug_concept_id) over(order by drug_exposure_start_date) as lead_drug_id
from diabetes dbt
inner join drug_concept dc
on dbt.person_id = dc.person_id

### -- # <Solution 7> - Can't Solve😂
1. sqlalchemy, regex 라이브러리를 활용
2. sqlalchemy를 활용하여 clinical note 테이블 데이터를 가져온다.
3. 만들어야할 테이블 컬럼의 패턴에 맞게 정규식을 작성한다.
4. clinical note 에서 가져온 row 데이터를 정규식 패턴을 통해 추출, 정제하여 각 테이블 컬럼 정보별로 list 를 만든다.
5. sqlalchemy 를 통해 walker102 스키마에 table을 생성한 후, create, insert 함수를 활용하여 row를 테이블에 입력한다.
