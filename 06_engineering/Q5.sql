/*
짝지어진 두번째 약의 처방 건수가 첫번째 약의 처방 건수보다 더 많은 첫번째 약의 약품명을
처방건수 순으로 출력합니다.
*/

begin;
drop table if exists drug_pair;

create temporary table drug_pair (drug_concept_id1 int, drug_concept_id2 int);
insert into drug_pair values (40213154,19078106),
	(19078106,40213154),
	(19009384,19030765),
	(40224172,40213154),
	(19127663,19009384),
	(1511248,40169216),
	(40169216,1511248),
	(1539463,19030765),
	(19126352,1539411),
	(1539411,19126352),
	(1332419,19126352),
	(40163924,19078106),
	(19030765,19009384),
	(19106768,40213154),
	(19075601,19126352);
end;

with drug_list as (
	select distinct drug_concept_id, concept_name, count(*) as cnt from
	emr.drug_exposure de
	join emr.concept
	on drug_concept_id = concept_id
	where concept_id in (
		40213154,19078106,19009384,40224172,19127663,1511248,40169216,1539463,
		19126352,1539411,1332419,40163924,19030765,19106768,19075601)
	group by drug_concept_id,concept_name
	order by count(*) desc
)
, drugs as (select drug_concept_id, concept_name from drug_list)
, prescription_count as (select drug_concept_id, cnt from drug_list)

-- drugs1
-- drug_concept_id1 을 중심으로 하는 테이블 생성
, drugs1 as (
	select dp.drug_concept_id1, dp.drug_concept_id2, drugs.concept_name, pc.cnt
	from drug_pair as dp
	join drugs on dp.drug_concept_id1 = drugs.drug_concept_id
	join prescription_count as pc on dp.drug_concept_id1 = pc.drug_concept_id
)

-- drugs2
-- drug_concept_id2 를 중심으로 하는 테이블 생성
, drugs2 as (
	select dp.drug_concept_id1, dp.drug_concept_id2, drugs.concept_name, pc.cnt
	from drug_pair as dp
	join drugs
	on dp.drug_concept_id2 = drugs.drug_concept_id
	join prescription_count as pc
	on dp.drug_concept_id2 = pc.drug_concept_id
)

select d1.concept_name
from drugs1 as d1
join drugs2 as d2
on d1.drug_concept_id1 = d2.drug_concept_id1 and d1.drug_concept_id2 = d2.drug_concept_id2
where d1.cnt < d2.cnt
order by d1.cnt;