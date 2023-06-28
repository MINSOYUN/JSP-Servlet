----- 컬럼 추가 ------
ALTER TABLE book ADD visitcount varchar(50);

---- book 조회 ------
select * from book;

----- book 삭제 ------
drop table book;

----- book 생성 ------
create table book(
    no number,
    title VARCHAR2(100 BYTE),
    author VARCHAR2(20 BYTE),
    publisher VARCHAR2(50 BYTE),
    rentyn char(1) not null,
    visitcount VARCHAR2(50 BYTE),
    postdate date default sysdate
);

----- book 생성 ------
ALTER TABLE book ADD sfile varchar(50);

----- book 데이터 생성 ------
insert into book values(seq_book_no.nextval, '문과 남자의 과학 공부', '유시민', '돌베개', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '세이노의 가르침', '세이노', '데이원', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '차가운 자본주의', '윤루카스', '떠오름', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '역행자', '자청', '웅진지식하우스', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '메리골드 마음 세탁소', '윤정은', '북로망스', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '꿀벌의 예언', '베르나르 베르베르', '열린책들', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '도둑맞은 집중력', '요한 하리', '어크로스', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '유연함의 힘', '수잔 애쉬포드', '상상스퀘어', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '1분 요리 뚝딱이형', '뚝딱이형', '길벗', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '내면소통', '김주환', '인플루엔셜', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '유현준의 인문 건축 기행', '을유문학사', '돌베개', 'N', 0, sysdate);
insert into book values(seq_book_no.nextval, '마음의 지혜', '김경일', '포레스트북스', 'N', 0, sysdate);

----- sysdate와 같으면 날짜만 출력 ------
SELECT
  CASE
    WHEN TRUNC(postdate) = TRUNC(sysdate) THEN TO_CHAR(postdate, 'YYYY-MM-DD HH24:MI:SS')
    ELSE TO_CHAR(postdate, 'YYYY-MM-DD')
  END AS 등록일
FROM book;

----- book 조회 쿼리 ------
select no, title, author, publisher, nvl((select 대여여부 from 대여 where 도서번호 = no and 대여여부 ='Y'), 'N') rentyn,
    visitcount, case when trunc(postdate) = trunc(sysdate) then to_char(sysdate, 'YYYY-MM-DD HH24:MI:ss')
    else to_char(postdate, 'YYYY-MM-DD') end from book;

----- 대여 조회 ------    
select * from 대여;

----- book, 대여 조회 ------
 select b.no, b.title, d.대여여부, b.author, b.publisher, b.visitcount, b.postdate, d.아이디, to_char(대여일,'yy/mm/dd') 대여일, to_char(반납가능일,'yy/mm/dd') 반납가능일 
			 , 반납일, sfile, ofile, d.대여번호
from book b, 대여 d
where b.rentno = d.대여번호(+) and b.no=65;

----- book 조회 ------
select * from book
where no='65';

----- book 업데이트 ------
update book set rentno= 'R00076', rentyn='Y'
where no=65 and (rentno is null or rentno='');

----- 대여 insert ------
insert into 대여 values ('R00106', 'ADMIN', '66', 'Y', sysdate, null, sysdate+14, null);


SELECT 'R' || LPAD(no, 5, '0') FROM book;