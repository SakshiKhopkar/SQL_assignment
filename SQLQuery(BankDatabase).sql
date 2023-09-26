create table Bank(
bank_Id int primary key,
bname varchar(25),
BAddress varchar(30),
city varchar(25),
Bstate varchar(25),
)
insert into Bank values ( 1,'HDFC','Karve raod,Pune','pune','Mharashtra'),
(2,'RBL','Main chuk sangli','Sangli','maharashtra'),(3,'SBI','MarineLine mumbai','Mumbai','Maharashtra')
,(4,'ICIC','Andheri mumbai','Mumbai','Maharashtra')
create table Bcustomer(
cust_Id int,
bank_id int,
constraint FK_bank_id foreign key (bank_id) references Bank(bank_id),
constraint fk_Bcust_id foreign key (cust_id) references customer_master(cust_id)
)
insert into Bcustomer values ( 1001,1),(1002,3),(1003,4),(1004,4),(1005,1)
create table Accounts(
Acc_no int primary key,
cust_id int,
Acctype_id int,
Balance int,
constraint fk_customer_id foreign key (cust_id) references customer_Master(cust_id),
constraint fk_acctype_id foreign key (Acctype_id) references AccountType(acctype_id)
)
insert into accounts values (1234,1001,11,67000),(4567,1002,22,770000),(8910,1003,33,870000),(1112,1004,44,50000),(1314,1005,11,60000)
create table AccountType(
acctype_id int primary key,
acctype varchar(25)
)
insert into accountTYpe values (11,'saving'),(22,'Recurring depo'),(33,'Money Market'),(44,'Fixed depo'),(55,'cheque'),(66,'Joint')
create table Transactions(
transaction_id int,
Acc_no int,
amount int,
transaction_tye varchar(20),
Tdate date,
constraint fk_acc_no foreign key (acc_no) references Accounts(acc_no)
)
drop table transactions
insert into Transactions values (201,1234,7000,'Debit','2023/12/12'),(202,4567,5000,'Credit','2023/11/12'),
(201,8910,72000,'Debit','2023/10/12'),(201,1112,5400,'Debit','2023/12/23')
insert into transactions values(201,1112,5500,'Debit','2023/11/23')
create table customer_Master
(
cust_id int primary key,
cname varchar(25),
contact varchar(30),
age int,
pan_no varchar(25)
)
insert into customer_master values(1001,'Sujog','9032451234',31,'FK234'),(1002,'Sanjay','9987654321',30,'FkM23')
,(1003,'Savita','9976543210',23,'FKE22'),(1004,'Sourabh','9975647534',34,'FKR42'),(1005,'Gauri','7845047603',22,'FKT54')
,(1006,'Suresh','8876435076',40,'FKY76')
select * from Bank
select * from customer
select * from Accounts
select * from AccountType
select * from Transactions
select * from customer_Master

--1.Find the no of accounts in saving account
select count(acc_no) from Accounts where acctype_id in(select acctype_id from accountType where acctype='saving')
--2.Display all bank name, cname , city from all  bank in ascending order of bankname  and desceding order of city name
select b.bname,c.cname,b.City from Bank b inner join Bcustomer cust on cust.bank_id = b.bank_Id 
inner join customer_Master c on c.cust_id=cust.cust_id 
--3.Find the customer who has perform maximum number of transaction
select * from customer_master where cust_id=(select cust_id from accounts where acc_no =(select top 1 acc_no from Transactions group by acc_no order by count(transaction_id) desc))
--4.find the customers whose  balance is greater than avg balance of saving accounts.
 select * from customer_master where cust_id in(select cust_id from accounts where balance>(select avg(balance) from accounts where acctype_id in (select acctype_id from AccountType where acctype='saving')))
 --5.find the amount , name of customer whose acc_no is 1234
 select t.amount,a.cust_id,c.cname from transactions t inner join accounts a on t.Acc_no=a.Acc_no
 inner join customer_master c on c.cust_id = a.cust_id where t.acc_no=1234
 --6.display the customer name ,contact of customers whose account type is‘saving’ order by descending order of cname .
 select cname,contact from customer_master where cust_Id in (select a.cust_id from accounts a inner join AccountType ac on ac.acctype_id=a.Acctype_id where ac.acctype='saving')order by cname desc
 --7.display bank name , total balance of all customers in that bank of all banks in descending order of balance.
 select b.Bname,sum(a.balance) as 'balance of bank' from bank b inner join Bcustomer c on c.bank_id=b.bank_Id 
 inner join Accounts a on a.cust_id=c.cust_Id 
 group by b.bname order by 'balance of bank'desc
