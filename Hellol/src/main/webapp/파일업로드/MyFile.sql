create table myfile(
    idx number primary key,
    name varchar2(50) not null,
    title varchar2(200) not null,
    cate varchar2(30) ,
    ofile varchar2(100) not null,
    sfile varchar2(100) not null,
    postdate date default sysdate not null
);

comment on column myfile.idx is '일련번호';
comment on column myfile.name is '작성자';
comment on column myfile.title is '제목';
comment on column myfile.cate is '카테고리';
comment on column myfile.ofile is '원본 파일명';
comment on column myfile.sfile is '저장된 파일명';
comment on column myfile.postdate is '등록한 날짜';