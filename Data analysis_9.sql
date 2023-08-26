--P.N and total sales in 2014 but not in 2011
select p.Name [Product Name] ,sum(sod.OrderQty*sod.UnitPrice) [toatal sales ]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on sod.SalesOrderID=soh.SalesOrderID
join Production.Product p
on p.ProductID = sod.ProductID
where year(soh.OrderDate)=2014
group by p.Name
Except
select p.Name ,sum(sod.OrderQty*sod.UnitPrice) 
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on sod.SalesOrderID=soh.SalesOrderID
join Production.Product p
on p.ProductID = sod.ProductID
where year(soh.OrderDate)=2011
group by p.Name
------------------------------------------------------------------------------------------------------------
select pc.Name [Category Name],psc.Name [Sub Category Name],p.Name [Prouduct Name],year(soh.OrderDate) [Order Year],sum(sod.OrderQty*sod.UnitPrice)[Total Cost],
case
when sum(sod.OrderQty*sod.UnitPrice)>10000then'High'
when sum(sod.OrderQty*sod.UnitPrice)<10000then'Meduim'
else 'Low'
end [Level]
from Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on soh.SalesOrderID=sod.SalesOrderID
join Sales.SpecialOfferProduct sop
on sop.SpecialOfferID=sod.SpecialOfferID
join Production.Product p
on p.ProductID= sop.ProductID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID=p.ProductSubcategoryID
join Production.ProductCategory pc
on pc.ProductCategoryID=psc.ProductCategoryID 
where
year(soh.OrderDate)=2013
group by pc.Name,psc.Name,p.Name,year(soh.OrderDate)
 
union
select pc.Name,psc.Name,p.Name,year(soh.OrderDate),sum(sod.OrderQty*sod.UnitPrice),
case
when sum(sod.OrderQty*sod.UnitPrice)>10000then'High'
when sum(sod.OrderQty*sod.UnitPrice)<10000then'Meduim'
else 'Low'
end
from Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on soh.SalesOrderID=sod.SalesOrderID
join Sales.SpecialOfferProduct sop
on sop.SpecialOfferID=sod.SpecialOfferID
join Production.Product p
on p.ProductID= sop.ProductID
join Production.ProductSubcategory psc
on psc.ProductSubcategoryID=p.ProductSubcategoryID
join Production.ProductCategory pc
on pc.ProductCategoryID=psc.ProductCategoryID  
where 
year(soh.OrderDate)=2014
group by pc.Name,psc.Name,p.Name,year(soh.OrderDate)

---------------------------------------------------------------------------------------------
select  top 1dt.[product sales],p.Name,p.ProductID
from 
(select  sod.ProductID [product id],sum(sod.OrderQty*sod.UnitPrice) [product sales]
from Sales.SalesOrderDetail sod
group by sod.ProductID) as dt 
join Production.Product p
on p.ProductID=dt.[product id]
order by [product sales] desc

--------------------------------------------------------------------------------
select sum(dt. [toatal sales ])
from
(select p.Name [Product Name] ,sum(sod.OrderQty*sod.UnitPrice) [toatal sales ]
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on sod.SalesOrderID=soh.SalesOrderID
join Production.Product p
on p.ProductID = sod.ProductID
where year(soh.OrderDate)=2014
group by p.Name
Except
select p.Name ,sum(sod.OrderQty*sod.UnitPrice) 
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on sod.SalesOrderID=soh.SalesOrderID
join Production.Product p
on p.ProductID = sod.ProductID
where year(soh.OrderDate)=2011
group by p.Name) as dt


