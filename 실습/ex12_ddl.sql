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
        - 기본키
        - 테이블의 행을 구분하기 위한 제약 사항 
        - 값이 유일하다.(UNIQUE) + 필수값(NOT NULL)
    
    3. FOREIGN KEY
    
    4. UNIQUE
    
    5. CHECK
    
    6. DEFAULT
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

