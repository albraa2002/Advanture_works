use AdventureWorks2019

select sum(dt.[product sales])
from
(select p.Name , SUM(sod.UnitPrice*sod.OrderQty) [product sales]
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
where year(soh.OrderDate) =2014
group by p.Name
except
select p.Name , SUM(sod.UnitPrice*sod.OrderQty) [product sales]
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
where year(soh.OrderDate) =2011
group by p.Name
) as dt

-- task 2

select p.Name product ,psc.Name subcategory , pc.Name category,SUM(sod.OrderQty*sod.UnitPrice) [product sales]  ,'Medium'[product level]
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID = pc.ProductCategoryID
where year(soh.OrderDate) in (2012,2013)
group by p.Name ,psc.Name , pc.Name
having sum(sod.OrderQty*sod.UnitPrice) between 10000 and 50000
union
select p.Name product ,psc.Name subcategory , pc.Name category,SUM(sod.OrderQty*sod.UnitPrice) [product sales],'Low price'
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID = pc.ProductCategoryID
where year(soh.OrderDate) in (2012,2013)
group by p.Name ,psc.Name , pc.Name
having SUM(sod.UnitPrice*sod.OrderQty)<10000
union
select p.Name product ,psc.Name subcategory , pc.Name category,SUM(sod.OrderQty*sod.UnitPrice) [product sales],'High price'
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID = pc.ProductCategoryID
where year(soh.OrderDate) in (2012,2013)
group by p.Name ,psc.Name , pc.Name
having SUM(sod.UnitPrice*sod.OrderQty)>50000
--------rank products inside each category from high to low prices-------------------------------------
select dt.Name,dt.Color
from
(select p.name ,p.Color,p.ListPrice,rank()over(partition by p.color order by p.listprice desc) [product rank]
from Production.Product p
where p.color is not null
) as dt
where dt.[product rank] =1

select p.name ,p.Color,p.Class,p.ListPrice,rank()over(partition by p.class order by p.listprice desc) [product rank]
from Production.Product p
where p.Class  is not null

select psc.Name,p.Color,p.ListPrice,dense_RANK()over(partition by psc.name,p.color order by p.listprice)
from Production.Product p
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID = p.ProductSubcategoryID


-- Most sold product for each year 
select sdt.year,sdt.Name,sdt.ranked
from (
select dt.[year],dt.Name,RANK()over(partition by dt.[year] order by dt.[product sales] desc) ranked
from
(
select year(soh.OrderDate) [year],p.Name ,SUM(sod.OrderQty*sod.UnitPrice) [product sales]
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID = pc.ProductCategoryID
group by year(soh.OrderDate),p.Name ) as dt
)sdt
where ranked =1

--
select dt.year,dt.Name,dt.[product sales],SUM(dt.[product sales])over(order by dt.year,dt.name) [accumulative sales]
from
(
select year(soh.OrderDate) [year],p.Name ,SUM(sod.OrderQty*sod.UnitPrice) [product sales]
from Production.Product p 
join Sales.SalesOrderDetail sod 
on p.ProductID=sod.ProductID
join Sales.SalesOrderHeader soh 
on soh.SalesOrderID = sod.SalesOrderID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID = pc.ProductCategoryID
group by year(soh.OrderDate),p.Name ) as dt

select sum(unitprice*orderqty)
from sales.SalesOrderDetail
-- CTE Explain

with sales_cte(name,sales)
as
(
select  p.Name ,sum(UnitPrice*OrderQty)
from Production.Product p 
join Sales.SalesOrderDetail sod
on p.ProductID = sod.ProductID
group by p.name
)
select top 3 dt.name,dt.sales,dt.tile_rank 
from
(select sc.name,sc.sales,NTILE(5) over (order by sc.sales desc) tile_rank
from sales_cte sc) dt
where dt.tile_rank=2



with sales_cte(name,sales)
as
(
select  p.Name ,sum(UnitPrice*OrderQty)
from Production.Product p 
join Sales.SalesOrderDetail sod
on p.ProductID = sod.ProductID
group by p.name
)
select  top 3 dt.name,dt.sales,dt.[part rank]

from
(select sc.name,sc.sales ,NTILE(10)over(order by sc.sales desc) [part rank]
from sales_cte sc) dt
where dt.[part rank]=2

--- 
select e.NationalIDNumber+'('+LEFT(e.JobTitle,1) +')' 
from HumanResources.Employee e