-- ex29_relationship

/*
    1. 기본키
        a. 단일키
        b. 복합키
    
    2. 관계
        a. 비식별 관계
        b. 식별 관계
        
*/

select * from tblUser;
drop table tblUser;

-- 부모가 자식을 바라보는 시점으로써의 표현 > 식별 vs 비식별 
-- *** 자식 테이블에서 FK가 PK의 역할을 하면 식별관계라고 한다. 결합↑
-- *** 자식 테이블에서 FK가 일반 컬럼이면 비식별관계라고 한다.  결합이 느슨

-- 식별관계가 만들어지기 위한 조건
-- 1. 1:1관계
-- 2. 복합키

-- 회원 테이블 : 게시판 테이블
-- 단일키(PK) + 1:N + 비식별 관계

-- 회원 테이블 : 회원 상세 테이블
-- 단일키(PK) + 1:1 + 식별 관계

-- 비식별
-- 홍길동 (회원) - 글A
-- 홍길동(회원) - 글B
-- 홍길동(회원) - 글C

-- 식별
-- 홍길동(회원) - 홍길동(세부정보)

-- 회원 테이블
create table tblUser (
    seq number primary key,     -- 성능과 효율성
    id varchar2(30) not null,
    pw varchar2(30) not null,
    name varchar2(30) not null
);

-- 게시판
create table tblBoard(
    seq number primary key,
    subject varchar2(1000) not null,
    content varchar2(4000) not null,
    regdate date default sysdate not null,
    user_seq number not null references tblUser(seq)
);

select * from tblUser;
select * from tblBoard;


-- 유저 세부 정보
create table tblUserDetails (
    seq number,
    tel varchar2(15) not null,
    email varchar2(50) not null,
    address varchar2(200) not null,
    
    constraint tbluserdetails_seq_pk primary key(seq),
    constraint tbluserdetails_seq_fk foreign key(seq) references tblUser(seq)
);

-- N:N 관계가 발견되면 중간에 테이블을 생성
-- 1:N, N:1 관계로 바꾼다.

-- 학생, 과목, 수강
create table tblStudent(
    seq number primary key,
    name varchar2(30) not null    
);

create table tblSubject(
    seq number primary key,
    name varchar2(100) not null
);

create table tblRegistration (
    student_seq number not null,
    subject_seq number not null,
    score number not null,
    
    constraint tblregistration_pk primary key(student_seq, subject_seq),
    constraint tblregistration_stu_fk foreign key(student_seq) references tblStudent(seq),
    constraint tblregistration_sub_fk foreign key(subject_seq) references tblSubject(seq)
);


insert into tblStudent values (1, '홍길동');
insert into tblStudent values (2, '강아지');
insert into tblStudent values (3, '고양이');

insert into tblSubject values (1, '자바');
insert into tblSubject values (2, '오라클');
insert into tblSubject values (3, '스프링');

insert into tblRegistration values (1, 1, 0);
insert into tblRegistration values (1, 2, 0);
insert into tblRegistration values (1, 3, 0);
insert into tblRegistration values (2, 1, 0);
insert into tblRegistration values (2, 2, 0);
insert into tblRegistration values (2, 3, 0);
insert into tblRegistration values (3, 2, 0);
insert into tblRegistration values (3, 3, 0);

select * from tblRegistration;

-- 홍길동 + 자바 > 점수?
select seq from tblStudent where name = '홍길동';
select seq from tblSubject where name = '자바';
select score from tblRegistration where student_seq = 1 and subject_seq = 1;

select score from tblRegistration where student_seq = (select seq from tblStudent where name = '홍길동') and subject_seq = (select seq from tblSubject where name = '자바');

select score
    from tblRegistration r
        inner join tblStudent stu on stu.seq = r.student_seq
            inner join tblSubject sub on sub.seq = r.subject_seq
where stu.name = '홍길동' and sub.name = '자바';

-- 홍길동 + 어떤 과목?
select sub.name
    from tblRegistration r
        inner join tblStudent stu on stu.seq = r.student_seq
            inner join tblSubject sub on sub.seq = r.subject_seq
where stu.name = '홍길동';

select name 
from tblSubject 
where seq in (select subject_seq from tblRegistration where student_seq = (select seq from tblStudent where name = '홍길동'));

-- 자바 + 어떤 학생?
select stu.name
    from tblRegistration r
        inner join tblStudent stu on stu.seq = r.student_seq
            inner join tblSubject sub on sub.seq = r.subject_seq
where sub.name = '자바';


-- 보충 수업
create table tblExtra (
    seq number primary key,
    regdate date, 
    student_seq number,
    subject_seq number,
    
    constraint tblextra_fk foreign key(student_seq, subject_seq) references tblRegistration(student_seq, subject_seq)
);

insert into tblExtra values (1, sysdate,1, 1);
insert into tblExtra values (2, sysdate+1, 1, 2);

select * from tblExtra;

-- 홍길동 > 어떤 과목 + 보충수업 날짜?

select stu.name, sub.name, e.regdate
    from tblRegistration r
        inner join tblStudent stu on stu.seq = r.student_seq
            inner join tblSubject sub on sub.seq = r.subject_seq
                inner join tblExtra e on r.student_seq = e.student_seq and r.subject_seq = e.subject_seq
where stu.name = '홍길동';