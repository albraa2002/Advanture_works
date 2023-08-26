-- total sales for Accessories in 2013
select pc.Name category,sum(sod.OrderQty*sod.UnitPrice) [toatal sales for 2013]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
join Production.product p
on p.ProductID = sod.ProductID
join Production.ProductSubcategory psc 
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on pc.ProductCategoryID = psc.ProductCategoryID
where pc.Name='accessories'
and YEAR(soh.OrderDate) = 2013
group by pc.Name

---- total sales for 2014
select pc.Name category,sum(sod.OrderQty*sod.UnitPrice) [toatal sales for 2013]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
join Production.product p
on p.ProductID = sod.ProductID
join Production.ProductSubcategory psc 
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on pc.ProductCategoryID = psc.ProductCategoryID
where YEAR(soh.OrderDate) = 2014
group by pc.Name


-- total sales for each subcategory 
select psc.Name Subcategory,YEAR(soh.OrderDate) [year],sum(sod.OrderQty*sod.UnitPrice) [toatal sales]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
join Production.product p
on p.ProductID = sod.ProductID
join Production.ProductSubcategory psc 
on psc.ProductSubcategoryID = p.ProductSubcategoryID
group by psc.Name,YEAR(soh.OrderDate)
order by psc.Name

-- sales for each quarter in 2014
select YEAR(soh.OrderDate) [year],DATEPART(QQ,soh.OrderDate) [quarter],sum(sod.OrderQty*sod.UnitPrice) [toatal sales]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
where YEAR(soh.OrderDate) = 2014
group by YEAR(soh.OrderDate) ,DATEPART(QQ,soh.OrderDate) 
order by DATEPART(QQ,soh.OrderDate)

-------------------------------------------------------------
select sod.ProductID,sod.OrderQty
from Sales.SalesOrderDetail sod
order by sod.ProductID

select sod.ProductID,sod.OrderQty,IIF(sod.OrderQty>10,'special','Ordinal') [speciality]
from Sales.SalesOrderDetail sod
order by sod.ProductID

select p.name,p.ListPrice,iif(p.ListPrice>100,'High price','Low price') [level]
from Production.Product p


select p.name,p.ListPrice,iif(p.ListPrice>500,'High price',iif(p.listprice>100,'Medium Price','Low price')) [level]
from Production.Product p

select p.name,p.ListPrice,
case p.ListPrice
when 500 then 'High price'
when 100 then 'Medium price'
else 'Low Price'
end
from Production.Product p

select p.name,p.ListPrice,
case 
when p.ListPrice>500 then 'High price'
when p.ListPrice>100 then 'Medium price'
else 'Low Price'
end [Level]
from Production.Product p

select sod.SalesOrderID ,sum(sod.OrderQty*sod.UnitPrice) total 
,case
when sum(sod.OrderQty*sod.UnitPrice) > 1000 then 'High'
else 'Low'
end [Order Level]
from Sales.SalesOrderDetail sod
group by sod.SalesOrderID  

select E.NationalIDNumber,e.OrganizationLevel,
case when e.OrganizationLevel is null then 0 else 1 end [binary classification]
from HumanResources.Employee e


select YEAR(soh.OrderDate) [year],
CHOOSE(month(soh.orderdate),'Winter', 'Winter', 'spring',
'spring', 'summer','summer','summer','summer','Autumn','Autumn',
'Winter','Winter')  [Season],sum(sod.OrderQty*sod.UnitPrice) [toatal sales]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
group by YEAR(soh.OrderDate) ,CHOOSE(month(soh.orderdate),'Winter', 'Winter', 'spring',
'spring', 'summer','summer','summer','summer','Autumn','Autumn',
'Winter','Winter') 
order by YEAR(soh.OrderDate)


select p.Name,p.ListPrice,'High Price' [Level]
from production.Product p 
where p.ListPrice > 1000
union
select p.Name,p.ListPrice,'Medium Price' 
from production.Product p 
where p.ListPrice between 500 and 1000
union
select p.Name,p.ListPrice,'Low Price' 
from production.Product p 
where p.ListPrice < 500


select sod.ProductID 
from Sales.SalesOrderDetail sod
where YEAR(sod.ModifiedDate)=2011 
intersect 
select sod.ProductID 
from Sales.SalesOrderDetail sod
where YEAR(sod.ModifiedDate)=2012 
intersect
select sod.ProductID 
from Sales.SalesOrderDetail sod
where YEAR(sod.ModifiedDate)=2013
intersect 
select sod.ProductID 
from Sales.SalesOrderDetail sod
where YEAR(sod.ModifiedDate)=2014 


select sod.ProductID 
from Sales.SalesOrderDetail sod
where YEAR(sod.ModifiedDate)=2011 
Except 
select sod.ProductID 
from Sales.SalesOrderDetail sod
where YEAR(sod.ModifiedDate)=2013 

select max( dt.[product sales]) from 
(select  sod.ProductID [product id],sum(sod.OrderQty*sod.UnitPrice) [product sales]
from Sales.SalesOrderDetail sod
group by sod.ProductID) as dt join Production.Product p
on p.ProductID = dt.[product id]
