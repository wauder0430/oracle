--ex06_order.sql

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
    WHERE search_condition -- 행 조건 지정 > 원하는 행만 가져와라 
    ORDER BY order_expression [ASC|DESC] -- 레코드 정렬 > 정렬 기준 (컬럼) 
    
    각 절의 순서 **********************************************
    3. SELECT
    1. FROM 
    2. WHERE
    4. ORDER BY 
    
    ORDER BY절
    - ORDER BY 컬럼명
    - ORDER BY 컬럼명 [,컬럼명 [ASC|DESC]] X N
    - ORDER BY 컬럼명 ASC;
    - ORDER BY 컬럼명 DESC;
    
*/

-- *** 원본 테이블 저장된 레코드의 순서는 어떤 정렬 상태인지 알 수 없다. > 오라클 맘대로 ...

select * from tblInsa;
select * from tblInsa order by name;
select * from tblInsa order by name asc;
select * from tblInsa order by name desc; -- 1차 정렬

select * from tblInsa order by jikwi asc, buseo desc; -- 2차 정렬
select * from tblInsa order by jikwi asc, buseo desc, basicpay asc; -- 3차 정렬

-- 정렬 > 우위 비교 > 대상 > 숫자, 문자, 날짜 
select * from tblInsa order by basicpay desc;
select * from tblInsa order by name asc;
select * from tblInsa order by ibsadate desc;


-- select절의 컬럼 인덱스를 사용해서 정렬 가능
-- 첨자가 1부터 시작
select  
    name, buseo, jikwi  --2.
from tblInsa            --1.
order by 2 asc;         --3. 

-- 급여(기본급+상여급)순으로 
select * from tblInsa order by basicpay desc;
select * from tblInsa order by basicpay+sudang desc;

-- 직위순으로 정렬: 부장(4) > 과장(3) > 대리(2) > 사원(1)
select 
    name, jikwi,  case 
                when jikwi = '부장' then 4
                when jikwi = '과장' then 3
                when jikwi = '대리' then 2
                when jikwi = '사원' then 1
            end as jikwiSeq
    from tblInsa 
        order by jikwiSeq desc, name asc;

select 
    name, jikwi
    from tblInsa 
        order by 
            case 
                when jikwi = '부장' then 4
                when jikwi = '과장' then 3
                when jikwi = '대리' then 2
                when jikwi = '사원' then 1
            end
        desc, name asc;


--tblInsa 남자 > 여자 순으로 
select 
    name, ssn, buseo
    from tblInsa
        order by
            case 
                when ssn like('%-1%') then 1
                when ssn like('%-2%') then 2
            end asc, name asc;
