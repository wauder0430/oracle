-- ex26_with.sql

/*
    [WITH <Sub Query>] 
    SELECT column_list
    FROM table_name
    -- [JOIN | UNION]
    [WHERE search_condition]  
    [GROUP BY group_by_expression]
    [HAVING serach_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    WITH <Sub Query> -- 인라인뷰에 잠시 이름을 붙인다. (가독성)
    SELECT column_list  -- 원하는 컬럼을 지정 > 해당 컬럼만 가져와라 
    FROM table_name     -- 데이터 소스, 어떤 테이블로부터 데이터를 가져와라
    WHERE search_condition -- 행 조건 지정 > 원하는 행만 가져와라 
    GROUP BY group_by_expression -- 그룹을 나눈다.
    HAVING serach_condition -- 그룹 조건 지정 > 원하는 그룹만 가져와라
    ORDER BY order_expression [ASC|DESC] -- 레코드 정렬 > 정렬 기준 (컬럼) 
    
    각 절의 순서 **********************************************
    1. WITH <Sub Query>
    6. SELECT
    2. FROM 
    3. WHERE
    4. GROUP BY
    5. HAVING
    7. ORDER BY 
    
*/

select * from
    (select name, buseo, jikwi from tblInsa where city = '서울') seoul;
-- =
with seoul as (select name, buseo, jikwi from tblInsa where city = '서울')
select * from seoul;

-- tblMen. 몸무게(90이하) + tblWomen.몸무게(60초과) > join
-- tblMen inner join tblWomen

select name, age, couple from tblMen where weight <= 90;
select name, age, couple from tblWomen where weight > 60;

select * from (select name, age, couple from tblMen where weight <= 90) a 
        inner join (select name, age, couple from tblWomen where weight > 60) b
            on a.couple = b.name;

with a as (select name, age, couple from tblMen where weight <= 90),
    b as (select name, age, couple from tblWomen where weight > 60)
select * from a inner join b on a.couple = b.name;

