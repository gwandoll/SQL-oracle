-- 2강 테이블 데이터 출력
-- 예제 1 사원 테이블에서 사원번호와 이름과 월급을 출력하세요

select empno,ename,sal
from emp ;

-- 문제 1 사원테이블에서 사원 이름과 직업과 부서번호를 출력하세요

select ename,job,empno
from emp;

-- 예제 2 사원테이블의 모든 열과 데이터를 출력하세요

select * -- asterisk
from emp;

-- 예제2 문제1 부서 테이블의 모든 열과 데이터를 출력하세요

select *
from dept;

-- 컬럼별칭 사용하기
--예제3 사원번호와 이름 월급을 출력하는데 컬럼명이 사원번호 사원이름 salary로 출력되게 하세요

select empno as "사원번호" , ename as 사원이름, sal as "Salary" --표기하고 싶은 문자열 그대로 나타내려면 ""
from emp;

-- 예제3 문제1 이름과 직업을 출력하는데 컬럼명이 한글로 이름, 직업으로 출력되게 하세요

select ename as 이름 , job as 직업
from emp;

--연결 연산자 ||
--예제4 사원테이블에서 이름과 월급을 서로 붙여서 출력해보세요

select ename || sal
from emp;

--예제4 문제1 사원테이블에서 이름과 직업을 서로 붙여서 아래와 같이 문장으로 출력되게 하시요
-- 예시: KING의 직업은 PRESIDENT 입니다

select ename || '의 직업은 ' || job || ' 입니다' -- 문자인식을 위한 ''
from emp;

--예제5 중복된 데이터 제거해서 출력하기
-- 직업을 출력하는데 중복행을 제거해서 출력하세요
select distinct job
from emp;

--예제5 문제1 부서번호를 출력하는데 중복행을 제거해서 출력하세요

select distinct deptno
from emp;

--예쩨6 데이터를 정렬해서 출력하기
-- 이름과 월급을 출력하는데, 월급이 낮은 사원부터 높은 사원 순으로 출력하세요
select ename, sal
from emp
order by sal asc;  -- order by 후 컬럼명 asc(오름차순) or desc(내림차순)

--예제6 문제1 
이름과 입사일을 출력하는데 최근에 입사한 사원부터 출력하세요
select ename,hiredate
from emp
order by hiredate desc;

--예제7 WHERE절 배우기
--월급이 3000인 사원들의 사원이름,월급,직업을 출력하세요

select ename,sal,job
from emp
where sal = 3000; -- WHERE 검색조건 입력

--예제7 문제1 사원번호가 7788인 사원의 사원번호와 사원이름과 월급을 출력하세요

select empno,ename,sal
from emp
where empno = 7788;

--예제8 이름이 scott인 사원의 이름 월급 직업 입사일 부서번호를 출력하세요
select ename,sal,job,hiredate,deptno
from emp
where ename = 'SCOTT'; --문자와 날짜는 '' 사용, 대소문자 가려야함

--예제8 문제1 직업이 salsman인 사원들의 이름과 직업과 입사일을 출력하세요

select ename,job,hiredate
from emp
where job = 'SALESMAN';

--예제8 문제2 81/11/17일에 입사한 사원의 이름과 입사일을 출력하세요

select ename,hiredate
from emp
where hiredate = '81/11/17';
