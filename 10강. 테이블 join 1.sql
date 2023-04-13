--예제58 여러테이블의 데이터를 조인ㄹ해서 출력하기 (EQUI JOIN)
--사원테이블과 부서테이블을 조인해서 이름과 부서위치를 출력하세요 

select e.ename,d.loc,e.deptno --두 테이블에 다 컬럼이 있는경우 앞에 테이블명을 붙여줘야함
from emp e,dept d                          --하나만 있는 컬럼이라도 테이블명을 써주는게 더 효율적
where e.deptno = d.deptno;  --테이블 별칭 사용하면 훨씬 편해짐

--예제58 문제1 직업이 SALESMAN인 사원들의 이름과 직업과 부서위치를 출력하세요

select e.ename,e.job,d.loc
from emp e, dept d
where  e.deptno = d.deptno and  e.job = 'SALESMAN';

--예제58 문제2 DALLAS에서 근무하는 사원들의 이름과 월급과 부서위치를 출력하세요 

select e.ename,e.sal,d.loc
from emp e,dept d
where e.deptno = d.deptno and d.loc = 'DALLAS';

--예제59 여러테이블의 데이터를 조인해서 출력하기 (NON EQUI JOIN)
--사원테이블과 급여테이블과 조인하여 이름과 월급과 월급에 대한 등급을 출력하세요 

select e.ename,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal; -- 두 테이블간 같은 컬럼이 없지만 관련있는 컬럼이 존재

--예제59 문제1 급여등급이 4등급인 사원들의 이름과 월급을 출력하는데 월급이 높은 사원부터 출력하세요

select e.ename,e.sal
from emp e, salgrade s
where e.sal between s.losal and s.hisal and s.grade = 4
order by e.sal desc;

--예제60 여러 테이블의 데이터를 조인해서 출력하기 (OUTER JOIN)
--이름과 부서위치를 출력하는데 다음과 같이 BOSTON도 출력되게 하세요

select e.ename, d.loc
from emp e, dept d
where e.deptno (+) = d.deptno; -- 모자란쪽(오른쪽 )에 (+) 해주기

--예제60 문제1 사원테이블 전체에 이름과 부서위치를 출력하는데 JACK도 출력되게 하세요

select e.ename, d.loc
from emp e, dept d
where d.deptno (+) = e.deptno; 

--예제61 여러 테이블의 데이터를 조인해서 출력하기 (SELF JOIN) 같은 테이블 조인 
--직업이 SALESMAN인 사원들의 사원이름과 직업을 출력하고 이름과 관리자의 직업을 출력하세요 

select 사원.ename as 사원,사원.job,관리자.ename as 관리자,관리자.job
from emp 사원,emp 관리자 
where 관리자.empno = 사원.mgr;

--예제61 문제1 예제61번 결과를 다시 출력하는데 관리자인 사원들보다 더 많은 월급을 받는 사원들을 출력하세요

select 사원.ename as 사원,사원.sal ,관리자.ename as 관리자,관리자.sal
from emp 사원, emp 관리자
where 사원.mgr = 관리자.empno and 관리자.sal < 사원.sal;
