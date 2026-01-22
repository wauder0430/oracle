-- ex02_select.sql

/*
    SELECT문
    - DML, DQL
    - 특정 테이블로부터 원하는 데이터를 가져온다.
    - 00절 > 각각의 기능
    
    [WITH <Sub Query>] 
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING serach_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    SELECT column_list  -- 원하는 컬럼을 지정 > 해당 컬럼만 가져와라 
    FROM table_name     -- 데이터 소스, 어떤 테이블로부터 데이터를 가져와라
    
    각 절의 순서 **********************************************
    2. SELECT
    1. FROM 
    
    
*/

select regdate      --2.
from tblType;       --1.

select * from tabs; --tabs > tables + 시스템 테이블

-- EMPLOYEES 구조?
desc employees; --describe

select *        -- *, 모든 컬럼
from employees;

select last_name, phone_number
from employees;

select * from tblCountry;
select * from tblComedian;
select * from tblDiary;
select * from tblInsa;
select * from tblMen;
select * from tblWomen;
select * from tblTodo;
select * from tblHouseKeeping;


select *            
from tblCountry;

select name         -- 단일 컬럼
from tblCountry;

select name, capital   -- 다중 컬럼
from tblCountry;

select capital, name   -- 다중 컬럼 > 컬럼순서는 마음대로
from tblCountry;

select name, length(name) -- 같은 컬럼 여러번 가져오기
from tblCountry;

-- select 질의(query) > 결과 반환 > 항상 테이블 형태 
-- > 결과 테이블(Result Table), 결과 셋(Result Set)


-- 에러 
select * from tblCountr; -- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
select nam from tblCountry; -- ORA-00904: "NAM": 부적합한 식별자


