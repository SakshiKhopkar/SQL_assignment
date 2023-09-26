create database DP6Titans_lab
create table Model(
model_Id int primary key,
Model_name varchar(20),
cost int,
)
insert into model values(1,'yamaha YZF',182556),(2,'Bajaj pulsar',1717830),
(3,'TVS Apache',271000),(4,'KTM Rc', 2140000),(5,'Yamaha R15',182000)
create table customer
(
cust_id int primary key,
First_name varchar(25),
last_name varchar(25),
mobile_no varchar(25),
gender varchar(25),
email varchar(25),
)
insert into customer values(101,'sanjay','Mahnotra','8976543242','Male','sanjay@123gmail.com'),
(102,'soniya','Mahnotra','8878565247','Female','soniya@123gmail.com'),
(103,'gyatri','Sharama','9975373534','female','Gyatri@123gmail.com'),
(104,'Vinay','Jadhav','8856784321','Male','Vinay@123gmail.com'),
(105,'Varsha','yadav','9976234101','female','Varsha@123gmail.com')
create table purchase
(
purchase_id int,
cust_Id int,
model_id int,
booking_amount int,
payment_Id int,
purchase_date date,
rating_Id int,
constraint fK_cust_id foreign key (cust_id) references customer(cust_id),
constraint fk_model_id foreign key (model_id) references model(model_id),
constraint fk_payment_Id foreign key (payment_id) references Payment_mode(payment_Id),
constraint fk_rating_id foreign key (rating_id) references feedback_rating(rating_id),
)
insert into purchase values (11,101,1,50000,11,'2023/06/20',4),(12,102,1,70000,11,'2023/07/23',4),
(13,103,2,55000,33,'2023/06/15',4),(14,104,3,57000,22,'2023/06/05',5),
(16,105,5,182000,11,'2023/09/25',5),(17,101,2,66000,22,'2023/08/16',4)
insert into purchase values (18,105,4,77000,11,'2023/09/14',2),
insert into purchase values (19,101,1,60000,11,'2023/08/21',5)
create table Payment_mode(
payment_id int primary key,
payment_type varchar(30)
)
create table feedback_rating
(
 rating_Id int primary key,
 rating varchar(25)
 )
 drop table feedback_rating
 drop table purchase
 insert into feedback_rating values(5,'excellent'),(4,'Good'),(3,'average'),(2,'bad'),(1,'complaint')
 insert into payment_mode values ( 11,'online'),(22,'cash'),(33,'Cheque')
 select* from model
 select * from purchase
 select * from feedback_rating
 select * from payment_mode
 select * from customer
 --1.	WAQ to get the balance amount for customers who made cash 
 select (m.cost-p.booking_amount) as 'balance' from model m inner join purchase p on m.model_Id=p.model_id 
 inner join customer c on c.cust_id=p.Cust_id
 inner join Payment_mode pt on pt.payment_id=p.payment_id where pt.payment_type='cash'
 --3.	Create an index to have faster retrival of data on the basis of booking_amount.
 create unique index index_at on purchase(booking_amount)
 select * from purchase
 --2.Delete all the records of customer who have paid complete amount as that of bike cost.
 delete from customer where cust_id in (select c.cust_id from customer c inner join purchase p on p.cust_Id=c.cust_id 
 inner join model m on p.model_id=m.model_id where (m.cost-p.booking_amount)=0)
 --4.WAQ to change payment mode to cash for ‘yamaha YZF’ purchased by customer with id 101. 
 update purchase set payment_id=22 where purchase_id=(select p.purchase_id from purchase p inner join model m on m.model_id=p.model_id where model_name='yamaha YZF' and cust_id=101)
 --5.Map where key is modelName and value is arraylist of ids of customers who purchased that model.
 --6.Create a stored procedure to get the full name of customer whose cust_id is provided as input.
 --7.WAQ to get the number of complaints registered for model activa 5G.
 --8.WAQ to get all customer names who haven’t given ratings yet
 select c.* from customer c inner join purchase p on p.cust_id=c.cust_id where p.rating_id = null 
 --9.Delete all complaint records from purchase. 
 delete from  purchase where rating_id=1
 --10.Update ratings given by Mr Vaibhav from good to excellent.
 update purchase set rating_id=5 where cust_id=(select cust_id from customer where first_name='vinay')
 --11.Reduce cost of all bikes for which rating is bad by 10%. 
 update model set cost=(cost-(cost*0.1)) where model_id=
 (select p.model_id from purchase p inner join Feedback_rating f on f.rating_id=p.rating_id where f.rating='bad')
 --12.Write a to display highest selling model along with name and count 
 select top 1 m.model_Id,m.model_name,count(p.cust_id) as 'count' from purchase p 
 inner join model m on m.model_Id=p.model_id group by m.model_id,m.Model_name order by count(p.cust_id) desc
 --------------------------------------------------------------------------------------------------
 select cust_name from customer where cust_id =
 (select cust_id from account where acc_no =(select top 1 acc_no from trasaction order by count(transa_id) desc))
