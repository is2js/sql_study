/*
환자들이 진단 받은 상병 내역 중 첫글자는 (a,b,c,d,e) 문자로 시작하고
중간에 “heart” 단어가 포함된 상병 이름을 찾는 쿼리.
*/

select distinct(c.concept_name)
from emr.condition_occurrence as co
left join emr.concept as c
on co.condition_concept_id = c.concept_id
where c.concept_name ~* '^[abcde]' and c.concept_name ~* 'heart';