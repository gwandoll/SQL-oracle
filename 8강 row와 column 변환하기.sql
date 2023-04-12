--예제47 row를 column으로 출력하기 1(sum+decode)
--부서번호와 부서번호별 토탈 월급을 출력하는데 다음과 같이 가로로 출력하세요

select deptno,sum(sal)
from emp
group by deptno;

select sum(decode(deptno,10 ,sal,null)) as "10", -- 그룹함수에서 null은 연산에서 제외하기때문에 효율적 
       sum(decode(deptno,20 ,sal)) as "20", -- 아닐때 값을 비워놓으면 null과 같음
       sum(decode(deptno,30 ,sal,null)) as "30"
from emp;

--예제47 문제1 직업,직업별 토탈월급을 가로로 출력하세요

select sum(decode(job,'ANALYST',sal)) as ANALYST,
       sum(decode(job,'CLERK',sal)) as CLERK,
       sum(decode(job,'MANAGER',sal)) as MANAGER,
       sum(decode(job,'PRESIDENT',sal)) as PRESIDENT,
       sum(decode(job,'SALESMAN',sal)) as SALESMAN
from emp;

--예제48 row를 column으로 출력하기2 (PIVOT) --서브쿼리를 사용해서 필요한 컬럼들만 가져와야함
                                       --토탈 월급을 출력하는데 부서번호의 토탈월급, in ()에 대한 

select * -- 선택해서 보고 싶다면 "10","20"  pivot문의 결과를 출력할수 있도록 select 작성
from (select deptno,sal from emp)-- in line view(쿼리문이 처음실행되는 from절에 쿼리를 작성하는 방식)
pivot (sum(sal) for deptno in (10,20,30) ); -- pivot(그룹함수 for 기준컬럼 in (데이터1,2,3..))

--예제48 문제1 직업,직업별 토탈월급을 pivot문을 이용하여 가로로 출력하세요

select *
from (select job,sal from emp)
pivot (sum(sal) for job in ('PRESIDENT' as "PRESIDENT",'MANAGER','SALESMAN','CLERK','ANALYST'));
                                        --컬럼에 ''가 붙어있는걸 없애려면 as ~
                                        
--예제49 column를 row로 출력하기 (UNPIVOT) unpivot( 출력할 컬럼이름 for 데이터가 출력될 컬럼이름 in (데이터1,2,3)

select *
from order2;

select *
from order2
unpivot (건수 for 아이템 in (BICYCLE,CAMERA,NOTEBOOK)); -- unpivot문은 ''안써도 됨

select *
from crime_cause;

--예제49 문제1 범죄원인 테이블을 생성하고 방화사건의 가장 큰 원인이 무엇인지 출력하세요

select *
from (select * from crime_cause where CRIME_TYPE = '방화');

select *
from (select * from crime_cause where CRIME_TYPE = '방화')
unpivot (건수 for 원인 in ( 생계형, 유흥,도박,허영심,복수,해고,징벌,가정불화,호기심,유혹,사고,불만,부주의,기타))
order by 건수 desc;

--다른방법
select *
from crime_cause
unpivot (건수 for 원인 in ( 생계형, 유흥,도박,허영심,복수,해고,징벌,가정불화,호기심,유혹,사고,불만,부주의,기타))
where crime_type = '방화' 
order by 건수 desc;
