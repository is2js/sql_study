-- 간단 설명
-- RDBMS, 오픈소스, 다중사용자 및 다중 스레드 지원, 다양한 언어용 API제공
-- 웹개발에 자주 이용 PHP-MYSQL
-- oracle이 사서.. 오픈소스이긴 하지만, 상업적 사용시 라이센스 구매해애햠.
-- 설치: oracle 가입해서 해야함.
-- oracle이 사면서 워크벤치를 만들었다.

-- 만약 mysql 안켜진다면: 
-- 1) 서비스 > mysql 검색 후 시작 (시작도 비활성화상태면 -> 속성 -> 시작:자동으로 변경)
-- 2) 윈도우터미널: net start mysql80

-- vscode 확장: 
-- 1) mysql cwei~ (windows에서 vscode킬때만 연결된다!!! -> wsl-우분투에서는 localhost에 mysql에 안깔린 상태임.)
--   -> ctrl+k,s 로 run query 단축키를 (ctrl+enter) -> alt+enter로 바꿔서, 줄바꿈(ctrl+enter)를 유지하면서 쿼리를 실행시킨다.
-- 2) sql highlighting 


-- 참고사이트
-- https://chaelinyeo.github.io/etc/MySQL%EC%A0%95%EB%A6%AC/#%EC%9E%90%EC%8B%A0%EB%A7%8C%EC%9D%98-%EC%97%B0%EB%9D%BD%EC%B2%98-%ED%85%8C%EC%9D%B4%EB%B8%94-%EB%A7%8C%EB%93%A4%EA%B8%B0%EC%9D%B4%EB%A6%84-%EC%A0%84%ED%99%94%EB%B2%88%ED%98%B8-%EC%A3%BC%EC%86%8C-%EC%9D%B4%EB%A9%94%EC%9D%BC

SHOW DATABASES;