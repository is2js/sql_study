/*
환자번호 ‘1891866’ 환자의 약 처방 데이터에서 
처방된 약의 종류별로 처음 시작일, 마지막 종료일, 복용일(마지막 종료일과 처음시작일의 차이)을 구하고 
복용일이 긴 순으로 정렬하여 테이블을 생성.
*/
begin;
drop table if exists emr.summary_drug_date;

create table emr.summary_drug_date as(
	select drug_concept_id,
		min(drug_exposure_start_date) as drug_expousure_first_date, 
		max(drug_exposure_end_date) as drug_exposure_last_date, 
		(max(drug_exposure_end_date)-min(drug_exposure_start_date)) as diff_first_and_last_date
	from emr.drug_exposure
	where person_id = 1891866
	group by 1
	order by 4 desc
);

end;