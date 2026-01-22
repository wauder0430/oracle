create table tblAAA (
    name varchar2(30) not null,
    color varchar2(30) not null
);

create table tblBBB (
    name varchar2(30) not null,
    color varchar2(30) not null
);

insert into tblAAA values ('강아지', '검정');
insert into tblAAA values ('고양이', '노랑');
insert into tblAAA values ('토끼', '갈색');
insert into tblAAA values ('거북이', '녹색');
insert into tblAAA values ('강아지', '회색');

insert into tblBBB values ('강아지', '검정');
insert into tblBBB values ('고양이', '노랑');
insert into tblBBB values ('호랑이', '주황');
insert into tblBBB values ('사자', '회색');
insert into tblBBB values ('고양이', '검정');

commit;