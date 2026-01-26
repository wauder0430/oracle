--ex19_subquery.sql

/*
    SQL
    1. Main Query, 쿼리
        - 하나의 문장안에 하나의 select(insert, update, delete)문으로 되어 있는 쿼리
        
    2. Sub Query, 서브 쿼리
        - 하나의 문장안에 또 다른 문장이 들어있는 쿼리
        - 메인 쿼리     <- 서브 쿼리
        - select        <- select
        - insert        <- select
        - update        <- select
        - delete        <- select 
    
*/

-- tblCountry. 인구수가 가장 많은 나라의 이름? 중국
select max(population) from tblCountry;
select name from tblCountry where population =  120660;

select
    name
from tblCountry 
where population = (select max(population) from tblCountry);

-- tblComedian 몸무게가 가장 많이 나가는 사람의 정보
select *
from tblComedian
where weight = (select max(weight) from tblComedian);

-- tblInsa 평균 급여보다 더 많이 받는 직원들?
select * from tblInsa
where basicpay >= (select avg(basicpay) from tblInsa);

/*
    서브 쿼리 삽입 위치
    1. 조건절 > 비교값으로 사용
        a. 반환값이 1행 1열 > 단일값 반환 > 상수 취급 == 값 1개
        b. 반환값이 N행 1열 > 다중값 반환 > 열거형 비교 > in 연산자
        c. 반환값이 1행 N열 > 다중값 반환 > 그룹 비교 > N:N 비교 ( , ) = (서브 쿼리)
        d. 반환값이 N행 N열 > 다중값 반환 > b + c > in 연산자 + N:N 비교
        
        
*/
select * from tblWomen
where couple = (select name from tblMen where age = 31 and height = 183);

-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
select * from tblWomen
where couple = (select name from tblMen where age = 22);
-- > 
select * from tblWomen
where couple in (select name from tblMen where age = 22);


-- tblInsa. '홍길동'과 같은 지역
select * from tblInsa where city = (select city from tblInsa where name ='홍길동');

-- tblInsa. '홍길동'과 같은 지역 + 같은 부서
select * from tblInsa where city = (select city from tblInsa where name = '홍길동')
    and buseo = (select buseo from tblInsa where name = '홍길동');

select * from tblInsa 
    where (city,buseo) = (select city, buseo from tblInsa where name = '홍길동');

-- 급여가 260만원 이상 받는 직원과 같은 부서 + 같은 지역 > 직원?
select * from tblInsa
    where (city, buseo) in (select city, buseo from tblInsa where basicpay >= 2600000);


/*
    서브 쿼리 삽입 위치
    1. 조건절 > 비교값으로 사용
    2. 컬럼 리스트 > 컬럼값으로 사용
        - 반드시 결과값이 1행 1열이어야 한다. > 스칼라 쿼리(원자값 반환) 
        a. 정적 서브 쿼리 > 모든 행에 동일한 값을 반환
        b. 상관 서브 쿼리 > 메인 쿼리의 일부 값을 활용해 서브쿼리에 사용 
                          > 메인 쿼리와 연관된 값을 반환 
    
*/
select 
    name, buseo, basicpay,
    --전체 평균 급여
    (select round(avg(basicpay)) from tblInsa)
from tblInsa;


-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
select 
    name, buseo, basicpay,
    --전체 평균 급여
    (select jikwi from tblInsa)
from tblInsa;

-- ORA-00913: 값의 수가 너무 많습니다
select 
    name, buseo, basicpay,
    (select jikwi, city from tblInsa where num = 1001)
from tblInsa;


-- 상관 서브 쿼리 
select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa where buseo = a.buseo)
from tblInsa a;


/*
    서브 쿼리 삽입 위치
    1. 조건절 > 비교값으로 사용
    2. 컬럼 리스트 > 컬럼값으로 사용
        - 반드시 결과값이 1행 1열이어야 한다. > 스칼라 쿼리(원자값 반환) 
        a. 정적 서브 쿼리 > 모든 행에 동일한 값을 반환
        b. 상관 서브 쿼리 > 메인 쿼리의 일부 값을 활용해 서브쿼리에 사용 
                          > 메인 쿼리와 연관된 값을 반환
    3. FROM절
        - 서브 쿼리의 결과셋을 또 하나의 테이블이라고 생각하고 메인 쿼리가 실행 
        - 익명 테이블 역할 or 임시 테이블 역할 
        - 인라인 뷰(Inline View)
*/
select num, name, jikwi from tblInsa where buseo = '기획부';

select * from (select num, name, jikwi from tblInsa where buseo = '기획부');