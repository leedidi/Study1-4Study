-- 관리자 테이블
CREATE TABLE ADMIN
( AD_ID VARCHAR2(10)
, AD_PW VARCHAR2(15)    CONSTRAINT ADMIN_PW_NN NOT NULL

, CONSTRAINT ADMIN_ID_PK PRIMARY KEY(AD_ID)
);


-- 교수 테이블
CREATE TABLE PROFESSOR
( PRO_ID        VARCHAR2(10)
, PRO_PW        VARCHAR2(15)    
, PRO_NAME      VARCHAR2(10)    CONSTRAINT PROFESSOR_NAME_NN NOT NULL
, PRO_FIRSTSSN  CHAR(6)         CONSTRAINT PROFESSOR_FIRSTSSN_NN NOT NULL
, PRO_LASTSSN   CHAR(7)         CONSTRAINT PROFESSOR_LASTSSN_NN NOT NULL

, CONSTRAINT PROFESSOR_ID_PK PRIMARY KEY(PRO_ID)
, CONSTRAINT PROFESSOR_SSN_UK UNIQUE(PRO_FIRSTSSN, PRO_LASTSSN)
);


-- 학생 테이블
CREATE TABLE STUDENT
( STU_ID            VARCHAR2(10)
, STU_PW            VARCHAR2(15)
, STU_NAME          VARCHAR2(10)    CONSTRAINT STUDENT_NAME_NN NOT NULL
, STU_FIRSTSSN      CHAR(6)         CONSTRAINT STUDENT_FIRSTSSN_NN NOT NULL
, STU_LASTSSN       CHAR(7)         CONSTRAINT STUDENT_LASTSSN_NN NOT NULL

, CONSTRAINT STUDENT_ID_PK PRIMARY KEY (STU_ID)
, CONSTRAINT STUDENT_SSN_UK UNIQUE(STU_FIRSTSSN, STU_LASTSSN)
);


-- 중도탈락사유 테이블
CREATE TABLE DROP_RES
( REASON_NO VARCHAR2(7)
, REASON    VARCHAR2(100) CONSTRAINT DRES_REASON_NN NOT NULL

, CONSTRAINT DRES_REASON_NO_PK  PRIMARY KEY(REASON_NO)
, CONSTRAINT DRES_REASON_UK     UNIQUE(REASON)
);


-- 강의실 테이블
CREATE TABLE ROOM
( ROOM_NO           VARCHAR2(5)
, ROOM_CAPACITY     VARCHAR2(200)
, CONSTRAINT ROOM_NO_PK PRIMARY KEY(ROOM_NO)
);


-- 교재 테이블
CREATE TABLE BOOK
( BOOK_NO       VARCHAR2(7)
, BOOK_NAME     VARCHAR2(100)   CONSTRAINT BOOK_BNAME_NN NOT NULL
, AUTHOR_NAME   VARCHAR2(10)    CONSTRAINT BOOK_ANAME_NN NOT NULL
, PUBLISHER     VARCHAR2(100)   CONSTRAINT BOOK_PUBLISHER_NN NOT NULL

, CONSTRAINT BOOK_NO_PK PRIMARY KEY(BOOK_NO)
);


-- 과정 테이블
CREATE TABLE CURRICULUM
( CUR_NO            VARCHAR2(7)
, CUR_NAME          VARCHAR2(100)   CONSTRAINT CURRICULUM_NAME_NN NOT NULL
, CUR_STARTDATE     DATE
, CUR_ENDDATE       DATE
, ROOM_NO           VARCHAR2(5)

, CONSTRAINT CURRICULUM_NO_PK PRIMARY KEY(CUR_NO)
, CONSTRAINT CURRICULUM_STARTDATE_CK CHECK(CUR_STARTDATE < CUR_ENDDATE)
, CONSTRAINT CURRICULUM_ROOM_NO_FK FOREIGN KEY(ROOM_NO)
                        REFERENCES ROOM(ROOM_NO)
);


-- 과목 테이블
CREATE TABLE SUBJECT
( SUB_NO        VARCHAR2(7)
, SUB_NAME      VARCHAR2(100)   CONSTRAINT SUBJECT_NAME_NN NOT NULL
, BOOK_NO       VARCHAR2(7)

, CONSTRAINT SUBJECT_NO_PK PRIMARY KEY (SUB_NO)
, CONSTRAINT SUBJECT_BOOK_NO_FK FOREIGN KEY (BOOK_NO)
            REFERENCES BOOK(BOOK_NO)
, CONSTRAINT SUBJECT_NAME_UK UNIQUE (SUB_NAME)
);


-- 과목개설 테이블
CREATE TABLE SUB_LIST
( LIST_NO       VARCHAR2(7)
, CUR_NO        VARCHAR2(7) CONSTRAINT SUBLI_CUR_NO_NN NOT NULL
, SUB_NO        VARCHAR2(7) CONSTRAINT SUBLI_SUB_NO_NN NOT NULL
, SUB_STARTDATE DATE
, SUB_ENDDATE   DATE
, PRO_ID        VARCHAR2(10)
, ATTEND_DIV    NUMBER(3)   DEFAULT 0
, PRAC_DIV      NUMBER(3)   DEFAULT 0
, WRITE_DIV     NUMBER(3)   DEFAULT 0

, CONSTRAINT SUBLI_LIST_NO_PK PRIMARY KEY(LIST_NO)

, CONSTRAINT SUBLI_CUR_NO_FK FOREIGN KEY(CUR_NO)
                             REFERENCES CURRICULUM(CUR_NO)
, CONSTRAINT SUBLI_SUB_NO_FK FOREIGN KEY(SUB_NO)
                             REFERENCES SUBJECT(SUB_NO)
, CONSTRAINT SUBLI_PRO_ID_FK FOREIGN KEY(PRO_ID)
                             REFERENCES PROFESSOR(PRO_ID)

, CONSTRAINT SUBLI_SUB_STARTDATE_CK CHECK(SUB_STARTDATE < SUB_ENDDATE)
, CONSTRAINT SUBLI_DIV_CK CHECK(ATTEND_DIV + PRAC_DIV + WRITE_DIV = 100)
, CONSTRAINT SUBLI_ATTEND_DIV_CK CHECK(ATTEND_DIV BETWEEN 0 AND 100)
, CONSTRAINT SUBLI_PRAC_DIV_CK  CHECK(PRAC_DIV BETWEEN 0 AND 100)
, CONSTRAINT SUBLI_WRITE_DIV_CK CHECK(WRITE_DIV BETWEEN 0 AND 100)
);


-- 수강신청 테이블
CREATE TABLE REGISTRATION
( REG_NO    VARCHAR2(7)
, STU_ID    VARCHAR2(10)    CONSTRAINT REGISTRATION_STU_ID_NN NOT NULL
, CUR_NO    VARCHAR2(7)     CONSTRAINT REGISTRATION_CUR_NO_NN NOT NULL
, REG_DATE  DATE DEFAULT SYSDATE

, CONSTRAINT REGISTRATION_REG_NO_PK PRIMARY KEY(REG_NO)
, CONSTRAINT REGISTRATION_STU_ID_FK FOREIGN KEY(STU_ID)
                            REFERENCES STUDENT(STU_ID)
, CONSTRAINT REGISTRATION_CUR_NO_FK FOREIGN KEY(CUR_NO)
                            REFERENCES CURRICULUM(CUR_NO)
);


-- 성적 테이블
CREATE TABLE SCORE
( SCORE_NO      VARCHAR2(7)
, REG_NO        VARCHAR2(7) CONSTRAINT SCORE_REG_NO_NN NOT NULL
, LIST_NO       VARCHAR2(7) CONSTRAINT SCORE_LIST_NO_NN NOT NULL
, ATTEND_SCORE  NUMBER(3) DEFAULT 0
, PRAC_SCORE    NUMBER(3) DEFAULT 0
, WRITE_SCORE   NUMBER(3) DEFAULT 0

, CONSTRAINT SCORE_NO_PK PRIMARY KEY(SCORE_NO)
, CONSTRAINT SCORE_REG_NO_FK FOREIGN KEY(REG_NO)
             REFERENCES REGISTRATION(REG_NO)
, CONSTRAINT SCORE_LIST_NO_FK FOREIGN KEY(LIST_NO)
             REFERENCES SUB_LIST(LIST_NO)
, CONSTRAINT SCORE_ATTEND_CK CHECK (ATTEND_SCORE BETWEEN 0 AND 100)
, CONSTRAINT SCORE_PRAC_CK CHECK (PRAC_SCORE BETWEEN 0 AND 100)
, CONSTRAINT SCORE_WRITE_CK CHECK (WRITE_SCORE BETWEEN 0 AND 100)
);


-- 중도탈락학생 테이블
CREATE TABLE STU_DROP
( DROP_NO       VARCHAR2(7)
, REG_NO        VARCHAR2(7) CONSTRAINT STUDROP_REG_NO_NN NOT NULL
, STU_DROPDATE  DATE        DEFAULT SYSDATE
, REASON_NO     VARCHAR2(7)
, CONSTRAINT STUDROP_NO_PK    PRIMARY KEY(DROP_NO)
, CONSTRAINT STUDROP_REG_NO_FK     FOREIGN KEY(REG_NO)
             REFERENCES REGISTRATION(REG_NO)
, CONSTRAINT STUDROP_REASON_NO_FK  FOREIGN KEY(REASON_NO)
             REFERENCES DROP_RES(REASON_NO)
);

SELECT *
FROM TAB;