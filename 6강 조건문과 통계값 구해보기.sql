--예제33 NULL값 대신 다른 데이터 출력하기(NVL,NVL2)
--이름과 월급과 커미션을 출력하는데 커미션이 null인 사원들은 값을 0으로 출력하세요
select ename,sal,nvl(comm,0) -- nvl(컬럼명,null대신 넣을 값)
from emp;                     --nvl2(컬럼명,지정값1,지정값2) null이 아닌경우 지정값1을, null인경우 지정값2 출

--예제33 이름과 커미션을 출력하는데 커미션이 null인 사원들은 no comm이라는 글씨로 출력되게 하세요
select ename,nvl(to_char(comm),'no comm')-- 기존데이터와 치환할 데이터형이 다른경우 에러발생
from emp;         --숫자형을 문자형으로 변환해 데이터 형을 맞춰줌

--예제34 IF문을 SQL로 구현하기 1(DECODE) =비교일떄 사용 
--이름 부서번호 보너스를 출력하는데 보너스가 부서번호가 10번이면 300, 20이면 400 나머지는 0으로 출력하세요

select ename,deptno,decode(deptno,10,300, --10이면 300
                                  20,400, -- 20이면 400
                                     0) as 보너스 -- 둘다 아니면 0
from emp;

--이름,직업,보너스를 출력하는데 직업이SALESMAN이면 6000, ANALYST면 3000,MANAGER면 2000 나머지는 0으로 출력하세요

select ename,job,decode(job,'SALESMAN',6000,'ANALYST',3000,
                            'MANAGER',2000,0) as 보너스
from emp;

--예제35 IF문을 SQL로 구현하기 (CASE) <,>,= 비교일떄 사용 
--직업이 SALESMAN,ANALYST인 사원들의 이름 직업 보너스 출력, 월급이 3000이상이면 보너스 500, 2000이상이면 300, 1000이상이면 200 나머지는 0으로 출력하세요

select ename,job,sal ,case when sal >= 3000 then 500
                          when sal >= 2000 then 300
                          when sal >= 1000 then 200 else 0 end as 보너스
from emp
where job in ('SALESMAN','ANALYST');

--이름 월급 보너스 출력하는데 월급이 3000이상이면 9000, 2000이상이면 8000,나머지는 0으로 ㅜㄹ력하세요

select ename,sal, case when sal >= 3000 then 9000
                       when sal >= 2000 then 8000 else 0 end as 보너스
from emp;

--그룹함수
--예제36 최대값 출력하기(MAX)
--사원테이블에서 최대 월급을 출력하세요

select max(sal)
from emp;

--문제1 직업이 SALESMAN인 사원들중 최대월급을 출력하세요

select max(sal)
from emp
where job = 'SALESMAN';

--문제2 직업이 SALESMAN인 사원중 최대월급을 출력하는데, 아래와 같이 직업도 출력하세요

select job, max(sal) 
from emp
where job = 'SALESMAN'
group by job; -- 그룹핑하지않으면 job은 여러개 출력,max는 단일행 출력이라 안맞음

--예제37 최소값 출력하기(MIN)

select min(sal)
from emp
where job = 'SALESMAN';

--문제1 부서번호가 20번인 사원들중 최소월급을 출력하세요
select deptno, min(sal)
from emp
where deptno = 20
group by deptno;
--문제2 부서번호와 부서번호별 최소월급을 출력하세요

select deptno,min(sal)
from emp
group by deptno;

--예제38 평균값 출력하기(AVG)
--사원 테이블에서 평균 월급을 출력하세요

select avg(sal)
from emp;

--예제38 문제1 직업과 직업별 평균월급을 출력하는데 직업별 평균월급이 높은것부터 출력하세요

select job , avg(sal) as 평균
from emp
group by job
order by 평균 desc;-- 실행순서가 from group select order순이기 때문에 평균이라고 써도 출력 

--예제38 문제2 부서번호,부서번호별 평균월급을 출력하는데 부서번호별 평균월급을 출력할 때에 천단위 표시를 하시오 

select deptno,to_char(avg(sal),'999,999') as 평균월급
from emp
group by deptno;

--예제39 토탈값 출력하기(SUM)
--부서번호,부서번호별 토탈월급을 출력하세요

select deptno,sum(sal)
from emp
group by deptno;

--예제39 문제1 1981년도에 입사한 사원들의 월급의 토탈값을 출력하세요

select sum(sal)
from emp
where to_char(hiredate,'YYYY') = 1981;

--예제39 문제2 직업과 직업별 토탈월급을 출력하는데 직업별 토탈월급이 6000이상인것만 출력하세요

select job, sum(sal)
from emp
group by job
having sum(sal) >= 6000; --group 함수로 검색조건을 줄떄는 where가 아닌 having에 작성

--select 컬럼명 5
--from 테이블명 1
--where 검색조건 2
--group by 그룹핑할 컬럼명 3
--having 그룹함수로 검색조건 4
--order by 정렬할 컬럼 6

--예제40 건수 출력하기(COUNT)
--사원테이블의 전체 인원수가 몇명인지 출력하세요

select count(*)
from emp;

--그룹함수는 null값을 무시하고 출력함
select avg(comm) -- null값 제외하고 4로 나눈 값 
from emp;

--예제40 문제1 부서번호,부서번호별 인원수를 출력하세요

select deptno,count(*)
from emp
group by deptno;

--직업과 직업별 인원수를 출력하는데 직업이 SALESMAN은 제외하고 출력하고 직업별 인원수가 3명 이상인것만 출력하세요

select job,count(*)
from emp
group by job
having job <> 'SALESMAN' and count(*) >= 3;
--위처럼 검색조건인 job <> 'SALESMAN'은 where절에 쓰는게 더 효율적

select job,count(*)
from emp
where job != 'SALESMAN'
group by job
having count(*) >= 3;