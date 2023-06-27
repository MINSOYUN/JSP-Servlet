ALTER TABLE book ADD visitcount varchar(50);
select * from book;

drop table book;
create table book(
    no number,
    title VARCHAR2(100 BYTE),
    author VARCHAR2(20 BYTE),
    publisher VARCHAR2(50 BYTE),
    rentyn char(1) not null,
    visitcount VARCHAR2(50 BYTE),
    postdate date default sysdate
);

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