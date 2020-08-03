/*

    <함수  FUNCTION>
    - 자바로 치면 메소드 같은 존재
    - 전달값을 읽어 계산한 결과를 반환
    
    > 단일행 함수 : N개의 값을 읽어서 N개의 결과 리턴 ( 매 행마다 함수 실행 결과 반환)
    > 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴 ( 하나의 그룹별로 함수 실행 결과 반환)
    
    * 단일 행 함수와 그룹함수는 함께 사용 할 수 없음 !! : 결과 행의 갯수 가 다르기 때문

    * 함수를 쓸 수 있는 위치 : SELECT 절, WHERE 절, ORDER BY 절 , GROUP BY 절, HAVING 절                         

*/


------------------------------------< 단일행 함수 > --------------------------------------

/*
    < 문자 관련 함수>
    
    * LENGTH / LENGTHB
    
    LENGTH(STRING) : 해당 문자의 글자 수 반환
    LENGTHB(STRING) : 해당 문자의 바이트 수를 반환    
    
   > 결과값을 NUMBER 값으로 반환 
    
   >  STRING : 문자에 해당하는 컬럼 | '문자값'
    '가', '강', '나' 한글 한 글자당 3 BYTE로 취급
    'A', 'a', '1', '!' 한 글자당 1BYTE로 취급
    


*/

SELECT LENGTH('오라클'), LENGTHB('오라클!')
FROM DUAL; --> 가상테이블 (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-----------------------------------------------------------------
/*

    * INSTR
    문자열로부터 특정 문자의 위치값 반환
    
    INSTR(STRING, '문자', [찾을위치의시작값, {순번] ])
    => 결과값 NUMBER 타입
    
    > 찾을위치의 시작값
    1 : 앞에서부터 찾겠다! (기본값)
    -1 : 뒤에서부터 찾겠다!
    
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 찾을 위치 시작값, 순번 생략시 앞에서부터 첫번째의 B의 위치값
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 위와 동일
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL, '@') "@위치"
FROM EMPLOYEE;

------------------------------------------------


/*

    * SUBSTR
    문자열로부터 특정 문자열을 추출해서 반환
    (자바로 치면 문자열.substring() 메소드와 유사)
    
    => 결과값 CHRACTER 타입 반환
    
    SUBSTR(STRING, POSITION, LENGTH)
    
    > STRING : 문자타입 컬럼 또는 '문자값'
    > POSITION : 문자열을 잘라낼 시작위치값
    > LENGTH : 추출할 문자 개수( 생략시 끝까지 의미)
    
    

*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',-8, 3) FROM DUAL; -- 시작위치를 음수값으로 제시하면 뒤에서부터 위치를 찾음


SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) 성별
FROM EMPLOYEE;

-- 남자 사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 여자 사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

---------------------------------------------------------------------

/*
    * LPAD / RPAD
    문자에 대해 통일감있게 보여주고자 할 때 사용

    => 결과값 CHARACTER 타입

    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이(바이트), [덧붙이고자하는 문자])

    제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽 덧붙여 최종 N길이 만큼 문자열 반환
    > 덧붙이고자 하는 문자 생략시 기본값이 공백으로 처리
    
    
*/

SELECT EMAIL,  RPAD(EMAIL,20,'$')
FROM EMPLOYEE;

-- 891201-2***** 주민번호 조회      => 총 글자수 : 14글자
SELECT RPAD('891201-2', 14, '*') FROM DUAL;


-- 함수 중첩으로 사용 가능
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8),14,'*') "주민번호 암호화"
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*

    *LTRIM  / RTRIM
    
    
    LTRIM/RTRIM(STRING, [제거하고자하는 문자들] )

    문자열의 왼쪽 혹은 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
        
*/

SELECT LTRIM('     K H      ') FROM DUAL;
SELECT LTRIM('00012345600', '0') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL; -- 해당하는 문자를 다 지운다! 순서 상관없이!
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('578123KH', '0123456789') FROM DUAL;








