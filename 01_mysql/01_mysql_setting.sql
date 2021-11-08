-- 간단 설명
-- RDBMS, 오픈소스, 다중사용자 및 다중 스레드 지원, 다양한 언어용 API제공
-- 웹개발에 자주 이용 PHP-MYSQL
-- oracle이 사서.. 오픈소스이긴 하지만, 상업적 사용시 라이센스 구매해애햠.
-- 설치: oracle 가입해서 해야함.
-- oracle이 사면서 워크벤치를 만들었다.

-- 만약 mysql 안켜진다면 
-- 1) 서비스 > mysql 검색 후 시작 (시작도 비활성화상태면 -> 속성 -> 시작:자동으로 변경)
-- 2) 윈도우터미널: net start mysql80

-- 확장: 
-- 1) mysql (windows에서 vscode킬때만 연결된다!!!)
-- -> ctrl+k,s 로 run query 단축키를 (ctrl+enter) -> alt+enter로 바꿔서, 줄바꿈(ctrl+enter)를 유지하면서 쿼리를 실행시킨다.
-- 2) sql highlighting
-- 3) sql (BigQuery) -> f1:change language model -> sql(bigquery) 선택해서 sql 자동완성하게 하기
--   -> 이걸 바꾸면.. sql 실행이 안된다.



SHOW DATABASE;