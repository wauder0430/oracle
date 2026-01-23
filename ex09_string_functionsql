--ex09_string_function.sql

/*
    문자열 함수
    
    대소문자 변환
    - upper(), lower(), initcap()
    - varchar2 upper(컬럼명)
    - varchar2 lower(컬럼명)
    - varchar2 initcap(컬럼명)
    
*/

select 
    'aBcDeF',
    upper('aBcDeF'),
    lower('aBcDeF'),
    initcap('aBcDeF')   --첫글자 대문자 나머지 소문자
from dual;

--이름(first_name)에 'an' 포함된 직원? (대소문자 구분없이)
select 
    first_name
from employees
where lower(first_name) like '%an%';


/*
    문자열 추출함수
    - substr()
    - varchar2 substr(컬럼명, 시작위치, 가져올 문자 개수)
    - varchar2 substr(컬럼명, 시작위치) 끝까지 가져오기   // 가변 파라메타
*/

select 
    name,
    substr(name, 1, 3),
    substr(name, 2),
    substr(name, -1)
from tblCountry;

select 
    name, ssn,
    substr(ssn, 1, 2) as 생년,
    substr(ssn, 3, 2) as 생월,
    substr(ssn, 5, 2) as 생일,
    case
        when substr(ssn, 8, 1) in(1,3,5,7,9) then '남자'
        when substr(ssn, 8, 1) in(2,4,6,8,0) then '여자'
    end as 성별
from tblInsa;

-- tblInsa > 60명 > 김, 이, 박, 최, 정 > 각각 몇명?
select * from tblInsa where substr(name, 1, 1) = '김';
select * from tblInsa where substr(name, 1, 1) = '이';
select * from tblInsa where substr(name, 1, 1) = '박';
select * from tblInsa where substr(name, 1, 1) = '최';
select * from tblInsa where substr(name, 1, 1) = '정';

select 
    
    count(case when substr(name, 1, 1) ='김' then 1 end) as 김,
    count(case when substr(name, 1, 1) ='김' then 1 end) as 이,
    count(case when substr(name, 1, 1) ='김' then 1 end) as 박,
    count(case when substr(name, 1, 1) ='김' then 1 end) as 최,
    count(case when substr(name, 1, 1) ='김' then 1 end) as 정,
    count(
        case
            when substr(name, 1, 1) not in('김', '이','박', '최', '정') then 1
        end
    ) as 나머지
from tblInsa;

/*
    문자열 길이
    -number length(컬럼명)
    
*/

-- 함수들이 여러 절에서 사용되는 모습
-- 1. 컬럼 리스트
select name, length(name) from tblCountry;

-- 2. 조건절에서 사용
select name, length(name) from tblCountry where length(name) = 2;

-- 3. 정렬에서 사용
select name, length(name) from tblCountry
    order by length(name) asc, name asc;
    
/*
    문자열 검색
    - instr()
    - 검색어의 위치를 반환
    - number instr(컬럼명, 검색어)
    - number instr(컬럼명, 검색어, 시작위치)
    - number instr(컬럼명, 검색어, 시작위치, -1) //lastIndexOf()
    - 못찾으면 0 반환
*/

select 
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님', '홍길동') as r1,
    instr('안녕하세요. 홍길동님', '아무개') as r2,
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동') as r3,
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동', 11) as r4,
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동', instr('안녕하세요. 홍길동님 홍길동님', '홍길동')+3) as r5,
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동', -1) as r6
from dual;


/*
    패딩
    - lpad(), rpad()
    - left padding, right padding
    - varchar2 lpad(컬럼명, 개수, 문자)
    - varchar2 rpad(컬럼명, 개수, 문자)
    
*/

select 
    'a',
    lpad('a', 5), -- "    a" > %5s
    rpad('a', 5), -- "a    " > %-5s
    lpad('a', 5, 'b'),
    rpad('a', 5, 'b'),
    lpad('1', 5, '0')
from dual;

/*
    공백 제거
    - trim(), ltrim(), rtrim()
    - varchar2 trim(컬럼명)
    - varchar2 ltrim(컬럼명)
    - varchar2 rtrim(컬럼명)
*/

select 
    trim ('          하나   둘      셋      '),
    ltrim ('          하나   둘      셋      '),
    rtrim ('          하나   둘      셋      ')
from dual;


/*
    문자열 치환
    - replace()
    - varchar2 replace(컬러명, 찾을 문자열, 바꿀 문자열)
    
    - regexp_replace(컬러명, 정규표현식, 바꿀 문자열)
*/

select 
    replace('홍길동', '홍', '김'),
    replace('홍길동', '최', '김'),
    replace('홍길동홍', '홍', '김')
from dual;

select
    name, 
    regexp_replace(name, '김[가-힣]{2}', '김OO'),
    regexp_replace(name, '([가-힣])[가-힣]{2}', '\1OO'),
    regexp_replace(tel, '(\d{3})-(\d{4})-(\d{4})', '\1-xxxx-\3')
from tblInsa;


-- String[] split() > 없음

/*
    문자열 치환 
    - decode()
    - replace() 유사
    - varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열)
    - varchar2 decode(컬럼명, 찾을 문자열[, 바꿀 문자열, 찾을 문자열] X N)
    
*/

select 
    gender,
    case
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1,
    replace(replace(gender, 'm', '남자'), 'f', '여자') as g2,
    decode(gender, 'm', '남자', 'f', '여자') as g3
from tblComedian;


select 
    decode(continent, 'AS', '아시아', 'EU', '유럽', 'AF', '아프리카', 'SA', '남아메리카', 'AU', '오스트레일리아')
from tblCountry;


-- tblComedian. 남자수? 여자수?
select 
    count(case
        when gender = 'm' then 1
    end) as m1,
    count(case
     when gender = 'f' then 2
    end) as f1,
    count(decode(gender, 'm', 1)) as m2,
    count(decode(gender, 'f', 2)) as f2
from tblComedian;

-- 100만 이하 몇명? 100~200만 몇명? 200만 이상 몇명?
select
    count(case 
        when basicpay between 0 and 1000000 then 1
    end),
    count(case
        when basicpay between 1000001 and 2000000 then 1
    end),
    count(case 
        when basicpay > 2000000 then 1
    end)
from tblInsa;