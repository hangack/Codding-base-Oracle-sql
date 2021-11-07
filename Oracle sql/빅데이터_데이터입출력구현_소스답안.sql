create table "productsTbl"(
    "productid" CHAR(10) constraint pk_productsTbl_productid PRIMARY key,
    "projuctName" NVARCHAR2(20) not null,
    "price" number not null,
    "amount" number not null
);
create table "customerTbl"(
    "customerid" CHAR(10) constraint pk_customerTbl_customerid PRIMARY key,
    "customername" NVARCHAR2(20) not null,
    "customerAddr" NVARCHAR2(100) not null,
    "customerContact" CHAR(11) not null
);
create table "tradeTbl"(
    "tradeNo" CHAR(10)constraint pk_tradeTbl_tradeNo PRIMARY key,
    "productid" CHAR(10) not null,
    "customerid" CHAR(10) not null,
    "tradeAmount" number not null,
    constraint fk_tradeTbl_productid foreign key("productid") references "productsTbl"("productid"),
    constraint fk_tradeTbl_customerid foreign key("customerid") references "customerTbl"("customerid")
);


insert into "productsTbl"
values('B001','JAVA',20000,100);
insert into "productsTbl"
values('B002','HTML&CSS',15000,150);
insert into "productsTbl"
values('B003','Python',17500,200);
insert into "productsTbl"
values('B004','javaScript',17000,150);
insert into "productsTbl"
values('B005','Oracle',25000,75);

insert into "customerTbl"
values('S001','수주IT그룹','경기도 수원시','01012345678');
insert into "customerTbl"
values('N001','남양 소프트웨어','경기도 화성시','01045679365');
insert into "customerTbl"
values('K001','과주 IDC 센터','경기도 과천시','01014753695');
insert into "customerTbl"
values('K002','금주정보통신','경기도 시흥시','01098753215');
insert into "customerTbl"
values('S002','서원 소프트','경기도 용인시','01012357895');

insert into "tradeTbl"
values('T001','B003','S002',30);
insert into "tradeTbl"
values('T002','B003','N001',40);
insert into "tradeTbl"
values('T003','B004','S002',20);
insert into "tradeTbl"
values('T004','B005','N001',40);
insert into "tradeTbl"
values('T005','B004','K002',50);


commit;

SELECT * FROM "productsTbl";
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('productsTbl');

SELECT * FROM "customerTbl";
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('customerTbl');

SELECT * FROM "tradeTbl";
SELECT table_name, constraint_name
FROM user_constraints
where table_name in('tradeTbl');