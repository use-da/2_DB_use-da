--1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 “학과 명”, “계열”으로 표시하도록 한다

SELECT DEPARTMENT_NAME 학과이름, CATEGORY 계열
FROM TB_DEPARTMENT


--2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
SELECT DEPARTMENT_NAME || '의 정원은 ' ||CAPACITY ||'명 입니다.'"학과별 정원"
FROM TB_DEPARTMENT

--3. “국어국문학과”에 다니는 여학생 중 현재 휴학중인 여학생을 출력
SELECT STUDENT_NAME 
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '국%'
AND STUDENT_SSN LIKE '2%'
AND ABSENCE_YN ='Y';

--4. 도서관에서 대출 도서 장기 연체자들을 찾아 이름을 게시해라. 
--학번 A513079, A513090, A513091, A513110 , A513119
SELECT STUDENT_NAME 
FROM TB_STUDENT 
WHERE STUDENT_NO = 'A513079'
OR STUDENT_NO = 'A513090'
OR STUDENT_NO = 'A513091'
OR STUDENT_NO = 'A513110'
OR STUDENT_NO = 'A513119';

--5. 입학정원이 20명이상 30명이하인 학과의 이름과 계열을 출력
SELECT DEPARTMENT_NAME , CATEGORY 
FROM TB_DEPARTMENT 
WHERE CAPACITY >= 25
AND CAPACITY <= 30;

--6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 지니고 있다. 춘 기술대학교 총장의 이름을 출력
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO IS NULL;

--7. 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인
SELECT STUDENT_NAME 
FROM TB_STUDENT 
WHERE DEPARTMENT_NO IS NULL;

--8. 수강신청을 하려고 한다. 선수과목 여부를 확인하는데 선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해라
SELECT CLASS_NO 
FROM TB_CLASS 
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. 춘 대학에는 어떤 계열들이 있는지 조회
SELECT CATEGORY 
FROM TB_DEPARTMENT
GROUP BY CATEGORY;

--10. 02학번 전주 거주자들의 모임을 만들 때 휴학한 사람들은 제외하고 재학중인 학생들의 학번, 이름, 주민번호를 출력
SELECT STUDENT_NO , STUDENT_NAME ,STUDENT_SSN 
FROM TB_STUDENT 
WHERE ABSENCE_YN != 'Y'
AND STUDENT_NO LIKE 'A2%'
AND STUDENT_ADDRESS LIKE '%전주%';

--1. 영어영문학과(학과코드002) 학생들의 학번과 이름, 입학년도를 입학년도가 빠른순으로 표시해 출력(”학번”, ”이름”, “입학년도”표시)
SELECT STUDENT_NO ,STUDENT_NAME ,SUBSTR(ENTRANCE_DATE,1,8)입학년도 
FROM TB_STUDENT
WHERE DEPARTMENT_NO LIKE '%002%'
ORDER BY 입학년도;

--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다. 교수의 이름과 주민번호를 화면에 출력(결과값 다를 시 원인분석)
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR 
WHERE PROFESSOR_NAME NOT LIKE '___';

--3. 춘 기술대학교의 남자 교수들의 이름, 나이 출력(나이 오름차순 + ‘만’ 나이, 교수 중 2000년 이후 출생자 없음, “교수이름”, ”나이”표시)
SELECT PROFESSOR_NAME 교수이름 , FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE( 19 || SUBSTR(PROFESSOR_SSN,1,6)))/12) 나이 
FROM TB_PROFESSOR 
WHERE SUBSTR(PROFESSOR_SSN, 8, 1)='1'
ORDER BY 나이;

--나이 : EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(19 ||SUBSTR(PROFESSOR_SSN,1,6))
--만 나이 : MONTH_BETWEEN(SYSDATE,TO_DATE(19 ||SUBSTR(PROFESSOR_SSN,1,6)))/12

--4. 교수들의 이름 중 성을 제외한 이름만 출력(”이름”표시, 성이 2자인 교수는 없다고 가정)
SELECT SUBSTR(PROFESSOR_NAME,2) 
FROM TB_PROFESSOR

--5. 춘 기술대학교의 재수생 입학자 출력(19세에 입학 시 재수 아님)
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT 
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)
-EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6)))>19;

--6. 2020년 크리스마스는 무슨 요일
SELECT TO_CHAR(TO_DATE(20201225),'day')
FROM DUAL;

--7. TO_DATE(’99/10/11’,’YY/MM/DD’), TO_DATE(’49/10/11’,’YY/MM/DD’)
--,TO_DATE(’99/10/11’,’RR/MM/DD’),TO_DATE(’49/10/11’,’RR/MM/DD’)는 각각 몇년 몇월 몇일?
SELECT TO_DATE('99/10/11', 'YY/MM/DD')FROM DUAL;
SELECT TO_DATE('49/10/11', 'YY/MM/DD')FROM DUAL;
SELECT TO_DATE('99/10/11', 'RR/MM/DD')FROM DUAL;
SELECT TO_DATE('49/10/11', 'RR/MM/DD')FROM DUAL;


--8. 춘 기술대학교 2000년 이후 입학자들은 학번A시작, 2000년 이전 학번인 학생들의 학번과 이름 출력
SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT 
WHERE STUDENT_NO NOT LIKE 'A%';

--9. 학번이 A517178인 한아름의 총 평점을 출력(”평점”출력, 점수는 반올림 해 소수점 한 자리까지 표기)
SELECT ROUND((SUM(POINT)/8),1) 평점
FROM TB_STUDENT 
JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A517178';

--10. 학과별 학생 수 출력(”학과번호”,”학생 수(명)”표시)
SELECT DEPARTMENT_NO 학과번호, COUNT(*) 학생 수(명)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11. 지도 교수를 배정받지 못한 학생 수 출력(COUNT(*))
SELECT COUNT(*)
FROM TB_STUDENT 
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번 A112113 김고운 의 년도 별 평점을 출력(”년도”, “년도 별 평점” 표시, 점수는 반올림 해 소수점 한 자리까지 표기)
SELECT SUBSTR(TERM_NO,1,4)년도,ROUND(AVG(POINT), 1) "년도 별 평점" 
FROM TB_GRADE
WHERE STUDENT_NO='A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 년도;

--13. 학과 별 휴학생 수 출력(”학과코드명”, “휴학생 수” 표시)   

SELECT DEPARTMENT_NO 학과코드명, SUM(DECODE(ABSENCE_YN,'Y', 1, 0)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO 
ORDER BY DEPARTMENT_NO; 

--COUNT(DECODE(ABSENCE_YN,'Y', 1))"휴학생 수"
--WHERE절 잘못 사용-> 없어야 모든 학과 나온다 --WHERE ABSENCE_YN ='Y'

--14. 춘 대학교에 다니는 동명이인 학생의 이름과 수 출력(”동일이름”, “동명인 수” 표시)
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT 
GROUP BY STUDENT_NAME 
HAVING COUNT(*) >= 2
ORDER BY 1;

--15. 학번이 A112113인 김고운 의 년도, 학기 별 평점 과 년 도별 누적 평점, 총 평점을 출력(평점은 반올림 해 소수점 한 자리까지 표시, “년도” “학기”, “평점” 표시)

FROM TB_GRADE 

SELECT NVL(SUBSTR(TERM_NO, 1, 4), ' ') 년도, NVL(SUBSTR(TERM_NO, 5, 2), ' ')학기, ROUND(AVG(POINT), 1)평점 
FROM TB_GRADE
WHERE STUDENT_NO ='A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2);

-->ORDER BY 절에 함수 작성 가능