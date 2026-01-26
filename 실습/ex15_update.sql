--ex15.update.sql

/*
    update문
    - 원하는 행의 원하는 컬럼값으로 수정하는 명령어
    
    update 테이블명 set 컬럼명 = 값, [컬럼명 = 값] X N [where 절]
    
*/
commit;
rollback;

select * from tblCountry;

-- 대한민국: 서울 > 세종
update tblCountry set capital = '세종' where name = '대한민국';

-- 전체 세계 인구수 10% 증가
update tblCountry set population = population * 1.1;

update tblCountry set capital = '제주', population = 5000, area = 20 where name = '대한민국';