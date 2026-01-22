-- ### 정렬 ###################################


-- 1. employees. 전체 이름(first_name + last_name)이 가장 긴 -> 짧은 사람 순으로 정렬해서 가져오기
--    > 컬럼 리스트 > fullname(first_name + last_name), length(fullname)
select first_name || last_name as fullname, length(FIRST_NAME||LAST_NAME) as "length(fullname)"
from employees
order by length(FIRST_NAME||LAST_NAME) desc;

-- 2. employees. 전체 이름(first_name + last_name)이 가장 긴 사람은 몇글자? 가장 짧은 사람은 몇글자? 평균 몇글자?
--    > 컬럼 리스트 > 숫자 컬럼 3개
select
    max(length(FIRST_NAME||LAST_NAME)) as maxnamelength,
    min(length(FIRST_NAME||LAST_NAME)) as minnamelength,
    round(avg(length(FIRST_NAME||LAST_NAME))) as avgnamelength
from EMPLOYEES;


select * from employees;
-- 3. employees. last_name이 4자인 사람들의 first_name을 가져오기
--    > 컬럼 리스트 > first_name, last_name
--    > 정렬(first_name, 오름차순)
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where length(LAST_NAME) = 4
order by FIRST_NAME asc;

