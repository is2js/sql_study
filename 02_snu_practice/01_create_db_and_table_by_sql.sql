-- db 생성 및 use db
CREATE DATABASE pmd;
use pmd;

-- 빈 table 생성 ->  bulk insert into 
-- * person
create table person(
    personid int,
    sex int,
    birthday datetime,
    ethnicity int
);

--
create table electrocardiogram (
    personid int,
    ecgdate datetime null,
    RR int null,
    QT int null,
    QTc int null,
    ACCI int null,
    ecgdept varchar(2) null,
    ecgsource varchar(2) null
);

--
create table laboratory (
    personid int,
    labdate datetime null,
    labname varchar(2) null,
    labvalue float null
);

-- 
create table diagnosis (
personid int,
diagdate datetime,
diagcode varchar(20),
diaglocalcode varchar(20),
diagdept varchar(2)
);

-- 
create table drug (
    personid int,
    drugdate datetime null,
    druglocalcode varchar(20),
    atccode varchar(20),
    drugdept varchar(2),
    [route] varchar(2),
    duration int
);

--
create table diagnosiscodemaster (
    diaglocalcode varchar(20),
    diagnosis varchar(455)
);

create table drugcodemaster (
    druglocalcode varchar(20),
    drugigrdname varchar(100)
);

