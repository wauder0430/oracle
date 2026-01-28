-- ex25_rank_function.sql

/*
    순위 함수
    - rownum을 기반으로 만들어진 함수
    
    1. rank() over(oder by 컬럼명 [asc|desc])
        - 동일값 = 동일순위
        - 누적O
    2. dense_rank() over(oder by 컬럼명 [asc|desc])
        - 동일값 = 동일순위
        - 누적X
    3. row_number() over(oder by 컬럼명 [asc|desc])
        - 무조건 다른 순위
        - rownum을 직접 사용했을 때와 동일
*/

-- tblInsa. 급여순으로 가져오시오. + 순위 표시
select name, buseo, basicpay from tblInsa order by basicpay desc;

select
    a.*, rownum 
from (select name, buseo, basicpay from tblInsa order by basicpay desc) a;

-- 1. 
select 
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

-- 2.
select 
    name, buseo, basicpay,
    dense_rank() over(order by basicpay desc) as rnum
from tblInsa;

-- 3.
select 
    name, buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;


-- 1위
-- ORA-30483: 윈도우 함수를 여기에 사용할 수 없습니다
select 
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa
    where rank() over(order by basicpay desc) = 1;
    
    
select * from
    (select 
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa) where rnum = 8;
    
    
--순위함수 + partition by == group by 역할
select 
    name, buseo, jikwi, basicpay,
    rank() over(partition by buseo, jikwi order by basicpay desc) as rnum
from tblInsa;