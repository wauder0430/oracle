ex16_delete.sql

/*
    delete
    - DML
    - 원하는 행을 삭제하는 명령어 
    - 컬럼 삭제(X) 
    
    delete [from] 테이블명 [where 절] 
    
*/
commit;
rollback;

select * from tblCountry;
delete from tblCountry where name = '중국';
delete from tblCountry where continent = 'AS';
delete from tblCountry;

-- DML
-- select 일부
-- insert 전부
-- update 전부
-- delete 전부