-- ex24_pseudo.sql

/*
    의사 컬럼, Pseudo Column
    - 실제 컬럼은 아닌데 컬럼처럼 행동하는 객체
    
    rownum
    - 행번호
    - 테이블내의 레코드의 행번호를 가져오는 역할
    - 오라클 전용
    
*/

select
    name, buseo,  -- 일반 컬럼(속성) > 레코드에 따라 서로 다른 값을 가진다.(개인 데이터)
    100, -- 상수 > 모든 레코드가 동일한 값을 가진다.
    length(name), -- 가공된 값(컬럼) 
    rownum -- 의사 컬럼
from tblInsa;

select name, buseo, rownum from tblInsa where rownum = 1;
select name, buseo, rownum from tblInsa where rownum <= 5;
select name, buseo, rownum from tblInsa where rownum = 5;
select name, buseo, rownum from tblInsa where rownum >= 5 and rownum <= 10;

-- *** 1. where절에 의해서 결과셋에 변화가 발생할 때마다 rownum이 다시 계산된다.
-- *** 2. rownum이 언제 만들어지느냐? from절을 실행할 때!!!

-- 서브쿼리 + rownum
-- 급여를 가장 많이 받는 5명을 가져오시오
select name, basicpay, rownum   -- 2. 가져오기
from tblInsa;                   -- 1. 현재 테이블 상태 + 행번호 할당

select name, basicpay, rownum   -- 2. 가져오기
from tblInsa                    -- 1. 현재 테이블 상태 + 행번호 할당
order by basicpay desc;         -- 3. 


select name, basicpay, rownum from tblInsa order by basicpay desc;

-- 1. 원하는 정렬을 한다.
-- 2. 1을 인라인뷰(서브쿼리)로 사용해서 메인 쿼리를 작성한다.
-- 3. 메인 쿼리의 rownum을 사용한다.

select name, basicpay, rownum from (select name, basicpay from tblinsa order by basicpay desc) where rownum <= 5;

select name, basicpay, rnum from (select name, basicpay, rownum as rnum from (select name, basicpay from tblinsa order by basicpay desc)) where rnum = 5;
select name, basicpay, rnum from (select name, basicpay, rownum as rnum from (select name, basicpay from tblinsa order by basicpay desc)) where rnum >= 5 and rnum <= 10;


-- 페이징 + 수당 정렬 > 10명씩
-- *는 혼자만 와야함
select i.*, rownum from tblInsa i order by sudang desc;

select a.*, rownum from (select * from tblInsa order by sudang desc) a;

select * from (select a.*, rownum as rnum from (select * from tblInsa order by sudang desc) a) where rnum between 11 and 20;

-- view로 만들기
create or replace view vwSudang
as 
select a.*, rownum as rnum from (select * from tblInsa order by sudang desc) a;

select * from vwSudang;

/*
    순서(순위)와 관련한 작업
    - 오라클 전용
    1. rownum
    2. 순위 함수 > rownum 편하게 + 추가 기능
    3. offset fetch > 12c 버전 이후 도입
*/
