--조인문법: 1. 오라클 조인문법: equi ,non equi, outer , self 
--        2. 1999 ansi조인문법 ( 미국 국립표준 협회) : on절, USING절

--예제62 여러 테이블의 데이터를 조인해서 출력하기 (ON절)
--on절을 사용한 조인문법으로 다음의 결과를 출력하세요 

select e.ename,e.sal,e.job,d.loc
from emp e, dept d
where e.deptno = d.deptno;

--ON절  from ,대신 join where 대신 on
select e.ename,e.sal,e.job , d.loc
from emp e join dept d
on ( e.deptno = d.deptno) -- 조인조건 
where e.job = 'SALESMAN'; -- 검색조건

--월급이 1000에서 3000사이인 사원들의 이름과 월급과 부서위치를 on절을 사용한 조인문법으로 출력하세요

select e.ename, e.sal, d. loc
from emp e join dept d
on ( e.deptno = d.deptno)  -- 조인조건 
where sal between 1000 and 3000; -- 검색조건 

--여러 테이블의 데이터를 조인해서 출력하기 (USING절)

select e.ename , e.job, e.sal,d.loc
from emp e join dept d
using ( deptno) -- 테이블 별칭 사용 X 
where e.job = 'SALESMAN';\

--USING절을 사용한 조인문법으로 부서위치가 DALLAS인 사원들의 이름과 월급과 부서위치를 출력하세요 

select e.ename, e.sal, d.loc
from emp e join dept d
using (deptno) -- 조인조건 
where d.loc = 'DALLAS'; -- 검색조건 

--예제64 여러테이블의 데이터를 조인해서 출력하기 (NATURAL JOIN) 

select e.ename as 이름 ,e.job as 직업,e.sal as 월급 ,d.loc as 부서위치
from emp e natural join dept d
where e.job = 'SALESMAN';

--예제64 문제1 직업이 SALESMAN이고 부서법호가 30번인 사원들의 이름과 직업과 월급과 부서위치를 출력하세요

select e.ename, e.job , e.sal, d.loc
from emp e natural join dept d
where deptno = 30 and e.job = 'SALESMAN'; -- using과 마찬가지로 공통 컬럼은 테이블 별칭 사용 x

--예제65 여러테이블의 데이터를 조인해서 출력하기 (LEFT / RIGHT OUTER JOIN)

select e.ename, e.job , e.sal , d.loc
from emp e , dept d
where e.deptno (+) = d.deptno;

--ansi조인

select e.ename, e.job, e.sal , d.loc
from emp e right outer join dept d -- equi 조인과 반대쪽
on ( e.deptno = d.deptno);

--1999 ansi조인문법을 이용하여 이름,직업 월급 부서위치를 출력하는데 사원테이블에 jack도 출력되게 하세요

select e.ename, e.job , e.sal , d. loc
from emp e left outer join dept d
on ( e.deptno = d.deptno);

--오라클 조인

select e.ename, e.job , e.sal , d. loc
from emp e , dept d
where e.deptno = d.deptno (+);

-- 여러 테이블의 데이터를 조인해서 출력하기 (FULL OUTER JOIN) -- ansi조인 문법에만 존재
--JACK도 출력되고 BOSTON도 출력되게 하세요

select e.ename , e.job , e.sal , d.loc
from emp e full outer join dept d
on ( e.deptno = d.deptno);

--예제66 문제1 직업이 ANALYST이거나 부서위치가 BOSTON인 사원들의 이름과 직업과 월급과 부서위치를 출력하는데 full outer 조인을 사용하여 출력하세요

select e.ename,e.job,e.sal,d.loc
from emp e full outer join dept d
on ( e.deptno = d.deptno)
where e.job = 'ANALYST' or d.loc= 'BOSTON';

