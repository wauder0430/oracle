--ex07_aggregation_function.sql

/*
    클래스내에 선언된 함수를 메서드라고 한다.
    
    자바(객체 지향)의 메서드
    - 모든 기능이 객체안에 구현 > 데이터(변수), 행동(메서드)
    - s1.getTotal()     //개인 행동
    - Student.getXXX()  //단체 행동
    
    SQL의 메서드(X) > 함수(O)
    - 주체가 없다.
    - 함수 자체로 존재한다.
    
    함수, Function
    1. 내장 함수, Built-in Fucntion
    2. 사용자 정의 함수, User Function > ANSI-SQL(X), PL/SQL(O)
    
    집계 함수, Aggregation Function
    - Java Stream > count(), sum(), average(), max(), min()
    
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    1. count()
    - 결과 테이블의 레코드 수를 반환
    - number count(*) // 특정 컬럼에 null 유무와 상관없이 모든 레코드 수
    - number count(특정 컬럼명) // null을 예상하고 레코드 수 
    - null 값은 제외한다.(*****)
    
*/
select * from tblCountry;
select count(*) from tblCountry;    --14
select count(name) from tblCountry; --14
select count(capital) from tblCountry;  --14
select count(population) from tblCountry; --13

-- 연락처가 있는 직원수?
select count(tel) from tblInsa; --57
select count(*) from tblInsa where tel is not null; --57
-- 연락처가 없는 직원수?
select count(*) from tblInsa where tel is null; --3
select count(*) - count(tel) from tblInsa; --3

-- 어떤 부서들이 있나요? > 부서가 몇개?
select distinct buseo from tblInsa;
select count (distinct buseo) from tblInsa;

--tblComdian 남자수? 여자수?
select * from tblComedian;
select count(*) from tblComedian where gender ='m';
select count(*) from tblComedian where gender ='f';

-- *** 자주 쓰는 패턴
-- 남자수와 여자수를 1개의 테이블로 가져오시오.
select 
    count(case
        when gender = 'm' then 1
    end) as 남자수,
    count(case
        when gender = 'f' then 1
    end) as 여자수
from tblComedian;

-- tblInsa 기획부 몇명? 총무부 몇명? 개발부 몇명?
select 
    count(case 
        when buseo = '기획부' then 1
    end) as 기획부인원,
    count(case 
        when buseo = '총무부' then 1
    end) as 총무부인원,
    count(case 
        when buseo = '개발부' then 1
    end) as 개발부인원,
    count(case
        when buseo not in('기획부', '총무부', '개발부') then 1
    end) as 나머지
from tblInsa;

/*
    2. sum()
    - 해당 컬럼의 합을 구한다.
    - number sum(특정 컬럼명)
    - 숫자형 컬럼에만 적용
    
*/
select sum(population), sum(area) from tblCountry;
select sum(name) from tblCountry; --ORA-01722: 수치가 부적합합니다
select sum(ibsadate) from tblCountry; --ORA-00904: "IBSADATE": 부적합한 식별자
select sum(*) from tblCountry; --ORA-00936: 누락된 표현식

select 
    sum(basicpay) as 지출급여합,
    sum(sudang) as 지출수당합,
    sum(basicpay) + sum(sudang) as 총지출,
    sum(basicpay + sudang) as 총지출
from tblInsa;

/*
    3. avg()
    - 해당 컬럼의 평균값
    - number avg(특정 컬럼명)
    - 숫자형 컬럼에만 적용
    
*/
--tblInsa, 평균 급여?
select sum(basicpay) / 60 from tblInsa; -- 1556526
select sum(basicpay) / count(*) from tblInsa; -- 1556526
select avg(basicpay) from tblInsa; -- 1556526

--tblCountry 평균 인구수?
select sum(population) / 14 from tblcountry; --14475
select sum(population) / count(*) from tblcountry; --14475
select avg(population) from tblCountry; --15588
select sum(population) / count(population) from tblCountry; --15588

-- 회사 > 성과급 지급 > 출처 > 1팀 공로~
-- 1. 균등 지급 > 총지급액 / 모든직원수 = sum() / count(*)
-- 2. 차등 지급 > 총지급액 / 1팀직원수  = sum() / count(1팀) = avg()

/*
    4. max()
        - 최댓값 반환
        - object max(특정 컬럼명)
        
    5. min()
        - 최솟값 반환
        - object min(특정 컬럼명)
        
    - 숫자형, 문자형, 날짜형 모두 적용가능
*/

select max(basicpay) from tblInsa;
select max(name), min(name) from tblInsa;
select min(ibsadate), min(ibsadate) from tblInsa;

select 
    count(*) as 직원수,
    sum(basicpay) as 총급여합,
    round(avg(basicpay)) as 평균급여,
    max(basicpay) as 최고급여,
    min(basicpay) as 최저급여
from tblInsa;


-- 집계 함수 사용 시 주의점!

-- 1. ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--              not a single-group group function
-- 컬럼 리스트(select절)에서는 집계함수와 일반컬럼을 동시에 사용할 수 없다.
-- 요구사항] 직원들의 이름과 전체 직원수를 가져오시오.
select name, count(*) from tblInsa; 
select name from tblInsa;
select count(*) from tblInsa;

-- 2. ORA-00934: 그룹 함수는 허가되지 않습니다
--              group function is not allowed here
-- where절에서 집계 함수를 사용할 수 없다.
-- where절 == 개인에 대한 질문
-- 요구사항] 평균 급여보다 더 많이 받는 직원들?
select avg(basicpay) from tblInsa; --1556526
select * from tblInsa where basicpay >= 1556526;
select * from tblInsa where basicpay >= avg(basicpay);

select * from tblInsa group by basicpay having;
