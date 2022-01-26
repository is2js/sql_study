import sqlalchemy
import pandas as pd

# https://stackoverflow.com/questions/46543436/speeding-bulk-insert-into-mysql-with-python


# * 01_sql로 table 생성 -> table_name만(file은 sample_만 붙는다) 바꿔서 csv -> df -> db
table_name = 'diagnosiscodemaster' 

file_name = 'sample_' + table_name
file_abs_path = f'C:/sql_study/02_snu_practice/data/{file_name}.csv'
mysql_password = '564123'
uri = f'mysql+pymysql://root:{mysql_password}@localhost/pmd'
engine = sqlalchemy.create_engine( uri )

# 1. engine.execute("")로 직접 쿼리 실행하여 [빈 테이블 생성]
# engine.execute(f'''drop table if exists {table_name};''')
# engine.execute(f'''{table_create_stmt}''')

# 2. pandas를 이용해서  csv-> df-> 데이터삽입
# using_pandas('table4', uri)
# * 처리1) master csv들 read_csv unicodeError -> encoding = 'unicode_escape'
# * 처리2) master csv들 -> sqlalchemy.exc.OperationalError Unknown column -> db칼럼명과 동일하게 csv칼럼명 수정
df = pd.read_csv(f'{file_abs_path}', encoding = 'unicode_escape')
df.to_sql(table_name, con=uri, if_exists='append', index=False)

print(f"{table_name}: bulk insert complete!")