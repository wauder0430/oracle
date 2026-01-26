--ex12_ddl.sql

/*
    수업 진도
    
    1. 초반 DML(ex01~ex11)
    2. DDL > 테이블(구조)
    3. 후반 DML
    -------------------------- ANSI-SQL
    4. 데이터 설계(모델링)
    5. 간단한 프로젝트(팀 프로젝트): 1일
    -------------------------- 
    6. PL/SQL 
    -------------------------- PL/SQL
    7. DB 프로젝트(팀 프로젝트): 1주
    
    
    1. DDL 
    - Data Definition Language
    - 데이터 정의어
    - DB의 구조를 생성/관리하는 명령어
    - 데이터베이스 객체(테이블, 뷰, 사용자, 인덱스 등)를 
        생성/수정/삭제하는 명령어
    a. create: 생성
    b. drop  : 삭제
    c. alter : 수정
    
    
    테이블 생성하기 > 테이블 구조(스키마, Schema) 설계 > 컬럼 정의하기
        > 컬럼의 이름, 자료형, 길이, 제약사항 정의, 
        
    create table 테이블명(
        컬럼 선언,
        컬럼명 자료형(길이) NULL 제약사항
    );
    
    제약사항, Constraint *****
    - 데이터베이스 무결성을 보장하기 위한 장치
    - 해당 컬럼에 들어갈 데이터에 대한 조건(***)
        1. 조건을 만족하면 > 저장
        2. 조건을 불만족하면 > 에러 발생
    
    1. NOT NULL
        - 해당 컬럼이 반드시 값을 가져야 한다. 
        - 해당 컬럼에 값이 없으면 에러 발생
        - 필수값(required)
        
    2. PRIMARY KEY, PK
        - 기본키(Key == 컬럼) > 대표 역할
        - 테이블의 행을 구분하기 위한 제약 사항 
        - 값이 유일하다.(UNIQUE) + 필수값(NOT NULL)
        - 하나의 테이블에 PK는 2개 이상 존재 불가능 
        - 반드시 테이블에는 PK가 존재해야 한다.(PK 없는 테이블 존재 가능 > 안만듬)
    
    3. FOREIGN KEY
    
    4. UNIQUE
        - 유일하다. 레코드간에 중복값을 가질 수 없다. 
        - NULL을 가질 수 있다. > 식별자가 될 수 없다.
        ex) 초등학교 학급
            - 학생(번호(PK), 이름(NN), 직책(UQ))
                1. 홍길동, 반장
                2. 아무개, null
                3. 강아지, 부반장
    
    5. CHECK
        - 사용자 정의형
        - 조건 정의 > 컬럼의 제약 사용으로 적용
        - where절 조건과 동일
         
    [6. DEFAULT]
        - 기본값 설정 기능
        - insert/update 작업 시 > 컬럼에 값을 안 넣으면 null 대신에
                                  미리 설정한 값을 대신 대입 (기본값)
    
*/

-- 메모 테이블 
create table tblMemo(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) null, -- 이 컬럼은 값을 안 넣어도 됩니다. (optional)
    name varchar2(30) null,
    memo varchar2(1000) null,
    regdate date null
);

select * from tblMemo;

insert into tblMemo ( seq, name, memo, regdate) 
    values (1, '홍길동', '메모입니다.', '2026-01-23');

insert into tblMemo ( seq, name, memo, regdate) 
    values (2, '아무개', '테스트입니다.', to_date('2026-01-23 17:07:54', 'yyyy-mm-dd hh24:mi:ss'));

insert into tblMemo ( seq, name, memo, regdate) 
    values (3, '강아지', '멍멍멍', sysdate);

insert into tblMemo ( seq, name, memo, regdate) 
    values (4, '고양이', '메모입니다.', null);

insert into tblMemo ( seq, name, memo, regdate) 
    values (5, '병아리', null , null);

insert into tblMemo ( seq, name, memo, regdate) 
    values (6, null, null , null);

insert into tblMemo ( seq, name, memo, regdate) 
    values (null, null, null , null);

select * from tblMemo;
drop table tblMemo;
-- 메모 테이블 
create table tblMemo(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) not null,             -- 메모번호(N•N)
    name varchar2(30) null,             -- 작성자
    memo varchar2(1000) not null,       -- 메모내용(NN)
    regdate date null                   -- 날짜
);

insert into tblMemo ( seq, name, memo, regdate) 
    values (1, '강아지', '멍멍멍', sysdate);

-- ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다
insert into tblMemo ( seq, name, memo, regdate) 
    values (2, '고양이', null, sysdate);

-- ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다 
insert into tblMemo ( seq, name, memo, regdate) 
    values (3, '고양이', '', sysdate); -- sql은 빈문자열도 null로 취급한다.
    

select * from tblMemo;
drop table tblMemo;
-- 메모 테이블 
create table tblMemo(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) primary key,          -- 메모번호(PK)
    name varchar2(30) null,             -- 작성자
    memo varchar2(1000) not null,       -- 메모내용(NN)
    regdate date null                   -- 날짜
);

insert into tblMemo ( seq, name, memo, regdate) 
    values (1, '강아지', '멍멍멍', sysdate);

insert into tblMemo ( seq, name, memo, regdate) 
    values (2, '고양이', '멍멍멍', sysdate);

insert into tblMemo ( seq, name, memo, regdate) 
    values (3, '강아지', '왈왈왈', sysdate);

-- ORA-00001: 무결성 제약 조건(HR.SYS_C008520)에 위배됩니다
insert into tblMemo ( seq, name, memo, regdate) 
    values (3, '홍길동', '메모테스트', sysdate);







select * from tblMemo;
drop table tblMemo;
-- 메모 테이블 
create table tblMemo(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) primary key,          -- 메모번호(PK)
    name varchar2(30) unique,             -- 작성자(UQ)
    memo varchar2(1000) not null,       -- 메모내용(NN)
    regdate date null                   -- 날짜
);

insert into tblMemo ( seq, name, memo, regdate) 
    values (1, '강아지', '멍멍멍', sysdate);

insert into tblMemo ( seq, name, memo, regdate) 
    values (2, '고양이', '멍멍멍', sysdate);

-- ORA-00001: 무결성 제약 조건(HR.SYS_C008523)에 위배됩니다
insert into tblMemo ( seq, name, memo, regdate) 
    values (3, '강아지', '왈왈왈', sysdate);
    
insert into tblMemo ( seq, name, memo, regdate) 
    values (3, '병아리', '삐약', sysdate);
    
    
    
select * from tblMemo;
drop table tblMemo;
-- 메모 테이블 
create table tblMemo(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) constraint tblmemo_seq_pk primary key,          -- 메모번호(PK)
    name varchar2(30) null,             -- 작성자
    memo varchar2(1000) not null,       -- 메모내용(NN)
    regdate date null,                  -- 날짜
    
    -- 중요도(1(중요), 2(보통), 3(안중요))
    -- where priority >= 1 and priority <=3
    -- priority number(1) check (priority >= 1 and priority <=3)
    priority number(1) constraint tblmemo_priority_ck check (priority between 1 and 3),
    
    -- 카테고리(할일, 공부, 약속)
    -- 
    category varchar2(10) constraint tblmemo_category_ck check(category in ('할일', '공부', '약속'))
);

insert into tblMemo ( seq, name, memo, regdate, priority, category) 
    values (1, '강아지', '멍멍멍', sysdate, 1 , '할일');
    
insert into tblMemo ( seq, name, memo, regdate, priority, category) 
    values (2, '고양이', '야옹', sysdate, 1 , '할일');
    
-- ORA-02290: 체크 제약조건(HR.SYS_C008525)이 위배되었습니다
insert into tblMemo ( seq, name, memo, regdate, priority, category) 
    values (3, '병아리', '멍멍멍', sysdate, 4 , '할일');
    
-- ORA-02290: 체크 제약조건(HR.SYS_C008526)이 위배되었습니다
insert into tblMemo ( seq, name, memo, regdate, priority, category) 
    values (4, '송아지', '음메', sysdate, 2 , '시험');
    
    
    

select * from tblMemo;
drop table tblMemo;
-- 메모 테이블 
create table tblMemo(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) primary key,          -- 메모번호(PK)
    name varchar2(30) default '익명',   -- 작성자           
    memo varchar2(1000) not null,       -- 메모내용(NN)
    regdate date default sysdate        -- 날짜
);

insert into tblMemo ( seq, name, memo, regdate) 
    values (1, '강아지', '멍멍멍', sysdate);
    
-- 명시적 null 대입 > 사용자의 의지가 담겨있다고 봄 + 의지 표현
insert into tblMemo ( seq, name, memo) 
    values (2, null, '멍멍멍'); --null > default 동작 안함
    
-- 암시적 null 대입 > 사용자의 의지가 없다. 
insert into tblMemo(seq, memo)
    values (3, '삐약'); -- null 대신 '익명' > default 동작 함 
    
    
    



/*
    제약 사항을 만드는 방법
    
    1. 컬럼 수준에서 만드는 방법
        - 위의 수업 방식
        - 컬럼을 선얼할 때 제약 사항도 같이 선언하는 방식
        - 가독성 향상 > 어떤 컬럼 + 어떤 제약 > 직관적으로 인식 가능
    
    2. 테이블 수준에서 만드는 방법
        - 컬럼 선언과 제약 사항 선언을 분리하는 방식
        - 가독성 향상 > 테이블 크기가 커질수록 코드 관리 용이 
    
    3. 외부에서 만드는 방법
    
*/

select * from tblMemo;
drop table tblMemo;
-- 메모 테이블 
create table tblMemo(
    seq number(3),         
    name varchar2(30),              
    memo varchar2(1000),       
    regdate date,
    
    constraint tblmemo_seq_pk primary key(seq),
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check (length(memo) >= 10)
);