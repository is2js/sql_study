/*
제 2형 당뇨병을 진단받은 환자 중에
18세 이상의 환자 중에
진단을 받은 이후 Metformin을 90일 이상 복용한 환자수
*/

select count(distinct(emr.person.person_id))
from emr.person
left join emr.condition_occurrence as co on co.person_id = emr.person.person_id
left join emr.drug_exposure as dp on dp.person_id = emr.person.person_id
where co.condition_concept_id in (
	3191208,36684827,3194332,3193274,43531010,4130162,45766052,
	45757474,4099651,4129519,4063043,4230254,4193704,4304377,
	201826,3194082,3192767)
	and date_part('year', current_timestamp) - emr.person.year_of_birth >= 18
	and drug_concept_id = 40163924