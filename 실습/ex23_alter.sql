--ex23.sql

/*
    DML > 
    
    - 데이터 입력: insert 
    - 데이터 수정: update
    - 데이터 삭제: delete
    
    DDL > 객체 조작
    - 객체 생성: create
    - 객체 수정: alter(or replace)
        - alter table 테이블명 add (컬럼 정의);
    - 객체 삭제: drop
    
    테이블 수정하기 
    - 테이블 수정 > 컬럼 수정 > 컬럼명 or 자료형(길이) or 제약사항 수정
    
    테이블을 수정해야 하는 상황 발생 !!
    1. 테이블 삭제(drop) > 테이블 DDL(create) 수정 > 수정된 DDL로 다시 테이블 생성
        a. 기존 테이블에 데이터가 없는 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있는 경우 > 미리 데이터 백업 > 테이블 삭제 > 테이블 DDL(create) 수정 > 수정된 DDL로 다시 테이블 생성 > 백업한 데이터를 다시 복구
        
    2. alter 명령어 사용 > 기존 테이블의 구조 변경
        a. 기존 테이블에 데이터가 없는 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있는 경우 > 상황에 따라 비용 차이 발생 
    
*/
drop table tblEdit;
create table tblEdit (
    seq number,
    name varchar2(20)
);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');

-- Case 1. 새로운 컬럼을 추가하기
-- ORA-01758: 테이블은 필수 열을 추가하기 위해 (NOT NULL) 비어 있어야 합니다.
alter table tblEdit 
    add (price number not null);

alter table tblEdit 
    add (price number default 0 not null);
    
delete from tblEdit;    
desc tblEdit;
select * from tblEdit;


-- Case 2. 기존 컬럼을 삭제하기
alter table tblEdit 
    drop column 컬러명;

alter table tblEdit 
    drop column price;

-- PK 삭제 > 절대 금지 


-- Case 3. 컬럼 수정하기 

-- Case 3.1 컬럼 길이 수정하기(확장/축소)
insert into tblEdit values (4, '삼성 갤럭시북6 프로');

alter table tblEdit
    modify (칼럼 정의); -- 칼럼 정의 선언 표현과 같음

alter table tblEdit
    modify (name varchar2(100)); -- 확장 

-- ORA-01441: 일부 값이 너무 커서 열 길이를 줄일 수 없음    
alter table tblEdit
    modify (name varchar2(20)); -- 축소      
    
-- 상품명 중 가장 이름 긴 상품명? > 컬럼 길이 조절
select name from tblEdit where length(name) = (select max(length(name)) from tblEdit);

select lengthb(name) from tblEdit order by length(name) desc;

-- 삼성 갤럭시북6 프로 = 8 X 3 + 3 X 1 = 27

alter table tblEdit
    modify (name varchar2(27)); -- 축소          

-- Case 3.2 컬럼의 제약사항 수정하기(not null)
alter table tblEdit
    modify (컬럼명 자료형(길이) null); -- not null > null
alter table tblEdit
    modify (컬럼명 자료형(길이) not null); -- null > not null

-- ORA-02296: (HR.) 사용으로 설정 불가 - 널 값이 발견되었습니다.
alter table tblEdit
    modify (name varchar2(27) not null);
alter table tblEdit
    modify (name varchar2(27) default '임시' not null); -- 불가능
alter table tblEdit
    modify (name varchar2(27) null);
insert into tblEdit values (5, null);

-- Case 3.3 컬럼의 자료형 바꾸기
-- ORA-01439: 데이터 유형을 변경할 열은 비어 있어야 합니다
alter table tblEdit
    modify (name number);

update tblEdit set name = null;

-- Case 3.4 컬럼명 바꾸기 
alter table tblEdit
    rename column name to item;


-- Case 4. 제약 사항 조작(추가, 삭제)
drop table tblEdit;

create table tblEdit (
    seq number,
    name varchar2(20)
);

alter table tblEdit 
    add constraint tbledit_seq_pk primary key(seq);

alter table tblEdit 
    add constraint tbledit_name_uq unique(name);
    
alter table tblEdit
    drop constraint tbledit_name_uq;

desc tblEdit;
select * from tblEdit;


-- DB 처음 설계 + 구축
-- style 1.
create table tblEdit (
    seq number primary key,
    name varchar2(20) unique
);

-- style 2.
create table tblEdit (
    seq number,
    name varchar2(20),
    
    constraint tbledit_seq_pk primary key(seq),
    constraint tbledit_name_uq unique(name)
);

-- style 3.
create table tblEdit (
    seq number,
    name varchar2(20)
);
alter table tblEdit add constraint tbledit_seq_pk primary key(seq);
alter table tblEdit add constraint tbledit_name_uq unique(name);
