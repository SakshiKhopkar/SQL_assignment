create table Doctor (
Did int not null,
dname varchar(25),
Daddresss varchar(30),
Qualification varchar(30),
noOfPtient_handeled int,
)
drop table doctor
create table PtientMaster (
Pcode int not null,
Pname varchar(30),
Paddr varchar(30),
age int,
gender varchar(20),
BloodGroup varchar(20),
)
drop table PtientMaster
create table AdmittedPatient
(
pcode int,
Entry_date date,
Discharge_date date,
WardNo int,
Disease varchar(30),
did int,
)
drop table AdmittedPatient
create table Bill(
Pcode int,
Bill_amount int, 
)
select * from bill
drop table Bill
---------------------------------------------------------------------------------------------------------------------------------------------------
--1)write a queries to create all tables with primary key ,foreign key 
alter table Bill add constraint Fk_Pcode foreign key (pcode) references ptientMaster(pcode)
alter table admittedpatient add constraint fk_pcodeA foreign key (pcode) references PtientMaster(pcode)
alter table admittedpatient add constraint fk_did foreign key (did) references doctor(did)
alter table ptientmaster add constraint PK_Pcode primary key(pcode)
alter table doctor add constraint pk_Did primary key(did)
--2)write a query to describe above tables.
select d.*,a.*,b.*,p.* from doctor d inner join AdmittedPatient a on a.did=d.did inner join PtientMaster p on p.Pcode=a.pcode
inner join Bill b on b.Pcode=p.Pcode
--3)write a query to drop primary key from patientMaster
alter table ptientMaster drop constraint pk_pcode 
--4)Suppose Discharge _date is not present into AdmittedPatient write query to add Discharge_date column into the AdmittedPatient
alter table ptientmaster add  discharge_date date
--5)write a query to change the data type wardno int to varchar(10)
alter table admittedpatient alter column  wardno varchar(10)
select * from admittedpatient
--6)write a query to drop one foreign key from AdmittedPatient
alter table admittedpatient drop constraint fk_pcodeA 
--7)write a query to add foreign key such that if parent is delete or update child also delete or update 
--8)write a query to add primary key to patientMaster
alter table ptientMaster add constraint pk_pcode primary key(pcode)
--9)write a query to insert 5 records into the Doctor table
insert into doctor values(101,'Sumit','kalyani nagar,pune','MBBS',10),(102,'vaishanavi','Main st nagar,mumbai','BAMS',8)
,(103,'Bhumika','Elm,Delhi','MBBS',10),(104,'Girish','Oak Ave,Bangalore','BDS',7),(105,'SUdhakar','Pine Rd,Chennnai','BUMS',14)
select * from doctor
--10)write a query find the no. of doctors as per qualification
select Qualification ,count(did) from doctor group by qualification
--11)	find the doctors whose qualification is BAMS or MBBS
select * from doctor where qualification='MBBS' or qualification='BAMS'
--)find patients  whose age is between 21to 27    with bloodgroup A+ 
select Pname from ptientmaster where age between 21 and 27 and bloodgroup ='a+'
--13 )find the doctors whose address is mumbai and noofpatient_handle are 10
select * from doctor where Daddresss='mumbai'
--14)find the count of pateint as per the blood group
select bloodGroup,count(Pcode) as 'count of patient' from ptientMaster group by bloodgroup 
--15)find the maximum bill amount
select max(bill_amount) from bill
--16)find the doctors who has noofpatient_handle are more than 10;
select * from doctor where noOfPtient_handeled>=10
--17)	find the number of patients who live in pune;
select count(pcode) from ptientMaster where Paddr ='pune' 
--18)find the patients whose bloodgroup is AB+ and gender is the female
  select * from ptientMaster where bloodgroup='AB+' and gender='female'
--19)find the no of patient with covid 19  as per the ward and display wardno with maxmum patient of covid 19
 select wardNo,count(pcode) from AdmittedPatient where disease='covid 19' group by wardNo
--20)delete the patient whose wardno is 4 or 6 and Disease is covid 19 
  delete from ptientMaster where pcode in ( select pcode from AdmittedPatient where wardno in(4,6) and disease='covid 19')
--21)remove all records from bill table
  truncate table bill
--22)find the details of doctor who are treating the patient of wardno3
   select * from doctor where did in(select did from AdmittedPatient where wardNo=3)
--23)find details of patient who are discharge  within the date 12-12-18 to 25-12-18
   -- Skip-->select * from ptientMaster where pcode in(select pcode from admittedPatient where discharge_date < '18/12/12' and discharge_date > '18/12/25')
--24)Give details of patient who are admited in hospital more than 5 days
  select * from ptientMaster where pcode in ( select pcode from admittedPatient where day(cast(discharge_date as date))-day(cast(Entry_date as date))=5)
--25)find the patient who are suffered from dengue and having age less than 30and bloodgroup is'A'
    select * from ptientmaster where pcode=(select pcode from admittedpatient where disease='Dengue') and age<30 and bloodgroup like 'A%'
--26)find the patient who recover from dengue and  bill amount is greater than 10000
    --skip--> select * from ptientMaster where pcode in (( select pcode from AdmittedPatient where (discharge_date)-(select cast(getdate() as date))='0'),(select pcode from Bill where bill_amount=10000))
--27)find Patient  whose doctors  qualifiaction is M.b.b.s 
  select * from ptientMaster where pcode in(select pcode from admittedpatient where did in(select did from doctor where qualification ='mbbs'))
