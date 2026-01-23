--ex10_casting_function.sql

/*

    자바
    - 엄격한 문법을 준수하는 언어
    
    sql
    - 유연한 문법을 제공하는 언어
    - 자료형 판정에 대해 유연함 > 형변환이 자동으로 많이 발생
    
    형변환 함수
    1. varchar2 to_char(숫자형): 숫자 > 문자 *
    2. varchar2 to_char(날짜형): 날짜 > 문자 *****
    3. number to_number(문자형): 문자 > 숫자 *
    4. date to_date(문자형):     문자 > 날짜 *****
    
    1. varchar2 to_char(숫자형 [,형식 문자열])
    
    형식 문자열 구성 요소
    a. 9: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 공백으로 채운다. > %5d
    b. 0: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 0으로 채운다. > %05d
    c. $: 달러 기호
    d. L: 통화 기호(지역 설정)
    e. .: 소수점
    f. ,: 자리수 표현
    
*/

select 
    length(basicpay),
    to_char(basicpay)
from tblInsa;

select 
    weight, --64
    to_char(weight), --64
    '@' ||to_char(weight, '99999') || '@', --64 > '   64'
    '@' ||to_char(weight, '00000') || '@',  --64 > '00064'
    '@' ||to_char(-weight, '99999') || '@', --64 > '   64'
    '@' ||to_char(-weight, '00000') || '@',  --64 > '00064'
    '@' ||to_char(123456789, '00000') || '@'  --64 > '00064' --error ######
from tblComedian;

select
    100,
    to_char(100, '$999'), --$100
    to_char(100, 'L999')  --￦100
    --to_char(100, '999달러')-- 불가능
from dual;

select
    3.14,
    to_char(3.14, '9.99'),--3.14
    to_char(3.14, '99.9'), --3.1
    to_char(3.15, '99.9'), --3.2
    trim(to_char(1234567, '9,999,999'))
from dual;

/*
    2. varchar2 to_char(날짜형 [,형식 문자열]): 날짜 > 문자 *****
    
    형식 문자열 구성 요소
    a. yyyy
    b. yy 
    c. month
    d. mon
    e. mm
    f. day
    g. dy
    h. ddd
    i. dd
    j. d
    k. hh
    l. hh24
    m. mi
    n. ss
    o. am(pm)
    
*/

-- sysdate: 함수 > 현재 date를 반환 > LocalDate.now()
select sysdate from dual;   --'26/01/23'
select to_char(sysdate, 'yyyy') from dual; -- 2026 > 년(네자리)
select to_char(sysdate, 'yy') from dual; -- 26 > 년(두자리)
select to_char(sysdate, 'month') from dual; -- 1월 > 월 (풀네임)
select to_char(sysdate, 'mon') from dual; -- 1월 > 월 (약어)
select to_char(sysdate, 'mm') from dual; -- 01 > 월
select to_char(sysdate, 'day') from dual; -- 금요일 > 요일(풀네임)
select to_char(sysdate, 'dy') from dual; --  금 > 요일(약어)
select to_char(sysdate, 'd') from dual; -- 6 > 요일(이번주 며칠)
select to_char(sysdate, 'ddd') from dual; -- 023 > 일(올해 며칠)
select to_char(sysdate, 'dd') from dual; -- 23 > 일(이번달 며칠)
select to_char(sysdate, 'hh') from dual; -- 02 > 시(12H)
select to_char(sysdate, 'hh24') from dual; -- 14 > 시(24H)
select to_char(sysdate, 'mi') from dual; -- 46 > 분
select to_char(sysdate, 'ss') from dual; -- 24 > 초
select to_char(sysdate, 'am') from dual; -- 오후
select to_char(sysdate, 'pm') from dual; -- 오후 


select sysdate,
    to_char(sysdate, 'yyyy-mm-dd'),-- 2026-01-23
    to_char(sysdate, 'hh24:mi:ss'),-- 14:49:43
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), -- 2026-01-23 14:49:43
    to_char(sysdate, 'day am hh:mi:ss') -- 금요일 오후 02:49:43
from dual;

--평일 입사 vs 휴일
select 
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    to_char(ibsadate, 'day') as 요일,
    case 
        when to_char(ibsadate, 'd') in ('7', '1') then '휴일입사'
        else '평일입사'
    end
from tblInsa;

--요일별 입사 인원수? 1개의 테이블
select 
    count(decode(to_char(ibsadate, 'd'), '1', 1)) as 일,
    count(decode(to_char(ibsadate, 'd'), '2', 1)) as 월,
    count(decode(to_char(ibsadate, 'd'), '3', 1)) as 화,
    count(decode(to_char(ibsadate, 'd'), '4', 1)) as 수,
    count(decode(to_char(ibsadate, 'd'), '5', 1)) as 목,
    count(decode(to_char(ibsadate, 'd'), '6', 1)) as 금,
    count(decode(to_char(ibsadate, 'd'), '7', 1)) as 토
from tblInsa;

-- 3.number to_number(문자형)
select
    '123' *2,
    to_number('123') * 2
from dual;


-- 4. date to_date(문자형)
select 
    *
from tblInsa
where ibsadate < '2010-01-01'; -- 날짜 리터럴(X)

select 
    *
from tblInsa
    where ibsadate >= to_date('2010-01-01'); -- 시분초 > 자정 > 00:00:00

select name, to_char(ibsadate, 'yyyy-mm-dd hh24:mi:ss') from tblInsa;

select 
    '2026-01-23', --2026-01-23
    to_date('2026-01-23'), --26/01/23
    to_date('2026-01-23 12:30:40', 'yyyy-mm-dd hh24:mi:ss'), -- 26/01/23 시분초가 들어가면 표기해야함
    to_date('2026.01.23'),
    to_date('20260123')
from dual;

--tblInsa. 2010-01-01 ~ 2010-12-31 사이에 입사한 직원
select * from tblInsa
    where ibsadate >= '2010-01-01' 
        and ibsadate <= to_date('2010-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss');

select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2010';