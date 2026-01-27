-- ex21_view.sql 

/*
    View, 뷰
    - DB Object > 객체 > 오라클에 저장
    - create/drop > DDL
    - 가상 테이블, 뷰 테이블 등.. 
    - 테이블과 유사한 행동을 한다.
    - select의 결과를 복사한 테이블(X)
    - SQL(select문)을 저장한 객체(O)
    
    create [or replace] view 뷰이름
    as  -- 연결부(as, is)
    select 문;
    
    뷰 사용 목적
    1. 자주 쓰는 쿼리를 저장
    2. 복잡하고 긴 쿼리를 저장
    3. 저장 객체 > 같은 데이터베이스 사용자끼리 뷰 공유 가능 > 재사용 or 협업
    4. 권한 통제 > 보안 
        - 신입 사원 > 직원들 연락처 > 문자 메시지 발송
            - tblInsa
            - vwInsa
*/

create or replace view vwInsa -- or replace때문에 덮어쓰기도 가능
as
select num, name, jikwi from tblInsa where buseo = '기획부';

select * from vwInsa;
select * from tblInsa; -- 계정에 따른 테이블 접근 권한 유/무

create table tblTel
as
select num, name, tel from tblInsa;

select * from tblTel;

create or replace view vwTel
as
select num, name, tel from tblInsa;

select * from vwTel;    -- 실명 뷰
--= 
select * from (select * from tblTel);  -- 익명 뷰(인라인 뷰)

update tblInsa set tel = '010-1111-2222' where num = 1001;
select * from tblInsa where num = 1001; -- 010-1111-2222
select * from tblTel where num = 1001;  -- 011-2356-4528
select * from vwTel where num = 1001;   -- 010-1111-2222


-- 비디오 대여점 사장님 > 날마다 업무
-- 회원, 비디오, 대여, 반납유무, 반납예정일, 연체일, 연체료
create view vwCheck
as
select 
    m.name as 회원명,
    v.name as 비디오,
    r.rentdate as 대여일,
    r.retdate as 반납일,
    g.period as 대여기간,
    r.rentdate + g.period as 반납예정일,
    case
        when r.retdate is not null then r.retdate - r.rentdate - g.period
        when r.retdate is null then round(sysdate) - r.rentdate - g.period
    end as 연체일,
    case
        when r.retdate is not null then r.retdate - r.rentdate - g.period
        when r.retdate is null then round(sysdate) - r.rentdate - g.period
    end * g.price * 0.1 as 대여료
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            inner join tblVideo v
                on v.seq = r.video
                    inner join tblGenre g
                        on g.seq = v.genre;
                        
select * from vwCheck;



-- 뷰 사용 시 주의점 !! 
-- 1. select > 실행O > "뷰는 읽기 전용 테이블이다!!"
-- 2. insert > 실행O > 절대 사용 금지!!
-- 3. update > 실행O > 절대 사용 금지!!
-- 4. delete > 실행O > 절대 사용 금지!!

create or replace view vwTodo
as
select * from tblTodo;
select * from vwTodo;

insert into vwTodo values(21,'뷰만들기',sysdate, null);
update vwTodo set completedate = sysdate where seq = 21;
delete from vwTodo where seq = 21;



-- 단순뷰(테이블 1개) > CRUD 가능
-- 복합뷰(테이블 2개 이상) > CRUD 불가능 > R 가능


