-- *.sql (SQL)스크립트 파일

-- ex01_datatype.sql

-- 한줄 주석
/*
    여러줄 주석
*/

/*
    관계형 데이터베이스
    - 변수(X), 제어문(X) > SQL은 프로그래밍 언어가 아니다.(제어 흐름X)
    - DB와 대화를 목적으로 하는 언어 > 대화형 언어
    - SQL 자료형 > 테이블 선언할 때 사용 > 컬럼에 적용

    ANSI-SQL 자료형(오라클 자료형) 
    
    1. 숫자형
        - 정수/실수
        a. number
            - (유효자리)38자리까지 표현
            - 12345678901234567890123456789012345678
            - 1~22byte
            - 1X10^-130 ~ 9.9999X10^125
            - number: 정수 or 실수
            - number(percision): 전체 자리수, 정수형만 
            - number(precision, scale)
            
    2. 문자형
    
    3. 날짜/시간형
    
    4. 이진 데이터 

*/

/*
    DDL
    
    create table 테이블명 (
        컬럼 선언,
        컬럼 선언,
        컬럼 선언,
        컬럼명 자료형
    );

*/

-- 수업 식별자 패턴: DB Object > 헝가리언 표기법 Ctrl + Enter

drop table tblType; -- 테이블 삭제

create table tblType (
    --num number
    --num number(3) -- 3자리, -999 ~ +999
    num number(4,2) -- 4wkfl + 소수 이하 2자리  
);


select * from tabs; --tables. 내가 가지고 있는 테이블 목록

-- 데이터 추가하기
-- isnert into 테이블명 (컬럼명) values (값);
-- isnert into 테이블명 (컬럼명, 컬럼명) values (값, 값);

insert into tblType (num) values (100); -- 100 > 정수형 리터럴
insert into tblType (num) values (3.14); -- 3.14 > 실수형 리터럴
insert into tblType (num) values (3.54); -- 반올림 > 4 
insert into tblType (num) values (12345678901234567890123456789012345678);
insert into tblType (num) values (12345678901234567890123456789012345678901234567890);

select * from tblType; --테이블의 모든 데이터를 가져와라