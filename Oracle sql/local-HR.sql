--> CH.2 데이터 조회

select * from tab;              --  대소문자 구분이 없다
SELECT * FROM HR.employees;



DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;


--  ctrl+enter로 등록하면 내부에 등록되서 코드가 삭제되도 유지된다.

CREATE TABLE DEPARTMENT
        (DNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
         DNAME VARCHAR2(14),
	 LOC   VARCHAR2(13) ) ;
CREATE TABLE EMPLOYEE 
        (ENO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR2(10),
 	 JOB   VARCHAR2(9),
	 MANAGER  NUMBER(4),
	 HIREDATE DATE,
	 SALARY NUMBER(7,2),
	 COMMISSION NUMBER(7,2),
	 DNO NUMBER(2) CONSTRAINT FK_DNO REFERENCES DEPARTMENT);
CREATE TABLE SALGRADE
        (GRADE NUMBER,
	 LOSAL NUMBER,
	 HISAL NUMBER );
     
INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;     -- commit을 넣으면 속성 수정 불가능

SELECT * FROM employee;     -- 14개 행
SELECT * FROM department;   --  4개 행
SELECT * FROM salgrade;     --  5개 행




desc employee;      --  테이블 속성 구성의 구조 확인
desc dual;          --  dual: 임시의 가상 테이블(테이블에 없는 값을 출력 ex:print)
select sysdate from dual;       --  select (field) from (table)

select * from HR.employees;     -- 스키마.테이블 형식이지만
select * from employee;         -- 같은 스키마일 경우 스키마를 생략해도 가능
select ename,eno,manager from employee;


select eno,ename,salary, salary*12 from employee;   -- 산술 연산자(+-*/)
select eno,ename,salary, salary*12, salary*12+commission from employee;
    -- null(commission)인 경우 연산결과 (null)
select eno,ename,salary, salary*12, salary*12+NVL(commission,0) from employee;
    -- null 데이터 연산을 도와주는 함수 (null일 경우 이전 값으로 실행)
select eno,ename,salary, salary*12, salary*12+NVL(commission,0) as 연봉 from employee;
    -- 컬럼명을 특정 별칭으로 지을때는 as (키워드)를 붙인다.
select eno,ename,salary, salary*12, salary*12+NVL(commission,0) 연봉 from employee;
    -- 단, as 키워드를 생략도 가능
select eno,ename,salary, salary*12, salary*12+NVL(commission,0) "$연_  _봉#" from employee;
    -- 내부에 특수기호를 삽입을 때 ""를 사용한다.
    
select dno from employee;
select distinct dno from employee;
    -- 컬럼의 데이터값이 중복되는 경우 중복 데이터를 제거하고 출력하기 위해 DISTINCT를 사용한다
    
SELECT * FROM employee where salary >= 1500;
    -- where 조건절: 특정 조건(열(칼럼))에 해당하는 데이터 행(튜플)을 불러온다
select * from employee where job = 'ANALYST';
    -- 숫자 이외의 데이터는 ''로 묶어서 작성


SELECT eno,ename,salary FROM employee where ename = SCOTT;
SELECT eno,ename,salary FROM employee where ename = 'SCOTT';
SELECT eno,ename,salary FROM employee where ename = 'scott';    -- 자료형은 대소문자구분을한다.
SELECT eno,ename,salary FROM employee where ename > 'SCOTT';    --  알파벳 순서
SELECT eno,ename,salary FROM employee where ename > 'aCOTT';    --  대문자 유니코드 번호가 소문자보다 앞에 있다.
SELECT * FROM employee where hiredate <= '1981/01/01';
SELECT * FROM employee where hiredate <= '1981-01-01';
SELECT * FROM employee where hiredate <= '1981.01.01';
SELECT * FROM employee where hiredate != '1981.01.01';          --  != , <> , ^=
SELECT eno,ename,salary FROM employee where commission is not null; 
SELECT eno,ename,salary FROM employee where commission is null;     -- null 값을 불러올 땐 연산자가 아닌 명령어로 입력 

select * from employee where dno = 10 and job = 'MANAGER';
select * from employee where dno = 10 or job = 'MANAGER';
select * from employee where not dno = 10;
select * from employee where not job = 'MANAGER' and (dno = 10 or job = 'MANAGER');
select * from employee where not job = 'MANAGER' and dno = 10 or job = 'MANAGER';   -- 괄호가 없으면 순차 적용
select * from employee where not dno = 10 and job = 'MANAGER';
select * from employee where job = 'MANAGER' and not dno = 10;
select * from employee where not (dno = 10 and job = 'MANAGER');


--ex
SELECT * FROM employee where salary>=1000 and salary<=1500;
SELECT * FROM employee where 1000<=salary and 1500>=salary;
SELECT * FROM employee where 1000<=salary<=1500;        -- 조건을 한번에 표현할 수 있는 경우라도 따로 작성한다
SELECT * FROM employee where 1000<=salary and salary<=1500;
SELECT * FROM employee where salary<1000 or salary>1500;
SELECT * FROM employee where commission=300 or commission=500 or commission=1400;

-- between and: 칼럼 between a and b 사이 값에 해당하는 칼럼
SELECT * FROM employee where salary BETWEEN 1000 AND 1500;      -- 
SELECT * FROM employee where salary not BETWEEN 1000 AND 1500;
SELECT * FROM employee where hiredate BETWEEN '1982.01.01' AND '1982.12.31';

-- in(): in에 해당되는 모든 칼럼을 출력
SELECT * FROM employee where commission in(300,500,1400);
SELECT * FROM employee where commission not in(300,500,1400);

-- Like 연산자 & 와일드카드(% or _) A like 
-- %: 해당 위치에 문자가 없거나 여러 문자가 와도 상관 없음
SELECT * FROM employee where ename like 'F%';
SELECT * FROM employee where ename like '%M%';
SELECT * FROM employee where ename like '%N';
SELECT * FROM employee where ename not like '%A%';
-- _: 해당 위치에 어떤 문자가 와도 상관 없음(단, 1:1로 대입)
SELECT * FROM employee where ename like '_A%';
SELECT * FROM employee where ename like '__A%';

-- is: null 값은 알 수 없는 값이기에 비교,연산,할당등이 불가능하다
SELECT * FROM employee where commission = null;
SELECT * FROM employee where commission is null;
SELECT * FROM employee where commission is not null;

/* order by: 칼럼 정렬(기본값은 오름차순 정렬)
 ASC: 오름차순, DESC: 내림차순              */
SELECT * FROM employee order by salary ;
SELECT * FROM employee order by salary asc;
SELECT * FROM employee order by salary desc;
SELECT * FROM employee order by salary, commission, ename asc;
SELECT * FROM employee order by salary desc, ename asc;


-- pratice
SELECT ename,salary as 급여,salary+300 as "인상된 급여" FROM employee;

SELECT
    ename, salary as 급여, salary*12+100 as "연간 총수입"
FROM employee;

SELECT
    ename, salary
FROM employee where salary > 2000 order by salary desc;

SELECT
    ename, dno
FROM employee where eno = 7788;

SELECT
    ename, salary
FROM employee where salary not between 2000 and 3000;

SELECT
    ename, job, hiredate
FROM employee where hiredate between '1981.2.20' and '1981.5.1';

SELECT
    ename, dno
FROM employee where dno = 20 or dno = 30 order by ename;

SELECT
    ename, dno
FROM employee where salary BETWEEN 2000 AND 3000 and (dno = 20 or dno = 30) order by ename asc;

SELECT
    ename, hiredate
FROM employee where hiredate like '81%';

SELECT
    ename,job
FROM employee where manager is null;

SELECT
    ename, salary, commission
FROM employee where commission is not null and commission != 0 order by commission desc;

SELECT
    *
FROM employee where ename like '__R%';

SELECT
    ename
FROM employee where ename like '%A%' and ENAME ENAME LIKE '%E%';

SELECT
    ENAME, JOB, salary
FROM employee where job IN('CLERK','SALESMAN') AND SALARY NOT IN(1600,950,1300);

SELECT
    ENAME, SALARY, COMMISSION
FROM EMPLOYEE WHERE COMMISSION>=500;



--> CH.3 데이터 자료형
/*
숫자 데이터(NUMBER)
38자리까지 표현이 가능하고 22바이트 가변 길이 숫자를 저장한다.
NUMBER      숫자 데이터 있는 그대로 사용
NUMBER(A)   전체 자리수를 A만큼 표기
NUMBER(A,B) 전체 자리수를 A만큼 표기하고 소수점 아래로 B만큼 표기
*/

/*
문자 데이터(CHAR,NCHAR,VARCHAR,NVARCHAR,CLOB,NCLOB)
N: 유니코드 2~x
CHAR(n): 고정길이 문자열       1~2000
VARCHAR(n): 가변길이 문자열    1~4000
CLOB: 대용량 텍스트
*/

/*
날짜(DATE)의 시간(TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE) 데이터
date: 연,월,일,시,분,초
timestamp: date + 밀리초
*/


--  형변환
/*
yyyy: 연도표시(4),  yy: 연도표시(2),    mm: 월,  mon: 월(알파벳),    day: 요일,    dy: 요일(약어)
am/pm: 오전,오후,   a.m/p.m: 오전,오후  hh/hh12: 시간(0~12)      hh24: 시간(0~24) mi: 분  ss: 초
0: 자릿수(if 맞지 않는 경우 '0' 표시)   9: 자릿수(if 맞지 않는 경우 표시하지 않음) 
L: 로컬 지역 통화기호    .: 소수점      ,:천 단위 자리구분
*/
SELECT
    ename, hiredate, to_char(hiredate,'yy/mm'), to_char(hiredate,'yyyy-mm-dd day')
FROM employee;      -- to_char(숫자 or 날짜): 를 문자열로 변경

-- to_char(number | date, 'format') > 숫자 혹은 날짜를 지정 포멧 형식의 문자열로 전환
SELECT
    to_char(sysdate, 'yyyy/mm/dd, hh24:mi:ss')
FROM dual;          -- hh24: 24시간 형식으로 표현

SELECT
    ename, to_char(salary,'L990,000')
FROM employee;      -- L: 해당 로컬 지역의 화폐단위
-- to_date(): 특정 데이터를 날짜형으로 변환하는 함수
-- TO_DATE('char','fotmat'): 특정 데이터를 포맷형식의 문자열로 전환
SELECT
    ename, hiredate
FROM employee where hiredate = TO_DATE(19810220,'yyyymmdd');
SELECT
    ename, hiredate
FROM employee where hiredate = TO_DATE(810220);
-- to_number: 특정 데이터를 숫자로 변환
SELECT
    to_number('10,000','00,000')-to_number('50,000','999,999')
FROM dual;



--> CH.4 그룹함수
/*
SUM()           : 총 합계
AVG()           : 평균
ROUND(NUM,자리수)         : 반올림
TRUNC(NUM,자리수)         : 이후 자리 제거
MAX()           : 최대값
MIN()           : 최소값
COUNT()         : 행의 개수
COUNT(Distinct) : 행의 개수(중복 부분은 1회만)
STDEV()         : 표준편차
VARIANCE()      : 분산
*/
SELECT
    SUM(salary)AS"급여 총액",
    AVG(salary)AS"급여 평균",
    ROUND(AVG(salary))AS"급여 평균(정수)",
    TRUNC(AVG(salary),5)AS"급여 평균 제거",
    ROUND(AVG(salary),5)AS"급여 평균 반올림",
    MAX(salary)AS"최대 급여",
    MIN(salary)AS"최소 급여"
FROM EMPLOYEE;
SELECT
    SUM(commission) as "커미션 총액"     -- null 값을 제외하고 계산해준다
FROM employee;

SELECT
    count(*) as "사원 수"
FROM employee;
SELECT
    count(commission) as "커미션을 받는 사원 수"
    -- 기본적으로 null 값을 제외하고 카운트한다.
FROM employee;
SELECT
    count(commission) as "커미션을 받는 사원 수"
FROM employee where commission is not null;
    -- 조건문을 추가할 수 있다.
SELECT
    count(DISTINCT dno) as "count(DISTINCTDNO)"
    -- distinct: 중복된 값을 카운트에서 제거
FROM employee;
SELECT
    ename, max(salary)
    -- ename: 14개, 그룹함수: 1개 >> 여러개의 결과가 나와야하지만 1개의 결과만 나오는 칼럼이 있어서 오류 발생
FROM employee;

--  group by
SELECT
    max(salary)
FROM employee group by job;
    -- 따라서 특정 칼럼을 기준으로 그룹을 지어 결과 비교 가능
SELECT
    job,max(salary)
FROM employee group by job;
SELECT
    ename,max(salary)
FROM employee group by job;
    -- group by 그룹화 하지 않은 컬럼이 들어가면 오류발생
SELECT
    dno,job,avg(salary),max(salary)
FROM employee group by dno,job
              order by dno asc,job desc;
    -- group by에서 and 형식으로 들어갈 경우 여러 컬럼이 가능
    -- 순서눈 dno(상위그룹) -> job(하위그룹) 으로 그룹지어진다.
    
-- group by ~ HAVING
SELECT
    job,avg(salary), sum(salary)
FROM employee
where avg(salary)>=2000
GROUP by job;   -- 그룹 함수는 where절 뒤에 올 수 없다
SELECT
    job,avg(salary), sum(salary)
FROM employee
where DNO>=20   -- 그룹함수에 관한 조건이 들어가지 못할 뿐이다.
GROUP by job;
SELECT
    job,avg(salary), sum(salary)
FROM employee 
GROUP by job
having avg(salary)>=2000;   -- 그룹 함수에 조건을 추가하고 싶으면 HAVING 절을 뒤에 넣어야한다.

-- ex)
SELECT
    dno,max(salary)
FROM employee
group by dno
having max(salary)>=3000;
SELECT
    job,sum(salary), count(*) 
FROM employee
group by job
having sum(salary)>=5000;
SELECT
    max(avg(salary))
FROM employee
group by dno;
SELECT
    dno,max(avg(salary))
    -- 그룹함수가 중첩 사용되면 일반 필드가 들어갈 수 없다.
FROM employee
group by dno;

-- ROLLUP()
SELECT
    JOB,DNO,SUM(salary)
FROM employee
group by job,dno;
SELECT
    JOB,DNO,SUM(salary)
FROM employee
group by rollup(job,dno);   -- 각 job-dno 마다 합계를 출력하고 job에 대한 합계를 출력한 뒤 총합을 출력한다

-- Practice
SELECT
    max(salary) as "최고액(Maximun)",min(salary) as "최저액(Minimun)",
    sum(salary) as "총(Sum)",round(avg(salary)) as "평균 급여(Average)"
FROM employee;

SELECT
    job ,max(salary) as "최고액(Maximun)",min(salary) as "최저액(Minimun)",
         sum(salary) as "총(Sum)",round(avg(salary)) as "평균 급여(Average)"
FROM employee
group by job;

SELECT
    job,count(*)
FROM employee
group by job;

SELECT
    COUNT(DISTINCT MANAGER) as "COUNT(MANAGER)"
FROM employee;

SELECT
    max(salary) - min(salary) as DIFFERENCE
FROM employee;

SELECT
    job,min(salary)
FROM employee
where manager is not null
group by job
having not min(salary) < 2000;

SELECT
    dno as "부서번호(DNO)",count(*) as "사원수(Number of PeoPle)",
    to_char(round(avg(salary),2),'990,000.00') as "평균급여(Salary)"
FROM employee
group by dno;



--> CH4-2 다양한 함수

/* 문자열 함수
ASCII(영문자)            : 한 문자의 아스키값 반환
CHR(숫자)                : 숫자 아스키값에 해당하는 문자 반환
ASCIISTR(유니코드문자)    : 유니코드문자를 입력하면 16진수의 유니코드 반환
UNISTR(유니코드)         : 유니코드값을 입ㄺ하면 해당 문자를 반환
LENGTH(문자열)           : 문자열의 길이 반환
*/
SELECT ASCII('T') FROM DUAL;
SELECT CHR(84) FROM DUAL;
SELECT ASCIISTR('\') FROM DUAL;
SELECT UNISTR('\cc9c') FROM DUAL;
/*
LENGTHB(문자열)          : 문자열의 바이트 수 반환
LENGTHC(문자열)          : 유니코드 문자열 길이 반환
*/
SELECT LENGTH('한글'), LENGTH('AB'), LENGTHB('한글'), LENGTHB('AB'), LENGTHC('한글') FROM DUAL;
/*
CONCAT(문자열1,문자열2)                                    : 두개의 문자열 결합
문자열1 || 문자열2                                         : 두개 이상의 문자열 결합
INSTR(기준문자열, 부분문자열,찾기 시작위치(,X번째 부분문자열))  : 기준문자열에서 부분문자열을 찾아 문자열이 시작하는 위치를 반환
INSTRB(기준문자열, 부분문자열,찾기 시작위치(,X번째 부분문자열)) : 기준문자열에서 부분문자열을 찾아 문자열이 시작하는 위치를 반환, 단 Byte단위로 센다.
*/
SELECT CONCAT('이것','오라클'),'이것이'||'오라클'||'인것' FROM DUAL;
SELECT INSTR('이것이 Oracle이다. 이것도 오라클이다.','이것') FROM DUAL;
SELECT INSTR('이것이 Oracle이다. 이것도 오라클이다.','이것',2) FROM DUAL;
SELECT INSTRB('이것이 Oracle이다. 이것도 오라클이다.','이것',2) FROM DUAL;
SELECT INSTR('CORPORATE FLOOR','OR',2,3) FROM DUAL;
/*
LOWER(문자열)                              : 소문자로 변환
UPPER(문자열)                              : 대문자로 변환
INITCAP(문자열)                            : 첫글자만 대문자로 나머지는 소문자
REPLACE(문자열, 원래문자열, 바꿀 문자열)     : 문자열에서 원래 문자열을 찾아서 바꿀 문자열로 바꿔준다.
TRANSLATE(문자열, 원래 문자열, 바꿀 문자열)  : 한 글자씩 찾아서 변환
*/
SELECT LOWER('abcdEFGH'),upper('abcdEFGH'),initcap('this is oraCLe') from dual;
select REPLACE('JACK and JUE','J','BL') FROM dual;
select REPLACE('이것이 Oracle이다', '이것이', 'This is') FROM DUAL;
select TRANSLATE('SQL*Plus User''s Guide', ' */''', '___') FROM DUAL;
select TRANSLATE('이것이 Oracle이다', '이것', 'AB') FROM DUAL;
select ename, lower(ename), job, INITCAP(job) from employee;
select eno,ename,dno from employee where ename = 'scott';
select eno,ename,dno from employee where ename = upper('scott');
select eno,ename,dno from employee where ename = initcap('scott');
/*
SUBSTR(문자열, 시작위치, 길이)           : 시작위치에서 길이만큼 문자열을 반환
REVERSE(문자열)                        : 문자열 순서를 거꾸로 한다.
LPAD(문자열,길이,채울 문자열)            : 문자열의 길이만큼 늘린 다음 빈 곳을 채울 문자열로 채운다. 길이는 바이트 단위로 센다.
RPAD(문자열,길이,채울 문자열)            : ''
LTRIM(문자열, 제거할 문자)               : 문자열의 왼쪽/오른쪽에서 제거할 문자를 제거한다. 생략시 공백을 제거
RTRIM(문자열, 제거할 문자)               : ''
TRIM(제거할방향 제거할문자 FROM 문자열)   : 문자열의 앞뒤의 제거할 문자를 제거한다. 방향 생략시 앞뒤 모두, 제거할 문자가 없으면 공백을 제거. 방향: LEADING(앞) TRAILING(뒤) BOTH(양쪽,DEFUALT)
REGEXP_COUNT(문자열, 문자)             : 문자열에서 문자의 개수를 센다.
*/
SELECT SUBSTR('대한독립만세호',3,4) FROM DUAL;
SELECT REVERSE('oracle') FROM dual;
SELECT rpad('이것이',12,'문'),lpad('이것이',12,'문') FROM dual;    -- 한글 유니코드는 문자 1개당 길이2or3
SELECT rtrim('     이번생은ㅎㅋㄹㅋㅎㅋㅋ','ㅋㅎ'), ltrim('      망했어용ㅋㅋ') FROM dual;
SELECT trim('   이번생은    '), trim(both 'ㅋ' from 'ㅋㅋGㅋ이번생은ㅋㅋGㅋ') FROM dual;
SELECT trim(both 'ㅋG' from 'ㅋㅋGㅋ이번생은ㅋㅋGㅋ') FROM dual;   -- TRIM에서 제거 가능한 문자는 하나만 들어갈 수 있다.
SELECT REGEXP_COUNT('이것이 오라클이다.','이') FROM dual;
SELECT * FROM employee WHERE substr(ename,-1,1)='N';        -- : ename에서 a번째(-1:마지막 1번째)의 문자열 길이b(1)가 N인 경우
SELECT LPAD(salary,10,'*'),RPAD(salary,10,'*') from employee;
/*
ABS(숫자): 절대값
------삼각함수(라디안)------
ACOS(숫자),ASIN(숫자)
ATAN(숫자),
ATAN2(숫자1,숫자2),
SIN(숫자),COS(숫자),
TAN(숫자)
------지수,로그함수------
EXP(숫자)
LN(숫자),LOG(숫자)
*/

/*
CEIL(숫자): 올림
FLOOR(숫자): 내림
ROUND(숫자): 반올림
MOD(숫자1, 숫자2): 숫자1을 숫자2로 나눈 나머지
POWER(숫자1, 숫자2): N1^N2
SQRT(숫자): 제곱근
SIGN(숫자): 음,양 판단(-1,0,1)
TRUNC(숫자,N2): 숫자를 소수점을 기준으로 N위치까지 구하고 나머지를 버린다
*/
SELECT SIN(30 * 3.14159265359/180) FROM DUAL;
SELECT SIN(1RAD) FROM DUAL;

/*
NVL(컬럼명(표현식), 대체데이터): null인 경우 -> 대체데이터
NVL2(컬럼명, 데이터1, 데이터2): numm인 경우 -> 데이터2, else -> 데이터1
NULLIF(표현식1,표현식2): 두 결과가 같으면 null, 아니면 표현식1 반환
COALESCE(표현식1,표현식2…표현식N): 여러 인자들중 null이 아닌 첫번째 인자를 반환

                                switch ~case문과 비슷하다
DECODE(표현식, 조건1, 결과1,       표현식의 값이 조건1과 일치하면 결과1 반환
              조건2, 결과2,       조건2과 일치하면 결과2 반환
              조건3, 결과3,       조건3과 일치하면 결과3 반환
              ….,
              기본결과n           모든 조건이 일치하지 않으면 기본결과 반환
              
CASE 표현식                      if~else문과 비슷하다
      WHEN 변수의 논리1 THEN 결과1
      WHEN 변수의 논리2 THEN 결과2
      WHEN 변수의 논리3 THEN 결과3
      ELSE 결과N
END

*/

SELECT ename, salary, commission,
    NVL(commission,0),
    salary*12+NVL(commission,0)
FROM employee;

SELECT ename, salary, commission,
    NVL2(commission,salary*12+commission,salary*12)
FROM employee;

SELECT NULLIF('A','A'),NULLIF('B','A')
FROM dual;

SELECT ename,salary,commission,
    COALESCE(commission,salary,0)
FROM employee;

SELECT ename,dno,
    DECODE(dno, 10, 'ACCOUNTING',
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DEFAULT') AS DNAME
FROM employee;

SELECT ename,dno,
    CASE WHEN dno = 10 THEN 'ACCOUNTING'
         WHEN dno = 20 THEN 'RESEARCH'
         WHEN dno = 30 THEN 'SALES'
         WHEN dno = 40 THEN 'OPERATIONS'
         else 'DEFAULT'
    end
    as DNAME
FROM employee;


-- Practice
SELECT SUBSTR(hiredate,1,5)
FROM employee;

SELECT *
FROM employee
where substr(hiredate,4,2) = '04';

SELECT *
FROM employee
where mod(eno,2) = 0;

SELECT TO_CHAR(hiredate,'YY/MM/DD  DY') 
FROM employee;

SELECT eno, NVL2(eno,manager,0)
FROM employee;

SELECT ename,job,salary,
    DECODE(job, 'ANALYST', salary+200,
                'SALESMAN', salary+180,
                'MANAGER', salary+150,
                'CLERK', salary+100
                ) AS 연봉인상
FROM employee;




--> CH.5 서브쿼리
-- 단일행 서브쿼리
SELECT ename
FROM employee
where salary > ( SELECT salary
                 FROM employee
                 where ename = 'SCOTT' );
                
SELECT dno, min(salary)
FROM employee
group by dno
having min(salary) > (SELECT min(salary)
                    from employee
                    where dno = 30);
                    

-- 다중행 서브 쿼리: 서브쿼리 반한 결과가 1개 이상일 때 사용 + 다중행 연산자
/* 다중행 연산자
IN          :서브 쿼리 중 하나라도 일치하면 TRUE
ANY, SOME   :           하나 이상 일치하면 TRUE
ALL         :           모든 값이 일치해야 TRUE
EXSIT       :비교 조건이 서브 쿼리의 결과중 만족하는 값이 하나라도 존재하면 TRUE
*/
SELECT eno, ename
FROM employee
WHERE salary = (SELECT min(salary)
                FROM employee
                GROUP by dno);      -- 각 dno 마다 1개의 결과로 3개의 결과가 출력되 단일행 서브쿼리로는 불가능하다
SELECT eno, ename
FROM employee
WHERE salary in(SELECT min(salary)  -- 연산자 in이 들어가 3개의 결과가 나오는 다중행 서브쿼리가 되었다.
                FROM employee
                GROUP by dno);
                
SELECT *
FROM employee
WHERE salary < any (SELECT salary           -- 다중행 결과 직업이 판매사원인 여러 튜플을 입력받았다.
                    FROM employee           -- salary < any 로 위 튜플중 최소 하나보다 작은 월급의 조건
                    where job = 'SALESMAN') -- 따라서 임금이 1600인 ALLEN보다 작은 값의 모든 직원이 조건을 만족한다.
and job!='SALESMAN';    -- 단, 세일즈 맨인 사람은 제외한다. salary < any() and job != 'SALESMAN'

SELECT *
FROM employee
WHERE salary <  all (SELECT salary
                    FROM employee           -- all 결과로 모든 도출 값에 대하여 만족해야한다.
                    where job = 'SALESMAN') -- 따라서 임금이 제일 적은 영업사원인 WARD(1250)보다 적아야한다.
and job!='SALESMAN'; 


-- Practice
SELECT ename, job
FROM employee
where job = (SELECT job
            FROM employee
            WHERE eno = 7788);

SELECT ename, job
FROM employee
where salary > (SELECT salary
                FROM employee
                WHERE eno = 7499);

SELECT ename, job, salary
FROM employee
where salary = (SELECT min(salary)
                FROM employee);

SELECT job , to_char(ROUND(avg(salary),2),'990,000.00')
FROM employee
group by job
having avg(salary) <= all (SELECT avg(salary)
                    from employee
                    group by job);
                    
--5*
SELECT ename, salary, dno
FROM employee
where salary IN(SELECT min(salary)
                from employee
                group by dno);
SELECT ename, salary, dno
FROM employee
where salary IN(SELECT min(salary)
                from employee
                group by dno);

SELECT eno, ename, job, salary
FROM employee
where salary < any(SELECT salary
                    FROM employee
                    where job = 'ANALYST')
and job != 'ANALYST';

SELECT ename
FROM employee
where eno IN(SELECT eno
            FROM employee
            where manager is null);
                
SELECT ename
FROM employee
where eno not IN(SELECT eno
                FROM employee
                where manager is null);
                    
SELECT ename, hiredate
FROM employee
where dno = (SELECT dno
            FROM employee
            where ename = 'BLAKE')
and ename != 'BLAKE';

SELECT eno,ename
FROM employee
where salary > (SELECT avg(salary)
                FROM employee)
order by salary asc;

SELECT eno,ename
FROM employee
where dno IN(SELECT dno
                FROM employee
                where ename like '%K%');
                
SELECT ename, dno, job
FROM employee
where dno = (SELECT dno
            FROM department
            where loc = 'DALLAS');
            
SELECT ename, salary
FROM employee
where job IN(SELECT job
            FROM employee
            where job = 'MANAGER');
            
SELECT dno,eno,job
FROM employee
where dno = (SELECT dno
                FROM department
                where dname = 'RESEARCH');

SELECT eno, ename, salary
FROM employee
where eno IN(SELECT eno
            FROM employee
            where salary >(SELECT avg(salary)
                            FROM employee)
            and dno in(SELECT dno
                        FROM employee
                        where ename like '%M%')
            );
            
--16******
SELECT job
FROM employee
where job = (SELECT job
            FROM employee
            group by job
            having avg(salary) = (select min(avg(salary))   -- having 절에서 2중 그룹함수는 사용이 불가능
                                        from employee       -- select 절에서 2중 그룹함수는 사용가능하지만 다른 컬럼과 같이 사용 불가
                                        group by job));
                                        
SELECT eno, ename
FROM employee
where eno in(SELECT manager
                from employee);



--> CH.6 데이터 조작 & 트랜젝션 (DML)
/*
INSERT: 데이터 추가
UPDATE: 데이터 편경
DELETE: 데이터 삭제

데이터 추가
INSERT INTO 테이블명 (컬럼명1,컬럼명2...) VALUES (데이터1,데이터2...)
INSERT INTO 테이블명 VALUES (데이터1,데이터2...) : 데이터의 모든 컬럼을 채우면 컬럼명 생략 가능
*/
INSERT INTO employee(eno,ename,job,manager,hiredate,salary,commission,dno)
VALUES (8121,'ALICE','CLERK',7788,SYSDATE,1200,100,10);
INSERT INTO employee
VALUES (8231,'KATHERINE','SALESMAN',7698,SYSDATE,1750,800,30);

COMMIT;
SELECT * FROM employee;

INSERT INTO employee(ename,job,eno,salary,commission)   -- 컬럼명을 명시하면 순서가 바껴도, 생략되도 입력할 수 있다.
VALUES ('','CLERK',8121,12000,10000);   -- 칼럼이 명시되지 않은 곳은 null이 들어간다.

INSERT INTO employee(eno)       VALUES(8500);
INSERT INTO employee(eno,ename) VALUES(8600,null);
INSERT INTO employee(eno,ename) VALUES(8700,'');    -- null을 입력하거나 아무것도 입력하지 않으면 null이 들어간다
INSERT INTO employee(eno,ename,hiredate) VALUES(8800,null,'2020/12/31');
INSERT INTO employee(eno,ename,hiredate) VALUES(8900,null,to_date('2020/12/31','yyyy-mm-dd'));
INSERT INTO employee(eno,ename,hiredate) VALUES(8950,null,sysdate); -- sysdate(시스템 date): 현재 날짜 참조


/*
데이터 복사
CREAT
*/
CREATE TABLE emp1
AS SELECT * FROM employee;                  -- 다중행 복사
CREATE TABLE emp2
AS SELECT * FROM employee WHERE 1=0;        -- where (bool): 구조 복사, true 일 경우 모두 복사하고 false일 경우 구조만 복사한다
CREATE TABLE emp3
AS SELECT * FROM employee WHERE 2=2;
CREATE TABLE emp4
AS SELECT * FROM employee WHERE 0=0;
CREATE TABLE emp5
AS SELECT * FROM employee WHERE 2=5;
SELECT * FROM emp1;
SELECT * FROM emp2;
SELECT * FROM emp3;
SELECT * FROM emp4;
SELECT * FROM emp5;
DROP table emp2;
DROP table emp3;
DROP table emp4;
DROP table emp5;

-- UPDATE: 데이터 변경
/*
update 테이블명 set 컬럼명1=데이터1 ,컬럼명2=데이터2…where 조건;
*/
CREATE TABLE emp3
AS SELECT * FROM employee;

UPDATE emp3 SET ename = 'RUNA', job = 'MANAGER'
where eno = 8500;
UPDATE emp3 SET commission = 500;   -- 모든 조건의 커미션을 500으로 변경
UPDATE emp3
SET salary = (SELECT losal
                FROM salgrade
                where grade = 1)
WHERE dno is null;              -- dno가 null 인 모든 사원의 급여를 salgrade 스키마의 grade = 1에 만족하는 losal값을 일괄 입력한다

UPDATE emp3
SET dno = (SELECT dno
            FROM department
            WHERE dname = 'OPERATIONS'),
    manager = (SELECT eno
                FROM emp3
                WHERE job = 'PRESIDENT')
WHERE ename is null;                    -- ename이 null 값인 사람의 부서 명에 department 스키마의 operations(40)을 입력하고
                                        --                        매니저에 KING의 사원 번호를 넣는다.

SELECT * FROM salgrade;
SELECT * FROM department;
SELECT * FROM emp3;
-- DELETE: 데이터 삭제
/*
delete  from 테이블명 where 조건;
조건에 해당하는 레코드를 삭제한다.
조건절 생략 시 모두 삭제
*/
CREATE TABLE emp4
AS SELECT * FROM employee;

DELETE FROM emp4
WHERE ENAME = 'ALICE';
DELETE FROM emp4;
INSERT INTO emp4
SELECT * FROM employee;
DELETE FROM emp4 WHERE ENAME IS NULL;
DELETE FROM emp4
WHERE dno = (SELECT dno
                FROM department
                WHERE dname ='RESEARCH');


SELECT * FROM department;
SELECT * FROM emp4;
-- 트랜젝션
/*
데이터 처리를 위한 논리 작업의 단위, 데이터의 일관성을 보장한다.
여러 명령어를 실행할 때 전부 실행하거나 오류로 인해 전부 취소된다.

COMMIT  : 모든 작업을 정상 처리하고 모든 처리 결과를 확정하는 명령,영구저장
ROLLBACK: 명령어를 수행하면 하나의 트랜젝션 과정을 종료한다.
*/

CREATE TABLE depart2
AS
SELECT * FROM department;

DELETE FROM depart2;    -- 세미콜론을 잘못 넣은 경우, DEPART2의 모든 데이터가 삭제된다.
WHERE dno = 10

ROLLBACK;               -- 이전 명령 뭉치를 되돌린다

DELETE FROM depart2
WHERE dno = 10;

COMMIT;
ROLLBACK;               -- COMMIT이 완료된 이후이기 때문에 되돌리기가 불가능하다.


SELECT * FROM department;
SELECT * FROM depart2;


-- Practice
CREATE TABLE EMP_INSERT
AS SELECT * FROM employee
WHERE 1=0;

INSERT INTO EMP_INSERT(eno,ename,hiredate) VALUES (5002,'TY',SYSDATE);

INSERT INTO EMP_INSERT(eno,ename,hiredate) VALUES (5001,'KIM',SYSDATE-1);

CREATE TABLE EMP_COPY
AS SELECT * FROM employee;

UPDATE EMP_COPY
SET dno = 10
WHERE eno = 7788;

UPDATE EMP_COPY
SET job = (SELECT job
            FROM EMP_COPY
            WHERE eno = 7499)
, salary = (SELECT salary
            FROM EMP_COPY
            WHERE eno = 7499)
WHERE eno = 7788;

UPDATE EMP_COPY
SET dno = (SELECT dno
            FROM EMP_COPY
            WHERE eno = 7369)
WHERE job = (SELECT job
            FROM EMP_COPY
            WHERE eno = 7369);
            
CREATE TABLE DEPT_COPY
AS SELECT * FROM department;

DELETE FROM dept_copy
where dname = 'RESEARCH';

DELETE FROM dept_copy
where dno = '10' or dno = '40';


ROLLBACK;
COMMIT;
SELECT * FROM EMP_INSERT;
SELECT * FROM EMP_COPY;
SELECT * FROM dept_copy;



--> CH.7 테이블 제어 DDL
/*
CREATE TALBE (Name)
CREATE TALBE (Name) (컬럼명1,타입1(바이트크기),컬럼명2,타입2(바이트크기)...)
영어,숫자,특수문자(_,#,$) 조합의 30자 이내로 작성가능
대소문자 구분은 없다, 소문자로 저장하려면 별도로 ""로 묶는다
다른 객체의 이름과 중복되면 안된다.
*/
CREATE TABLE dept2(
        dno NUMBER(2), 
        dname VARCHAR2(14), 
        loc VARCHAR2(13)
        );
SELECT    * FROM dept2;

/*
서브 쿼리를 이용해 새로운 테이블 생성 가능.
다만, not null 을 제외한 제약조건을 복사 할 수 없다.
CREATE TABLE 테이블명[컬럼 순서...] AS 서브쿼리
*/
create table dept_second
as SELECT * FROM department;

SELECT    * FROM department;

create table dept_third
as SELECT * FROM department
where 0=5;    -- where false식 = 테이블 구조만 복사

SELECT * FROM dept_third;

create table dept20
as SELECT eno,ename,salary*12 as "ani_sal"  -- 칼럼에 수식이 들어간 형태는 반드시 별칭을 지정.
from employee
where dno = 20;

SELECT * FROM dept20;


/*
ALTER: 테이블 구조 및 정보 변경 (시험x)
컬럼 생성: ALTER TABLE 테이블명 ADD(컬럼명 타입(크기))
컬럼 변경: ALTER TABLE 테이블명 MODIFY 컬럼명 타입(크기)
컬럼 수정: ALTER TABLE 테이블명 RENAME COLUMN 컬럼명 to N컬럼명
컬럼 삭제: ALTER TABLE 테이블명 DROP COLUMN 컬럼명
*/
ALTER TABLE dept20 ADD(birth data);   -- data는 default 크기
ALTER TABLE dept20 MODIFY ename varchar2(30);
ALTER TABLE dept20 RENAME COLUMN school to education;
ALTER TABLE dept20 DROP COLUMN age;

/*
RENAME: 테이블 이름 변경
RENAME 테이블명 TO N테이블명
*/

rename dept20 to emp20;

SELECT * FROM emp20;

/*
DROP: 테이블 삭제 [테이블 내부 레코드까지 전부 삭제]
DROP TABLE 테이블
*/
drop table emp20;

/*
TRUNCATE: 구조를 남기고 모든 레코드를 삭제
TRUNCATE TABLE 테이블
*/
TRUNCATE TABLE dept_second;
SELECT * FROM dept_second;


-- 데이터 사전
/*
USER_: 자신의 계정이 소유한 객체 등에 관한 정보 조회
ALL_ : 자신 계정 소유 또는 권한을 부여 받는 객체 등에 관한 정보 조회
DBA_ : 데이터 베이스 관리자만 접근 가능한 객체 등의 정보 조회
*/
/*
user_
TABLES: 사용자가 소유한 테이블 정보
SEQUENCES: 사용자가 소유한 시퀀스 정보
INDEXES: 사용자가 소유한 인덱스정보
VIEWS: 사용자가 소유한 뷰 정보
*/
select * from user_tables;

select * from all_TABLES;   -- hr 계정에서 접근 가능한 모든 테이블의 소유 및 권한 조회
select * from dba_tables;   -- dba: 시스템 계정으로만 접근 가능


-- Practice
create table dept (
        dno number(2),
        dname varchar2(14),
        loc varchar2(13)
        );
SELECT * FROM dept;

create table emp(
        eno number(2),
        ename varchar2(10),
        dno number(2)
        );
SELECT * FROM emp;

ALTER TABLE emp MODIFY ename VARCHAR2(25);

SELECT * FROM employee;
create table employee2
as SELECT eno as "EMP_ID",ename as name,salary as sal, dno as "DEPT_ID"
from employee;
SELECT * FROM employee2;

drop table emp;

rename employee2 to emp;
SELECT * FROM emp;

SELECT * FROM dept;
ALTER TABLE dept DROP COLUMN dname;
ALTER TABLE dept RENAME COLUMN loc to unused;
ALTER TABLE dept DROP COLUMN unused;




--> CH.8 데이터 무결성과 제약조건
/*
무결성은 데이터의 정확성, 일관성, 유효성이 유지되는 것을 말하며 데이터베이스 관리 시스템의 중요한 기능이다.
개체 무결성 : 모든 테이블은 기본키로 선택된 필드를 가져야 한다.
참조 무결성 : 참조관계에 해당하는 두 테이블의 데이터를 항상 일관된 값을 가져야 한다.
도메인 무결성 : 테이블에 존재하는 필드의 무결성을 보장하기 위한 것 NOY NULL,필드 타입등이 있다
무결성 규칙 : 도메인 무결성보다 넓은 개념의 무결성이며 모든 데이터베이스 전체에 공통으로 적용되는 규칙
*/
/*
제약조건
데이터 무결성 제약 조건이란 테이블에 적절하지 않는 값이 입력되는 것을 방지하기 위해 테이블을 생성할 때 각 컬럼에 정의하는 여러 가지 규칙을 말한다.
NOT NULL: 칼럼에 NULL 값을 포함하지 못하도록 지정한다.
UNIQUE: 테이블의 모든 로우에 대해서 유일한 값을 갖도록 한다.
PRIMARY KEY: 테이블의 각 레코드를 식별하기 위해 사용되는 키로 NULL과 중복된 값을 모두 허용하지 않는다 (NOT NULL + UNIQUE)(기본값)
FOREIGN KEY: 참조되는 테이블에 컬럼의 값이 항상 존재해야 한다.
CHECK: 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값 만을 허용한다.
*/

-- not null
create table customer(
    id varchar2(20) unique,
    pwd varchar2(20) not null,      -- 문자타입(char)
    name varchar2(20) not null      -- null값이 들어갈 수 없다.
);
insert into customer
values('asdf','1234',null);     -- not null 제약조건 때문에 null값이 들어갈 수 없다.
insert into customer
values('asdf','1234','park');
insert into customer
values('asdf','6789','kim');    -- unique 제약조건으로 다른 튜플과 같은 값이 들어갈 수 없다.
SELECT * FROM customer;

drop table customer;

/*
제약조건 이름 지정
칼럼명 타입(크기) constraint 제약조건이름 제약조건
테이블 생성시 직접 제약조건의 이름을 부여 할 수 있다.
제약조건을 재확인 하는 과정에서 편리하다.
*/
create table customer(
    id varchar2(20) constraint customer_id_uq unique,
    pwd varchar2(20) constraint customer_pwd_nn not null,
    name varchar2(20) constraint customer_name_nn not null
);
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('CUSTOMER');    -- ''안에 들어가 있기 때문에 대문자로 저장된 스키마 값을 불러와야한다.

alter table customer drop constraint customer_id_uq;    -- constraint 삭제방법


-- PRIMARY KEY (NOT NULL + UNIQUE)
/*
PRIMARY KEY 제약조건은 테이블에 기본 키를 생성합니다.
테이블에는 반드시 기본키가 존재해야 하며 기본키는 두가지 특성을 가진다. NULL값을 가질 수 없고, 고유해야 한다.(NOT NULL + UNIQUE)
기본키는 특정 레코드를 고유하게 구분(식별)할 수 있어야 한다.(개체 무결성)
*/
CREATE TABLE customer(
    id varchar2(20),
    pwd varchar2(20) constraint customer_pwd_nn not null,
    name varchar2(20) constraint customer_name_nn not null,
    CONSTRAINT custormer_id_pk PRIMARY KEY(id)          -- 제약조건을 따로 지정할 경우 제약조건 뒤에 컬럼명을 명시한다. 제약조건(컬럼명)
);

insert into customer
VALUES('asdf','1234','park');
insert into customer
VALUES('asdf','6789','kim');
insert into customer            -- id: priamry key의 unique에 걸린다
VALUES(null,'1597','hong');     -- id: priamry key의 not null에 걸린다

SELECT table_name, constraint_name
FROM user_constraints
where table_name in('CUSTOMER');


-- FOREIGN KEY: 참조 무결성을 위한 외래키 제약조건을 생성한다.
/*
외래키 제약 조건을 생성하면 두 테이블 간의 관계가 형성된다.
이때 외래키가 생성되는 테이블을 참조테이블 또는 자식테이블이라고 부른다.
외래키가 가르키는 대상이 되는 테이블을 기준 테이블 또는 부모 테이블이라고 부른다.
참조의 대상이 되는 키는 반드시 기본키나 유니크 제약조건이 있어야 한다.
자식 테이블의 외래키는 부모 테이블의 기본키를 참조하고 있다.
외래키 제약조건에 걸린 해당 컬럼에 데이터를 입력하기 위해서는 부모의 해당 데이터에 '존재' 해야한다.
부모에 존재하지 않는 데이터 입력시 오류를 발생 시킨다.
*/
CREATE TABLE Student(
    stuno varchar2(20) CONSTRAINT Student_id_pk PRIMARY KEY,
    name varchar2(20) constraint Student_pwd_nn not null,
    major varchar2(20)
);

create table registration (
    enrollid varchar2(20),
    stuno varchar2(20), 
    subject varchar2(20) constraint registration_subject_nn not null, 
    constraint registration_enrollid_pk primary key(enrollid), 
    constraint registration_stuno_fk foreign key(stuno) references student(stuno)   -- foreign key 제약조건 생성은 따로 참조
);

drop table registration;

insert into student
VALUES('S001','Ko','math');
insert into student
VALUES('S002','Hong','physics');
insert into student
VALUES('S003','lisa','computer science');

insert into registration
VALUES('E001','S001','Linear Algebra');
insert into registration
VALUES('E002','S002','Algorithm');
insert into registration
VALUES('E003','S005','Constitutional Law');     -- S005는 데이터에 존재하지 않으므로 참조 불가


-- CHECK
/*
CHECK 제약조건은 컬럼에 저장 가능한 데이터의 범위나 조건을 정의한다.
해당 범위나 조건에 벗어나는 값이 들어오면 오류를 발생 시킨다.
*/
CREATE TABLE customer(
    id varchar2(20) constraint customer_id_pk primary key,
    pwd varchar2(20) constraint customer_pwd_nn not null,
    name varchar2(20) constraint customer_name_nn not null,
    jumsu number(3) CONSTRAINT customer_jumsu_range check(0<=jumsu and jumsu<=100)
);
SELECT * FROM customer;

insert into customer
VALUES('asdf','1234','park',75);
insert into customer
VALUES('qwer','6789','kim',123);    -- jumsu(check): 0<=a=<100
insert into customer
VALUES('zxcv','1597','hong',-65);   -- jumsu(check): 0<=a=<100


-- 제약조건 변경
/*
ALTER TABLE~~
제약 조건 추가: add
제약 조건 변경: modity
제약 조건 제거: drop
*/
create table stu_copy
as SELECT * FROM student;
SELECT * FROM stu_copy;
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('STU_COPY');

create table reg_copy
as SELECT * FROM registration;
SELECT * FROM reg_copy;
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('REG_COPY');

alter table stu_copy
add constraint stu_copy_stuno_pk PRIMARY KEY(stuno);
alter table reg_copy
add constraint stu_copy_enrollid_pk PRIMARY KEY(enrollid);
alter table reg_copy
add constraint reg_copy_stuno_fk foreign KEY(stuno) references student(stuno);

alter table stu_copy
modify major CONSTRAINT stu_copy_major_nn not null;

alter table reg_copy
drop primary key;
alter table stu_copy
drop primary key cascade;
alter table stu_copy
drop constraint stu_copy_major_nn;


-- 제약조건 활성화/비활성화

SELECT table_name, constraint_name, status
FROM user_constraints
where table_name in('STUDNET','REGISTRATION');

alter table registration
disable constraint registration_stuno_fk;

insert into registration
values ('E003','S005','Constitutional Law0');

alter table registration
enable CONSTRAINT registration_stuno_fk;        -- 무결성 체크를 하기 때문에 이전 삽입된 행으로 인해 사용 불가

alter table registration
enable novalidate CONSTRAINT registration_stuno_fk;     -- novalidate: 기존 데이터는 무시하고 이후 삽입되는 튜플만 무결성 체크

-- Practice

create table emp_sample
as SELECT * FROM employee
where 0=1;
alter table emp_sample
add constraint my_emp_pk PRIMARY KEY(eno);


CREATE TABLE dept_sample 
AS  SELECT * FROM department
WHERE 1=0; 
ALTER TABLE dept_sample 
ADD CONSTRAINT my_dept_pk PRIMARY KEY(dno); 

ALTER TABLE emp_sample 
ADD CONSTRAINT my_emp_dept_fk 
FOREIGN KEY(dno) REFERENCES dept_sample(dno); 

ALTER TABLE emp_sample 
ADD CONSTRAINT emp_commission_min CHECK(commission>0); 

SELECT * FROM emp_sample;
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('EMP_SAMPLE');