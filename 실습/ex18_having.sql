--ex18_having.sql

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
    GROUP BY group_by_expression -- 그룹을 나눈다.
    HAVING serach_condition -- 그룹 조건 지정 > 원하는 그룹만 가져와라
    ORDER BY order_expression [ASC|DESC] -- 레코드 정렬 > 정렬 기준 (컬럼) 
    
    각 절의 순서 **********************************************
    5. SELECT
    1. FROM 
    2. WHERE
    3. GROUP BY
    4. HAVING
    6. ORDER BY 
    
    having 절
    - 그룹에 대한 조건
    
*/

select                          -- 3. 그룹별 통계값을 구한다. 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa                    -- 1. 60명의 데이터를 가져온다.
group by buseo;                 -- 2. 60명을 대상으로 부서별 그룹을 나눈다.


select                          -- 4. 그룹별 통계값을 구한다. 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa                    -- 1. 60명의 데이터를 가져온다.
where basicpay >= 1500000       -- 2. 60명 중 급여가 150만원 이상인 사람만 가져오기
group by buseo;                 -- 3. 3X명을 대상으로 부서별 그룹을 나눈다.


select                          -- 4. 그룹별 통계값을 구한다. 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa                    -- 1. 60명의 데이터를 가져온다.
group by buseo                  -- 2. 60명을 대상으로 부서별 그룹을 나눈다.
having avg(basicpay) >= 1500000; -- 3. 각 그룹별 평균급여가 150만원 이상인 그룹만 통과



-- 각 부서별 과장+부장 인원수가 3명 이상인 부서들?
select 
    buseo,
    count(*)
from tblInsa
where jikwi in ('과장', '부장')
group by buseo
having count(*) >= 3;


