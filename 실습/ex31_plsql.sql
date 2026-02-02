-- ex31.plsql.sql
/*
    PL/SQL
    - Oracle's procedural Language extension to SQL
    - 기존의 ANSI-SQL + 절차 지향 언어 기능 추가(변수, 제어문 등)
    - A 업무 > 자바 구현 or PL/SQL 구현
    
    프로시저, Procedure
    - 메서드, 함수 등...
    - 순서가 있는 명령어들의 집합(***)
    
    1. 익명 프로시저
        - 1회용 코드 작성
        
    2. 실명 프로시저
        - 저장 > 재사용
        - 데이터베이스 객체(DB Object)

    PL/SQL 프로시저 구조

    1. 4개의 블럭으로 구성
        - DECLARE
        - BEGIN
        - EXCEPTION
        - END

    2. DECLARE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능

    3. BEGIN ~ END
        - 구현부(메서드의 {} 역할)
        - 구현된 코드를 작성하는 영역
        - 생략 불가능
        - 구현된 코드? ANSI-SQL + PL/SQL
        - try절 역할

    4. EXCEPTION
        - 예외처리부
        - catch절 역할
        - 생략 가능

    DECLARE
        변수 선언;
        객체 선언;
    BEGIN
        업무 코드(ANSI-SQL);
        업무 코드(PL/SQL);
    EXCEPTION
        예외 처리;
    END;


    1. 자료형
    - ANSI-SQL 동일

    2. 변수 선언하기
    - 변수명 자료형(길이) [NOT NULL] [DEFAULT 값];
    - 컬럼 선언과 유사

    자바 + 오라클 = ANSI-SQL만 사용(MyBatis, JPA기술)
    자바 + MySQL = ANSI-SQL만 사용

    PL/SQL(안쓰는방향으로 가고있음)
    1. 익명 프로시저
    2. 실명 프로시저
        a. 프로시저
        b. 함수
    3. 트리거
    4. 인데스
    


*/

-- ANSI-SQL 영역
select * from dual;

-- dbms_output.put_line 특징 > 옵션
set serveroutput on; -- 현재 세션(session - 접속 중)에만 유효
set serverout on;

-- PL-SQL 영역 > 프로시저 영역내에서만 실행 가능
begin
    dbms_output.put_line('안녕하세요.');
end;
/

declare
    -- 변수명 자료형(길이) [NOT NULL] [DEFAULT 값];
    num number;
    name varchar2(30);
    today date;
begin
    -- PL/SQL의 대입 연산자
    num := 10;
    name := '홍길동';
    today := to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss');
    dbms_output.put_line(num);
    DBMS_OUTPUT.PUT_LINE(name);
    DBMS_OUTPUT.PUT_LINE(today);
end;
/

declare
    num1 number;
    num2 number;
    num3 number := 30;
    num4 number default 40;
    num5 number not null := 50;
begin
    num1 := 10;
    DBMS_OUTPUT.PUT_LINE(num1);

    -- 초기화 안한 변수를 바로 출력
    DBMS_OUTPUT.PUT_LINE(num2);
    DBMS_OUTPUT.PUT_LINE(num3);
    DBMS_OUTPUT.PUT_LINE(num4);
    DBMS_OUTPUT.PUT_LINE('num5: ' || num5);
    num3 := null;
    DBMS_OUTPUT.PUT_LINE('num3: '|| num3);

end;
/

/*
    변수 > 어떤 용도로 사용?
    - 일반적인 값을 저장하는 용도
    - select 결과를 저장하는 용도(***)

*/
declare
    vbuseo varchar2(15);
begin
    
    -- ORA-06550: 줄 4, 열5:PLS-00428: 해당 SELECT 문에 INTO 절이 필요합니다.
    -- ANSI-SQL(select문)
    -- ANSI-SQL의 select 문의 결과셋을 PL/SQL에게 전달할 수 없다.
    select buseo into vbuseo from tblInsa where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;
/

-- tblInsa > 성과급 받는 직원
create table tblBonus(
    name varchar2(15)
);

-- 1. 개발부 + 부장 > select name ?
-- 2. tblBonus + insert
select name from tblInsa where BUSEO = '개발부' and JIKWI = '부장';
insert into tblBonus(name) values ((select name from tblInsa where BUSEO = '개발부' and JIKWI = '부장'));
select * from TBLBONUS;

declare
    vname varchar2(15);
begin
    --1.
    select name into vname from TBLINSA where buseo = '총무부' and JIKWI = '부장';
    DBMS_OUTPUT.PUT_LINE(vname);
    --2.
    insert into TBLBONUS (name) values (vname);
end;
/
select * from TBLBONUS;

-- select into절
-- : select의 결과셋이 1줄일때
-- : select의 결과셋이 n줄일때(skip) > 커서

-- 1. 원자값(단일 컬럼)
-- 2.

declare
--     vname varchar2(15);
--     vbuseo varchar2(15);
--     vjikwi varchar2(15);
--     vbasicpay number;
    vname tblInsa.NAME%type;
    vbuseo tblInsa.BUSEO%type;
    vjikwi tblInsa.JIKWI%type;
    vbasicpay tblInsa.BASICPAY%type;
begin
    select
        name, buseo, jikwi, BASICPAY
    into vname, vbuseo, vjikwi, vbasicpay
    from TBLINSA
        where name = '홍길동';

    -- select into 주의점
    -- 1. 컬럼의 개수와 변수의 개수 일치
    -- 2. 컬럼의 순서와 변수의 순서 일치
    -- 3. 컬럼과 변수의 자료형(길이) 일치

    DBMS_OUTPUT.PUT_LINE(vname);
    DBMS_OUTPUT.PUT_LINE(vbuseo);
    DBMS_OUTPUT.PUT_LINE(vjikwi);
    DBMS_OUTPUT.PUT_LINE(vbasicpay);
end;
/
/*
    타입 참조
    - 사용하는 테이블의 특정 컬럼의 자료형+길이를 알아내서 변수에 적용
    - 적용 되는 정보
        1. 자료형
        2. 길이
*/

declare
    vbuseo tblInsa.buseo%type;
begin
    select buseo into vbuseo from TBLINSA where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;
/


declare
    --vnum tblInsa.num%type;
    --vbuseo tblInsa.buseo%type;
    -- 레코드를 담을 수 있는 변수
    vrow tblInsa%rowtype;
begin
    --select num, name, buseo, JIKWI, IBSADATE, city, ssn, tel, BASICPAY, SUDANG from TBLINSA where name = '홍길동';
    select * into vrow from TBLINSA where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vrow.name);
end;
/

declare
    vnum number := 10;
begin
    -- basic 문법
    if vnum > 0 then
        DBMS_OUTPUT.PUT_LINE('양수');
    end if;
    
    vnum := -10;
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    else 
        dbms_output.put_line('양수 아님');
    end if;
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then -- else if, elsif, elseif 등..
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('영');
    end if;
end;
/

drop table tblBonus;


create table tblBonus(
    seq number primary key,                             -- 번호(PK)
    num number not null references tblInsa(num),        -- 직원번호(FK)
    bonus number not null                               -- 성과금
);

/*
    제어문
    1. 조건문
        - if
        - case
    2. 반복문
        - loop(단순 반복)
        - for loop(횟수 반복 - 자바 for)
        - while loop(조건 반복 - 자바 while)
    3. 분기문

*/



-- 직원 1명 선택(num) > 보너스 지급
-- 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 사원/대리 > basicpay * 2

declare
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
    vjikwi      tblInsa.jikwi%type;
    vbonus      tblBonus.bonus%type;
begin
    -- 1.
    select num, basicpay, jikwi into vnum, vbasicpay, vjikwi
    from tblinsa
        where num = 1001;
        
    -- 2.
    if(vjikwi = '과장' or vjikwi = '부장') then
        vbonus := vbasicpay * 1.5;
    elsif(vjikwi in('사원', '대리')) then 
        vbonus := vbasicpay * 2;
    end if;

    insert into tblBonus (seq, num, bonus)
        values((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);
end;
/

select * from tblbonus b
    inner join tblinsa i
        on i.num = b.num;

-- 반복문
begin
    loop
        dbms_output.put_line('구현부');
    end loop;
end;
/

DECLARE
    vnum number := 1; -- 루프 변수 역할
begin
    loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
        
        exit when vnum>10;
    end loop;
end;
/

-- for loop
begin
    
    -- IntStream.range(1,10);
    -- 향상된 for문 역할
    for i in 1..15 loop -- for i in reverse 1..15 loop
        dbms_output.put_line(i);
    end loop;
end;
/

-- while loop
declare
    vnum number := 1;
begin
    while vnum <=10 loop
        dbms_output.put_line(vnum);
        vnum := vnum+1;
    end loop;
end;
/

-- 함수(input > output)
-- public in sum(int a, int b)
create or replace function fnSum(
    a number, 
    b number) 
return number
is
    -- 변수 선언
begin
    return a + b;
end fnSum;
/


select 10, 20, fnSum(10,20) from dual;


-- 1. 성별 > 자주하는 업무
-- 2. 성별 > 다른 팀원들도 하는 업무
select 
    name, ssn, basicpay,
    case
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'
    end as gender 
from tblInsa; 

create or replace function fnGender(
    ssn varchar2
) return varchar2
is
begin
    if substr(ssn, 8, 1) = '1' then 
        return '남자';
    elsif substr(ssn, 8, 1) = '2' then
        return '여자';
    else
        return null;
    end if;
end fnGender;
/

select 
    name, ssn, basicpay, fnGender(ssn) as gender,
    fnBonus(jikwi, basicpay, sudang) as bonus
from tblInsa;

create or replace function fnBonus(
    jikwi varchar2,
    basicpay number,
    sudang number
) return number
is 
begin
    if jikwi in('과장', '부장') then 
        return (basicpay + sudang) * 1.5;
    elsif jikwi in('사원', '대리') then
        return (basicpay + sudang) * 2;
    else
        return null;
    end if;
end fnBonus;
/



/*
    트리거, Trigger
    - 선언 > 호출(사용): X (메서드, 함수 등)
    - 선언 > 감시(대기) 상태 > 이벤트 발생 > 호출(사용): O 
    
    - 트리거 선언(누구(테이블)를 감시(insert/update/delete)해라!! + 명령)
        > 이벤트 발생 > 트리거 자동 실행
        
    - 트리거 호출 
        - 개발자 X
        - 오라클 시스템 O
        
    트리거 구문
    
    create or replace trigger 트리거명
        before|after
        insert|update|delete
        on 테이블명
        [for each row]
    declare 
        선언부;
    begin 
        구현부;
    end;
    
    for each row 유무
    
    1. 무
        - 문장 단위 트리거
        - Table Level Trigger
        - 테이블에서 발생한 사건 자체가 중요한 경우
        
    2. 유
        - 행(Record) 단위 트리거
        - 그 발생 사건이 어떤 레코드에서 적용되었는지 중요한 경우
        
*/

-- tblInsa > 직원 삭제(퇴사)
-- 월요일 > 퇴사 불가능

select * from tblBonus;
drop table tblBonus;
delete from tblInsa where num = 1001;

commit;
rollback;
select * from tblInsa;

create or replace trigger trgInsa
    before
    delete
    on tblInsa
begin
    dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss') || '트리거가 실행되었습니다.');
    
    -- 월요일 퇴사 불가능 
    if to_char(sysdate, 'dy') = '월' then
        -- 강제로 에러 발생
        -- throw new Exception() // 예외 던지기
        
        -- -20000 ~ 29999
        raise_application_error(-20001, '월요일에 퇴사 불가능');
    end if;
end trgInsa;
/
-- 트리거 상태
select trigger_name, status from user_triggers;
-- 트리거 중지(CCTV 전원 off)
alter trigger trgInsa disable;
-- 트리거 시작(CCTV 전원 on)
alter trigger trgInsa enable;

-- 로그 트리거 
-- tblDiary > 트리거 > 사건 > 로그 
select * from tblDiary; 

create table tblLogDiary (
    seq number primary key,
    message varchar2(500) not null,
    regdate date default sysdate not null
);  
create sequence seqLogDiary;

-- tblDiary > 사건 > tblLogDiary 기록
create or replace trigger trgDiary
    after 
    insert or update or delete
    on tblDiary
declare
    vmessage tblLogDiary.message%type;
begin
    if inserting then
        dbms_output.put_line('trgDiary 호출됨 - insert');
        vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
        dbms_output.put_line('trgDiary 호출됨 - update');
        vmessage := '기존 항목이 수정되었습니다.';
    elsif deleting then
        dbms_output.put_line('trgDiary 호출됨 - delete');
        vmessage := '기존 항목이 삭제되었습니다.';
    end if;
    
    insert into tblLogDiary values (seqLogDiary.nextVal, vmessage, default);
    
end trgDiary;
/

insert into tblDiary values(11, '배불러요.', '추움', sysdate);

update tblDiary set subject = '너무 배불러요' where seq = 11;

delete from tblDiary where seq = 11;

select * from tblLogDiary;  -- 통계 or 차트 



select * from tblDiary;

create or replace trigger trgDiary
    after
    delete
    on tblDiary
    --for each row
declare
begin
    -- :old, :new > 의사 레코드, 상관 변수
    dbms_output.put_line('레코드가 삭제되었습니다.');
    
end trgDiary;
/

insert into tblDiary values(11, '배불러요.', '추움', sysdate);

update tblDiary set subject = '너무 배불러요' where seq = 11;

delete from tblDiary where seq = 11;
rollback;



select * from tblMen;

create or replace trigger trgMen
    before
    -- update
    -- insert
    delete
    on tblMen
    for each row -- :old, :new 사용하겠다.
declare

begin
    dbms_output.put_line('--------------------------------');
    dbms_output.put_line('수정 전 나이: ' || :old.age);
    dbms_output.put_line('수정 후 나이: ' || :new.age);
    dbms_output.put_line('전 여친: ' || :old.couple);
    dbms_output.put_line('현 여친: ' || :new.couple);
    dbms_output.put_line('--------------------------------');
end trgMen;
/

update tblMen set age = age + 1 where name = '홍길동';

update tblMen set couple = '홍현희' where name = '홍길동';
select * from tblMen;

insert into tblMen values('강아지', 3, 30, 10, null);

delete from tblMen where name = '강아지';


-- 회원 테이블, 게시판 테이블
-- : 포인트 정책
-- 1. 글 작성 > 포인트 + 100
-- 2. 글 삭제 > 포인트 - 50

drop table tblUser;
select * from tblUser;

SELECT fk.owner, fk.constraint_name , fk.table_name 
        FROM all_constraints fk, all_constraints pk 
        WHERE fk.r_constraint_name = pk.constraint_name 
                   AND fk.constraint_type = 'R' 
                   AND pk.table_name = UPPER('tblUser')
        ORDER BY fk.table_name;
drop table tblBoard;
drop table tbluserdetails;

drop table tblUser;
create table tblUser(
    id varchar2(30) primary key,
    point number not null
);

create table tblBoard(
    seq number not null,
    subject varchar2(2000) not null,
    id varchar2(30) not null references tblUser(id)
);
select * from tblBoard;


-- 1. 글을 쓴다.(삭제한다.)
-- 2. 포인트를 더한다.(뺀다.)

-- CASE 1. 직접 제어
-- 1.1 글쓰기
insert into tblUser values('hong', 0);
insert into tblBoard values(1, '안녕하세요.', 'hong');

-- 1.2 포인트 누적
update tblUser set point = point +100 where id ='hong';

-- 1.3 글 삭제
delete from tblBoard where seq = 1;

-- 1.4 포인트 차감
update tblUser set point = point - 50 where id = 'hong';

select * from tblBoard;
select * from tblUser;

-- CASE 2. 트리거
create or replace trigger trgBoard
    after
    insert or delete
    on tblBoard
    for each row
begin
    if inserting then
        update tblUser set point = point + 100 where id = :new.id;
    elsif deleting then
        update tblUser set point = point - 50 where id = :old.id;
    end if;
end trgBoard;
/

-- 장단점 견해 차이
-- 1. 본 업무에 집중할 수 있는 환경을 만들어 준다. (게시판 업무 집중, 포인트 업무 X)
-- 2. 본 업무 이외의 사건을 알 수가 없다. (포인트 증감이 발생하는지 알 수 없다.)

insert into tblBoard values (2, '게시판입니다.', 'hong');
delete from tblBoard where seq = 2;

select trigger_name, status from user_triggers;
alter trigger trgBoard disable;


/*
    인덱스, Index
    - 검색을 빠른 속도로 하기 위해 사용하는 도구
    
    데이터베이스의 데이터 검색 방식
    - 어떤 데이터를 검색 > 처음 ~ 끝까지 차례대로 검색 > table full scan
    - 검색을 위한 특정 컬럼 > 별도의 테이블 복사 > 정렬 >> 인덱스(색인)
*/



select * from tblInsa where name = '엄용수';

select count(*) from tblAddressBook;

create table tblIndex
as 
select * from tblAddressBook;

select count(*) from tblIndex; -- 16,384,000

insert into tblIndex select * from tblIndex;

set timing on;
-- 인데스 없이 검색 > 경과 시간: 00:00:07
select count(*) from tblIndex where name = '최민기';

-- 인덱스 생성 > 경과 시간 : 00:00:22
create index idxName on tblIndex(name);

-- 인덱스 사용해서 검색 > 경과 시간 : 00:00:00.22
-- 힌트(Hint) > 오라클에서 보조 명령
select /*+ index(tblIndex idxName) */ count(*) from tblIndex where name = '최민기';

-- 단일 인덱스(컬럼 1개)
create index idxHometown on tblIndex(hometown);
select /*+ index(tblIndex idxHometown) */ count(*) from tblIndex where hometown = '서울';

-- 복합 인덱스(컬럼 2개 이상)
create index idxHometownJob on tblIndex(hometown, job);
select /*+ index(tblIndex idxHometownJob) */ count(*) from tblIndex where hometown = '서울' and job = '학생';

-- 함수 기반 인덱스(가공)
create index idxEmail on tblIndex(substr(email, instr(email, '@')));
select /*+ index(tblIndex idxEmail) */
    count(*) from tblIndex where substr(email, instr(email, '@')) = '@naver.com';


-- 인덱스를 걸지 않아도 자동으로 걸리는 경우
-- 1. PK
-- 2. Unique 
select * from tblInsa where num = 1010;

select * from tblAddressBook where seq = 1900; -- 경과 시간: 00:00:00.053
select * from tblAddressBook where name = '박신영'; -- 경과 시간: 00:00:00.009

/*
    인덱스를 사용해야 하는 상황
    1. 레이블에 레코드가 많을 때
    2. where절에서 사용하는 횟수가 많은 컬럼에 적용(*****)
    3. 인덱스 손익분기점 > 검색 결과가 원본 테이블의 10~15% 이하인 경우
    
    인덱스를 사용하지 말아야 하는 상황
    1. 레이블에 레코드가 적을 때(풀 스캔과 차이 거의 없음)
    2. 인덱스 손익분기점 > 검색 결과가 원본 테이블의 10~15% 이상인 경우
    3. 해당 테이블이 삽입, 수정, 삭제가 빈번할 경우(******************)
    
    프로젝트 마지막 > 부하가 걸리는 검색 작업 선별 > 인덱스 생성 + 시간차 테스트 
*/
drop index idxName;