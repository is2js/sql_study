--������ ���̽� ����
create database PMD 

--����� ������ ���̽� ����
use PMD

--���̺� ����
create table Person (
personid int,
sex int,
birthday datetime,
ethnicity int
)

--
bulk insert Person from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\sample_person.csv'
with (firstrow=2, format='CSV')



create table Electrocardiogram (
personid int,
ecgdate datetime null,
RR int null,
QT int null,
QTc int null,
ACCI int null,
ecgdept varchar(2) null,
ecgsource varchar(2) null,
)
bulk insert Electrocardiogram from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\sample_Electrocardiogram.csv'
with (firstrow=2, KEEPNULLS, format='CSV')


create table Laboratory (
personid int,
labdate datetime null,
labname varchar(2) null,
labvalue float null
)

bulk insert Laboratory from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\sample_Laboratory.csv'
with (firstrow=2, KEEPNULLS, format='CSV')




create table Diagnosis (
personid int,
diagdate datetime,
diagcode varchar(20),
diaglocalcode varchar(20),
diagdept varchar(2)
)

bulk insert Diagnosis from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\sample_Diagnosis.csv'
with (firstrow=2, KEEPNULLS, format='CSV')




drop table Drug
create table Drug (
personid int,
drugdate datetime null,
druglocalcode varchar(20),
atccode varchar(20),
drugdept varchar(2),
[route] varchar(2),
duration int
)

bulk insert Drug from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\sample_Drug.csv'
with (firstrow=2, KEEPNULLS, format='CSV')



create table DiagnosisCodeMaster (
diaglocalcode varchar(20),
diagnosis varchar(max)
)


bulk insert DiagnosisCodeMaster from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\DiagnosisCodeMaster.csv'
with (firstrow=2, KEEPNULLS, format='CSV')



create table DrugCodeMaster (
druglocalcode varchar(20),
drugigrdname varchar(100)
)
bulk insert DrugCodeMaster from 'C:\Users\is2js\Desktop\����Ȱ��\0111 DB���̳�\sql_loading_sample\DrugCodeMaster.csv'
with (firstrow=2, KEEPNULLS, format='CSV')




