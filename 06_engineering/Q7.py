import psycopg2

# postgres 정보 입력
conn = psycopg2.connect(host='localhost', dbname='test', user='postgres', password='admin', port='5432')
cur = conn.cursor()

sql = """
        select emr.person.person_id, 
                dp.drug_concept_id,
                dp.drug_exposure_start_date
        from emr.person
        left join emr.condition_occurrence as co on co.person_id = emr.person.person_id
        left join emr.drug_exposure as dp on dp.person_id = emr.person.person_id
        where co.condition_concept_id in (
            3191208,36684827,3194332,3193274,43531010,4130162,45766052,
            45757474,4099651,4129519,4063043,4230254,4193704,4304377,
            201826,3194082,3192767)
            and dp.drug_concept_id in (19018935, 1539411,1539463,19075601,1115171)
        group by 1, 3, 2
        order by 1, 3
    """
cur.execute(sql)
datas = cur.fetchall()

# 처방받은 약을 같은 날짜별로 그룹하기
# datas[i][0] = person_id
# datas[i][1] = drug_concept_id
# datas[i][2] = drug_exposure_start_date
result = []
stack = [[datas[0][1]]]
for i in range(1, len(datas)):
    # person_id가 다르면 다른 사람이므로 stack을 result에 저장 후, stack 초기화
    if datas[i][0] != datas[i-1][0] or i==len(datas)-1:
        result.append([datas[i-1][0], stack])
        stack = [[datas[i][1]]]
    
    # 같은 날 처방받은 약을 한 그룹으로 묶고, stack에 push
    elif datas[i][0] == datas[i-1][0] and datas[i][2] == datas[i-1][2]:
        concept_id = stack.pop()
        concept_id.append(datas[i][1])
        stack.append([concept_id])
    
    # 다른 날이라면 stack에 push
    else:
        stack.append([datas[i][1]])


# 처방받은 약 변동 사항 확인하기.
result2 = []
for person_id, stack in result:
    if len(stack) == 1:
        count = 0
    else:
        count = 0
        # stack의 이전 값과 다르다면 처방 받은 약이 변동된 것이므로 +1
        for i in range(1, len(stack)):
            if stack[i-1] != stack[i]:
                count +=1
    
    result2.append([person_id, count])

# 처방받은 약 변동 빈도로 배열 정렬하기.
result2 = sorted(result2, key=lambda result:result[1], reverse=True)
for person_id, change_frequency in result2:
    print(person_id, change_frequency)