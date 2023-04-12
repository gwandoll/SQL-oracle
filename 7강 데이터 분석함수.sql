--예제41 데이터 분석함수로 순위 출력하기1 (RANK) -- 1,1,3,4,5 ~ 
--직업이 ANALYST,MANAGER인 사원들의 이름 직업 월급과 월급에 대한 순위를 출력하세요

select ename,job,sal, rank() over (order by sal desc) 순위
from emp            -- rank뒤 over에 rank에 적용할 구문작성   rank() over (order by 컬럼명 정렬)
where job in ('ANALYST','MANAGER');

--예제41 문제1 부서번호가 20번인 사원들의 이름과 부서번호와 월급과 월급에 대한순위를 출력하세요

select ename,sal,rank() over (order by sal desc) 순위
from emp
where deptno = 20;

--예제42 데이터 분석함수로 순위 출력하기2 (DENSE_RANK) -- 1,1,2,3,4~~
--직업이 ANALYST,MANGER인 사원들의 이름과 직업과 월급과 순위를 출력하는데 그옆에 순위가 동일한 경우 바로 다음순위가 출력되게 하세요

select ename,sal,dense_rank () over (order by sal desc) 순위
from emp
where job in ('ANALYST','MANAGER');

--예제42 문제1 직업,이름,월급,순위를 출력하는데 순위가 직업별로 각각 월급이 높은 사원순으로 순위를 부여하세요

select job,ename, sal, dense_rank() over (partition by job -- 직업별로 파티션 나눈후 순위 매기기 
                                          order by sal desc) 순위
from emp;

--예제42 문제2 월급이2975인 사원은 사원테이블에서 월급의 순위가 몇위인가
-- densc_rank(기준값) within group (order by 순위를 적용할 컬럼)
select dense_rank(2975) within group (order by sal desc) 순위 --within group절의 컬럼에서 기준값의 순위를 출력
from emp;

--예제43 데이터 분석함수로 등급 출력하기 (NTILE) ntile(등급을 나눌수) over(order by 기준칼럼 정렬 )
--직업이 ANALYST,MANAGER,CLERK인 사원들의 이름과 직업과 월급과 등급을 출력하는데 등급을 4등급으로 나눠서 출력하세요

select ename,job sal, ntile(4) over(order by sal desc) 등급
from emp
where job in ('ANALYST','MANAGER','CLERK');

--예제43 문제1 이름,입사일,입사한 사원순으로 등급을 나누는데 등급을 5등급으로 나눠서 출력하세요 

select ename,hiredate, ntile(5) over (order by hiredate asc) 등급
from emp;

--예제44 순위의 비율 출력하기(CUME_DIST)
--이름과 월급과 순위와 자신의 월급의 순위에 대한 비율을 출력하세요

select ename,sal,dense_rank() over (order by sal desc) 순위,
                round(cume_dist() over (order by sal desc),2) 비율
from emp;

--예제44 문제1 부서번호와 이름과 월급과 월급의 순위에 대한 비율을 출력하세요 순위 비율이 부서번호별로 각각 출력되게 하세요
--부서번호별 순위비율을 나타내려면 patition by 사용
select deptno,ename,sal, dense_rank() over (order by sal desc) 순위,
                        cume_dist() over (partition by deptno order by sal desc) 비율
from emp;               -- 부서번호로 파티션나누고 월급으로 비율 출력

--예제45 데이터를 가로로 출력하기 (LISTAGG) listagg(컬럼명,'구분자') within group (order by 기준컬럼) 
--부서번호를 출력하고 해당 부서번호별로 속한 사원들의 이름을 가로로 출력하세요

select deptno,listagg(ename,',') within group (order by ename asc) as 이름
from emp
group by deptno; -- 그룹으로 묶어야만 에러없이 출력됨

--예제45 문제1 직업,직업별로 속한 사원들의 이름을 가로로 출력하는데 가로로 출력될 때에 월급이 높은 사원부터 출력되게 하세요

select job,listagg(ename,',') within group (order by sal desc)  as 이름
from emp
group by job;

--예제46 바로전 행과 다음행 출력하기 (LAG,LEAD) 이전행: lag(컬럼명,행번호) over (order by 기준컬럼), 다음행 lead
--직업이 ANALYST,MANAGER인 사원들의 사원번호와 이름과월급을 출력하는데 다음과 같이 월급의 그 전행과 다음행이 출력되게 하세요

select ename,sal, lag(sal,1) over (order by sal asc) 전행, --한행 전,후기때문에 1입력 
                 lead(sal,1) over (order by sal asc) 다음행
from emp
where job in ('ANALYST','MANAGER');

--예제46 문제1 이름,입사일 바로 전에 입사한 사원과의 간격일을 출력하세요
    
select ename,hiredate, hiredate - lag(hiredate,1) over (order by hiredate asc) 간격일
from emp;