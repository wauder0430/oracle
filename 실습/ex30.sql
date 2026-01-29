-- ex30.sql

/*
    ** 지금 예제 테이블은 근태 관리의 적합한 구조가 아니다.
    
    근태(출결) 관리
    - 근태 상태 관리(정상, 지각, 조퇴)
    - 2026년 1월 > 한달분 데이터(1일~31일)
    - 달력 > 출력 
    
*/
-- 근태 테이블
create table tblDate (
    seq number primary key,         -- PK
    state varchar2(30) not null,    -- 정상, 지각, 조퇴
    regdate date not null           -- 날짜
);

-- 원래라면
create table tblDate (
    seq number primary key,         -- PK
    inTime date not null,
    outTime date not null
);--------------------------------
select * from tblDate;

insert into tblDate (seq, state, regdate) values (1, '정상', '2026-01-02');
--01-03: 토요일
--01-04: 일요일
insert into tblDate (seq, state, regdate) values (2, '정상', '2026-01-05');
insert into tblDate (seq, state, regdate) values (3, '지각', '2026-01-06');
insert into tblDate (seq, state, regdate) values (4, '지각', '2026-01-07');
insert into tblDate (seq, state, regdate) values (5, '정상', '2026-01-08');
insert into tblDate (seq, state, regdate) values (6, '정상', '2026-01-09');
--01-10: 토요일
--01-11: 일요일
insert into tblDate (seq, state, regdate) values (7, '정상', '2026-01-12');
--insert into tblDate (seq, state, regdate) values (8, '결석', '2026-01-13');
insert into tblDate (seq, state, regdate) values (9, '정상', '2026-01-14');
insert into tblDate (seq, state, regdate) values (10, '조퇴', '2026-01-15');
insert into tblDate (seq, state, regdate) values (11, '정상', '2026-01-16');
--01-17: 토요일
--01-18: 일요일
insert into tblDate (seq, state, regdate) values (12, '지각', '2026-01-19');
insert into tblDate (seq, state, regdate) values (13, '정상', '2026-01-20');
insert into tblDate (seq, state, regdate) values (14, '정상', '2026-01-21');
--insert into tblDate (seq, state, regdate) values (15, '결석', '2026-01-22');
insert into tblDate (seq, state, regdate) values (16, '정상', '2026-01-23');
--01-24: 토요일
--01-25: 일요일
insert into tblDate (seq, state, regdate) values (17, '정상', '2026-01-26');
insert into tblDate (seq, state, regdate) values (18, '정상', '2026-01-27');
insert into tblDate (seq, state, regdate) values (19, '정상', '2026-01-28');
insert into tblDate (seq, state, regdate) values (20, '정상', '2026-01-29');

commit;

-- 근태 조회 or 출력 > select 
-- 1월 1일부터 1월 29일까지 내역 > 29건의 내역 + 실제 기록 18건
-- 기록이 없는 날도 같이 보고 싶다. > 공휴일, 주말, 결석
-- 1. ANSI-SQL
-- 2. PL/SQL
-- 3. Java

-- 1. 1월 1일 ~ 1월 29일 > 날짜 데이터 생성하기
-- ANSI-SQL > 반복문(X) > 계층형 쿼리
-- 일련번호 생성용 > 계층형 쿼리
create or replace view vwDate
as
select 
    to_date('2026-01-01') + level -1 as regdate
from dual
    connect by level <= 29;
    
-- 2.    
select * from vwDate;  -- 1월 한달 날짜
select * from tblDate; -- 1월 한달 근태

-- 공휴일 처리 > 테이블 따로 생성
create table tblHoliday(
    seq number primary key,
    regdate date not null,
    name varchar2(50) not null
);
insert into tblHoliday values(1, '2026-01-01', '신정');
    
select 
    vd.regdate as 날짜, 
    case
        when to_char(vd.regdate, 'dy') = '토' then '토요일'         -- 주말 처리
        when to_char(vd.regdate, 'dy') = '일' then '일요일'         -- 주말 처리                 -- 공휴일 처리 > 공식 없음!
        when h.seq is not null then h.name
        when td.state is null then '결석'
        else td.state
    end as 상태
from vwDate vd 
    left outer join tblDate td on to_char(vd.regdate, 'yyyy-mm-dd') = to_char(td.regdate, 'yyyy-mm-dd')
        left join tblHoliday h on to_char(vd.regdate, 'yyyy-mm-dd') = to_char(h.regdate, 'yyyy-mm-dd')
order by vd.regdate;


/*
    1. ANSI-SQL
    2. 모델링+ 정규화
    3. DB 프로젝트 > 1일
    4. PL/SQL
    5. DB 프로젝트
    
    씨네21 > 영화 > 영화랭킹 > DB모델링 
    > 사진 영상 제외인데
    유튜브 링크로 대체 가능 
    최소 20 ~ 30개 로 잡아야 적절한 모델링 가능 
    ex) 감독이 여러명인 경우
        장르가 여러개인 경우 

    영화 > 작업 순서
    1. 사이트 분석 > 어떤 데이터 추출 (높은 디테일 권장)
    2. 논리 모델링 > [산출물]
    3. 물리 모델링 > [산출물]
    4. DDL 작성 > [산출물]
    5. 데이터 추가 > DML 작업 > [산출물]
    6. 검증
    
*/

