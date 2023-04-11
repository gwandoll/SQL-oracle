--예제26 날짜간 개월수 출력하기 (MONTHS+BETWEEN)
--이름을 출력하고 입사한 날짜부터 오늘까지 총 몇달을 근무했는지 출력하세요

select sysdate -- 오늘날짜를 출력하는법
from dual;

select ename,round(months_between(sysdate,hiredate)) -- (현재날짜,기준날짜)순으
from emp;

--문제1 내가 태어난 날부터 오늘까지 총 몇달인지 출력하세요

select months_between(sysdate,'1995/04/25')
from dual;

--예제27 개월 수 더한 날짜 출력하기(ADD_MONTHS)
--2019년 5월1일부터 100달뒤 날짜는 어떻게 되는지 출력해보세요

select add_months('2019/05/01',100) --(기준날짜,더할 개월수)
from dual;

--오늘부터 100달 뒤 날짜가 어떻게 되는지 출력하세요

select add_months(sysdate,100)
from dual;

--예제28 특정 날짜뒤에 오는 요일 날짜 출력하기 (NEXT_DAY)
--2021년 5월 5일부터 바로 돌아오는 월요일의 날짜가 어떻게 되는지 출력하세요

select next_day('2021/05/05','월요일') --(특정날짜,요일)
from dual;

--오늘부터 앞으로 돌아올 금요일의 날짜가 어떻게 되는지 출력하세요

select next_day(sysdate,'금요일')
from dual;

--특정 날짜가 있는 달의 마지막 날짜 출력하기 (LAST_DAY)
--2021년 5월 5일의 해당 달의 마지막 날짜를 출력하세요

select last_day('2021/05/05')
from dual;

--오늘부터 이번달 말일까지 총 며칠 남았는지 출력하세요

select last_day(sysdate) - sysdate
from dual;



--예제30 문자형으로 데이터유형 변환하기 (TO_CHAR)
--날짜형 -> 문자형  , 숫자형 --> 문자형으로 출력가능하게 해줌

--to_char(날짜 컬럼명,'날짜 포맷'
--날짜포맷 : 년도: RRRR, YYYY, RR , YY
         --달 : MON, MM
         --일: DD
         --요일:DAY,DY
 
 --날짜형 ->문자형 예시
 select ename, hiredate,to_char(hiredate,'yyyy'),to_char(hiredate,'MON'), to_char(hiredate,'DD')
,to_char(hiredate,'DAY'),to_char(hiredate,'DY') --숫자형으로 보이지만 문자형
from emp;
--숫자형 -> 문자형 예시
select ename,sal,to_char(sal,'999,999') --단위마다 , 찍어줌
from emp;

--이름이 scott인 사원의 입사한 요일과 월급을 출력하는데 천단위 표시해서 출력하세요

select to_char(hiredate,'DAY'),to_char(sal,'9,999')
from emp
where ename = 'SCOTT';

--수요일에 입사한 사원들의 이름과 입사일과 입사한 요일을 출력하세요

select ename,hiredate,to_char(hiredate,'DAY')
from emp
where to_char(hiredate,'DAY') = '수요일';

--내가 태어난 생일의 요일을 출력하세요

select to_char(to_date('1995/04/25'),'DAY') --날짜형식을 알려줘야 날짜로 인식함
from dual;

--예제31 날짜형으로 데이터 유형 변환하기(TO_DATE)
--81년 11월 17일에 입사한 사원의 이름과 입사일을 출력하세요

select ename,hiredate
from emp
where hiredate = '81/11/17'; -- 혅재 세션의 날짜포맷이 RR/MM/DD이기때문에 에러없이 검색가능

--현재 세션의 정보 확인하는 방법
select *
from nls_session_parameters; --NLS_DATE_FORMAT이 RR/MM/DD로 되어있음

--현재 세션이 날짜형식을 DD/MM/RR로 바꾼다면
alter session set nls_date_format = 'DD/MM/RR';

select ename,hiredate
from emp
where hiredate = '81/11/17'; --날짜형식이 안맞기때문에 에러가 남
--날짜형식에 관계없이 출력하고싶다면 to_date로 표시
select ename,hiredate
from emp
where hiredate = to_date('81/11/17','RR/MM/DD'); 

--다시 원래대로 바꿔주기
alter session set nls_date_format = 'RR/MM/DD';

--예제31 문제1 1981년도에 입사한 사원들의 이름과 입사일을 출력하는데 최근에 입사한 사원부터 출력하세요

select ename,hiredate
from emp
where to_char(hiredate,'YYYY') = 1981
order by hiredate desc;

--다른방법
select ename,hiredate
from emp
where hiredate between to_date('1981/01/01','RRRR/MM/DD')
                  and  to_date('1981/12/31','RRRR/MM/DD')+1
order by hiredate desc;

--예제32 암시적 형 변환 이해하기
select ename,sal
from emp
where sal='3000'; 
    --숫자  문자 이지만 숫자의 우선순위가 높아서 암시적으로 문자를 숫자로 실행함 
    
--쿼리 실행계획(explain plan for ~ from talbe(dbms_xplan.display)
--질의문이 실행되는 순서와 정보를 출력합니다
explain plan for
select ename,sal
from emp
where sal='3000'; 

select * from table(dbms_xplan.display); -- '3000'으로 실행했지만 실행계획을 보면 3000으로 실행했음
                                        -- 암시적 형변환이 일어난 것  

-- 이 쿼리가 실행되는이유 
explain plan for
select ename,sal
from emp
where sal like '30%'; 
   --  숫자형   문자형이므로 숫자형이 더 우선순위가 높아 문자를 숫자도 바꾸려하지만 %때문에 불가능함
   -- 그렇기때문에 숫자형을 문자형으로 변환한뒤 쿼리를 실행함 
select * from table(dbms_xplan.display); --filter(TO_CHAR("SAL") LIKE '30%') 문자형으로 변환된 모습

-- 형변환을 하기때문에 비효율적, 형식을 맞춰주는게 좋다
