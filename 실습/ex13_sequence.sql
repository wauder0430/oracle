--ex13_sequence.sql

/*
    시퀀스, sequence
    - DB Object(테이블, 제약사항, 시퀀스 등...)
    - DB Object > 생성/수정/삭제 > DDL(create, drop, alter)
    - 일련 번호를 생성하는 객체(***)
    - 오라클 전용
    - 주로 식별자를 만드는데 사용
    
    시퀀스 객체 생성하기
    - create sequence 시퀀스명; 
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명;
    
    시퀀스 객체 사용하기 
    - 시퀀스명.nextVal
    - 시퀀스명.currVal

*/

create sequence seqNum;
drop sequence seqNum;
create sequence seqNum start with 6; 

select seqNum.nextVal from dual;
select seqNum.currVal from dual;

create sequence seqNo;

select seqNo.nextVal from dual;
select seqNo.currVal from dual;

select name, seqNum.nextVal from tblInsa;


select * from tblMemo;
insert into tblMemo ( seq, name, memo, regdate) 
    values (seqNum.nextVal, '강아지', '멍멍멍', sysdate);
    
select seqNum.currVal from dual;

-- 쇼핑몰 > 상품번호 > abc001,bdf5534...
select 'ABC' || seqNum.nextVal from dual;

select 'ABC' || lpad(seqNum.nextVal,3,0) from dual;

select * from tblMemo;

/*
    시퀀스 객체 생성하기 
    - create sequence 시퀀스명;
    - create sequence 시퀀스명 
                                increment by n -- 증감치
                                start with n   -- 시작값
                                maxvalue n     -- 최댓값
                                minvalue n     -- 최솟값
                                cycle          -- 순환구조
                                cache n;       -- 임시저장
*/

drop sequence seqTest;
create sequence seqTest 
                    --increment by 5;
                    --maxvalue 10
                    --cycle
                    --cache 20;
                    
-- 접지 > 정전                    
-- service.msc > OracleServiceXE > 중지
select seqTest.nextVal from dual; --15 > ??? > 37
select seqTest.currVal from dual;

