/*
	SEQUENCE(순서, 연속, 수열)
	: 순차적 번호 자동 생성기 역할의 객체

	SEQUENCE 객체를 생성해서 호출하게 되면 지정된 범위 내에서 일정한 간격으로 증가하는 숫자가 순차적으로 출력됨

	EX) 1부터 10까지 1씩 증가하고 반복하는 시퀀스 객체
	1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10...
	
	SEQUENCE는 주로 PK역할의 컬럼에 삽입되는 값을 만드는 용도로 사용 -> 인위적 주 식별자

	[작성법]
  	CREATE SEQUENCE 시퀀스이름
	  [STRAT WITH 숫자]             : 처음 발생시킬 시작값 지정, 생략하면 자동 1이 기본
	  [INCREMENT BY 숫자]           : 다음 값에 대한 증가치, 생략하면 자동 1이 기본
   	  [MAXVALUE 숫자 | NOMAXVALUE]  : 발생시킬 최대값 지정 (10의 27승 -1)
 	  [MINVALUE 숫자 | NOMINVALUE]  : 최소값 지정 (-10의 26승)
 	  [CYCLE | NOCYCLE]            : 값 순환 여부 지정
	  [CACHE 바이트크기 | NOCACHE]    : 캐시메모리 기본값은 20BYTE, 최소값은 2BYTE
								
	*시퀀스의 캐시 메모리는 할당된 크기만큼 미리 다음 값들을 생성해 저장해둠
	-> 시퀀스 호출 시 미리 저장되어진 값들을 가져와 반환하므로 매번 시퀀스를 생성해서 반환하는 것보다 DB속도가 향상됨.

    ** 시퀀스 사용 방법 **
    1) 시퀀스명.NEXTVAL : 다음 시퀀스 번호를 얻어옴. (INCREMENT BY만큼 증가된 값)
                        단, 시퀀스 생성 후 첫 호출인 경우 START WITH의 값을 얻어옴.
    2) 시퀀스명.CURRVAL : 현재 시퀀스 번호 얻어옴.
                        단, 시퀀스 생성 후 NEXTVAL 호출 없이 CURRVAL를 호출하면 오류 발생.


*/

--옵션 없이 SEQUENCE 생성 
-- 범위 : 1 ~ 10^38
-- 시작 : 1
-- 반복 : NOCYCLE
-- 캐시메모리 20BYTE 
CREATE SEQUENCE SEQ_TEST;


-- *CURRVAL 주의사항
-- CURRVAL는 마지막 NEXTVAL 호출 값을 다시 보여주는 기능
-- -> NEXTVAL을 먼저 호출해야 CURRVAL 호출 가능
SELECT SEQ_TEST.CURRVAL FROM DUAL;
-- ORA-08002: 시퀀스 SEQ_TEST.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다

SELECT SEQ_TEST.NEXTVAL FROM DUAL; --1
SELECT SEQ_TEST.CURRVAL FROM DUAL; --1

SELECT SEQ_TEST.NEXTVAL FROM DUAL; --2
SELECT SEQ_TEST.NEXTVAL FROM DUAL; --3
SELECT SEQ_TEST.NEXTVAL FROM DUAL; --4
SELECT SEQ_TEST.NEXTVAL FROM DUAL; --5
SELECT SEQ_TEST.CURRVAL FROM DUAL; --5












