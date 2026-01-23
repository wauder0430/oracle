-- ex03_operator.sql

/*
    연산자, Operator
    
    1. 산술 연산자
    - +, -, *, /
    - %(없음) > 함수로 제공(mod())
    
    2. 문자열 연산자(concat)
    - ||
    
    3. 비교 연산자
    - >, >=, <, <=
    - =, <>
    - 논리값 반환 > boolean 없음 > 표현 불가능
    - 컬럼리스트에서 사용 불가
    - 조건절에서 사용
    
    4. 비교연산자
    - and, or, not
    - 조건절에서 사용
    
    5. 대입 연산자
    - = 
    - 컬럼 = 값 
    - update문 
    - 복합대입연산자 없음
    
    6. 3항 연산자
    - 없음
    
    7. 증감 연산자
    - 없음 
    
    8. SQL연산자
    - 자바 > instanceof
    - SQL > in, between, like, is 등 ..
    
    
    *** 모든 연산자는 피연산자로 null을 가질 수 없다. 
    10 + 0 = 10
    10 + null = 연산 불가능
    
    
*/

select * from tblCountry;

select 
    name, 
    capital,
    name || ' ' || capital
from tblCountry;

select 
    population,
    area,
    population + 10,
    population - 10,
    population * 10,
    population / 10,
    population + area
from tblCountry;

select *     
from tblCountry
where area > 100;

select *     
from tblCountry
where name = '대한민국';

select *     
from tblCountry
where name <> '대한민국';

select *     
from tblCountry
where continent = 'AS' and not area>100; 

----------------------------------


/*
    테이블/컬럼 > 별칭(Alias)
    
    컬럼 별칭 
    - 결과셋의 컬럼명을 바꾼다
    - 결과셋의 컬럼명들을 올바르게 유지하고 싶을 때 .. 
    ex) name as 이름
    1. 컬럼명이 중복될 때
    2. 컬럼이 가공했을 때
    
    테이블 별칭
    - 결과셋과는 무관
    - SQL 작성 시 편리함을 제공
    
*/


select 
    name, 
    capital 
from tblCountry;

-- 1.
select tblMen.name as 남자이름, tblWomen.name as 여자이름  from tblMen inner join tblWomen on tblMen.name = tblWomen.couple;
                                                                                                                                                                                   
-- 2.
select 
    name,
    length(name) as 국가명글자수,
    area * 2 + 10 as 면적연산결과
from tblCountry;



select name, capital from tblCountry;

select hr.tblCountry.name, hr.tblCountry.capital from hr.tblCountry;

-- 오라클은 table 별명에 as를 붙이지 않는다.
select c.name, c.capital    --2.
from hr.tblCountry c;       --1.

