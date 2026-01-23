--ex05_column.sql

-- 컬럼 리스트에서 할 수 있는 행동들
-- SELECT 컬럼리스트

-- 컬럼명
select name, jikwi, buseo from tblInsa;

-- 연산
select name || '님' as name, sudang * 2 as bonus from tblInsa;

-- 상수
select 
    name, 100
from tblInsa;

select 
    100
from tblInsa;

-- 함수
select name, length(name) from tblCountry;


/*
    distinct
    - 컬럼 리스트에서 사용
    - 레코드의 중복값 제거
    - distinct 컬럼명 > (X)
    - distinct 컬럼리스트 > (O)
    
*/

-- tblCountry 어떤 대륙들이 있어요? > 개인? vs 그룹? 
select distinct continent from tblCountry;

-- tblInsa 어떤 부서가 있어요?
select distinct buseo from tblInsa;
select distinct jikwi from tblInsa;
select distinct city from tblInsa;
select distinct name from tblInsa;

select distinct buseo, name from tblInsa;
select distinct buseo, jikwi from tblInsa;



/*
    SQL > 제어문 없음
    
    case문 
    - 대부분 절에서 사용 
    - 조건문 역할 > 컬럼값 조작 
    - 자바: 다중 if문 or switch case문
    - 조건 만족: then 값 반환
    - 조건 불만족: null 반환 (***)
    
    언어
    1. C 계열 > 컴파일 언어
    2. Basic 계열 > 인터프리터 > 스크립트
    
*/

select
    last||first as name,
    gender,
    case 
        --when 조건 then 값
        when gender='m' then '남자'
        when gender='f' then '여자'
    end as genderName,
    case gender
        when 'm' then '남자'
        when 'f' then '여자'
    end as genderName2
from tblComedian;


select 
    name, continent,
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        else continent
    end as continetName
from tblCountry;

select 
    last||first as name, weight,
    case
        when weight > 90 then '과체중'
        when weight > 50 then '정상체중'
        else '저체중'
    end state,
    case 
        when weight >=50 and weight <=90 then '정상체중'
        else '주의체중'
    end state2,
    case 
        when weight between 50 and 90 then '정상체중'
        else '주의체중'
    end state3
from tblComedian;

-- 사원, 대리 > 현장직
-- 과장, 부장 > 관리직
select 
    name, jikwi,
    case 
        when jikwi = '사원' or jikwi = '대리' then '현장직'
        when jikwi = '과장' or jikwi = '부장' then '관리직'
    end,
    case 
        when jikwi in ('사원', '대리') then '현장직'
        when jikwi in ('과장', '부장') then '관리직'
    end 
from tblInsa;


select 
    name, ssn,
    case
        when ssn like '%-1%' then '남자직원'
        when ssn like '%-2%' then '여자직원'
    end as gender
from tblinsa;

select 
    title, 
    case
        when completedate is null then '미완료'
        when completedate is not null then '완료'
    end
from tblTodo;