create table patients
(
patient_Id int primary key,
first_name varchar(25),
last_name varchar(30),
gender char(1),
birth_date date,
city varchar(30),
province_id char(2),
allergies varchar(80),
height decimal(3,0),
weights decimal(4,0),
constraint Fk_province_id foreign key(province_id) references province_names(province_id)
)
insert into patients values (5,'suresh','Khan','M','1995/03/03','sangli','1',null,121,60)
insert into patients values(2,'vaibhavi','Patil','F','2001/04/07','Hajipur','4','thiroid allergies',160,51)
,(3,'samir','Joshi','M','2002/10/21','Pune','1','penicillin',170,65),
(4,'sahil','Sharama','M','1993/11/03','Kolhapur','1','Morphine',151,50),
(1,'Kavya','Jadhav','f','1980/10/03','Patana','4','AltraZolam',140,47)
create table doctors(
doctor_id int primary key ,
first_name varchar(30),
last_name varchar(30),
specialty varchar(25)
)
insert into doctors values(101,'Gaurav','sharma','Internal Medicine'),(102,'Samiksha','Rathod','Internal Medicine')
,(103,'Sonakshi','Patil','Dermatology'),(104,'Vishakha','Khan','Gynecology'),(105,'Anany','Devdar','Pedia tricss'),
(106,'Sanjana','Deshmukh','Orthologest')
create table admissions
(
patient_id int,
admission_date date,
discharge_date date,
diagnosis varchar(50),
attending_doctor_ID int,
constraint fk_patient_id foreign key (patient_id) references patients(patient_id),
constraint fk_attending_doctor_id foreign key(attending_doctor_ID) references doctors(doctor_id)
)
insert into admissions values (1,'2023-09-01','2023-09-10',' Pneumonia',101),(2,'2023-08-15','2023-08-20','Appendicitis',102),
(3,'2023-07-03','2023-07-10','Heart Attack',103),(4,'2023-09-05','2023-09-12','Influenza',104),
( 5,'2023-08-10','2023-08-18','Broken Leg',106)
insert into admissions values(1,'2023/09/14','2023/10/10','cardiac arthimia',104)
create table province_names
(
province_id char(2) primary key,
provience_name varchar(30)
)
insert into province_names values('1','Maharashtra'),('2','goa'),('3','Andhra pradesh'),('4','Bihar'),('5','Gujrat')
drop table patients
drop table province_names
drop table admissions
drop table doctors
select * from province_names
select * from patients
select * from admissions
select * from doctors
--1.show the first name,last name and gender of pateient who's gender is M
select p.first_name,p.last_name,p.gender from patients p where p.gender='M'
--2 Show the first name & last name of patients who does not have any allergies
select first_name,last_name from patients where allergies is null
--3.Show the patients details that start with letter ‘C’
select * from patients where first_name like 's%'
--4.Show the patients details that height range 100 to 200
select * from patients where height between 100 and 200
--5.Update the patient table for the allergies column. Replace ‘NKA’ where allergies is null
update patients set allergies='NKA' where allergies is null
--6.Show how many patients have birth year is 2020
select count(patient_id) from patients where year(cast(birth_date as date))=2001
--7.Show the patients details who have greatest height
select * from patients where height=(select max(height) from patients)
--8.Show the total amount of male patients and the total amount of female patients in the patients table.
select gender, count(patient_id) as 'count of male and female' from patients group by gender
--9.Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
--Show results ordered ascending by allergies then by first_name then by last_name
select first_name,last_name,allergies from patients where allergies='penicillin' or allergies='Morphine' 
order by allergies,first_name,last_name desc
--10.Show first_name, last_name, and the total number of admissions attended for each doctor.
--Every admission has been attended by a doctor.
select concat(d.first_name,' ',d.last_name) ,count(a.patient_id) as 'patient attended' from doctors d
inner join admissions a on a.attending_doctor_id=d.doctor_id group by concat(d.first_name,' ',d.last_name)
--11.For every admission, display the patient's full name, their admission diagnosis, 
--and their doctor's full name who diagnosed their problem.
select p.first_name,p.last_name, a.diagnosis,d.first_name as 'doctor first name',d.Last_name as 'doctor last name' from patients p 
left join admissions a on a.patient_id=p.patient_id
left join doctors d on d.doctor_id = a.attending_doctor_id
-------------------------------------------------------------------------------------

