-- ex11_datetime_function.sql

/*
    날짜시간 함수
    
    sysdate
    - 시스템의 시각을 반환
    - date sysdate
    
*/
select sysdate from dual;

/*
    날짜 연산 
    1. 시각 - 시각 = 시간(일)
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각
    
*/

-- 1. 시각 - 시각 = 시간(일,시,분,초)
-- 현재 - 입사일 = 근무시간
select 
    name, to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    round(sysdate - ibsadate) as 근무일수,
    round((sysdate - ibsadate) * 24) as 근무시수,
    round((sysdate - ibsadate) * 24 * 60) as 근무분수,
    round((sysdate - ibsadate) * 24 * 60 * 60) as 근무초수
from tblInsa;
-- 홍길동	2008-10-11	6313.652349537037037037037037037037037037

select 
    title, adddate, completedate,
    round((completedate - adddate) * 24) as "실행하기 까지 걸린 시간"
from tblTodo
--order by 4;
--order by "실행하기 까지 걸린 시간";
order by round((completedate - adddate) * 24);

-- 2. 시각 + 시간(일) = 시각
-- 3. 시각 - 시간(일) = 시각
select
    sysdate,
    sysdate + 100 as "100일 후",
    sysdate - 100 as "100일 전",
    to_char(sysdate + (3 / 24), 'hh24:mi:ss') as "3시간 뒤", --26/01/23
    to_char(sysdate - (30 / 60 /24), 'hh24:mi:ss') as "30분 전" --26/01/23
from dual;

/*
    날짜 연산(월, 년)
    - 시각 - 시각 = 시간(월)
    - number months_between(date, date)
    
*/
select 
    name,
    (sysdate - ibsadate) as 근무일수,
    round(months_between(sysdate, ibsadate)) as 근무개월수,
    round(months_between(sysdate, ibsadate)/12) as 근무년수
from tblInsa;

/*
    add_months()
    - 시각 + 시각(월) = 시각
    - 시각 - 시각(월) = 시각
*/
select
    sysdate, 
    sysdate + 3,
    add_months(sysdate, -2),
    add_months(sysdate, 3),
    add_months(sysdate, 3*12)
from dual;

/*
    시각 - 시각 = 시간
    1. 일, 시, 분, 초 > 연산자(-)
    2. 월, 년 > months_between()
    
    시각 + 시간, 시각 - 시간 = 시각
    1. 일, 시, 분, 초 > 연산자(+, -)
    2. 월, 년 > add_months()
*/


-- null 함수 > null value
-- 1. nvl( , )   > 값이 있으면 그 값을 사용하고, 없으면 대체값을 사용한다.
-- 2. nvl2( , , )  > 값이 있으면 앞에값을, 없으면 뒤에값을 사용한다.

select 
    name, population,
    case 
        when population is not null then population
        when population is null then 0
    end,
    nvl(population, 0),
    nvl2(population, '인구 기재됨', '인구 기재안됨')
from tblCountry;
