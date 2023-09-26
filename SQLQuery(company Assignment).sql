create database students
use students
create table students
(
StudentID int primary key,
sname varchar(25),
StudentCity varchar(25)
)
create table subjects
(
 SubId int primary key,
 subname varchar(25),
 Maxmarks int,
 Passing int,
 )
 create table Exam
 (
  StudentId int,
  SubID int,
  Marks int,
  constraint fk_studentId foreign key (studentId) references students(studentId),
  constraint fk_subId foreign key (subId) references Subjects(subId)
  )
  select * from students
  select * from subjects
  select * from exam
  drop table students
   drop table subjects
    drop table exam
  alter table subjects alter column maxmarks  maxmarks numeric(4,2)
  alter table subjects modify column passing passing numeric(4,2)
  alter table exam alter column marks marks numeric(4,2)
  insert into students values(1,'Ram','pune'),(2,'sham','mumbai'),(3,'sita','pune'),(4,'Gita','Nashik')
  insert into subjects values (1,'maths',100,40),(2,'English',100,40),(3,'Marathi',50,15),(4,'Hindi',50,15)
  insert into Exam values (1,1,100),(1,2,85),(1,2,85),(1,3,40),(1,4,45),(2,1,35),(2,2,55),(2,3,25),(3,1,95),(3,2,87),(3,3,45),(3,4,42)
  --Insert a new student (sisd=5,namr=ramesh,city=Hydreabad)into the student table
  insert into students(StudentID,sname,StudentCity) values(5,'ramesh','Hydrabad')
  --change city of SId=4(Gita)to sangli
  Update Students set StudentCity='sangli' where StudentID=4
  --Return list of all student with column sid,name and city
  select * from students
  --Return list containing columns Sid,name,subname,marks,maxmarks,percentage
  select s.StudentId,s.sname,sub.subname,e.marks,sub.maxmarks,(e.marks/sub.Maxmarks)*100 as 'percentage' 
  from exam e
  inner join subjects sub on sub.subId=e.subId
  inner join students s on s.studentId=e.StudentId
  --return list containing columnn SId,Nmae,Subnamen,Marks

