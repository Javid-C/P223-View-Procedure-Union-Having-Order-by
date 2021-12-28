create table Brands(
	Id int primary key identity,
	Name nvarchar(20) not null
)

create table Notebooks(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Price decimal (18,2) check(Price>=0),
	BrandId int constraint FK_Notebooks_BrandId foreign key (BrandId) references Brands(Id)
)


insert into Brands
values('Samsung'),
('Apple'),
('Acer'),
('Mi'),
('ASUS')


insert into Notebooks
values('model1',200,1),
('model2',300,1),
('model3',400,2),
('model4',350.50,3),
('model5',500.25,3),
('model6',600,2),
('model7',700,4),
('model8',760,4),
('model9',800,5)


select n.Name,n.Price, b.Name as 'Brand Name' from notebooks n
join brands b
on n.BrandId = b.Id


select n.Name,n.Price, b.Name as 'Brand Name' from notebooks n
join brands b
on n.BrandId = b.Id
where b.Name like '%i%'


select * from Notebooks
where Price between 100 and 500 or Price>700


create table Phones(
	Id int primary key identity,
	Name nvarchar(25) not null,
	Price decimal(18,2) check(Price>=0),
	BrandId int foreign key references Brands(Id)
)


insert into Phones
values('model1',400,1),
('model4',400,1),
('model5',400,2),
('model10',400,3),
('model11',400,4),
('model12',400,4),
('model13',400,5),
('model14',400,5)


select * from 
(
select p.name,price, b.Name as 'Brand name' from Phones p
join Brands b
on p.BrandId = b.Id
union all
select n.name,price, b.Name as 'Brand name' from Notebooks n
join Brands b
on n.BrandId = b.Id
) as tbl
where tbl.Price > 300


create view vw_showallproducts
as
select p.name,price, b.Name as 'Brand name' from Phones p
join Brands b
on p.BrandId = b.Id
union all
select n.name,price, b.Name as 'Brand name' from Notebooks n
join Brands b
on n.BrandId = b.Id


select SUM(price) as TotalPrice from vw_showallproducts




select b.Name as 'BrandName',Count(n.Id) as 'Quantity',SUM(n.Price) as 'TotalPrice' from Notebooks n
join Brands b
on n.BrandId = b.Id
group by b.Name



select * from vw_showallproducts
where name like '%1%'


select * from vw_showallproducts
where name like 't%'


select * from vw_showallproducts
where name like '%1'

select * from vw_showallproducts
where price>500


create procedure usp_showproductDetails
@Price decimal(18,2)
as
select * from vw_showallproducts
where price>@Price


exec usp_showproductDetails 600,'model'


alter procedure usp_showproductDetails
@Price decimal(18,2),
@Search nvarchar(50)
as
select * from vw_showallproducts 
where price>@Price and Name like '%' + @Search + '%'


create procedure usp_deleteproduct
@Name nvarchar(20)
as
delete from Notebooks
where Name = @Name


alter procedure usp_deleteproduct
@Name nvarchar(25)
as
delete from Notebooks
where name = @Name


exec usp_deleteproduct 'thinkpad'



create procedure usp_addproduct
@Name nvarchar(25),
@Price decimal(18,2),
@BrandId int
as
insert into Notebooks
values(@Name,@Price,@BrandId)


exec usp_addproduct 'thinkpad',6000,6

create procedure usp_updateproduct
@Id int,
@Name nvarchar(25)
as
update Notebooks
set Name = @Name
Where Id = @Id

exec usp_updateproduct 9,'Mac'


create table Department(
	Id int primary key identity,
	Name nvarchar(40) not null
)

alter table Department
add DepartmentId int 


insert into Department(Name)
values('Idareetme'),
('Huquq'),
('Maliyye'),
('Karguzarliq'),
('HR'),
('Pirimariy'),
('Yandex')



select SubDep.name as 'Sub', MainDep.Name as 'Main' from Department as SubDep
left join Department as MainDep
on SubDep.DepartmentId = MainDep.Id



select * from vw_showallproducts
order by Price desc


select distinct name from Notebooks


select b.Name as 'BrandName' from Notebooks n 
join Brands b
on b.Id = n.BrandId
group by b.Name
having Count(n.Id)>=2