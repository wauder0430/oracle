--ex20.join.sql

/*
    관계형 데이터베이스 시스템이 지양하는 것들!! ***
    1. 테이블에 기본키(PK)가 없는 상태

    2. null이 많은 상태의 테이블 > 공간 낭비 + SQL 작업 불편
    3. 하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다.
    
    4. 데이터가 중복되는 상태 > 데이터 관리 불편(일관성 저하)
    
*/

-- 1.
commit;
rollback;
drop table tblNote;
create table tblNote (
    name varchar2(30) not null,
    contents varchar2(1000) not null,
    regdate date default sysdate not null
);

insert into tblNote values ('홍길동', '자바 정리', default);
insert into tblNote values ('아무개', '오라클 정리', default);
insert into tblNote values ('강아지', '네트워크 정리', default);
insert into tblNote values ('고양이', '자바 정리', default);
insert into tblNote values ('홍길동', '알고리즘 정리', default);

select * from tblNote;
update tblNote set contents = '자바 수업 정리' where name = '홍길동';



-- 2.
drop table tblUser;
create table tblUser (
    id varchar2(30) primary key,
    name varchar2(30) not null,
    hobby1 varchar2(50),
    hobby2 varchar2(50),
    hobby3 varchar2(50)
);

select * from tblUser;
insert into tblUser values ('hong', '홍길동', '독서');
insert into tblUser values ('dog', '강아지', null);
insert into tblUser values ('cat', '고양이', '운동, 독서, 코딩');
insert into tblUser values ('test', '테스트', '런닝, 매뉴얼독서');

select * from tblUser where hobby = '독서';
select * from tblUser where hobby like '%독서%';

update tblUser set hobby = '책읽기' where hobby = '독서';

-- '독서' > '책읽기' 
-- '매뉴얼독서' > 그대로



-- 회원 10000명 가입
-- 딱 1명 > 취미 100개
-- 9999명 > 취미 0~2개

insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('dog', '강아지', null, null, null);
insert into tblUser values ('cat', '고양이', '운동', '독서', '코딩');
insert into tblUser values ('test', '테스트', '런닝', '매뉴얼독서', null);

select * from tblUser
    where hobby1 = '독서' or hobby2 = '독서' or hobby3 = '독서';   -- 100개면 or절 100개...?
    
    
drop table tblShop;
-- 쇼핑몰 > 판매테이블
create table tblShop(
    seq number primary key,
    id varchar2(30) not null,
    name varchar2(30) not null,
    tel varchar2(15) not null,
    item varchar2(50) not null,
    qty number not null,    -- 수량
    regdate date default sysdate not null
);

insert into tblShop values(1, 'hong', '홍길동', '010-1234-5678', '마우스', 1, default);

insert into tblShop values(2, 'test', '테스트', '010-1235-5678', '키보드', 1, default);

insert into tblShop values(3, 'hong', '홍길동', '010-1234-5678', '태블릿', 1, default);

select * from tblShop;

-- 직원 정보 
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create table tblStaff(
    seq number primary key,
    name varchar2(30) not null,
    salary number not null,
    address varchar2(300) not null,
    project varchar2(300)               --담당 프로젝트
);
drop table tblStaff;
insert into tblStaff values (1, '홍길동', 300, '서울시', '홍콩 수출');

insert into tblStaff values (2, '아무개', 250, '인천시', 'TV 광고');

insert into tblStaff values (3, '하하하', 350, '의정부시', '매출 분석');

select * from tblStaff;

-- '홍길동'에게 담당 프로젝트를 1개 추가 > '고객 관리'




-- 직원 정보 
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create table tblStaff(
    seq number primary key,
    name varchar2(30) not null,
    salary number not null,
    address varchar2(300) not null
);

create table tblProject (
    seq number primary key,         -- 프로젝트 번호(PK)
    project varchar2(300) not null,
    staff_seq number                -- 담당직원번호
);

drop table tblStaff;
drop table tblProject;

insert into tblStaff values (1, '홍길동', 300, '서울시');

insert into tblStaff values (2, '아무개', 250, '인천시');

insert into tblStaff values (3, '하하하', 350, '의정부시');

select * from tblStaff;
select * from tblProject;

insert into tblProject values(1, '홍콩 수출', 1); -- 홍길동
insert into tblProject values(2, 'TV 광고', 2);   -- 아무개
insert into tblProject values(3, '매출 분석', 3);  -- 하하하
insert into tblProject values(4, '고객 관리', 1);  -- 홍길동
insert into tblProject values(5, '대리점 분양', 2); --아무개

-- 'TV 광고' 담당자?
-- 2 TV 광고 2
-- 2 아무개 250 인천시
select * from tblProject where project = 'TV 광고';
select * from tblStaff where seq = 2;

select * from tblStaff where seq = (select seq from tblProject where project = 'TV 광고');     

-- A. 신입 사원 입사 > 신규 프로젝트 배정
-- A.1 신입 사원 추가 (O)
insert into tblStaff values(4, '호호호', 220, '성남시');

-- A.2 신규 프로젝트 배정
insert into tblProject values(6, '자재 매입', 4);

select * from tblStaff where seq = (select staff_seq from tblProject where project = '자재 매입');     

-- A.3 신규 프로젝트 추가(O)
-- ORA-02291: 무결성 제약조건(HR.SYS_C008596)이 위배되었습니다- 부모 키가 없습니다
insert into tblProject values (7, '고객 유치', 5);
select * from tblProject;
select * from tblStaff where seq = (select staff_seq from tblProject where project = '고객 유치');     


-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제(O)
-- ORA-02292: 무결성 제약조건(HR.SYS_C008596)이 위배되었습니다- 자식 레코드가 발견되었습니다
delete from tblStaff where seq = 1;

select * from tblstaff;
select * from tblStaff where seq = (select staff_seq from tblProject where project = '홍콩 수출');     

-- B.2 '홍길동' 삭제 전 > 업무 인수 인계(위임)
select * from tblProject;

update tblProject set staff_seq = 2 where staff_seq = 1;
delete from tblStaff where seq = 1;
select * from tblStaff where seq = (select staff_seq from tblProject where project = '홍콩 수출');     



-- 테이블 생성 순서
-- 1. 부모 테이블 > 2. 자식 테이블

-- 테이블 삭제 순서
-- 1. 자식 테이블 > 2. 부모 테이블

create table tblStaff(
    seq number primary key,
    name varchar2(30) not null,
    salary number not null,
    address varchar2(300) not null
);

-- 먼저 생성 시 ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
create table tblProject (
    seq number primary key,         -- 프로젝트 번호(PK)
    project varchar2(300) not null,
    staff_seq number not null references tblStaff(seq)  -- 담당직원 번호(FK, 외래키, 참조키)
);


insert into tblStaff values (1, '홍길동', 300, '서울시');
insert into tblStaff values (2, '아무개', 250, '인천시');
insert into tblStaff values (3, '하하하', 350, '의정부시');

insert into tblProject values(1, '홍콩 수출', 1); -- 홍길동
insert into tblProject values(2, 'TV 광고', 2);   -- 아무개
insert into tblProject values(3, '매출 분석', 3);  -- 하하하
insert into tblProject values(4, '고객 관리', 1);  -- 홍길동
insert into tblProject values(5, '대리점 분양', 2); --아무개




create table tblShop(
    seq number primary key,                 -- 판매 번호(PK)
    item varchar2(50) not null,             -- 상품명
    qty number not null,                    -- 수량
    regdate date default sysdate not null,
    id varchar2(30) not null references tblUser(id) -- 구매한 고객 아이디(FK)
);

create table tblUser(
    id varchar2(30) primary key,        -- 고객 아이디(PK)
    name varchar2(30) not null,         -- 고객명
    tel varchar2(15) not null           -- 연락처
);


/*
    조인, Join
    - (서로 관계를 맺고) 2개(1개) 이상의 테이블을 대상 > select > 1개의 결과셋
    
    조인의 종류(ANSI-SQL)
    1. 크로스  조인, cross join
    2. 내부(단순) 조인, inner join *****
    3. 외부 조인, outer join       *****
        - 전체 외부 조인, full outer join
    
    
    1. 셀프 조인, self join
        

    DB 이론
    - 관계 대수 > 연산(자)
    - 테이블을 피연산자로 하는 연산
    - 테이블 + 테이블 = union
    - 테이블 - 테이블 = minus
    - 테이블 X 테이블 = join

    1. 크로스 조인, cross join
    
    - select 컬럼리스트 from 테이블A cross join 테이블명B;
    
    - 카티션 곱, 데카르트 곱
    - A 테이블, B 테이블 = 1개의 결과 테이블
    - 쓸모 없다. > 가치 있는 행과 가치 없는 행이 뒤섞여 있다.
    - 유효성 관계없이 양이 많은 데이터가 필요할 때 사용 > 대량의 더미 데이터용

*/
-- 1. 
select * from tblCustomer;  -- 고객 3명
select * from tblSales;     -- 판매 9건

select * from tblCustomer cross join tblSales; --ANSI-SQL
select * from tblCustomer, tblSales; --Oracle

/*
    2. 내부(단순) 조인, inner join
    - 크로스 조인에서 유효한 레코드만 추출한 조인
    
    - select 컬럼리스트 from 테이블A inner join 테이블명B on 테이블명A.PK = 테이블명B.FK;
    
*/
-- 2.
select 
    tblCustomer.seq as 회원번호,
    name as 회원명,
    tblSales.seq as 판매번호,
    item as 상품명
from tblCustomer 
    inner join tblSales 
        on tblCustomer.seq = tblSales.cseq; --ANSI-SQL;
select * from tblCustomer, tblSales 
    where tblCustomer.seq = tblSales.cseq;  --Oracle
    
select 
    c.seq as 회원번호,
    name as 회원명,
    s.seq as 판매번호,
    item as 상품명
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq; 


-- 고객 테이블 + 판매 테이블
-- 어떤 고객(c.name)이 어떤 물건(s.item)을 몇 개(s.qty)를 사갔습니까?
select 
    c.name,
    s.item,
    s.qty
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;

select 
    (select name from tblCustomer where seq = s.cseq),
    item,
    qty
from tblSales s; -- 자식테이블 > 메인쿼리


-- 비디오(c) + 장르(p)
select *
from tblGenre g 
    inner join tblVideo v
        on g.seq = v.genre;
        
-- 대여(c) + 비디오(p) = 비디오(c) + 장르(p) 
-- 대여 + 비디오 + 장르 
select * 
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video;
            

-- 회원(p) + 대여(c) = 대여(c) + 비디오(p) = 비디오(c) + 장르(p) 
-- 회원 + 대여 + 비디오 + 장르             
select * 
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on r.member = m.seq;
                    


                        
/*
    3. 외부 조인, outer join
    - 내부 조인의 반댓말?(X)
    - 내부 조인 결과 + a > 내부 조인의 확장 개념
    
  
    select 
        컬럼리스트 
    from 테이블A 
        (left|right) outer join 테이블명B 
            on 테이블명A.PK = 테이블명B.FK;

    
*/
select * from tblCustomer;  -- 3명 > 5명
select * from tblSales;     -- 9건

insert into tblCustomer values (4, '강아지', '010-1234-5678', '서울시');
insert into tblCustomer values (5, '고양이', '010-1234-5678', '서울시');

-- 내부 조인
--: 물건을 한번이라도 구매한 이력이 있는 고객의 정보와 구매 내역을 가져오시오.
select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;

-- 외부 조인
--: 모든(구매 이력이 있든, 없든) 고객의 정보를 가져오시오.
--: 구매 이력이 있다면.. 구매 내역도 같이 가져오시오.
--: 방향 > 보통 부모 테이블을 가르킨다.
select * 
from tblCustomer c
    left outer join tblSales s
        on c.seq = s.cseq;

select * from tblStaff; 
select * from tblProject;

-- 내부 조인
--: 프로젝트를 1개 이상 담당하고 있는 직원 정보 + 프로젝트 정보
select * 
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;
        
-- 외부 조인
--: 담당 프로젝트 유무와 상관없이, 모든 직원 정보를 가져와라 + 담당 프로젝트 정보
select * 
from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;
        
        
/*
    내부 조인 + 셀프 조인
    외부 조인 + 셀프 조인

    1. 셀프 조인, self join
    - 1개의 테이블을 사용하는 조인
    - 테이블이 자기 스스로와 관계를 맺는 경우에만 사용  
    
*/

-- hr.employees > 자기 참조

-- 직원 테이블
create table tblSelf(
    seq number primary key,                 -- 직원번호(PK)
    name varchar2(30) not null,             -- 직원명
    department varchar2(50) not null,       -- 부서명
    boss number references tblSelf(seq)     -- 상사번호(FK)
);

insert into tblSelf values (1, '홍사장', '사장실', null);
insert into tblSelf values (2, '김부장', '영업부', 1);
insert into tblSelf values (3, '박과장', '영업부', 2);
insert into tblSelf values (4, '최대리', '영업부', 3);
insert into tblSelf values (5, '정사원', '영업부', 4);
insert into tblSelf values (6, '이부장', '개발부', 1);
insert into tblSelf values (7, '하과장', '개발부', 6);
insert into tblSelf values (8, '신과장', '개발부', 6);
insert into tblSelf values (9, '황대리', '개발부', 7);
insert into tblSelf values (10, '허사원', '개발부', 9);

select * from tblSelf;

-- 1. join 
-- 2. sub query
-- 3. 계층형 쿼리

-- 직원들 중 직속 상사가 있는 직원만 가져오시오.
select 
    s2.name as 직원명,
    s2.department as 부서명,
    s1.name as 상사명
from tblSelf s1 -- 상사 테이블
    inner join tblSelf s2 -- 직원 테이블
        on s1.seq = s2.boss;

-- 모든 직원(+ 상사 정보) 가져오시오.
select 
    s2.name as 직원명,
    s2.department as 부서명,
    s1.name as 상사명
from tblSelf s1 -- 상사 테이블
    right join tblSelf s2 -- 직원 테이블
        on s1.seq = s2.boss;
        
select 
    name as 직원명,
    department as 부서명,
    (select name from tblSelf where seq = a.boss)
from tblSelf a;



/*
    5. 전체 외부 조인, full outer join
    - 서로 참조하고 있는 관계에서 사용
    - 테이블A > (참조) > 테이블B
    - 테이블B > (참조) > 테이블A
    
*/
select * from tblMen;
select * from tblWomen;

select m.name, w.name from tblMen m inner join tblWomen w on m.name = w.couple;

-- 커플 + 남자 솔로들...
select m.name, w.name from tblMen m left outer join tblWomen w on m.name = w.couple;

-- 커플 + 여자 솔로들...
select m.name, w.name from tblMen m right outer join tblWomen w on m.name = w.couple;

-- 커플 + 솔로들...
select m.name, w.name from tblMen m full outer join tblWomen w on m.name = w.couple;