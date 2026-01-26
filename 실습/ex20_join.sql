--ex20.join.sql

/*
    관계형 데이터베이스 시스템이 지양하는 것들!! ***
    1. 테이블에 기본키(PK)가 없는 상태
    
    2. null이 많은 상태의 테이블 > 공간 낭비 + SQL 작업 불편
    3. 하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다.
    
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
