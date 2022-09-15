--DDL(Data Definition Language)
--객체(OBJECT)를 만들고(CREATE), 수정(ALTER)하고, 삭제(DROP)하는 데이터 정의 언어

/* ALTER(바꾸다, 수정하다, 변조하다)

	테이블에서 수정할 수 있는 것
 	1) 제약조건(추가/삭제)
 	2) 컬럼(추가/수정/삭제)
 	3) 이름 변경(테이블, 제약조건명, 컬럼명)
 
 */

-- 1. 제약조건(추가/삭제)
-- [작성법]
-- 1) 추가 : ALTER TABLE 테이블명 ADD[CONSTRAINT 제약조건명] 제약조건(지정할 컬럼명)
--			[REFERENCES 테이블명[(컬럼명)]];   <-- FK인 경우 추가
-- 2) 삭제 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

-- *수정은 별도 존재하지 않음 -> 삭제 후 추가를 이용해 수정

-- DEPARTMENT 테이블 복사(컬럼명, 데이터타입, NOT NULL만 복사)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 추가
ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_U UNIQUE(DEPT_TITLE);

-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 삭제
ALTER TABLE DEPT_COPY DROP CONSTRAINT DEPT_U;

-- ***DEPT_COPY의 DEPT_TITLE 컬럼에 NOT NULL 추가/삭제***
ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_NN NOT NULL(DEPT_TITLE);
--> NOT NULL 제약조건은 새로운 조건을 추가하는 것이 아닌 컬럼 자체에 NULL 허용/비허용을 제어하는 성질 변경의 형태로 인식됨

--MODIFY(수정하다) 구문을 사용해서 NULL제어
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NOT NULL;

ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NULL;

-- 2. 컬럼(추가/수정/삭제)
-- [작성법]
-- 1) 추가 : ALTER TABLE 테이블명 ADD(컬럼명 데이터타입 [DEFAULT '값']);

-- 2) 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;          -> 데이터타입 변경
-- 		    ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT '값';      -> DEFAULT '값' 변경
-- 		    ALTER TABLE 테이블명 MODIFY 컬럼명 NULL / NOT NULL;  -> NULL 여부 변경

-- 3) 삭제 : ALTER TABLE 테이블명 DROP(컬럼명); 
-- 		    ALTER TABLE 테이블명 DROP COLUMN 컬럼명; 

--> *컬럼 삭제 시 주의사항
-- 테이블 : 행과 열로 이루어진 DB에 가장 기본적인 객체 , 데이터가 저장됨
-- 테이블은 최소 1개이상의 컬럼이 존재해야 되기 때문에 모든 컬럼은 삭제할 수 없다

SELECT*FROM DEPT_COPY;

-- 컬럼 추가
ALTER TABLE DEPT_COPY ADD(CNAME VARCHAR2(30));

ALTER TABLE DEPT_COPY ADD(LNAME VARCHAR2(30) DEFAULT '한국');
-- 컬럼이 추가되면서 DEFAULT값이 자동 삽입

-- D10 개발1팀 추가
INSERT INTO DEPT_COPY 
VALUES ('D10','개발1팀','L1', DEFAULT, DEFAULT);
-- ORA-12899: "LYH"."DEPT_COPY"."DEPT_ID" 열에 대한 값이 너무 큼(실제: 3, 최대값: 2)

-- DEPT_ID 컬럼 수정
ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);
-- 다시 위 INSERT 구문 실행

-- LNAME 컬럼 기본값 수정
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
-- 기본값을 변경해도 기존 데이터가 변하지 않는다

-- LNAME '한국' -> 'KOREA' 로 변경
UPDATE DEPT_COPY SET
LNAME=DEFAULT 
WHERE LNAME='한국';

COMMIT;

-- 모든 컬럼 삭제
ALTER TABLE DEPT_COPY DROP(LNAME);
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP(LOCATION_ID);
ALTER TABLE DEPT_COPY DROP(DEPT_TITLE);
ALTER TABLE DEPT_COPY DROP(DEPT_ID);
-- ORA-12983: 테이블에 모든 열들을 삭제할 수 없습니다

SELECT*FROM DEPT_COPY;

-- 테이블 삭제
DROP TABLE DEPT_COPY;

-- DEPARTMENT 테이블 복사해 DEPT_COPY 생성
CREATE TABLE DEPT_COPY
AS SELECT*FROM DEPARTMENT; 
-- 컬럼명, 데이터타입, NOT NULL여부만 복사

-- PK추가(DEPT_ID, D_COPY_PK)
ALTER TABLE DEPT_COPY ADD CONSTRAINT D_COPY_PK PRIMARY KEY(DEPT_ID);

-- 3. 이름 변경(테이블, 제약조건명, 컬럼명)
-- [작성법]
-- 1) 테이블 변경 : ALTER TABLE 테이블명(전) RENAME TO 테이블명(후);

-- 2) 제약조건명 변경 : ALTER TABLE 테이블명 RENAME CONSTRAINT 제약조건명(전) TO 제약조건명(후); 

-- 3) 컬럼명 변경 : ALTER TABLE 테이블명 RENAME COLUMN 컬럼명(전) TO 컬럼명(후)

ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME; 
ALTER TABLE DEPT_COPY RENAME CONSTRAINT D_COPY_PK TO DEPT_COPY_PK;
ALTER TABLE DEPT_COPY RENAME TO DCOPY;

SELECT*FROM DEPT_COPY;
SELECT*FROM DCOPY;

-- 4. 테이블 삭제
-- DROP TABLE 테이블명 [CASCADE CONSTRAINTS]

-- 1) 관계가 형성되지 않은 테이블 삭제
DROP TABLE DCOPY;

-- 2) 관계가 형성된 테이블 삭제
CREATE TABLE TB1(
	TB1_PK NUMBER PRIMARY KEY,
	TB1_COL NUMBER
);
CREATE TABLE TB2(
	TB2_PK NUMBER PRIMARY KEY,
	TB2_COL NUMBER REFERENCES TB1 
);

INSERT INTO TB1 VALUES(1,100);
INSERT INTO TB1 VALUES(2,200);
INSERT INTO TB1 VALUES(3,300);

COMMIT;

SELECT * FROM TB1;
SELECT * FROM TB2;

INSERT INTO TB2 VALUES(10,1);
INSERT INTO TB2 VALUES(12,2);
INSERT INTO TB2 VALUES(13,3);
INSERT INTO TB2 VALUES(14,4);
-- ORA-02291: 무결성 제약조건(LYH.SYS_C008422)이 위배되었습니다- 부모 키가 없습니다
DROP TABLE TB1;
-- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다

-- 해결방법 1) 자식, 부모 테이블 순서로 삭제
-- 		  2) ALTER를 이용해 FK 제약조건 삭제 후 테이블 삭제
--		  3) DROP TABLE 삭제옵션 CASCADE CONSTRAINTS 사용
			-- CASCADE CONSTRAINTS : 삭제하려는 테이블과 연결된 FK제약조건을 모두 삭제
DROP TABLE TB1 CASCADE CONSTRAINTS;

-- *** DDL 주의사항 ***
-- 1) DDL은 COMMIT/ROLLBACK이 되지않아 ALTER/DROP을 신중히 해야한다
-- 2) DDL과 DML 구문을 섞어 수행하면 안된다
-- 	  DDL은 수행 시 존재하고 있는 트랜잭션을 모두 DB에 강제COMMIT시킨다
--	  DDL이 종료된 후 DML구문을 수행하도록 권장한다

INSERT INTO TB2 VALUES(14,4);
INSERT INTO TB2 VALUES(15,5);

ALTER TABLE TB2 RENAME COLUMN TB2_COL TO TB2_COLCOL;

ROLLBACK;











