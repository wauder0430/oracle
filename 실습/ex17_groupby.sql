--ex17_groupby.sql

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
    ORDER BY order_expression [ASC|DESC] -- 레코드 정렬 > 정렬 기준 (컬럼) 
    
    각 절의 순서 **********************************************
    4. SELECT
    1. FROM 
    2. WHERE
    3. GROUP BY
    5. ORDER BY 
    
    group by 절
    - 특정 기준(컬럼값)으로 레코드들을 그룹을 나눈다.
        > 각각의 그룹을 대상으로 집계함수를 실행한다. 
    
*/

--tblInsa. 직위별 평균 급여
select round(avg(basicpay)) from tblInsa where jikwi ='부장';
select round(avg(basicpay)) from tblInsa where jikwi ='과장';
select round(avg(basicpay)) from tblInsa where jikwi ='대리';
select round(avg(basicpay)) from tblInsa where jikwi ='사원';


-- 집계함수 말고도 group by절에 사용한 컬럼 사용 가능
select round(avg(basicpay))
from tblInsa 
group by jikwi;

select jikwi as 직위,round(avg(basicpay)) as "직위별 평균 급여", count(*) as "직위별 인원수", sum(basicpay) as "직위별 총지급액", max(basicpay) as "직위별 최고 급여", min(basicpay) as "직위별 최저 급여"
from tblInsa
group by jikwi
order by decode(jikwi,'부장', 1 , '과장', 2, '대리', 3, '사원', 4);

-- 남자수? 여자수? (최종)
select * from tblComedian;

select count(*) from tblComedian where gender = 'm';
select count(*) from tblComedian where gender = 'f';

select 
    count(case
        when gender = 'm' then 1
    end) as 남자수,
    count(case
        when gender = 'f' then 1
    end) as 여자수
from tblComedian;

select 
    count(decode(gender, 'm', 1)) as 남자수,
    count(decode(gender, 'f', 1)) as 여자수
from tblComedian;

select gender, count(gender)
from tblComedian
group by gender;


select 
    buseo, count(*) as "부서별 인원수"
from tblInsa
group by buseo 
order by "부서별 인원수";



select 
    buseo, 
    count(*)
    -- name -- ORA-00979: GROUP BY 표현식이 아닙니다.
from tblInsa
group by buseo;


-- 1차 그룹 > 2차 그룹 > 3차 그룹
select 
    jikwi, buseo,
    count(*)
from tblInsa
    group by jikwi, buseo 
order by buseo;

-- tblInsa
-- 급여별 그룹
-- 100만원 미만 
select
    (floor(basicpay /1000000) + 1) * 100 || '만원 이하' as money,
    count(*)
from tblInsa
    group by floor(basicpay/1000000);

select 
    case
        when floor((basicpay/1000000)) * 1000000 = 0 then '100만원 미만'
        when floor((basicpay/1000000)) * 1000000 = 1000000 then '100만원대'
        when floor((basicpay/1000000)) * 1000000 = 2000000 then '200만원대'
    end as pay,
    count(*)
from tblInsa
group by floor((basicpay/1000000))
order by pay;

-- tblInsa 남자수? 여자수
select 
    case 
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'
    end as 성별,
    count(*)
from tblInsa
    group by substr(ssn, 8, 1);


-- tblTodo
select 
    case
        when completedate is not null then '한일'
        else '안한일'
    end,
    count(*)
from tblTodo
    group by
        case
            when completedate is not null then '한일'
            else '안한일'
        end;


-- tblInsa. 과장+부장 몇명? 사원+대리 몇명?
select
        case
            when jikwi in('과장', '부장') then 1
            else 2
        end,
        count(*)
from tblInsa
group by 
        case
            when jikwi in('과장', '부장') then 1
            else 2
        end;



