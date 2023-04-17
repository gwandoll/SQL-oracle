--예제67 집합연사자로 데이터를 위아래로 연결하기 (UNION ALL)
--부서번호와 부서번호별 토탈월급을 출력하는데 다음과 같이 맨 아래에 전체 토탈 월급도 출력하세요

select deptno , sum(sal)
from emp
group by deptno
union all
select to_number(null)as deptno,sum(sal) -- 위 쿼리와 아래쿼리의 컬럼개수가 똑같아야하고 
from emp                                --위와 아래의 데이터 타입이 맞아야 효율적
order by deptno;                          --order by는 아래쿼리에 작성

--예제67 문제1 직업과 직업별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급도 출력하세요

select job, sum(sal)
from emp
group by job
union ALL
select to_char(null) as job, sum(sal)
from emp
order by job asc;

--예제68 집합연산자로 데이터를 위아래로 연결하기 (UNION)
--부서번호와 부서번호별 토탈월급을 출력하고 다음과 같이 맨 아래에 전체 토탈월급도 출력하는데 부서번호가 오름차순으로 정렬되어서 출력되게 하세요

select deptno , sum(sal)
from emp
group by deptno
union  -- all과 다르게 중복제거, 정렬해서 보여준다 
select to_number(null)as deptno,sum(sal) 
from emp;

--예제68 문제1  직업 직업별 토탈월급을 출력하는데 직업이 abcd 순으로 정렬되어서 출력하고 맨 아래에 전테 토탈월급을 출력하세요

select job,sum(sal)
from emp
group by job
union
select to_char(null), sum(sal)
from emp;

--다음과 같이 입사한 년도, 입사한 년도별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급이 출력되게 하세요(입사한 년도는 정렬되게)

select to_char(hiredate,'RRRR')as 년도 , sum(to_char(hiredate,'RRRR')) as 토탈월급 
from emp
group by to_char(hiredate,'RRRR')
union
select to_char(null),sum(sal) as 토탈월급 
from emp;

--예제69 집합 연산자로 데이터의 교집합 출력하기 (INTERSECT)

select ename,sal,job,deptno
from emp
where deptno in (10,20)
intersect
select ename,sal,job,deptno
from emp
where deptno in (20,30);

--예제69 문제1 사원테이블과 부서테이블과의 공통된 부서번호가 무엇인지 출력하세요 

select deptno
from emp
intersect
select deptno
from dept;

--예제70 집합 연산자로데이터의 차이를 출력하기 (MINUS) --차집합

select ename,sal,job,deptno
from emp
where deptno in (10,20)
minus
select ename,sal,job,deptno
from emp
where deptno in (20,30);

--예제70 문제1 부서테이블에는 존재하는데 사원테이블에는 존재하지 않는 부서번호는 ?

select deptno
from dept
minus
select deptno
from emp;

--예제71 서브 쿼리사용하기 (단일행 서브쿼리)
--JONES보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력하세요

select ename, sal -- 메인쿼리 
from emp
where sal >( select sal  -- 가로안 쿼리가 서브쿼리 
            from emp
            where ename = 'JONES');
            
--예제71 문제1 ALLEN보다 더 늦게 입사한 사원들의 이름과 월급을 출력하세요

select ename, sal
from emp
where hiredate > (select hiredate from emp where ename = 'ALLEN');

--예제72 서브쿼리 사용하기 (다중행 서브쿼리)
--직업이 SALESMAN인 사원들과 같은 월급을 받는 사원들의 이름과 월급을 출력하시오

select ename,sal
from emp
where sal in ( select sal -- 지금처럼 서브쿼리에서 여러값이 리턴되는게 다중행 서브쿼리: in, not in , >all ,>any
                from emp
                where job = 'SALESMAN');
            
--예제72 문제1 부서번호가 20번인 사원들과 같은 직업을 갖는 사원들의 이름과 직업을 출력하세요

select ename,job
from emp
where job in (select job from emp where deptno = 20);

