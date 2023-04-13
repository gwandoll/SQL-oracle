--예제50 데이터 분석 함수로 누적 데이터 출력하기 (SUM OVER) sum() over(order by 기준컬럼)
--직어빙 ANALYST,MANAGER인 사원들의 사원번호,사원이름,월급,월급에 대한 누적치를 출력하세요

select empno,ename,sal, sum(sal) over (order by empno rows -- 첫번째 행부터 현재행까지의 누적
                                        between unbounded preceding -- 기본값이라 안써도 됨  
                                        and current row) 
from emp됨
where job in ('ANALYST','MANAGER');

select ename,sal,sum(sal) over(order by empno)
from emp
where deptno = 20;

--예제51 데이터분석함수로 비율 출력하기(RATIO_TO_REPORT)
--부서번호가 20인 사원들의 사원번호,이름,월급,월급에 대한 비율을 출력하세요
select empno,ename,sal, round(ratio_to_report(sal) over(), 2) 비율
from emp
where deptno = 20;

--예제51 문제1 사원테이블 전체에서 사원번호,이름,월급,월급에 대한 비율을 출력하세요
select empno,ename,sal,round(ratio_to_report(sal) over(),2) 비율
from emp;

--예제52 데이터 분석함수로 집계결과 출력하기 (ROLLUP) 맨 아래에 집계결과 출력 
--직업,직업별 토탈월급을 출력하는데, 맨 아래에 다음과 같이 전체 토탈월급이 출력되게 하세요 

select job,sum(sal)
from emp
group by rollup(job); -- group by절에 rollup(기준컬럼)

--예제52 문제1 부서번호,부서번호별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급이 출력되게 하세요 

select deptno,sum(sal)
from emp
group by rollup(deptno);

select deptno,sum(sal)
from emp
group by grouping sets( (deptno), () ); -- grouping sets으로도 rollup과같이 출력 가능 

--예제53 데이터 분석함수로 집계결과 출력하기 (CUBE) 맨위에 집계결과 출력 
--직업, 직업별 토탈월급을 출력하는데 맨 위에 다음과 같이 전체 토탈월급이 출력되게 하세요

select job,sum(sal)
from emp
group by cube(job); -- rollup과 같음

--예제53 문제1 입사한년도(4자리), 입사한 년도별 토탈월급을 출력하는데 맨 위에 사원테이블의 전체 토탈월급이 출력되게 하세요

select to_char(hiredate,'RRRR'),sum(sal)
from emp
group by cube(to_char(hiredate,'RRRR'));

--예제54 데이터 분석함수로 집계결과 출력하기 (GROUPING SETS) 여러그룹의 집계결과를 한번에 출력
--다음과 같이 직업별 토탈월급과 부서번호별 토탈월급과 전체 토탈월급을 같이 출력하세요 
select deptno,job,sum(sal)
from emp
group by grouping sets( (deptno),(job), ()); -- 전체 토탈월급도 출력하고 싶으면 ()

select deptno,job,sum(sal)
from emp
group by grouping sets( (deptno,job), ()); -- ()의 역할은 기준 컬럼들이 동시에 묶인 결과를 출력할지 단일결과를 출력할지를 결정 
                            -- 같이 묶으면 각 부서번호별 직업별 토탈월급이 출력 

            
--예제54 문제1 입사한 년도(4자리)별 토탈월급과 직업별 토탈월급을 위아래로 같이 출력하세요

select to_char(hiredate,'RRRR'),job,sum(sal)
from emp
group by grouping sets(to_char(hiredate,'RRRR'),(job));

--예제55 데이터분석 함수로 출력 결과 넘버링하기 (ROW_NUMBER) row_number() over(order by 기준컬럼)
--부서번호가 20번인 사원들의 사원번호, 사원이름, 월급,순위를 출력하는 결과 끝에 번호를 넘버링해서 출력하세요

select empno,ename,sal,rank() over (order by sal desc) as rank, 
                        dense_rank() over (order by sal desc) as dense_rank, 
                        row_number() over (order by sal desc) as num
from emp
where deptno = 20;

--예제55 문제1 월급이 1000에서 3000사이인 사원들의 이름과 월급을  출력하는데 출력하는 결과 맨 끝에 번호를 넘버링해서 출력하세요

select ename,sal,row_number() over( order by sal desc) as 번호
from emp
where sal between 1000 and 3000;

--예제56 출력되는 행 제한하기(ROWNUM)
--사원테이블에서 맨 위 5개의 행만 아래와 같이 출력하세요
select rownum,empno,ename,job,sal -- rownum은 감춰진 컬럼 어느테이블에든 존재함 
from emp
where rownum <=5; --1외 다른번호는 부등호로 출력 

--예제56 문제1 직업이 SALESMAN인 사원들의 이름과 월급 직업을 출력하는데 맨 위 두개행만 출력하세요

select ename,sal,job
from emp
where job = 'SALESMAN' and rownum <=2;

--예제57 출력되는 행 제한하기 (SIMPLE TOP-n QUERIES)
-- 월급이 높은 사원순으로 사원번호, 이름,직업,월급을 출력하는데 다음과 같이 맨 위의 4개행만 출력하세요

select empno,ename,job,sal
from emp
order by sal desc fetch first 4 rows only;

select * 
from (select empno,ename,job,sal
    from emp
    order by sal desc)
where rownum <=4;

select * 
from (select empno,ename,job,sal,rank() over(order by sal desc) as rank
    from emp)
where rank <=4;


--최근에 입사한 사원순으로 이름 입사일과 월급을 출력하는데 맨위 5명만 출력하세요 

select ename,hiredate
from emp
order by hiredate desc fetch first 5 rows only;