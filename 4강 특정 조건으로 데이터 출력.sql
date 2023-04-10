--예제17 문자에서 특정 철자 추출하기 (SUBSTR)
--SMITH라는 단어에서 MI만 추출해서 출력하세요

select substr('SMITH',2,2) -- substr(문자열,시작철자 인덱스,잘라낼 갯수)
from dual; -- 가상의 테이블 환경을 구성하여 질의문의 결과를 확인할 때 사용

--문제1 사원 테이블에서 이름을 출력하는데 이름의 첫글자만 출력하고 첫글자를 소문자로 출력하세요

select lower(substr(ename,1,1))
from emp;

--예제18 문자열의 길이를 출력하기 (LENGTH)
--이름을 출력하고 이름의 철자의 길이를 출력하세요

select ename,length(ename)
from emp;

--문제1 이름의 철자의 길이가 5개 이상인 사원들의 이름과 이름의 철자의 길이를 출력하세요

select ename,length(ename)
from emp
where length(ename) >= 5;

--예제19 문자에서 특정 철자의 위치 출력하기(INSTR)
--SMITH라는 단어에서 알파벳 M이 몇번째 자리에 있는지 출력하세요

select instr('SMITH','M')
from dual;

--문제1 이름에 철자가 S가 포함된 사원들의 이름을 출력하세요

select ename
from emp
where instr(ename,'S') > 0;

--예제20 특정 철자를 다른 철자로 변경하기(REPLACE)
-- 이름과 월급을 출력하는데 숫자 0을 *로 출력하세요

select ename,replace(sal,0,'*') -- replace(컬럼명,변경전 문자,변경 후 문자)
from emp;

--문제1 이름과 월급을 출력하는데 숫자0부터 3까지는 *로 출력되게 하세요

select ename,regexp_replace(sal,'[0-3]','*') --정규식 함수: regexp사용하면 범위가능
from emp;

--예제21 특정 철자를 N개만큼 채우기(LPAD,RPAD)
--이름과 월급을 출력하는데 월급 컬럼의 자릿수를 10자리로 하고 월급을 출력하고 남는 나머지 자리에 *채우세요

select ename,lpad(sal,10,'*'), rpad(sal,10,'*') -- lpad(컬럼명,출력할 전체자릿수,남은공간에 채울문자)
from emp;

--예제22 특정 철자 잘라내기(TRIM,RTRIM,LTRIM)
--다음과 같이 smith 영어단어에서 s를 잘라내 출력, 뒤의 h를 잘라내고 출력, 양쪽 s를 잘라내고 출력하세요

select 'smith',ltrim('smith','s'), rtrim('smith','s'),trim('s' from 'smiths')
from dual;      --l,rtrim(컬럼명,잘라낼문자열) trim(잘라낼 문자열 from 컬럼명)

--문제1 다음의 데이터를 사원테이블에 입력하고 이름이 JACK인 사원의 이름과 월급을 출력하세요

insert into emp(empno,ename,sal)
values(3821,'JACK ', 3000 )

commit;

select ename,sal
from emp
where rtrim(ename,' ') = 'JACK'; -- 잘라낼 문자열을 입력하지 않으면 기본으로 공백을 잘라냄

select ename,sal
from emp
where trim(ename,' ') = 'JACK';

--예제23 반올림해서 출력하기 (ROUND)
--876.567 숫자를 출력하는데 소수점 두번째 자리인6에서 반올림해서 출력하세ㅛㅇ
함
select round(876.567,1) -- 8 7 6 .  5 6 7
from dual;              -- -3-2-1 0 1 2 3이며, 해당 인덱스까지 반올림, ex)0이면 소수점 X

--문제1 사원테이블에서 이름과 월급의 12%을 출력하는데 소수점 이하는 출력되지 않도록 반올림하세요

select ename, round(sal*0.12,0)
from emp;

--예제24 숫자를 버리고 출력하기(TRUNC)

select trunc(876.567,0)
from dual;

--예제25 나눈 나머지값 출력하기(MOD)
--숫자 10을 3으로 나눈 나머지 값을 출력하세요

select mod(10,3)
from dual;

--문제1 사원번호가 홀수인 사원들의 사원번호와 이름을 출력하세요

select empno,ename
from emp
where mod(empno,2) = 1;