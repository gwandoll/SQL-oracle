--예제9 산술연산자 배우기(*,/,+,-)
-- 연봉이 36000 이상인 사원들의 이름과 연봉을 출력하세요

select ename,sal as 연봉
from emp
where sal*12 >= 36000; -- 실행순서 : from -> where -> select

--예제9 문제1 직업이 ANALYST인 사원들의 이름과 연봉을 출력하세요

select ename,sal*12 as 연봉
from emp
where job = 'ANALYST';

--예제10 비교연산자 배우기
-- 월급이 1200이하인 사원들의 이름 월급 직업 부서번호를 출력하세요

select ename,sal,job,deptno
from emp
where sal <= 1200;

--예제10 문제1 직업이 SALESMAN이 아닌 사원들의 이름과 직업을 출력하세요

select ename,job
from emp
where job <> 'SALESMAN'; -- ^= , != 도 가능

--예제11 비교연산자 (between and)
-- 월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하세요

select ename,sal
from emp
where sal between 1000 and 3000;
-- 다른방법
select ename,sal
from emp
where sal >= 1000 and sal <= 3000;

--예제11 문제1 월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급을 출력하세요

select ename,sal
from emp
where sal not between 1000 and 3000;

--문제2 1981 11월 01일부터 1982년 5월30일 사이에 입사한 사원들의 이름과 입사일을 출력하세요

select ename,hiredate
from emp
where hiredate between '81/11/01' and '82/05/30';

--예제12 비교연산자 배우기(LIKE)
--이름의 첫글자가 s로 시작하는 사원들의 이름을 출력하세요

select ename
from emp
where ename like 'S%'; -- %는 와일드카드, %위치에 어떤 문자열이든 갯수에 상관없이 출력
                       --  _는 그 위치에 어떤 문자열이든 한자릿수만 출력
    
--예제12 문제1 이름의 끝 글자가 T로 끝나는 사원들의 이름을 출력하세요

select ename
from emp
where ename LIKE '%T'; -- 앞에 어떤 문자열이든 오고 T로끝나는 것들만

--문제2 이름의 두번째 철자가 M인 사원들의 이름을 출력하세요

select ename
from emp
where ename LIKE '_M%';

--비교연산자 (IS NULL)
--예제13 커미션이 null인 사원들의 이름과 커미션을 출력하세요
select ename,comm
from emp
where comm is null; -- null은 데이터가 없는 상태, 알수 없는 값 그렇기때문에 =비교연산자는 안댐

--예제13 문제1 커미션이 null이 아닌 사원들의 이름과 커미션을 출력하세요

select ename,comm
from emp
where comm is not null; 

--비교연산자 (IN)
--예제14 직업이 SALESMAN,ANALYST,MANAGER인 사원들의 이름과 월급 직업을 출력하세요

select ename,sal,job
from emp
where job in ('SALESMAN','ANALYST','MANAGER'); -- 여러개를 비교할 때 IN사용

--문제1 직업이 SALESMAN,ANALYST,MANAGER가 아닌 사원들의 월급과 직업을 출력하세요

select sal,job
from emp
where job not in ('SALESMAN','ANALYST','MANAGER');

--논리연산자 배우기 ( AND,OR,NOT)
--예제15 직업이 SALESMAN이고 월급이 1200이상인 사원들의 이름과 월급과 직업을 출력하세요
select ename,sal,job
from emp
where job = 'SALESMAN' and sal >= 1200;

--문제1 부서번호가 30번이고 커미션이 100이상인 사원들의 이름과 월급, 커미션을 출력하세요

select ename,job,comm
from emp
where deptno = 30 and comm >= 100; --비교연산자 부정은 not을 붙이는게 일반

--함수: 함수에 데이터를 입력하면 로직을 거쳐 데이터를 리턴
-- 단일행 함수: 데이터를 하나행만 입력해서 리턴
-- 다중행 함수: 여러개값을 입력하고 결과출력 ex)max 여러개의 데이터를 입력후 가장 큰것 출력

--예제 16 대소문자 변환 함수 배우기 (UPPER,LOWER,INITCAP)
-- 사원테이블에서 이름을 출력하는데 모두 소문자, 대문자 첫글자만 대문자로 출력하세요

select LOWER(ename),UPPER(ename),INITCAP(ename)
from emp;

--문제1 이름이 scott인 사원의 이름과 월급을 출력하는데 이름을 모두 소문자로 검색해도 결과가 출력되게

select ename
from emp
where lower(ename) = 'scott';