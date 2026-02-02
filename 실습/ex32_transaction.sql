-- ex32_transaction.sql

/*
    트랜잭션, Transaction
    - 데이터를 조작하는 업무들의 시간적 단위
    - 1개 이상의 DML을 묶어 놓은 단위 
    ex) 은행 > 계좌 
    
    
    트랜잭션 명령어(DCL > TCL)
    1. commit
    
    2. rollback
    
    3. savepoint
    
*/
create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

select * from tblTrans;

-- 우리가 하는 모든 행동(SQL - insert, update, delete) > 반드시 시간순으로 기억(*****)

-- A
-- 트랜잭션 시작 > 종료 > 또 다른 트랜잭션 시작 > 종료 > 또 다른 트랜잭션 시작..  

select * from tblTrans;

delete from tblTrans where name = '김말숙';

select * from tblTrans;

-- 김말숙 되살리기
rollback; -- 현재 트랜잭션에서 발생한 모든 SQL을 없었던 일로...

select * from tblTrans;


-- 진짜 삭제
delete from tblTrans where name = '김말숙';

select * from tblTrans;

commit; -- 이전까지 작업을 책임지고 승인 > 이전 작업은 되돌리지 않겠다.(***)

select * from tblTrans;




