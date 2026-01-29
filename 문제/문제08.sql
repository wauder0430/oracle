-- ### join ###################################


-- 1. tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.
select * from tblStaff;
select * from tblProject;

select a.name, a.address, a.salary, b.project from tblStaff a left outer join tblProject b on a.seq = b.staff_seq;
-- 2. tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select 
    m.name 
from tblMember m
    inner join tblRent r on m.seq = r.member
        inner join tblVideo v on r.video = v.seq 
where v.name = '뽀뽀할까요';
-- 3. tblStaff, tblProejct. 'TV 광고'을 담당한 직원의 월급은 얼마인가?
select * from tblStaff;
select * from tblProject;

select salary 
from tblStaff s 
    inner join tblProject p on s.seq = p.staff_seq
where p.project = 'TV 광고';
-- 4. tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?
select m.name 
from tblMember m 
    inner join tblRent r on m.seq = r.member
        inner join tblVideo v on r.video = v.seq
where v.name = '털미네이터';
-- 5. tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
select * from tblStaff;
select * from tblProject;
    
select name, salary, project
from tblStaff s 
    inner join tblProject p on s.seq = p.staff_seq
where address <> '서울시';
-- 6. tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
select * from tblCustomer;
select * from tblSales;

select s.cseq
from tblCustomer c
    inner join tblSales s on c.seq = s.cseq
group by s.cseq
    having count(s.cseq) >= 2;

select c2.tel, c2.name, s2.item
from tblCustomer c2
    inner join tblSales s2 on c2.seq = s2.cseq
where s2.seq in (select s.cseq
from tblCustomer c
    inner join tblSales s on c.seq = s.cseq
group by s.cseq
    having count(s.cseq) >= 2);


                
select * from TBLGENRE;
-- 7. tblVideo, tblRent, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
select
    v.name, v.QTY, g.price
from TBLVIDEO v
    inner join TBLRENT r on v.SEQ = r.VIDEO
        inner join tblGenre g on g.SEQ = v.GENRE;

  
-- 8. tblVideo, tblRent, tblMember, tblGenre. 2007년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
select
    m.name, v.name, r.RENTDATE, g.PRICE
from TBLVIDEO v
    inner join TBLRENT r on v.SEQ = r.VIDEO
        inner join tblGenre g on g.SEQ = v.GENRE
            inner join tblMember m on m.seq = r.member
where to_char(r.RENTDATE, 'yyyy-mm') like '2007-02%'

-- 9. tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
select
    m.name, v.name, r.RENTDATE
from TBLVIDEO v
    inner join tblRent r on v.seq = r.VIDEO
        inner join tblmember m on m.SEQ = r.MEMBER
where r.retdate is null;
    
-- 10. employees, departments. 사원들의 이름, 부서번호, 부서명을 가져오시오.
select
    e.FIRST_NAME||e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from EMPLOYEES e
    inner join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 11. employees, jobs. 사원들의 정보와 직업명을 가져오시오.
select e.*, j.JOB_TITLE
from EMPLOYEES e
    inner join jobs j on e.JOB_ID = j.JOB_ID;
        
-- 12. employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.
select * from EMPLOYEES;
select * from JOBS;

SELECT e.*
FROM EMPLOYEES e
    INNER JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE e.SALARY in (
    SELECT MAX(SALARY)
    FROM EMPLOYEES
    group by job_id
);
-- 13. departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.
select * from DEPARTMENTS;
select * from LOCATIONS;

select d.DEPARTMENT_NAME, l.CITY
from DEPARTMENTS d
    inner join locations l on d.LOCATION_ID = l.LOCATION_ID;
-- 14. locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.
select * from LOCATIONS;
select * from COUNTRIES;

select c.COUNTRY_NAME
from COUNTRIES c
    inner join locations l on c.COUNTRY_ID = l.COUNTRY_ID
where l.LOCATION_ID = 2900;
            
-- 15. employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.
select * from EMPLOYEES;

select FIRST_NAME||LAST_NAME as name, SALARY, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES
where SALARY >= 12000);
-- 16. employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 가져오시오.
select * from EMPLOYEES;
select * from DEPARTMENTS;
select * from LOCATIONS;

select
    e.FIRST_NAME||e.LAST_NAME as 이름, e.DEPARTMENT_ID as 부서번호, d.DEPARTMENT_NAME as 부서이름
from EMPLOYEES e
    inner join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
        inner join locations l on l.LOCATION_ID = d. LOCATION_ID
where l.city = 'Seattle';
    
-- 17. employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.
select e.*
from EMPLOYEES e
    inner join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where d.DEPARTMENT_ID = (select DEPARTMENT_ID from EMPLOYEES where FIRST_NAME = 'Jonathon');
    
-- 18. employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.
select e.FIRST_NAME||e.LAST_NAME as 사원이름, d.DEPARTMENT_NAME as 부서명, e.SALARY as 월급
from EMPLOYEES e
    inner join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where e.SALARY>= 3000;

            
-- 19. employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.
select d.DEPARTMENT_ID, d.DEPARTMENT_NAME, e.FIRST_NAME||e.LAST_NAME as name, e.SALARY
from EMPLOYEES e
    inner join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where e.DEPARTMENT_ID = 10;

-- 20. departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.
select * from DEPARTMENTS;
select * from JOB_HISTORY;

select START_DATE as 입사일, END_DATE as 퇴사일, d.DEPARTMENT_NAME as 근무부서
from DEPARTMENTS d
    inner join JOB_HISTORY j on d.DEPARTMENT_ID = j.DEPARTMENT_ID;
-- 21. employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.
select * from EMPLOYEES;

select a.EMPLOYEE_ID, a.FIRST_NAME||a.LAST_NAME as name, a.MANAGER_ID as 관리자, b.FIRST_NAME||b.LAST_NAME as 관리자이름
from EMPLOYEES a
    inner join (select * from EMPLOYEES) b on a.MANAGER_ID = b.EMPLOYEE_ID;

-- 22. employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.
select * from EMPLOYEES;
select * from jobs;

select FIRST_NAME||LAST_NAME as name, to_char(e.HIRE_DATE, 'yyyy') as 입사년도
from EMPLOYEES e
    inner join JOBS j on e.JOB_ID = j.JOB_ID
where j.JOB_TITLE = 'Sales Manager';

select to_char(e.hire_date, 'yyyy')as 입사년도, avg(SALARY) as 년도별평균급여
from EMPLOYEES e
    inner join JOBS j on e.JOB_ID = j.JOB_ID
where j.JOB_TITLE = 'Sales Manager'
group by to_char(e.hire_date, 'yyyy')
order by to_char(e.HIRE_DATE, 'yyyy') asc;

-- 23. employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 단, 도시에 근 무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.
select
     l.city as 도시명, avg(e.SALARY) as 평균급여, count(l.city) as 해당도시사원수
from EMPLOYEES e
    inner join DEPARTMENTS d
        on e.DEPARTMENT_ID = d.DEPARTMENT_ID
    inner join locations l
        on l.LOCATION_ID = d.LOCATION_ID
group by l.CITY
having count(l.CITY) < 10
order by 평균급여 asc;

-- 24. employees, jobs, job_history. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오. 현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것.
select * from EMPLOYEES;
select * from JOBS;
select * from JOB_HISTORY;

select
    e.FIRST_NAME||e.LAST_NAME as 사원이름, e.EMPLOYEE_ID as 사번
from JOB_HISTORY h
    inner join JOBS j on h.JOB_ID = j.JOB_ID
        inner join EMPLOYEES e on e.JOB_ID = j.JOB_ID
where  j.JOB_TITLE = 'Public Accountant';


    
-- 25. employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져오시오.
    
    
-- 26. employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.

